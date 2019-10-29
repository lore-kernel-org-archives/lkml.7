Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4A4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F5A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wavt2/1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfJ2InZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:43:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41696 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfJ2InZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:43:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id p4so12628931wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Y1e6eXMXynj3RVm6A/v7p+Rx7z46GaGYsW4oOsjovc=;
        b=wavt2/1wTjV79EJap7JbgnE2Twi+9BnBLl1BHzBNl3vIs2ZXYZ5HrrxkfM3CKwswgj
         sw6aeOhyfWasmAuDA08IFOYHsMO5LIBf5pt7y/wA3OVWD1tdoJBDyMNGJDcZHed3K0hQ
         TGIps6ZZGwOZNPavurYTlkGlU30hmfoZIJOEcYN97v5MIS0O24fHR+K8ChWaH2zKHIsh
         ICO8D+vwppTHPxR+5+JldQ3zx6FnSsFOXwCb8M9bkBt88WuwnipSdlRin1MJUpzqVmXp
         EVrEom4gkCv75CNw3zuLBldoeXeMrrVQ1LiZ6DAEtqXZf6rd2VdeislzDMV+Bh1GEfnV
         poIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Y1e6eXMXynj3RVm6A/v7p+Rx7z46GaGYsW4oOsjovc=;
        b=njNlhyjuabjo5g+co/oHC0zZOtk0b10lXf3NCWE7dv/FmsVQTke1e/HJjiVE4ujLdA
         6sMs47V09UExAXtho+QKst/CCwBxcsszAObWO/GDNk7iyGRbnCRSTEXyAgkOOlHxgl3p
         GHGiVkSRGARxyvB/YUd66msyEVwaPeaivh5vsJ4QudgKKBr546YXidJBTcEFwb8PCvv+
         li18fFBPlU9NDjbbwbE4BzRBK0ZbN6Et8l1tQSBIeYMjT+iZrHvJ8FNkEjWT6KySrwKs
         XlIgLYeH+G8Ryxny3NUHwIaQBGgHdGLu0gKsJOAWyMv9nZ63VofWEQ4JTEX+3RxYwoKe
         8+Hw==
X-Gm-Message-State: APjAAAV2PJjSGbhlLnRDdUUQyK4W+xoPhnEsYydAo9Bs2NhvwTUVNm37
        T594DbFg30/0jT2+nZyl/Z2avA==
X-Google-Smtp-Source: APXvYqx+LFWSW8vxJhxbdOsjx1jGLoXPJPKXrqqM25niggkWBSCsM/ioC7zlbwA136enGM6e3I1O9g==
X-Received: by 2002:adf:f152:: with SMTP id y18mr19562113wro.285.1572338603282;
        Tue, 29 Oct 2019 01:43:23 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id p10sm15381693wrx.2.2019.10.29.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:43:22 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:43:21 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     kvalo@codeaurora.org, davem@davemloft.net, swinslow@gmail.com,
        will@kernel.org, opensource@jilayne.com, baijiaju1990@gmail.com,
        tglx@linutronix.de, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] b43: Fix use true/false for bool type
Message-ID: <20191029084320.GC23615@netronome.com>
References: <20191028190204.GA27248@saurav>
 <20191029082427.GB23615@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029082427.GB23615@netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 09:24:27AM +0100, Simon Horman wrote:
> Hi Saurav,
> 
> thanks for your patch.
> 
> On Tue, Oct 29, 2019 at 12:32:04AM +0530, Saurav Girepunje wrote:
> > use true/false on bool type variable assignment.
> > 
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> 
> This does not seem to cover the case in dma.c,
> which seems to want fixing for the sake of consistency.

I now see this handled in a separate patch, sorry for the noise.

> Also, I wonder why bools rather than a bitmask was chosen
> for this field, it seems rather space intensive in its current form.
> 
> > ---
> >  drivers/net/wireless/broadcom/b43/main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
> > index b85603e91c7a..39da1a4c30ac 100644
> > --- a/drivers/net/wireless/broadcom/b43/main.c
> > +++ b/drivers/net/wireless/broadcom/b43/main.c
> > @@ -3600,7 +3600,7 @@ static void b43_tx_work(struct work_struct *work)
> >  			else
> >  				err = b43_dma_tx(dev, skb);
> >  			if (err == -ENOSPC) {
> > -				wl->tx_queue_stopped[queue_num] = 1;
> > +				wl->tx_queue_stopped[queue_num] = true;
> >  				ieee80211_stop_queue(wl->hw, queue_num);
> >  				skb_queue_head(&wl->tx_queue[queue_num], skb);
> >  				break;
> > @@ -3611,7 +3611,7 @@ static void b43_tx_work(struct work_struct *work)
> >  		}
> >  
> >  		if (!err)
> > -			wl->tx_queue_stopped[queue_num] = 0;
> > +			wl->tx_queue_stopped[queue_num] = false;
> >  	}
> >  
> >  #if B43_DEBUG
> > @@ -5603,7 +5603,7 @@ static struct b43_wl *b43_wireless_init(struct b43_bus_dev *dev)
> >  	/* Initialize queues and flags. */
> >  	for (queue_num = 0; queue_num < B43_QOS_QUEUE_NUM; queue_num++) {
> >  		skb_queue_head_init(&wl->tx_queue[queue_num]);
> > -		wl->tx_queue_stopped[queue_num] = 0;
> > +		wl->tx_queue_stopped[queue_num] = false;
> >  	}
> >  
> >  	snprintf(chip_name, ARRAY_SIZE(chip_name),
> > -- 
> > 2.20.1
> > 
> 
