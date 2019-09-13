Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99891C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D913206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568411892;
	bh=91j4ISXijXCbt1z+hPP2eMS9CqBpozbx7LShaBrRiUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQyJTkECs5ytHiS6vps1/bPH6eXprxl4gw1n6basK2Fwf7ffq85NpqFLt0/bP/A9Y
	 9M81dr5T1wPn/P+EBGTTam2DBklx0Ar9vwBZobBTpX2q1uWMS+ygi2Ev9/AR5nHnmg
	 3oDKGPtnb8BirNSPfmubupL49Mchjf72/J9SF68E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfIMV6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:58:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41253 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:58:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id w17so3898641oiw.8;
        Fri, 13 Sep 2019 14:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AQ3PXKKEYAPpTNJc/PTOp8Ob+kx8WcDFX3XJj1y+xiY=;
        b=QYNCSThMWO39OjcVuLVPo2qYCSbsZyzXqHd86wEUvmWW3aaFPwgEKaVnh+aTpbnHAe
         lHjiktVHISddLepOS9ud1QPM3nct+Aqjny9G11MgZhWRcfME+APAuiBKW130IJG36aRh
         2hHDXZNXvwPqc/gTTFrDwRahz0C7T1GbtFRKyRfT+MVHGQ6KyBzwBardY5QlGJTBDynJ
         AUbcplBmZE+/LP61OkeaTQZIYxb/NIQlp8zhqsyt61IhO8HTEMbpi0V9TFiOl4/yJVbX
         GsHMTUf0kY3zdRtiQGJf2Xf7TvWfg+pq9we8WkXdY2Lhg9+tFRXJDN+8l093tWTMsm90
         KH0g==
X-Gm-Message-State: APjAAAXVNEmNBPaDkFhCRET6YxN4VFO6OgKyL+ZIGyOveqyR3VCqOm/5
        zngTwJxp3HbgI9rZZlnSkg==
X-Google-Smtp-Source: APXvYqwcvObB3Yb/Y4El/uikyKAQB52Tnw3hLnBRUoI7ZLHlgxb3ip7OrKPwaxSV60bB8sfAR8RFlA==
X-Received: by 2002:a05:6808:b19:: with SMTP id s25mr5498975oij.126.1568411890436;
        Fri, 13 Sep 2019 14:58:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 34sm11938701ots.47.2019.09.13.14.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 14:58:09 -0700 (PDT)
Date:   Fri, 13 Sep 2019 16:58:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to
 non-negative cell_count
Message-ID: <20190913215809.GA11833@bogus>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
 <20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2019 15:28:46 +0200, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=          wrote:
> Referencing device tree nodes from a property allows to pass arguments.
> This is for example used for referencing gpios. This looks as follows:
> 
> 	gpio_ctrl: gpio-controller {
> 		#gpio-cells = <2>
> 		...
> 	}
> 
> 	someothernode {
> 		gpios = <&gpio_ctrl 5 0 &gpio_ctrl 3 0>;
> 		...
> 	}
> 
> To know the number of arguments this must be either fixed, or the
> referenced node is checked for a $cells_name (here: "#gpio-cells")
> property and with this information the start of the second reference can
> be determined.
> 
> Currently regulators are referenced with no additional arguments. To
> allow some optional arguments without having to change all referenced
> nodes this change introduces a way to specify a default cell_count. So
> when a phandle is parsed we check for the $cells_name property and use
> it as before if present. If it is not present we fall back to
> cells_count if non-negative and only fail if cells_count is smaller than
> zero.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/of/base.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 

Applied both patches, thanks.

Rob
