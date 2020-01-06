Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83372C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59448207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578347846;
	bh=7WDXA5LDetANMBWZDXycsKOa5hyKzpPA5A6X6eYPWGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ADcPh/zViYxn+jCVA25AdSgifTJ9imeMyxk+lR58GiWqNeyVsn65WRQTDWRwPeHWp
	 pD6tQzcy5TeMWhd7q8WKbKV8ZxmniFJ9RKTfbrVADeb27hEyEA+MP/LA/QKeAzjK3L
	 cwWahyl4rCW/AUWqFmnw+1ik8g5rULNOmJWR0nHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAFV5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:57:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35008 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFV5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:57:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id i15so5888464oto.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TkT8eaIKGqV3wsrlyewlpi+P3L8o3guOiv9YMvMP6U8=;
        b=c3O5E1L/ELkbolmajPJINyPW6MHi6kGMQJb937MkSX9Jr06hkDsS+x26q/O+h7Vd8T
         9tdAHagdd2GurhXyeshhHX/WwVKjbLHobjHsMFBZQLIUjef43BFYnNM5chz/dZ3zbFdN
         kc+qvVObaan+I/kKQen1n9fBwlf6vx4EtYMTEj7AZO/108qtJKTFZn5dc60bnqbBpTp5
         AV4huuay/QghpLvJToAMc8jKzDAXUXUhutuzZpTQDXhzm25raR6QhUbqFx/8malM6i7G
         XFp7dfAmnpsQf1RL5gvUymJzEt7/iemCBUrtqeQlY/ZpVnGyg2VHKKL+7AeuACvNXZF6
         GE4Q==
X-Gm-Message-State: APjAAAXaQW0MtmrV6B77sFqKmn/fiLM2A5wAxKsn804qHXw+P/qCoCmI
        JhejYXurWZsMZlE0qRWY0hwxi/8=
X-Google-Smtp-Source: APXvYqwfnrLaWriwx7T8F3r4jxYo6XLm1rmsRGK0NTNv3Xgq+b5dKB1eLhFqloaBd0egwaZ82RdQQg==
X-Received: by 2002:a9d:7552:: with SMTP id b18mr80712564otl.20.1578347842706;
        Mon, 06 Jan 2020 13:57:22 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id n2sm21724215oia.58.2020.01.06.13.57.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 13:57:22 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d8
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 15:57:21 -0600
Date:   Mon, 6 Jan 2020 15:57:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     yong.liang@mediatek.com, wim@linux-watchdog.org,
        linux@roeck-us.net, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        chang-an.chen@mediatek.com, freddy.hsin@mediatek.com,
        yingjoe.chen@mediatek.com, sboyd@kernel.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: mediatek: mt8183: Add #reset-cells
Message-ID: <20200106215721.GB31059@bogus>
References: <1578280296-18946-1-git-send-email-jiaxin.yu@mediatek.com>
 <1578280296-18946-2-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578280296-18946-2-git-send-email-jiaxin.yu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020 11:11:35 +0800, Jiaxin Yu wrote:
> Add #reset-cells property and update example
> 
> Signed-off-by: yong.liang <yong.liang@mediatek.com>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  | 10 ++++++---
>  .../reset-controller/mt2712-resets.h          | 22 +++++++++++++++++++
>  .../reset-controller/mt8183-resets.h          | 17 ++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/reset-controller/mt2712-resets.h
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
