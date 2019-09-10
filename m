Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF77C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B323320872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568115213;
	bh=623fYzFI8D1TaKyw1isaYldtSwGOQuKm+nvPmA7M2/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s/ysltLlhasUdnvV7yJ6TFV8v/rNVrSgrafIJaIvP7mr/1x2D9uIN03ZswRw4kcII
	 6AjRrMDTl4JGZ9GN9ZoekG06p2K0wbs/VRoYz8O1Y/i0EIBSYMcOU494NTjBCeHxzz
	 nHeZk2FOhZe6Fz1Um9vytMAnO7hTcpTcWzAWzVkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfIJLdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:33:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35828 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfIJLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:33:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id q22so11476260ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/87kLUWhA8VGKwQ9ReDVfft5SDHkATRiA6uskomi3Do=;
        b=VPec9JRv8Tfx9xEc4r84woloylMuGNHPDiClO6km+SMR4SlGOn2EWxH8paATQU4SYk
         EdX0wUykyyflt8+WFj/VGKXZi/CVm+7AEyvwhPWJkWLBihBks9G66wETZBSNT1pzq08G
         a35JZGXi1OKWxuE5XkZCOuOYghEjdjQryubYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/87kLUWhA8VGKwQ9ReDVfft5SDHkATRiA6uskomi3Do=;
        b=HXR42mrMEuAVLZAq3AV2c3jEfKG3b+2NP1e20JWgNQtMqDX1455iUOP97UAZBGwd7Z
         YCrnTyM91/e2/rxKwdMi20j1kROm9yDw6v1jkF4TAiLkZVka/zIqZ8NnBvZXB+Wbgx0e
         bgrV79EZWTf9dwi0RerMkh+ffYhLoueq3aL5m+J4261NWyDg+Gl/5Mn0O2RoEzbNY5p7
         keUfJPvJ4WluuEjrkwKeVCXwxOf7p1PR1klXGaYcgxLD/ILtkRxn8HGRMimvRjT+NPNi
         gfWA83sTqZAek0fxX0UOJolH8bElZzQ4hg9AfxOMxAyto/zucjQXBaISp4pmdU7WlPIx
         BpBQ==
X-Gm-Message-State: APjAAAUlX8TBc1N4cOEnLOVAsvY2xjzjUl3NFkie/abzto9fZQIQlh+b
        nwXy7fU6d613gYsn1VHReIJKzXco5AZpsg==
X-Google-Smtp-Source: APXvYqyCfbDrkZ6LtgxKyIfO8jKZ2l52ot97y3gcwHImV15QoPfUtUYUigXgJV+dj5U2ym0IXGi/vw==
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr20087846ljj.234.1568115209583;
        Tue, 10 Sep 2019 04:33:29 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id x13sm3987210lfc.80.2019.09.10.04.33.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 04:33:28 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id y23so15713600ljn.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:33:28 -0700 (PDT)
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr18756186lja.84.1568115208066;
 Tue, 10 Sep 2019 04:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
In-Reply-To: <20190910042107.GA1517@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Sep 2019 12:33:12 +0100
X-Gmail-Original-Message-ID: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
Message-ID: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 5:21 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> The commit b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), [1]
> which was merged in v5.3-rc1, *always* leads to a blocked boot on my
> system due to low entropy.

Exactly what is it that blocks on entropy? Nobody should do that
during boot, because on some systems entropy is really really low
(think flash memory with polling IO etc).

That said, I would have expected that any PC gets plenty of entropy.
Are you sure it's entropy that is blocking, and not perhaps some odd
"forgot to unplug" situation?

> Can this even be considered a user-space breakage? I'm honestly not
> sure. On my modern RDRAND-capable x86, just running rng-tools rngd(8)
> early-on fixes the problem. I'm not sure about the status of older
> CPUs though.

It's definitely breakage, although rather odd. I would have expected
us to have other sources of entropy than just the disk. Did we stop
doing low bits of TSC from timer interrupts etc?

Ted, either way - ext4 IO patterns or random number entropy - this is
your code. Comments?

                 Linus
