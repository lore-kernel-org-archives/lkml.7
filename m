Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E724820830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOHzuPSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfEFFDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 01:03:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52204 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfEFFDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:03:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id o189so3073224wmb.1;
        Sun, 05 May 2019 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0iwgFxx37HBfD23g1KI0JAhY1B0UoYTsAYZb53CyeGM=;
        b=XOHzuPSuLJL/Z10dbyoEM7k+gBvAnZCCF6rys475o3DudxtZhkJs94DWcWh36Tx5Q2
         6veOGvtrG/zfcjByqw9WJr9sF1L89x3/ner70GXftq3Xpx+eO4w5sz5Ep4lFeffoYuQW
         oz9xDZkMJyxn5G4h3srytj2jHzjlr5jgWbK4WRl5MmDANdruV3ipHTQ8IofQwb030C5D
         EBLLyRHp4eIZkMck4c/1gyfxR9bwUpbRbor8qXPOMtl3RFWQojQJ4ClZXzcZPLY2jgjW
         AyJgzRDb5TDXx/JFdJo3p6x5x3KmO+Im1SUL8xkkngPcUtFtYMGh5YwJbIeneqCfAz/f
         yK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0iwgFxx37HBfD23g1KI0JAhY1B0UoYTsAYZb53CyeGM=;
        b=DSIk4LQcH0RM8osBGxnlRuG7UY04uPHGqedhfRBvquA0KFJdINXoHHYg+bd9Z7pZDc
         UO/3+qIA54LJrAWwKH5CMTJxxSKrMcPptshCuXZqR94GUPY2+FLqHGKYyxAvKf8vFD3l
         cdYMYEnXG346HdnYYq6AqUh4xmxU/iAYGc2tIZQNpYfBm8MWETDAzCbaNzMJLoRgpCBf
         XAqBv2em+gS+4FcUzBvxuG1ibpAMi+fCUM3esbpEx6RCw3cMEPjzxjQsWz5BSRIrOLrk
         Q6pBK0lGHt/N96hvtS5HXMhHsQMiKfp757tre1RNTQNk4GclMF352xnCcll955BY5YkQ
         z9uA==
X-Gm-Message-State: APjAAAUq9OSoDy8e/AF7g7s0qhgwU0i3PGoRnSMibVO5B4fpcHctDCW6
        aqnRWiksY5cTs5UWldUFTQs=
X-Google-Smtp-Source: APXvYqxyUHJ5oByujLOvgNslNZ7DkEs7RGhkEdCGJuBgVCX2dCxAWCXjkXO3ymAjpKXP8Uc4QuFjcA==
X-Received: by 2002:a1c:cf83:: with SMTP id f125mr14014904wmg.96.1557118996660;
        Sun, 05 May 2019 22:03:16 -0700 (PDT)
Received: from felia ([2001:16b8:2d26:d900:408f:de1d:7b39:73c4])
        by smtp.gmail.com with ESMTPSA id j13sm31019135wrd.88.2019.05.05.22.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 22:03:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 6 May 2019 07:03:00 +0200 (CEST)
X-X-Sender: lukas@felia
To:     NeilBrown <neilb@suse.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shaohua Li <shli@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Himanshu Jha <himanshujha199639@gmail.com>,
        clang-built-linux@googlegroups.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md: properly lock and unlock in rdev_attr_store()
In-Reply-To: <877ebd693t.fsf@notabene.neil.brown.name>
Message-ID: <alpine.DEB.2.21.1905060657010.2480@felia>
References: <20190428104041.11262-1-lukas.bulwahn@gmail.com> <877ebd693t.fsf@notabene.neil.brown.name>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Apr 2019, NeilBrown wrote:

> On Sun, Apr 28 2019, Lukas Bulwahn wrote:
> 
> > rdev_attr_store() should lock and unlock mddev->reconfig_mutex in a
> > balanced way with mddev_lock() and mddev_unlock().
> 
> It does.
> 
> >
> > But when rdev->mddev is NULL, rdev_attr_store() would try to unlock
> > without locking before. Resolve this locking issue..
> 
> This is incorrect.
> 
> >
> > This locking issue was detected with Clang Thread Safety Analyser:
> 
> Either the Clang Thread Safety Analyser is broken, or you used it
> incorrectly.
>

Please ignore this patch.

Clang Thread Safety Analyser cannot handle the original code, but can
handle my semantically equivalent code. I did not get that at first, and
thought I fixed an issue, but I did not.

Sorry for the noise.

Lukas
 
> >
> > drivers/md/md.c:3393:3: warning: releasing mutex 'mddev->reconfig_mutex' that was not held [-Wthread-safety-analysis]
> >                 mddev_unlock(mddev);
> >                 ^
> >
> > This warning was reported after annotating mutex functions and
> > mddev_lock() and mddev_unlock().
> >
> > Fixes: 27c529bb8e90 ("md: lock access to rdev attributes properly")
> > Link: https://groups.google.com/d/topic/clang-built-linux/CvBiiQLB0H4/discussion
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Arnd, Neil, here a proposal to fix lock and unlocking asymmetry.
> >
> > I quite sure that if mddev is NULL, it should just return.
> 
> If mddev is NULL, the code does return (with -EBUSY).  All you've done
> is change things so it returns from a different part of the code.  You
> haven't changed the behaviour at all.
> 
> >
> > I am still puzzled if the return value from mddev_lock() should be really
> > return by rdev_attr_store() when it is not 0. But that was the behaviour
> > before, so I will keep it that way.
> 
> Certainly it should. mddev_lock() either returns 0 to indicate success
> or -EINTR if it received a signal.
> If it was interrupted by a signal, then rdev_attr_store() should return
> -EINTR as well.
> 
> As Arnd tried to explain, the only possible problem here is that the C
> compiler is allowed to assume that rdev->mddev never changes value, so
> in
>    rv = mddev ? mddev_lock(mddev) : =EBUSY
> 
> it could load rdev->mddev, test if it is NULL, then load it again and
> pass that value to mddev_lock() - the new value might be NULL which
> would cause problems.
> 
> This could be fixed by changing
> 
> 	struct mddev *mddev = rdev->mddev;
> to
> 	struct mddev *mddev = READ_ONCE(rdev->mddev);
> 
> That is the only change that might be useful here.
> 
> NeilBrown
> 
> 
> >
> >  drivers/md/md.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 05ffffb8b769..a9735d8f1e70 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -3384,7 +3384,9 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
> >  		return -EIO;
> >  	if (!capable(CAP_SYS_ADMIN))
> >  		return -EACCES;
> > -	rv = mddev ? mddev_lock(mddev): -EBUSY;
> > +	if (!mddev)
> > +		return -EBUSY;
> > +	rv = mddev_lock(mddev);
> >  	if (!rv) {
> >  		if (rdev->mddev == NULL)
> >  			rv = -EBUSY;
> > -- 
> > 2.17.1
> 
