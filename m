Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_MISSP_FREEMAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB946ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9355020854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LobMO/1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390973AbfJPHmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:42:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40904 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfJPHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:42:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id e13so5563892pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THg5AIRpzEMlPPt8spygiynKMTygfSswC7awShDdMxU=;
        b=LobMO/1OtmSkqdhcKBbbKNeFpMIP4hoHsRV4p1VCHldVwZ2SRicw5VVUb6sNSwKbnq
         VByBnG30mUKPa/sgQ5CddllExySAv+bvMVNglTtD02F6r/aDtsrzrTAgwHu3zs7ZLp8f
         Ox3OUs2ZqdmEiLFIbVVhkh42diPZLCX/I+lrtQrwBYWJhpU3cQBLQYIv9Cz3rptDcT5m
         fYV0Fsei2nCyxuIJ9V8Vlq6W5+zaQ0Y33nz2ONgz3gKrXj61WzD2nGF8Po5T2ka0L5Nm
         Qq13EyOESKDZy6N8pv7QrCTbJTovR+g3W19r+3CyBaK8dvnlZiGju/7rWMIqhQDXchV1
         ulew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=THg5AIRpzEMlPPt8spygiynKMTygfSswC7awShDdMxU=;
        b=lzypU2bH8FQ4Y5gH+SW49Z8KdQ2DSuDYOi1EJt1r4BjC904NVBHP3ElDRaeFAKA+KG
         MQA3671tK5fPfRrUwtmTNUfd9Dtpdn/Hakw+oVR4iarbTJnr++LX9aPuVL4hwR/7v4TL
         3tFZb2ObnbBTdVqTb2VzFPRMeCxTlFcOBOVLKNMvbFUSUjHs0kUU34pCMA6XUtXLYb/U
         5pWU6Uj5pw3p15Mo3I2zB0Dblc/Fm+0cweDKUOwFm4GMXnNaVfWCk/f2t4nwz/w/4ftJ
         XxELJakuwGkUummoUcNitBIEmf1lTwoT6I4C+qtIBxz3szMWVGfJ/1oLkyjYuAndLhMq
         b/bg==
X-Gm-Message-State: APjAAAXIGjiF580tXDfvfoKtKMrDpvq1bQz/8zuKAcBbsdhiag+Ufgyy
        T5IGWGsNzJXizdWAGBdoBy0=
X-Google-Smtp-Source: APXvYqzIecCR/3jU0SEKcTA9DhO74LXXfPo/HAnU2KYPgcgmmYd6QrNsRetxpjZrJLuPuTrJuFZDMQ==
X-Received: by 2002:a63:f453:: with SMTP id p19mr41882831pgk.433.1571211736414;
        Wed, 16 Oct 2019 00:42:16 -0700 (PDT)
Received: from whale ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id ce16sm2148561pjb.29.2019.10.16.00.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:42:15 -0700 (PDT)
Date:   Wed, 16 Oct 2019 00:42:13 -0700
From:   "<Chandra Annamaneni>" <chandra627@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        linux-kernel@vger.kernel.org, simon@nikanor.nu,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 1/5] KPC2000: kpc2000_spi.c: Fix style issues (line
 length)
Message-ID: <20191016074213.GB19148@whale>
References: <20191011055155.4985-1-chandra627@gmail.com>
 <20191011063219.GA986093@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011063219.GA986093@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:32:19AM +0200, Greg KH wrote:
> On Thu, Oct 10, 2019 at 10:51:51PM -0700, Chandra Annamaneni wrote:
> > Resoved: "WARNING: line over 80 characters" from checkpatch.pl
> 
> Please put "staging:" in your subject line, makes it easier to sort and
> handle.  It should look something like:
> 	staging: kpc2000_spi: fix line length issues
> 
> Looks a lot cleaner, right?
> 
> > 
> > Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
> > ---
> >  drivers/staging/kpc2000/kpc2000_spi.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> > index 3be33c450cab..81d79b116ce0 100644
> > --- a/drivers/staging/kpc2000/kpc2000_spi.c
> > +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> > @@ -30,19 +30,19 @@
> >  #include "kpc.h"
> >  
> >  static struct mtd_partition p2kr0_spi0_parts[] = {
> > -	{ .name = "SLOT_0",	.size = 7798784,		.offset = 0,                },
> > -	{ .name = "SLOT_1",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> > -	{ .name = "SLOT_2",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> > -	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> > -	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
> > +	{ .name = "SLOT_0",  .size = 7798784,  .offset = 0,                },
> > +	{ .name = "SLOT_1",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> > +	{ .name = "SLOT_2",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> > +	{ .name = "SLOT_3",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> > +	{ .name = "CS0_EXTRA",  .size = MTDPART_SIZ_FULL,  .offset = MTDPART_OFS_NXTBLK},
> 
> Why did you pick 2 spaces here as a random choice of padding?  That's
> very odd, please don't.
> 
> Either leave this alone (as it lines everything up nicely), or only use
> one space.  I would suggest just leaving it alone.
> 
> thanks,
> 
> greg k-h

I am going to leave it as is at your and Dan C's suggestion. 

Thanks!
Chandra

