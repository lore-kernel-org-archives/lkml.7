Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D79C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08366208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642490;
	bh=XYCCoPrRRuzOfBI7pKGY7LofKOJEhlcnqyMDEA4Xv6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=St2FJq6S0zIYn/+6rvd5WtLV6PEMyblvpIKNp5KFC/sLBb6VmfCpJTwPln7/ZBFcA
	 9ti+rBIoXyNj0DrRTE7RNlANkmM+FJI6buXT3hag0v9gsmCnu+N1v5hpoU15GP+EDs
	 T4qJj5KqnWGsDfQAET5HRGPEDhO8rn1E0uYb2QH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbfL2SB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:01:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33879 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387782AbfL2SBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 13:01:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so26540350ljg.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 10:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCSyB9m2Zr88NnL3FxL3EFrZeLkiQfHBJKQ2fbjaRy0=;
        b=Zn1G7f9Wur2twW/A1nhOhlBUw+rZSU4KgagykOVLG/mVxiw8gW/VYpb4eCWoEPdCDx
         WMZAWZFqvfV/gPJdEmm9Cx7J8/GAo0zBCvZ4o/N2ZAIShtPmuLha94Qq4abIb8F0amMg
         t9bnShkSiB80XNG5EgOUQb62S+8x7OTRnejH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCSyB9m2Zr88NnL3FxL3EFrZeLkiQfHBJKQ2fbjaRy0=;
        b=E4w9A1ku1JRSNoVJ+qeWmxJXjHRkr50f6n9wz65pugClcTQNZOg/IxcYXp3IVRIKgG
         lHF2gYu6QSTxNMicy0IC59yLH2tdd1HTsu+HnWtJilmv++lPvwAZFgBfcBFZKNsl4CMp
         hjX2YFRNcaUqve2F9CdHFbOA9AtS8V/TUIeBzcbUkwEB6vR5EO4RVILcbiSLrqOTtfWO
         98faIp7zNpnsKXEt52SjRq7NoR7uMD3iMgt2ZQzFv7BxrNyqq8NbnA3Szbv1P6dALb2v
         6v8mRgKduWxgg0EjCed6N4k2X+933OkPdJpWjaiUcVeshHGdJ1HrgOvvdjtAR/Qvw4ZK
         DtdA==
X-Gm-Message-State: APjAAAVpiouK5mjcUQwzXBCj6u3ZRmb90B+MAcNTSiA7N3/RNsiun9wq
        mJ2mkiOaCrhYDp9TWFp6/OMbPWr1hBM=
X-Google-Smtp-Source: APXvYqxL5CrdqM3dANY+A7BaZzdLczgc1NOuEsa+cFTRn/g3aW9RWRIzZA3awOqa0UnKUCrbWRCEVA==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr14234760ljk.245.1577642481624;
        Sun, 29 Dec 2019 10:01:21 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m8sm17570464lfp.4.2019.12.29.10.01.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 10:01:20 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id h23so31350144ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 10:01:20 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr35276819ljg.133.1577642480289;
 Sun, 29 Dec 2019 10:01:20 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.99999.375.1912201332260.21037@trent.utfs.org> <alpine.DEB.2.21.99999.375.1912261445200.21037@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.21.99999.375.1912261445200.21037@trent.utfs.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Dec 2019 10:01:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com>
Message-ID: <CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com>
Subject: Re: [PATCH] Re: filesystem being remounted supports timestamps until 2038
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 5:54 PM Christian Kujau <lists@nerdbynature.de> wrote:
>
>     When file systems are remounted a couple of times per day (e.g. rw/ro for backup
>     purposes), dmesg gets flooded with these messages. Change pr_warn into pr_debug
>     to make it stop.

How about just doing it once per mount?

IOW, if your issue is that you re-mount things read-only for backups
and then remount it rw again soon afterwards, but it's not actually
_unmounted_, maybe you could instead just add a flag to the 'struct
super_block' saying "this mount has been warned about already"?

That would seem to make sense regardless. No? Partoicularly since we
also don't want to warn multiple times just because the same thing
gets mounted in multiple places.

Of course, if you actually unmount and completely re-mount a
filesystem, then that would still warn multiple times, but at that
point I think it's reasonable to do.

                Linus
