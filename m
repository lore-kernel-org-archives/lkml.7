Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C662C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E53F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZQ6PxwUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfJJSiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:38:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36368 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfJJSiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:38:12 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so16011122iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUzRX7Xh7byk+MCJLYcIVyEy+EENOl4g6KMABWycDWw=;
        b=ZQ6PxwUt7uDnexDJkq9OENRzTCFskAngHyXDBZksax3F+PGRBGH8FR1A6RJapyEQ55
         /zzucfJ05Y9z2hjpZyqzThIvKaXCo7NfK/mdARhJfTS2Z1kk3fh+fAgRvxEYh+Hfn0xb
         CgRg0yjdWxEEOFfba4LnL9gOFEwaksq23hjZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUzRX7Xh7byk+MCJLYcIVyEy+EENOl4g6KMABWycDWw=;
        b=Oz5yo32hPiH035hExEw/EJVJ+7ZZBazZZ/hmwYucv5nXba1VBZdetsHpF12wp2iKz3
         IH5iz0zJhEUrJpHohCnN+2LpCD6/adeVUoS2s6R8kdrRMZDy2tpbRZyuoVQF/60E7moa
         DwKEWN5EKl4yBu3vlMVIGwA+2fb1GIsHDt7S5WiNY5KjR4ITqWx5+XAaucaM4Jsx2CBv
         5z+BzzhdqlyRwK0Sg0OqnsJmpkMGXY6XWxvkU4h6H26e9kX2a874JjNutRHwi2EuOvPF
         yp0ITfhgfz/JVfVlsD3YfOBlAgXllXLZaWDqI4/5UOTY1ZvgUgq00lj1SjCKOKWYslCH
         CgBQ==
X-Gm-Message-State: APjAAAUAhIydIb75VTmhgfJ/W/fj7K17jtJM5vnMA8BpH9+Lm8oor/p+
        1s0my7hOIr3zWhFImbDlXrml1EvrPIn26EWL9BIVdw==
X-Google-Smtp-Source: APXvYqyEPPCMhzAxynrhUpsjYl18h3kyEF/0J8BemwV2SSA0s8xu58jyxX1AcQyr0RHPK4QPm9Qtmih6L0sw0Cz+Egw=
X-Received: by 2002:a02:c4cd:: with SMTP id h13mr12796842jaj.142.1570732690810;
 Thu, 10 Oct 2019 11:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191008115342.28483-1-patrick.rudolph@9elements.com>
 <20191008115342.28483-2-patrick.rudolph@9elements.com> <5d9d120b.1c69fb81.b6201.1477@mx.google.com>
 <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com>
 <6cfca8c34ccd51f12b4418e9a74d8961e32077ed.camel@9elements.com> <5d9f3b9f.1c69fb81.62109.325d@mx.google.com>
In-Reply-To: <5d9f3b9f.1c69fb81.62109.325d@mx.google.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 10 Oct 2019 11:37:58 -0700
Message-ID: <CAODwPW-x1fwGSrvLNWCU4GAfGbD0zqo2HLm+33D8eUtxbnFLCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'll expose the coreboot tables using a sysfs driver, which then can be
> > used by coreboot tools instead of accessing /dev/mem. As it holds the
> > FMAP and "boot media params" that's all I need for now.
> >
> > The downside is that the userspace tools need to be keep in sync with
> > the binary interface the coreboot tables are providing.

Well, in the other version the kernel needs to be kept in sync
instead. No matter where you do the parsing, something needs to be
kept in sync. I think userspace would be easier, especially if we
would host a small userspace library in the coreboot repository that
other tools could just link.

> I'd rather we export this information in sysfs via some coreboot_fmap
> class and then make the "boot media params" another property of one of
> the fmap devices. Then userspace can search through all the fmap devices
> and find the "boot media params" one. Is anything else needed?

Okay, this is the fundamental question we need to answer first... do
you really think it's better to add a separate interface for each of
these, Stephen? The coreboot table[1] currently contains 49 entries
with all sorts of random firmware information, and most of these will
never be interesting to the kernel. Do we want to establish a pattern
where we add a new sysfs interface for each of them whenever someone
has a use case for reading it from userspace? I think this might be a
good point to implement a generic interface to read any coreboot table
entry from userspace instead, and say that if the kernel doesn't need
the information in a specific entry itself, it shouldn't need to know
how to parse it.

[1] https://review.coreboot.org/cgit/coreboot.git/tree/src/commonlib/include/commonlib/coreboot_tables.h
