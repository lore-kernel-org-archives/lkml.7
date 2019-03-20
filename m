Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390692184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="RoHc0M+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfCTPRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:17:33 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36965 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfCTPRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:17:32 -0400
Received: by mail-yw1-f65.google.com with SMTP id w66so2281553ywd.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OhLRzKALkL3nGCjb3PwqNOmA2gedhLWmXCa0Qs6Xno4=;
        b=RoHc0M+mP1OLL2NFx7yn0/QZP0q9J4PSXJCspDpu2GvQy80YCp+vHgtbaCoGul+3P+
         Rmdypv9kb+z8+SBV8PNgLm9H+Diuky8488orR8L0rA4iGBtKmBdSpWP8D+8sKNWBh6JQ
         RYJkDl6deB3XivuEVx+EDKilrJGInJIGZs8uOsKSL0+IHhuGmS5vxe/Ef5+cv+8qaaw7
         wkxZKtwmn2YJuoAkmBKq4Ec/dHdjoYZ17k17PonRqx+W0Rv68LJZBnhDaqNd1yZ38mXr
         hjxcBvunvGMk9KlXOc4FWbVu/7eB2VrNa2XTNPDLX9KymLPPhWkznZenwHbwjx+77mIm
         Wuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OhLRzKALkL3nGCjb3PwqNOmA2gedhLWmXCa0Qs6Xno4=;
        b=oHhSurLdvABU166fnX4CMN7Wntrpn3ynp9H6Ci/vbhN9TpV5655ViUJ1YAF8mJhgpK
         WCTXrDtP192fx1Ewiewxwpu9H37YnR9E7ocYAh4KORXJjtsPV4GbEJ+MRa2rKYXPPaOz
         YXIZ/vhpziwwvONr6aILr8ffcBeS65uDB7dcgYKg2QMSHemlA5gk5TfA4eOX1g1+o7lO
         n8ni+gDEvBRWztiNJ/s6vhVQwGQoA15AfN8X+pWXpqOqP4HHaOS/eipZgZhXzzf+LZ9D
         djjcIv6OX0e1ZgBVF9z2dTIdQYOSOg6275w77eesW7arNtUzP2KJOMvrrDVP/CpEvhjv
         DQ/w==
X-Gm-Message-State: APjAAAUJUSiBdLdAx3p5VGWLrJQ5FZh9C5/y93Iwh/NZoGGYXN02+opC
        y+oqSaec0hLhLP9sVWGo3G7bSw==
X-Google-Smtp-Source: APXvYqzQr2CLK/fwULYQq3VNkBV55f/ClfMVaFfphcBAPGFFc6pKU5cyV5HL+5E4NBw0hPocFM4CVA==
X-Received: by 2002:a81:2209:: with SMTP id i9mr7365425ywi.293.1553095051413;
        Wed, 20 Mar 2019 08:17:31 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id f185sm972052ywf.18.2019.03.20.08.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 08:17:30 -0700 (PDT)
Date:   Wed, 20 Mar 2019 11:17:29 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: Re: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
Message-ID: <20190320151728.GA19781@kudzu.us>
References: <20190320140812.5952-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320140812.5952-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:08:12PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/ntb/hw/intel/ntb_hw_gen3.c:535:5: warning:
>  symbol 'intel_ntb3_peer_db_addr' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Looks good to me.  Added to the ntb branch,

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_gen3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> index f475b56..c339716 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> @@ -532,9 +532,9 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  	return 0;
>  }
>  
> -int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> -				resource_size_t *db_size,
> -				u64 *db_data, int db_bit)
> +static int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> +				   resource_size_t *db_size,
> +				   u64 *db_data, int db_bit)
>  {
>  	phys_addr_t db_addr_base;
>  	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
> -- 
> 2.7.0
> 
> 
