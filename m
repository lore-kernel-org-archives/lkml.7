Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C16DC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 19:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650DE208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BITyB6XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfL1Tvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 14:51:35 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42846 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1Tvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 14:51:35 -0500
Received: by mail-il1-f194.google.com with SMTP id t2so9577204ilq.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 11:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgrDpnKqQu8o7QySWZrrmXPDct3+6ttAT3lHQXUR6f4=;
        b=BITyB6XZ5oqhINwxYA54lZxPQg6t7SFW0QPtjhUKJQi9/XrZpWgj6FE0EJuEHKJUeo
         QIOxtaYXBr0EqMA1uksYGKj4WO/25CCSMl/5cohGkYtsTmuBFqNemF580ojOiCLVqOve
         /dQ7famLosR4f1Lk9BRm0dfyfm669HtcfpmHDcGfPRRaVtVFaFgZyqjsbb5I2tdVrfTS
         Vj/TkMd/22usPPFsWtyYcs+PaidBs9r6FkMxv9fqqecGIwIpdwjrawXVsQGPBqAyF4Ke
         L67cRIJfGJlNLHdf3U+5cCn+J2/urIWKEcU1NLR/IMnpGf79RZ8eGolHAM231MymOnrf
         bUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgrDpnKqQu8o7QySWZrrmXPDct3+6ttAT3lHQXUR6f4=;
        b=mZ+sgXE82BuahhPlM99m9aA9oghiO6woU8LLoAH+0Kslk5O0Xo76Hs0KedIdT/ehbO
         BoAZSNZQeEY+6Yp93Neb5a13i9K0zY81mb8ckimj9SYkB4ouBZ+NRmRuJ0LZwi/Wm8R9
         /o9Zl3otPlN/YtMvZatSOtr7c8XrWKifEyIWs1+YDcd5nGVWE3FHhxpiN/W1znaYE7Kd
         qu5u4I5gxexHBx0T+Rlo8kKi4Af7ai+4xG1RAyrEN5G54U9ZdJceIAb1mdZ9ZRjOjEWc
         mnVc2PeHxwlRfnM61YsKR2WR9fkhCzh0+sk44ww9Kwt9zEOofwTPrncrRSgZcszJ3mSZ
         QIYQ==
X-Gm-Message-State: APjAAAXioJIlcUzHRf01JgZcTAkZ1t64zS92kslc7h5w4vGwKEZY7cY+
        beP8/7Z1BXtZgrYXubNYnIEm6dUeMD1yPd8qjHU=
X-Google-Smtp-Source: APXvYqwb+xSqiugn6gmak6DJwQImsEfOyDAalG1XUlTr29NWKv2rB4cGgRJURhBDfYZUEtlE277tUbpbzOQXl5TaGNs=
X-Received: by 2002:a92:1906:: with SMTP id 6mr52124485ilz.130.1577562694248;
 Sat, 28 Dec 2019 11:51:34 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.99999.375.1912201332260.21037@trent.utfs.org> <alpine.DEB.2.21.99999.375.1912261445200.21037@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.21.99999.375.1912261445200.21037@trent.utfs.org>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 28 Dec 2019 11:51:23 -0800
Message-ID: <CABeXuvqimxsa45ir-zpOQS_1M5buPaT3VMvigqo6oTUgMj0z8g@mail.gmail.com>
Subject: Re: [PATCH] Re: filesystem being remounted supports timestamps until 2038
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 5:54 PM Christian Kujau <lists@nerdbynature.de> wrote:
>
> On Fri, 20 Dec 2019, Christian Kujau wrote:
> > I noticed the following messages in my dmesg:
> >
> >  xfs filesystem being remounted at /mnt/disk supports imestamps until 2038 (0x7fffffff)
> >
> > These messages get printed over and over again because /mnt/disk is
> > usually a read-only mount that is remounted (rw) a couple of times a day
> > for backup purposes.
> >
> > I see that these messages have been introduced with f8b92ba67c5d ("mount:
> > Add mount warning for impending timestamp expiry") resp. 0ecee6699064
> > ("fix use-after-free of mount in mnt_warn_timestamp_expiry()") and I was
> > wondering if there is any chance to either adjust this to pr_debug (but
> > then it would still show up in dmesg, right?) or to only warn once when
> > it's mounted, but not on re-mount?

The warnings only make sense when you mount the filesystem rw because
it is the updating of timestamps that fail.
We can discuss what the log level of such messages should be.
pr_warn() seems correct to me to serve the purpose of the feature.
And, warning at the site of remount as rw seems correct also rather
than at the site of mount.
Maybe checking if it was already a rw mount and only warning the first
time might alleviate your problem? Adding Arnd and Al to see if they
have any suggestions.

-Deepa

> I realize that "it's the holidays", but it'd be a shame if this gets
> forgotten :(
>
>
> # uptime; dmesg | grep -c 2038
>  14:45:15 up 6 days, 21:16,  1 user,  load average: 0.20, 0.22, 0.27
> 350
>
> Attached is a "fix" that changes pr_warn into pr_debug, but that's maybe
> not what was intended here.
>
>
> Thanks,
> Christian.
>
>
> commit c9a5338b4930cdf99073042de0717db43d7b75be
> Author: Christian Kujau <lists@nerdbynature.de>
> Date:   Thu Dec 26 17:39:57 2019 -0800
>
>     Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry") resp.
>     0ecee6699064 ("fix use-after-free of mount in mnt_warn_timestamp_expiry()") introduced
>     a pr_warn message and the following gets sent to dmesg on every remount:
>
>      [...] filesystem being remounted at /mnt supports timestamps until 2038 (0x7fffffff)
>
>     When file systems are remounted a couple of times per day (e.g. rw/ro for backup
>     purposes), dmesg gets flooded with these messages. Change pr_warn into pr_debug
>     to make it stop.
>
>     Signed-off-by: Christian Kujau <lists@nerdbynature.de>
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index be601d3a8008..afc6a13e7316 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2478,7 +2478,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
>
>                 time64_to_tm(sb->s_time_max, 0, &tm);
>
> -               pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
> +               pr_debug("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
>                         sb->s_type->name,
>                         is_mounted(mnt) ? "remounted" : "mounted",
>                         mntpath,
>
>
>
> -- BOFH excuse #132:
>
> SCSI Chain overterminated
