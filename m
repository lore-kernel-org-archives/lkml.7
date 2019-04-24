Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588C9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2819B21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TLGuPGYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfDXKw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:52:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33093 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfDXKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:52:58 -0400
Received: by mail-it1-f193.google.com with SMTP id v8so5038866itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOy7JEgPo4evGALE7vtbJbbdRzccQOcXF9u3/Lr+Ou8=;
        b=TLGuPGYduviv1G7wE7tR0VQpHrP87uQ5NMWS2BAwv9zzjreMpdeejnOdbnFhh1af5x
         5PZXskVBx1z7UXpBry+/u5EZlB2PPGxdeyTMJ3C9ZMu4DlAoqNgz1JB2LTltG6aymYel
         8lrreUFAFzTNEQf5XI2cZNh1fp2S+p+EctxOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOy7JEgPo4evGALE7vtbJbbdRzccQOcXF9u3/Lr+Ou8=;
        b=X9KEKnudPnFRjrJ9rSt/YpbER4+C6C1aZcQzrpRCpSd7PSWkM45f4p4ybQPCWdRDle
         wc5O2ZoAWAXhZokPbiFfiiA/fV9oDfuaQwXjpfvm2A6g97RgTe26/257Ws/u/EpfI0Z2
         Vd6R0GJ8XUriPX2TgQjtUWppurjG8N17FVQFQRI4F/t52PsPCl65uKKuYZr7TLhhZWxO
         2M9LWCmDEHRIywLan1O5Uts+tIauXgez0PYsdMdHKf7e56fAYtEAFvrxWC9UewijQ1iW
         K8yfrtNu6OaeT8zAMrk7GXeAWm8+w6K+zNTGJ96xV3GUrj6n6gUFUtixWie16oQ19mhI
         jQ2g==
X-Gm-Message-State: APjAAAViwXPx1TS0Bwr9K9ESX7Uji/J1FfyiTZSZCNkBkGBG7Hn1+MpP
        y3E/bd+dz/BYxlOkDv2WvIWbAgS2SzatBWDDDY92qQ==
X-Google-Smtp-Source: APXvYqzFLULQoHPi5ak7v0UkfhKMrUKdTMr6VDcFQK3eii0CeeCx7JqZqFWl4nAGfQ+hAcTI1F92+cGPHzAiynOFRqM=
X-Received: by 2002:a24:1312:: with SMTP id 18mr5469221itz.121.1556103177810;
 Wed, 24 Apr 2019 03:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190301170831.23612-1-abbotti@mev.co.uk> <CAJfpegsQvUGz-YRQVrfkTWuSFe==Hg_Y=VpV0ZagKe0qGfxQ7g@mail.gmail.com>
 <d2bab6ae-0c52-5a6a-78e4-72a5f298a85f@mev.co.uk>
In-Reply-To: <d2bab6ae-0c52-5a6a-78e4-72a5f298a85f@mev.co.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 12:52:46 +0200
Message-ID: <CAJfpegvhvS2KEP3kFsSGXONVuBdSdpgy8OGqd79ehN0uGAy5VA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add ioctl flag for compat ioctl with 64-bit time_t
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 5:14 PM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> On 23/04/2019 13:55, Miklos Szeredi wrote:
> > On Fri, Mar 1, 2019 at 6:08 PM Ian Abbott <abbotti@mev.co.uk> wrote:
> >>
> >> Currently, a CUSE server running on a 64-bit kernel can tell when an
> >> ioctl request comes from a process running a 32-bit ABI, but cannot tell
> >> whether the requesting process is using legacy IA32 emulation or x32
> >> ABI, for example.  In particular, the server does not know the size of
> >> the client process's `time_t` type.
> >>
> >> For 64-bit kernels, the `FUSE_IOCTL_COMPAT` and `FUSE_IOCTL_32BIT` flags
> >> are currently set in the ioctl input request (`struct fuse_ioctl_in`
> >> member `flags`) for a 32-bit requesting process.  This patch defines a
> >> new flag `FUSE_IOCTL_COMPAT_64TIME` and sets it if the 32-bit requesting
> >> process (running on a 64-bit kernel) uses a 64-bit `time_t` type.
> >
> > Hi,
> >
> > Thanks for the patch.
> >
> > I think it should rather use in_x32_syscall() helper and follow that
> > naming because there's apparently at least one example in xfs of a
> > non-time_t related ioctl that varies between the x32 vs ia32.
>
> Hi Miklos,
>
> It is conceivable that COMPAT_USE_64BIT_TIME could be true for some
> other arch/ABI (although currently it is only ever set for x86/x32).
> Should it have separate flags for "compat 64-bit time" and "compat x32"
> (even though that is currently redundant)?

No, it should just be a single flag, something like
FUSE_IOCTL_COMPAT_X32 and the documentation should say that it implies
64bit time values.

Thanks,
Miklos
