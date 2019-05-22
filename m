Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4041F2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9zHpWyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfEVVpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:45:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42646 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfEVVpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:45:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id 13so2008089pfw.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3msBjqVTJ1kTESQU/rT/HU56k2o0e/t/iRqw2p4BFfY=;
        b=T9zHpWyJquwaUzakm+kApDt3POLoWJmKmRWBvXBVb+0YhVraKV+b6OnKSVvkmoVMTb
         m5E8aUR9YkzfPrDM9G36OUhEe0XDYAFFMRtUG23mFfC+ltHlRynUtamdsVMcO+SQGnrh
         aZ7n046ymukpCPNU/EMXN0YGHGxXsG2sJsUwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3msBjqVTJ1kTESQU/rT/HU56k2o0e/t/iRqw2p4BFfY=;
        b=CwAFhyrbNTr19XzTsdB6oCIhXtEeUe3k4MNzPj41pW616BVG26rnacfi9griDM5mA5
         cRWqRKmWt+0djmzqP7uogyoDBpEE04RDOXnKmCQ9/kiE83/ryaJx8xSd85zGJGJ3x7aI
         7ulBzNXk10KQSnUce48b/HFF8xh1jYF0cnALRKcev0VKjbTqIYM+GOjaR75hPVhJYIPL
         QC7o7z1d2F8zXvMj+LhKlPjjLfmqGotdOqV3e1AcILZNT6fRXTSDQ9xJcuTZuYXIO/T7
         7dXHCS2KuF1Zuuq6DMdcBqgYOtlDS5mryzL3aSqXH5pokaJgM5TdV4dRN6Gpw8HHje04
         uSqw==
X-Gm-Message-State: APjAAAVrVglxB2Rvbl2d4l/PLgWcrvL1qzIUnB1vN1odnqRJK1XG2Itp
        LnWWCsV1s0iIw8vQtqWC4LfO9Q==
X-Google-Smtp-Source: APXvYqzOarFkWaTvY38nd1mXMA6LjE1SIm+r6SAsYrEQCtbQjS4lltVrnHQvjcH6nVU5wIbi2MtCjg==
X-Received: by 2002:aa7:8219:: with SMTP id k25mr5697545pfi.38.1558561517334;
        Wed, 22 May 2019 14:45:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3sm44151294pfr.146.2019.05.22.14.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 14:45:16 -0700 (PDT)
Date:   Wed, 22 May 2019 14:45:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: onenand_base: Avoid fall-through warnings
Message-ID: <201905221444.014568B0F4@keescook>
References: <20190522180446.GA30082@embeddedor>
 <20190522233705.234d75d5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522233705.234d75d5@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:37:05PM +0200, Boris Brezillon wrote:
> > @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
> >  			if ((this->version_id & 0xf) == 0xe)
> >  				this->options |= ONENAND_HAS_NOP_1;
> >  		}
> > +		/* Fall through - ? */
> 
> So, the only thing that you'll re-use by falling through the next case
> is the '->options |= ONENAND_HAS_UNLOCK_ALL' operation. I find it easier
> to follow with an explicit copy of this line + a break.
> 
> >  
> >  	case ONENAND_DEVICE_DENSITY_2Gb:
> >  		/* 2Gb DDP does not have 2 plane */
> >  		if (!ONENAND_IS_DDP(this))
> >  			this->options |= ONENAND_HAS_2PLANE;
> >  		this->options |= ONENAND_HAS_UNLOCK_ALL;
> > +		/* Fall through - ? */
> 
> This fall through certainly doesn't make sense, as the only thing that
> might be done in the 1Gb case is conditionally adding the
> HAS_UNLOCK_ALL flag, and this flag is already unconditionally set.
> Please add a break here.
> 
> >  
> >  	case ONENAND_DEVICE_DENSITY_1Gb:
> >  		/* A-Die has all block unlock */
> 

Your reply was much more to-the-point than mine. :) I'd agree: retain
existing behavior (ONENAND_HAS_UNLOCK_ALL) and add breaks.

-- 
Kees Cook
