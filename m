Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25283C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF0820B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDHIrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:47:53 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41631 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:47:53 -0400
Received: by mail-ot1-f41.google.com with SMTP id 64so11246458otb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kXi2GogRRfLYCkUe+P9JP8LfWes3Q5tSDryeYOceAvs=;
        b=ITd1Hu1/NFHuBIsgT+2aGTeQOX+Ry9w83+qmc33bUayjnshKyzKatoowIHzc9EAXA0
         J6ygqiuwj/OytjBbHw+N1zLe+teS5l44Fc//fsYPMCFT9QuCN8cz/CRGEnI/bQAvpV8R
         yt1vWqEmsjDwvSDRAlnUDTi/d/1bdRYmSuqay/x24JhI7KzbohbOFgikq4Dd/jst49Gh
         syIkajIr0lY3u08/cNXofKA4NqlJ404a9Apt/c8JytaGZ7KvR5bbZxMAzx3TJExELkNa
         fSTQwDj76hxkXZA/icGTgCtSlmIwif9PUSgxIlWSVcV74yEtsToBRmFsRYcvzCycbEAU
         P8Jw==
X-Gm-Message-State: APjAAAWVF+o4uHcx9reRHCDNOcjaY0iqu7OqlcrAd06WyIHBLzA7QTcc
        v2giqRsL5uHOfsfD1CoSHQKtsoRLzvMILVZ0/Wjp6A==
X-Google-Smtp-Source: APXvYqxfNCrp5zQZiB6S/Mib0QtVN7XdgUPq88xxX9FAtR9iN2aZ+hwGHhUcL7CMr2vjCPXG0dAOkXha3RWtHPHlNYY=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr18908468otl.220.1554713272439;
 Mon, 08 Apr 2019 01:47:52 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 8 Apr 2019 10:47:43 +0200
Message-ID: <CAFqZXNsO63bX37T=bg=QRt6_EtpvXUNQ_N-TSXsN4=wd1Dz2zQ@mail.gmail.com>
Subject: kernel/time/ntp.c: Possible off-by-one error in TAI range check?
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

Hello,

while writing tests for clock adjustment auditing [1] [2], I stumbled
upon a strange behavior of adjtimex(2) when setting the TAI offset...

Commit 153b5d054ac2 ("ntp: support for TAI") added a possibility to
change the TAI offset from userspace via adjtimex(2). The code checks
if the input value (txc->constant) is greater than 0 and if it is not,
then it doesn't modify the value. Ignoring the fact that this check
should probably be in timekeeping_validate_timex() and cause -EINVAL
to be returned when false, I find it strange that the check doesn't
allow to set the value to 0, which seems to be the default value...

Was this behavior intended or should the code actually check for
txc->constant >= 0 instead of txc->constant > 0?

Thanks,

[1] https://github.com/linux-audit/audit-kernel/issues/10
[2] https://github.com/linux-audit/audit-kernel/wiki/RFE-More-detailed-auditing-of-changes-to-system-clock

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
