Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ED0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AE420879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPoE1xQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfEVP5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:57:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44097 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfEVP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:57:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so1277779pll.11;
        Wed, 22 May 2019 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmNGy/NFq2EOHvqVIGC3ySGjBTZpA5aNPHZwt8OoqlI=;
        b=PPoE1xQw3nra2WTRsZTaBZCtml6jPMVGPz706uZ+mCYLvT6e/vL+EE3yEKwTetPNlv
         JVokWZV0PVWmDrQ60rzh0mkexLrDVG+EB4cg1bG0H7sfjvcpRA9AXAta5KV5EFpC87an
         4JEZ0Emc577+64EdrmvL2uugj1A06eNNhIEC0AVxxZGqxFC3oyTYn2ZyywA4CsI/9uNj
         BMD8+VnLIMrHQ10JsFYNe11eZ2rd9L4DbTMYIgBxvDGhNDLWEEo6j4jg0VqIZXw2JFCt
         k2WqgAYlBmUOdqp7AyV12AF11INdzHUGgX7xt6M+q08baRHD59mpCCf2GqR4iYkEM7pm
         Zj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmNGy/NFq2EOHvqVIGC3ySGjBTZpA5aNPHZwt8OoqlI=;
        b=oth7Bb1boQ27hxqGL+JzjJZXN2fzam5Hh39k7mHdMle/Dg5qKkIWvsgU3HWzi3QZH1
         5a2MekctzGDArTlRD4SdVkZZ6dK+/1Xw7e8rFpykIr1DvtviweVrU2NujF4SDlqvN7G+
         Ew1n09Kd9rLgaUOcKyJrrXqf2SOw7dBApzlVwpJpMEv/sHqAGc9sPhzftpVjTItP9oxy
         iz/qz3NCE/RLS/IsKMBbYh9VMmN5aw3rjR2XM/WaBLTz45jN/CA5mE89CSDZGRKeLEos
         MPIT99dApZi/NEvgTy0NJzfS36xIDA69j0WkhvayYovMyK7tNmWAJtaglIhjx/08dSaL
         cQFQ==
X-Gm-Message-State: APjAAAWZ6xMbb5I93ngPi3sY+VTiA2S3yDjoWjiy5vBnPEvESGmVKFH5
        Xh8e9330Dodb6ECA72zrmxw=
X-Google-Smtp-Source: APXvYqwjIBzw5VgJ5UcxwexYB5MRjuc3hXWK1BuvqP2lReBMDIXLKnpXPeFEGo0eWjohrsL3X9FDoA==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr91573274pld.320.1558540624927;
        Wed, 22 May 2019 08:57:04 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id t7sm29962927pfh.156.2019.05.22.08.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:57:04 -0700 (PDT)
Date:   Wed, 22 May 2019 21:26:57 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] message/fusion/mptbase.c: Use kmemdup instead of memcpy
 and kmalloc
Message-ID: <20190522155657.GA12887@bharath12345-Inspiron-5559>
References: <20190522095335.GA3212@bharath12345-Inspiron-5559>
 <7e2a727333d1d764ae3c0099e050a0521e87d9d8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e2a727333d1d764ae3c0099e050a0521e87d9d8.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 04:48:33AM -0700, Joe Perches wrote:
> On Wed, 2019-05-22 at 15:23 +0530, Bharath Vedartham wrote:
> > Replace kmalloc + memcpy with kmemdup.
> > This was reported by coccinelle.
> []
> > diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> []
> > @@ -6001,13 +6001,12 @@ mpt_findImVolumes(MPT_ADAPTER *ioc)
> >  	if (mpt_config(ioc, &cfg) != 0)
> >  		goto out;
> >  
> > -	mem = kmalloc(iocpage2sz, GFP_KERNEL);
> > +	mem = kmemdup((u8 *)pIoc2, iocpage2sz, GFP_KERNEL);
> 
> You should remove the unnecessary cast here.
> 
>
Yes! I will change this in v2.

Thanks
Bharath
