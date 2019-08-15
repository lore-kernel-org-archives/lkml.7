Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA45208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="hIJ+7x/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfHOFCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:02:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33989 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfHOFCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:02:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id m10so1045479qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 22:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS6HLyRUhDQu+3NkI4g1F+69BtH5q9TDEgz0kbn7qPo=;
        b=hIJ+7x/QeZakBzih51K9QA/TTuu02mDzwe50C6f2RpBNZDuOYG3TQfIlRSUqUYtSp/
         qGfgVYUmo4glqeqj+ypvALMxF7lwLuhX/HLXIcesMb6yvgRPCM+I3H6jKNuY1+5GPD+u
         X4AmqEcw/zcwsIoc46fveVEqYmW/xfjWqGtPlkJnrZAb6NfxTWXgJmmAUDrp+RDFoUEm
         KFfUAaOJfVdQ2QQvMsqqoHu0n8Ho39m4F57xWHCc04G37R2oJbN/JS0sQF24l8y5n81P
         N77b6yZoqIpH4jHwrmVwXgChaRp5mo9mbwdcCGqr9u4WX3teX7YjZMJepSjuTOaXbYP/
         cRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS6HLyRUhDQu+3NkI4g1F+69BtH5q9TDEgz0kbn7qPo=;
        b=scFH9/40TDrID7Zbw7Qnu3VqwD4M7WV5CRKoNtKvKdvF742njj8lz/rtAISkryEk3g
         3RSvWo1zwBxBW/ImFHy3ZbUgRBr9BwW/pgCch5UVRXXZ0d1nRIhRJtMq4dl8bBOXb5+A
         6E5e9PFElIl8ZjA5oV6cxJoXqfNJMFH6PLEOIqVjX+vRIVahelc+9hlUSAdKTKBDcpGl
         sU4Zs0MC7vORcTQseXS+UaD/BHZoZnQMi1vTzpNSFpG1t9qla+ZFsax6J6Ef8B6FbDiE
         RdS/i9q4BFZIH3HqFn6+f1GS7i9LXgjEhvnNvGjsBbgfeEV/FKaJOcxE4eVqLxf/rlt4
         YBUg==
X-Gm-Message-State: APjAAAV47TaIOQ6bmGDLVeJ1DPlHwJnQbi/YO4NAuIzT9CZOmqsr9YxH
        juS3/SBrcTuyh0fIiL06rnGL9T+Xxn6pFoG82Hm7yg==
X-Google-Smtp-Source: APXvYqyDJzScIYWw0l2brOW8EJ/QS0yQnFobPvHFVrGdqU4Qac7pEWOeKePB9NtH3VEz2tJrLHPu04MoZ9xKFCJeFiM=
X-Received: by 2002:a37:4ed3:: with SMTP id c202mr2484764qkb.457.1565845339155;
 Wed, 14 Aug 2019 22:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com> <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
 <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com> <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com> <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
 <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com> <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
 <CAD8Lp46FgT6yoW9a4Yt8t=bVWzZbYHjw-Dqdk6Pvd2xzxfGHLQ@mail.gmail.com>
In-Reply-To: <CAD8Lp46FgT6yoW9a4Yt8t=bVWzZbYHjw-Dqdk6Pvd2xzxfGHLQ@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 15 Aug 2019 13:02:07 +0800
Message-ID: <CAD8Lp45S-0+b4ZjT=1xbq4ijFzQ4eC89QK=TVQn3A0ZKyeE0iA@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: Handle missing global clockevent gracefully
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 2:16 PM Daniel Drake <drake@endlessm.com> wrote:
> I can do a bit of testing on other platforms too. Are there any
> specific tests I should run, other than checking that the system boots
> and doesn't have any timer watchdog complaints in the log?

Tested this on 2 AMD platforms that were not affected by the crash here.
In addition to confirming that they boot fine without timer complaints
in the logs, I checked the calibrate_APIC_clock() result before and
after this patch. I repeated each test twice.

Asus E402YA (AMD E2-7015)
Before: 99811, 99811
After: 99812, 99812

Acer Aspire A315-21G (AMD A9-9420e)
Before: 99811, 99811
After: 99807, 99820

Those new numbers seem very close to the previous ones and I didn't
observe any problems.

Thanks
Daniel
