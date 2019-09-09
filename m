Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2927C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4011218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf7NSQaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404470AbfIILuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:50:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42742 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbfIILuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:50:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id c10so12095216otd.9;
        Mon, 09 Sep 2019 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tYnsX9gd/pntTIlgQ4B4VyJYL3dGeU36BYiNg93weko=;
        b=Lf7NSQawSCbhe/k3IJI1TCfhjpU0Y50olZ8SjBlQ9hCwUy6fpOWWBbCPNR+hH4nrVz
         Hwxk/Tj2RIJhqJgPHUYalGiHKyto6UmbF7nSjZhaSuTalrDaESOrIi4flyE7pjp00Zmo
         NxUnJaORjgsp6P6ixx7vEhCmzYyCXctFDkPqWKKK1hKrvq6fU4W/vAJqYnXiiucZV4JL
         68bLHtzxBU1oEEaIt+GfrSrh4hsKV4uvo6OUrzebd/+9wWDCOi3nes1rCtyfokF0TQRJ
         vYJdeTYOggNaey5ZVKYmMslDrVxRrzbfGO2rCm2tENMJZik9pQbW5QGQlrJmO+ZAMVvM
         NcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYnsX9gd/pntTIlgQ4B4VyJYL3dGeU36BYiNg93weko=;
        b=SSpgEuksJQdree50M+ubWC9aBWesfrsr9McCZcAtQopvAyvK9eQgwXutD99D0nOGv1
         WGvRnBXRt13WAS2Rd5H7NHPeTL0Q2WG7pOsHx7ddvGjztG76pds3IOJU0523qVGaNIhb
         JnsGjwueSbkzqaEg6mQ6PmdfVqZmACYKGyj59NxYx/eFbo/7wJIV/MnjWywNMcSkluYz
         n0FjYX3Kph9uZ1VGQibpIuyHZwouYbNvs1xb7W+4yBCqQMScM91R46CGQxfBud4D98pY
         FzufGV/dyJ/9QbxubJQdZsCpjc++Rx49Dwd/lNPpyQ/5FWYxzuzdCiIyFDSUi4YvFgGc
         O9xw==
X-Gm-Message-State: APjAAAUAalRZ0xW4/AGyoo+biHls6XrHHXCEh6KjkMjHBbDIdjNmY+S6
        EH89LBXw4QeOkLBHPUy6bvA=
X-Google-Smtp-Source: APXvYqz81/sZ3Pkc0lWDmNidgRCXz5Zv7nL6cj+W80+6srRNn+yisnyhjFJfvIBGQa2+i/z6zOhiWw==
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr19038806otc.301.1568029807760;
        Mon, 09 Sep 2019 04:50:07 -0700 (PDT)
Received: from sreeram-MS-7B98 (cpe-173-174-83-82.austin.res.rr.com. [173.174.83.82])
        by smtp.gmail.com with ESMTPSA id o4sm5379170otp.43.2019.09.09.04.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 04:50:07 -0700 (PDT)
Date:   Mon, 9 Sep 2019 06:50:06 -0500
From:   Sreeram Veluthakkal <srrmvlt@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        nishadkamdar@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, payal.s.kshirsagar.98@gmail.com
Subject: Re: [PATCH] FBTFT: fb_agm1264k: usleep_range is preferred over udelay
Message-ID: <20190909115006.GB3437@sreeram-MS-7B98>
References: <20190909012605.15051-1-srrmvlt@gmail.com>
 <20190909095625.GB17624@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909095625.GB17624@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:56:25AM +0100, Greg KH wrote:
> On Sun, Sep 08, 2019 at 08:26:05PM -0500, Sreeram Veluthakkal wrote:
> > This patch fixes the issue:
> > FILE: drivers/staging/fbtft/fb_agm1264k-fl.c:88:
> > CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> > +       udelay(20);
> > 
> > Signed-off-by: Sreeram Veluthakkal <srrmvlt@gmail.com>
> > ---
> >  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > index eeeeec97ad27..2dece71fd3b5 100644
> > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> >  	dev_dbg(par->info->device, "%s()\n", __func__);
> >  
> >  	gpiod_set_value(par->gpio.reset, 0);
> > -	udelay(20);
> > +	usleep_range(20, 40);
> 
> Is it "safe" to wait 40?  This kind of change you can only do if you
> know this is correct.  Have you tested this with hardware?
> 
> thanks,
> 
> greg k-h

Hi Greg, No I haven't tested it, I don't have the hw. I dug depeer in to the usleep_range

https://github.com/torvalds/linux/blob/master/kernel/time/timer.c#L1993
	u64 delta = (u64)(max - min) * NSEC_PER_USEC;

 * The @delta argument gives the kernel the freedom to schedule the
 * actual wakeup to a time that is both power and performance friendly.
 * The kernel give the normal best effort behavior for "@expires+@delta",
 * but may decide to fire the timer earlier, but no earlier than @expires.

My understanding is that keeping delta 0 (min=max=20) would be equivalent. 
I can revise the patch to usleep_range(20, 20) or usleep_range(20, 21) for a 1 usec delta.
What do you suggest?

thanks,
Sreeram
