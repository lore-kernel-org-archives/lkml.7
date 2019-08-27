Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D1A2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OkJdw2eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfH0Ixs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:53:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38016 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfH0Ixs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:53:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so30363935edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNx6tz74xU9hmYEbYc07ctD8LymWFI8TfuChqz+asMw=;
        b=OkJdw2eC6zdxQvsL0pfZDT70HNL0PbEw9zH0O9vVl14zTUGlZ9BzbAsXN0qpMI50hJ
         7RegQJE3tcCgr9J4XETmI5hDEz7QVZW6u9FPj90ZNUT3jFxKulaFD1E9Txsw3ohzrp/m
         dUmpvrH02s3Kvh262aT3G3dbe9sTdd9Ew54eD5rXOTRrOEyAUMLTrhEdXqdAzqzg5c9W
         XYEprG+ove5xUlp7s7GP0pLRhlJJIkxdVTEt0liug8/l+q97x9F4MWsGqcTlgRyzx96n
         uY426V9OAeve1Ca+tY7le8a6e4rIjNc5f8u8A6Xv0EkLIIbmD5g5SVBAMgNq1U5zNHzs
         NYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNx6tz74xU9hmYEbYc07ctD8LymWFI8TfuChqz+asMw=;
        b=d2bGDfPG8PZdJi7JMHOB6qEBWiB0UfVWhSq89Gp6Sb36/Rsjke9DfOgbQTzbBIfjg7
         mflqvTwc9IwbEoEc4/r/JTAK5WckdXoiUiawfQXBQIWTHYkGpp6Q5K996WymavgX/S7Z
         4MiivVQJl9iQm3FtVmkPicbx7GTXYSAVCKfhuxYWYESsMeD5Yfe7WjIYsWxUuh361xR3
         0Ayj6wMQ/fLN/t8Y1r1zWeiU611ZtITFkpRsCWsDLFWuL8DDpJ6Ry3CD2YptGr72RA20
         ce0WXTQooTn5ptn0R0wCMKxaAfLS8hiw00el3/vpByYTPpYaH4EKmFpw7I5m3uBu5meT
         wByw==
X-Gm-Message-State: APjAAAUP+7tX23CaA8UX9U52doko8tB4TPODvYPXn1mQAoTkiVevsL5s
        OSIFs4Bxily8thQtXV5RVm2rEFaQIqw3sgmFIKTsMw==
X-Google-Smtp-Source: APXvYqyujNBN4dohlktkcKzTTpAke4sYdHmNFq8k7RRaUgv2efVHw5GdohHpNB+V/zF/mT8mb5H35st0QN7czk4H0hU=
X-Received: by 2002:a05:6402:1344:: with SMTP id y4mr22538757edw.124.1566896026158;
 Tue, 27 Aug 2019 01:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
 <20190826201313.246208e9@why> <CA+CK2bAS-jDwY-qKfZQD8TbvyAhS1+rBvcxGqkR4BHd5NR5BGQ@mail.gmail.com>
 <d7461fb3-0f6d-8abf-084d-ce0be1f1a18d@kernel.org>
In-Reply-To: <d7461fb3-0f6d-8abf-084d-ce0be1f1a18d@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 27 Aug 2019 04:53:35 -0400
Message-ID: <CA+CK2bAk4Xb_hxh2KLxWKa8ogM-jO1MpREmc02TmUMpdJ2ZbSA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Running Linux without EFI is common, and there are scenarios which
> > make it appropriate. As I understand most of embedded linux do not
> > have EFI enabled, and thus I do not see a reason why we would not
> > support a first class feature of Linux (kexec) on non-EFI bootloaders.
>
> Define "most". All the arm64 systems I have around (and trust me, that's
> quite a number of them) can either use u-boot, which has more than
> enough EFI support to use this functionality, or use EDK-II natively.

OK. Is this the most common configuration in the embedded ARM64
devices currently deployed: phones, cameras, consoles, players, etc?

> > We (Microsoft) have a small highly secure device with a high uptime
> > requirement. The device also has PCIe and thus GICv3. The update for
>
> PCIe doesn't imply GICv3 at all.

My impression was that without PCIe GICv3 is rarely used, and this
could be the reason why this problem is not seen outside of larger
machines which normally have EFI enabled.

>
> > this device relies on kexec. For a number of reasons, it was decided
> > to use U-Boot and Linux without EFI enabled. One of those reasons is
> > to improve boot performance, enabling EFI in U-Boot alone reduces the
> > boot performance by half a second. Our total reboot budget is under a
> > second which makes that half a second unacceptable. Also, adding EFI
> > support to kernel increases its size and there are security
> > implications from enabling more code both in U-Boot and Linux.
>
> You're are missing the point. kexec with EFI has 0 overhead (no
> non-kernel EFI code gets executed), doesn't impact your time budget, and
> only relies on a single in-memory table. This can be pretty trivially
> provided by the dumbest EFI shim.

Thanks, this makes sense that the Linux boot time won't be affected. I
have not tested how u-boot was affected, but was told 0.5 second
longer to start.

> All you are describing above is a set of self imposed limitations in
> your bootloader, which you are fully in control of. So instead of
> reinventing a square wheel, I suggest you adopt the existing implementation.

I am not sure this analogy is correct, I do not think that non-EFI
enabled kernels became legacy.

> Another reason not to do this is interoperability: I want to be able to
> kexec whatever Linux kernel I want, without having to cope with all
> flavours of the same functionality. Effectively, the EFI table is a
> private ABI between two Linux kernels. We're not changing it.

This is exactly the problem: by having this region defined in signed
DTB file we reduce the amount of communication between the kernels.
Passing modified EFI Table causes us to pass more information from the
first kernel indefinitely through updates. Thus, increases a chance
for a security compromise. We are not changing EFI ABI between
kernels, it will stay as is. All this code does is enables kernels
that do not have EFI table communication between them a way to do
kexec updates with reduced amount of data exchange.

Thank you,
Pasha
