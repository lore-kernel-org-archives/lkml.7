Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB583C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20F7206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfDOIDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:03:06 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43365 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOIDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:03:06 -0400
Received: by mail-ot1-f48.google.com with SMTP id u15so13623071otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 01:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=933JfDMO/1tW7WuUydACw3VvF6ahaiXpe8YkBr+QZgk=;
        b=jhx6zW1S0xrkuBPVNbqGMqmcOCVcdG9ypYiSO31uCCHhAy0VnKjC/d0VhaChhK3uF0
         FD5zOqBPF3E92LcCMdZYcv8LG48ips8UapDqMvZuiokFXlMSY37T5+Rcep249Z/Gq1yh
         oOYxfvwWsQ64ZxT6uRThun+0mUCganDMyYA2somym6W0yamPkUb/fTMkasc892xVyIsc
         PgFwEERoFP4flZ+0XxiZoti+6v4+Dk4BXw51saWNh/qnLYMTsEcRViSbYuHUiRUHxXco
         1a3Flutt4pNPV871I0fmlGfBdgZRA84U9IZUcI6UUgcfEZ4apkpSHLiahIPYJGC6+MQG
         mocg==
X-Gm-Message-State: APjAAAW8XmgZ4xpmd81zw/IpEhrkeo/aMLJi94hjRf5x90xl3L2zCcda
        K4iKhRpj6+HqiIc+X0s5erUhRfJZVJHldpAflMeVuA==
X-Google-Smtp-Source: APXvYqxM2JIZZEnfz9diVsmrRveZIADxKKnny3BB8dzf9jd5L9/deXDGYHXwdpmH9zFey8ov7CzNEP6LCDYHFVWUJ3w=
X-Received: by 2002:a9d:27e9:: with SMTP id c96mr46997116otb.206.1555315385036;
 Mon, 15 Apr 2019 01:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO63bX37T=bg=QRt6_EtpvXUNQ_N-TSXsN4=wd1Dz2zQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsO63bX37T=bg=QRt6_EtpvXUNQ_N-TSXsN4=wd1Dz2zQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 15 Apr 2019 10:02:54 +0200
Message-ID: <CAFqZXNuqWGNwUTUxWjZRmx4PFL2zsRRo6fu+ZXZwaQAMvuf1kQ@mail.gmail.com>
Subject: Re: kernel/time/ntp.c: Possible off-by-one error in TAI range check?
To:     Roman Zippel <zippel@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 10:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Hello,
>
> while writing tests for clock adjustment auditing [1] [2], I stumbled
> upon a strange behavior of adjtimex(2) when setting the TAI offset...
>
> Commit 153b5d054ac2 ("ntp: support for TAI") added a possibility to
> change the TAI offset from userspace via adjtimex(2). The code checks
> if the input value (txc->constant) is greater than 0 and if it is not,
> then it doesn't modify the value. Ignoring the fact that this check
> should probably be in timekeeping_validate_timex() and cause -EINVAL
> to be returned when false, I find it strange that the check doesn't
> allow to set the value to 0, which seems to be the default value...
>
> Was this behavior intended or should the code actually check for
> txc->constant >= 0 instead of txc->constant > 0?

Ping?

>
> Thanks,
>
> [1] https://github.com/linux-audit/audit-kernel/issues/10
> [2] https://github.com/linux-audit/audit-kernel/wiki/RFE-More-detailed-auditing-of-changes-to-system-clock
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
