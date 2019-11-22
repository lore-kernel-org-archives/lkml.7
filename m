Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35473C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D0D20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574466753;
	bh=aTvmzeoDpBxYogmzi7ZPOzcUjrCa76xNLs8IvlLBSQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z00BBDTv3FCJ4aN4AWoejh84ukN8H7E/o/QSCwcTerQc3BurT0K8x/7BfdN2ofCNe
	 oktG5HGvFbtInuwJCJXrZifvoh222Hre2NowfqRX/ZAsm+y++wK6XPFI50xYTmM7c/
	 WErB1JEnkOmzqaLOJEHqlW+GoA7uChsv0CyBXKNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKVXwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:52:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37652 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKVXwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:52:32 -0500
Received: by mail-oi1-f196.google.com with SMTP id 128so25431oih.4;
        Fri, 22 Nov 2019 15:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIv0AP1JTSUxfnvgBVyjKeTWUuL1peOwjaFWykNE7iA=;
        b=mxalFyAy83L1LsEBBA3JOYlOqmmCEGUR7/4bJZHQy9MSkwUnJpjcFEqn1/WBJOSs+e
         CCHkw+OWl4WL1DNw9Zt9XzppgcGkx7jOIje0KzCnW+hX3U3M5beqj8SdaEoLTAL8AyuY
         gB3PA5GSon9FjcfVitJ42m6qSkgYmbd2xsfUpMVFf5csOFYkLtqRyD67DxJ4R8otBoRg
         ZIsd5L77t/Us9DccYQB+Z52XwgoPa7awr9pv8RonwG28xecsjhsXl8WtKMxnAbxMvssn
         60cUvC7AUm/YS2/j91Lcau+KwchIM6n6Lvwe51gFIjwgPTad+clh0cxT7prFvLPC5/vG
         YVVQ==
X-Gm-Message-State: APjAAAVFcN0yMDFgo0YYEOHIsblfNl/KKsmKgYRuZ/0ldEcz+bEQW1zS
        l0U0Je4v9ctzttVB+R9j0g==
X-Google-Smtp-Source: APXvYqyLwRnx+Xo7nbUb1L8qZT5IZ45QUOP+KUGZYQXdJQZMSvZtE8QAvSSeSdJm6fP20R3Oyo69Dw==
X-Received: by 2002:a05:6808:6c3:: with SMTP id m3mr15234183oih.56.1574466750932;
        Fri, 22 Nov 2019 15:52:30 -0800 (PST)
Received: from localhost ([2607:fb90:bd7:3743:c9ec:246b:67b7:9768])
        by smtp.gmail.com with ESMTPSA id l32sm2757861otl.74.2019.11.22.15.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:52:30 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:52:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: Add vendor prefix for ITE Tech. Inc.
Message-ID: <20191122235226.GA7738@bogus>
References: <1573811564-320-1-git-send-email-allen.chen@ite.com.tw>
 <1573811564-320-2-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573811564-320-2-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 05:52:17PM +0800, allen wrote:
> ITE Tech. Inc. (abbreviated as ITE ) is a professional fabless IC
> design house. ITE's core technology includes PC and NB Controller chips,
> Super I/O, High Speed Serial Interface, Video Codec, Touch Sensing,
> Surveillance, OFDM, Sensor Fusion, and so on.
> 
> more information on: http://www.ite.com.tw/
> 
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>

Please fix up your author name to match here.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 6046f45..552f5ef 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -463,6 +463,8 @@ patternProperties:
>      description: Intersil
>    "^issi,.*":
>      description: Integrated Silicon Solutions Inc.
> +  "^ite,.*":
> +    description: ITE Tech. Inc.
>    "^itead,.*":
>      description: ITEAD Intelligent Systems Co.Ltd
>    "^iwave,.*":
> -- 
> 1.9.1
> 
