Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B1C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813E0222A2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="VYCb2DI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKRV7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:59:22 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43278 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:59:22 -0500
Received: by mail-qv1-f67.google.com with SMTP id cg2so7243464qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yh2LgyyzK/gXaLAPGjRbal/CgoxZYqkEIqiLIiBsIFc=;
        b=VYCb2DI3ZrrRRsMjzgTL2+c8BizmQDMKsB9M+/SB/9K36bzrJpbnBMFdJ/b2BhqyKo
         rFxxEW4N/1S/b3a0YzBlKvO9sPku+awwkciEN40rDm5z6dP391OG+EN21zpjN2OrzaBB
         FjKJRGYPoixITGdQDAnr1lGCiRtRIfddLG7zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yh2LgyyzK/gXaLAPGjRbal/CgoxZYqkEIqiLIiBsIFc=;
        b=O6cErysNWlzbL/sLDwfTuM57Jlu1UMm+kdozx19zXe/l9z8E7g0+y2Dxz8thvheOvr
         wMe7/vGu+TLbrTwbz//DJmkopM7ksFrmomTObP93XNmzby+LuTI6bzdH+z4F6gU5LQKo
         Zu/Jo4X4Wg9CAGnIIZBRQIgCw9muEL7+wj2g0wacUkOZJUsf6mrpC7VJNDaUZxdbg59l
         EgyolYyLcw71bB5G1JH61w1SRdmbViAnJqunERIeuU/KHhaZ5Wa4/hsUQLZKeKimTUCW
         PLSnyAPOwy2yFWvPbQUawEoRqtZz82mzZKcwRIt2EKjiyMRE10a2rcRfx0AYu4MaM3i1
         lAHg==
X-Gm-Message-State: APjAAAWHQF4XSq2cb+4u60YHY0aHyo1ow0WladyPM6NXKPG1FcdnuyQh
        KemMFNdPDqC4ENaUq5E3Laxx+0vClqLL/nhirkDRiw==
X-Google-Smtp-Source: APXvYqw3/kOlkH92hdns139YX/h1EYFWBtwB/Kt1J3XOsgqwcjl5rRrFWA+dSFXOwQboHF68sI0tACccu47tWwIQmT8=
X-Received: by 2002:a0c:e60b:: with SMTP id z11mr28108101qvm.216.1574114359826;
 Mon, 18 Nov 2019 13:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20191117185332.18998-1-vitaly.wool@konsulko.com> <20191118190430.GA16134@cork>
In-Reply-To: <20191118190430.GA16134@cork>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 18 Nov 2019 22:59:08 +0100
Message-ID: <CAM4kBBJKFxU440Y=Bk+4PzS+w=F6Fg0g-6m6Vjrt=xfFUsfbSA@mail.gmail.com>
Subject: Re: [PATCH] zswap: use B-tree for search
To:     =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>, sjenning@redhat.com,
        johannes@sipsolutions.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 8:04 PM J=C3=B6rn Engel <joern@purestorage.com> wro=
te:
>
> On Sun, Nov 17, 2019 at 08:53:32PM +0200, vitaly.wool@konsulko.com wrote:
> > From: Vitaly Wool <vitaly.wool@konsulko.com>
> >
> > The current zswap implementation uses red-black trees to store
> > entries and to perform lookups. Although this algorithm obviously
> > has complexity of O(log N) it still takes a while to complete
> > lookup (or, even more for replacement) of an entry, when the amount
> > of entries is huge (100K+).
> >
> > B-trees are known to handle such cases more efficiently (i. e. also
> > with O(log N) complexity but with way lower coefficient) so trying
> > zswap with B-trees was worth a shot.
> >
> > The implementation of B-trees that is currently present in Linux
> > kernel isn't really doing things in the best possible way (i. e. it
> > has recursion) but the testing I've run still shows a very
> > significant performance increase.
> >
> > The usage pattern of B-tree here is not exactly following the
> > guidelines but it is due to the fact that pgoff_t may be both 32
> > and 64 bits long.
> >
> > Tested on qemu-kvm (-smp 2 -m 1024) with zswap in the following
> > configuration:
> > * zpool: z3fold
> > * max_pool_percent: 100
> > and the swap size of 1G.
> >
> > Test command:
> > $ stress-ng --io 4 --vm 4 --vm-bytes 1000M --timeout 300s --metrics
> >
> > This, averaged over 20 runs on qemu-kvm (-smp 2 -m 1024) gives the
> > following io bogo ops:
> > * original: 73778.8
> > * btree: 393999
>
> Impressive results.  Was your test done with a 32bit guest?  If yes, I
> would assume results for a 64bit guess to drop to about 330k.

No, it's on a 64 bit virtual machine. I take this improvement is partially
due to zswap_insert_or_replace function which requires less lookups
than the initial implementation, but it's the btree API that made it possib=
le.

> > +     if (sizeof(pgoff_t) =3D=3D 8)
> > +             btree_pgofft_geo =3D &btree_geo64;
> > +     else
> > +             btree_pgofft_geo =3D &btree_geo32;
> > +
>
> You could abuse the fact that pgoff_t is the same size as unsigned long
> and use the "l" suffix variant.  But apart from the obvious abuse, the
> "l" variant hasn't been used before and the implementation appears to be
> buggy.
>
> So no complaints about your use of the interface.

Thanks! I would then keep it as is and have a task for myself to try out an=
d
possibly debug the "l" suffix variant later on.

~Vitaly
