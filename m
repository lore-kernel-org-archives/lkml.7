Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147BC20856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bx1zz6Bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfH1UZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:25:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34166 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfH1UZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:25:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so330001pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m9K6geHQslN19tGBbmOQDx2FY+2m9BB3O5M0ryJqK9c=;
        b=bx1zz6Bghmx2cAm/3B3M1XQ5TzD9T6Shao6YQ/kAskDAzddvVphm3y/VszXyU8cVxt
         GmrZL8kV6W5wHbTkcTKkqgx5rPnKlOZTZtpFqe0b87i6tjcwzIPvhnmQatdzfwt755AQ
         /TbGEuYOWia2rpi1xfmsUoZAgfgNRQN8izYhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m9K6geHQslN19tGBbmOQDx2FY+2m9BB3O5M0ryJqK9c=;
        b=j1R85rJVVwDFgjrFCiMLtwXm9yFXCBx8CTiZIkjZbA6eBPKHxAramuUtmw3vhTl8Vs
         WX687iS9SDLudPgWXWK7qj0P/qRQaiTc1NelO0eTa/3tWNvNt4Kq39eyZmI/bi/Vpuxi
         TCx4rOm1NieBEFp706oc1xbR7bun4St78QpW/D1oQ9SnA4JyuRBpPe13wgnzPgZZ5pio
         3fWwaeAv0FseLE5DohFgwo/957piJGFm29nXSqUnQVul9cvNcvVQtssGYFHa4meE/U3c
         p9VOT2Op9DgRAbT2WKcHyz6BuGaHCa/gUGlisRCPlfgBcZNPzhbxcjB/YMc/TrR1H7+I
         UVMw==
X-Gm-Message-State: APjAAAXUrblIBDQKPR3rHe5hJm1zO8dPrWBnjC2+b4suiEch7OJmcJr2
        1O5LtSNAMrfZbd9Eff4GLevDOg==
X-Google-Smtp-Source: APXvYqxQAENVpZgVbOZciL3QGjuq0yBD38cfywqNfv+zc8DilopsyfnAC3fYr1sECkiUbk2gzmgRoA==
X-Received: by 2002:a63:5a0a:: with SMTP id o10mr5112466pgb.282.1567023932990;
        Wed, 28 Aug 2019 13:25:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h17sm232891pfo.24.2019.08.28.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:25:32 -0700 (PDT)
Date:   Wed, 28 Aug 2019 13:25:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Message-ID: <201908281325.1E7C2A9@keescook>
References: <20190610210613.GA21989@embeddedor>
 <3abfb317-76cc-f9a0-243f-9b493a524a98@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3abfb317-76cc-f9a0-243f-9b493a524a98@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:30:24PM -0500, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping:
> 
> Who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 6/10/19 4:06 PM, Gustavo A. R. Silva wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> > 
> > struct nd_region {
> > 	...
> >         struct nd_mapping mapping[0];
> > };
> > 
> > instance = kzalloc(sizeof(struct nd_region) + sizeof(struct nd_mapping) *
> >                           count, GFP_KERNEL);
> > 
> > Instead of leaving these open-coded and prone to type mistakes, we can
> > now use the new struct_size() helper:
> > 
> > instance = kzalloc(struct_size(instance, mapping, count), GFP_KERNEL);
> > 
> > This code was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

FWIW,

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> > ---
> >  drivers/nvdimm/region_devs.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index b4ef7d9ff22e..88becc87e234 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -1027,10 +1027,9 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
> >  		}
> >  		region_buf = ndbr;
> >  	} else {
> > -		nd_region = kzalloc(sizeof(struct nd_region)
> > -				+ sizeof(struct nd_mapping)
> > -				* ndr_desc->num_mappings,
> > -				GFP_KERNEL);
> > +		nd_region = kzalloc(struct_size(nd_region, mapping,
> > +						ndr_desc->num_mappings),
> > +				    GFP_KERNEL);
> >  		region_buf = nd_region;
> >  	}
> >  
> > 

-- 
Kees Cook


