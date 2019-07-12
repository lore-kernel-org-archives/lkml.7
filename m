Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED52BC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04CE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0iWFKLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfGLVJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:09:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35209 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:09:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so10093524wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GneF0+PbH/CRgotrMXeCWfRhR2ZKbCYB8PtMRk/UKrk=;
        b=Y0iWFKLooLZcj1W6PK6XujS67owj8oe3V29Xh3sd+1kjRMuvY4s9GgVCBprSwaKwac
         m7IMPNc51Gx6YfA/ZMg7/PVLrQleipaUAzauHBczJoXfTdpk0nN/zomniDmOqL0HkkBe
         n0ykO/1HHG9Hmr/tAN0+Ukxf/KtZqDH/D19xNlKNFcwpABv77teYqSn5Wm94Fqm6G2ui
         Nn40v2oatgJvVYHghQmqaLPI34io/yhNiZlfjO5FwnWCLoR5vGrvd471Lq6CgG6lmW12
         LFuLm8IQICod9lQVIfAD6FrhKtKRfCZqrvIpVEZnppLlzbpBYdafn0MPeWskSlv9NTns
         4e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GneF0+PbH/CRgotrMXeCWfRhR2ZKbCYB8PtMRk/UKrk=;
        b=D+nj7wlqMQawjimKQCHycR+m/HO6nFY1W0VHrxfrNXjtp7NqtBP2dMssO7/79Ui5Hj
         urgeRMKOEm4frEP0KdWmeFDO81/MXnvJjUhTMHIjCvyCeWVCbXQyg87cxdyEqalBdwbJ
         njJDf7s6QOu2IkOhQxZbeXEUlixge0BeAddsQNbXEHojCNI9bo4Pg77PnXYOacw/tlwF
         6e+OCn5mNoAVkHKaDZSJ6g3gIwXOq1h3cd7wb4TEF6walTeLk4jim6nGkpWsJOvkpOvF
         p27v6pm7XKIhZI40iG2J8fZBxAAdkZqRUvsDc6gXt7+JEnZ9a4e2G5VWncppB21/sndO
         kGGQ==
X-Gm-Message-State: APjAAAXg/uaB0kjpuBUfygMJsXMjiVzy2B3aH9dKxmOmEIf2BQT5ciYQ
        7p6oV8LJJrm+hr6S9C4ffywvRj6Hk56JAw==
X-Google-Smtp-Source: APXvYqzbZtk9rEf1yLBzHS12dgnTnxf/0E/Uapy9B1McjnO/pAW1it6p1pBG6Xtg1Kynr07VxMN0Ew==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr11660992wmj.13.1562965764726;
        Fri, 12 Jul 2019 14:09:24 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id g8sm11434363wme.20.2019.07.12.14.09.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 14:09:24 -0700 (PDT)
Date:   Fri, 12 Jul 2019 14:09:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
Message-ID: <20190712210922.GA102096@archlinux-threadripper>
References: <20190712073623.GA16253@kroah.com>
 <20190712074023.GD16253@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712074023.GD16253@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 09:40:23AM +0200, Greg KH wrote:
> On Fri, Jul 12, 2019 at 09:36:23AM +0200, Greg KH wrote:
> > The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:
> > 
> >   Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc1
> > 
> > for you to fetch changes up to c33d442328f556460b79aba6058adb37bb555389:
> > 
> >   debugfs: make error message a bit more verbose (2019-07-08 10:44:57 +0200)
> > 
> > ----------------------------------------------------------------
> > Driver Core and debugfs changes for 5.3-rc1
> > 
> > Here is the "big" driver core and debugfs changes for 5.3-rc1
> > 
> > It's a lot of different patches, all across the tree due to some api
> > changes and lots of debugfs cleanups.  Because of this, there is going
> > to be some merge issues with your tree at the moment, I'll follow up
> > with the expected resolutions to make it easier for you.
> > 
> > Other than the debugfs cleanups, in this set of changes we have:
> > 	- bus iteration function cleanups (will cause build warnings
> > 	  with s390 and coresight drivers in your tree)
> 
> And here is the patch that should resolve the coresight build issue.
> 

> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Mon, 1 Jul 2019 11:28:08 -0700
> Subject: [PATCH] coresight: Make the coresight_device_fwnode_match declaration's fwnode parameter const
> 
> drivers/hwtracing/coresight/coresight.c:1051:11: error: incompatible pointer types passing 'int (struct device *, void *)' to parameter of type 'int (*)(struct device *, const void *)' [-Werror,-Wincompatible-pointer-types]
>                                       coresight_device_fwnode_match);
>                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/device.h:173:17: note: passing argument to parameter 'match' here
>                                int (*match)(struct device *dev, const void *data));
>                                      ^
> 1 error generated.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 8b07fe55395a..7d401790dd7e 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -202,6 +202,6 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
>  
>  void coresight_release_platform_data(struct coresight_platform_data *pdata);
>  
> -int coresight_device_fwnode_match(struct device *dev, void *fwnode);
> +int coresight_device_fwnode_match(struct device *dev, const void *fwnode);
>  
>  #endif
> -- 
> 2.22.0
> 

Doesn't look like this made it into the merge, as I currently see that
same error with arm64 allyesconfig.

Cheers,
Nathan
