Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D2F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999401;
	bh=b78mm6Pn0rAv52OU4ubmpH9PV2ZfFp9g4+YY0qCPGeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TzXwk3PIiJBNLFd4RAm/FiqsiveHUxGtckeAHOYGuZ87sKfSTX9AE5WKyIlJcU4Hf
	 wSKahvg0pY5YMixbIPCLwRlpeB9q6gIVKRyE3QDXyHz3l2tZ1qJmaJn1EloiAjMw1r
	 90Tl157Ysq7dLQt6xKH1sI/BxmYaMKNWcM+uGzvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392844AbfGXUQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:16:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32821 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbfGXUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:16:37 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so92392628iog.0;
        Wed, 24 Jul 2019 13:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SleUqq6V31kzUwMjIX1qfrELhcVA/KVuaspMZ04YgL4=;
        b=hnUrX0SNfyvI1kO1tKzrbX8dqiUXo+qlmeDnL0kQ5PfAA6cQdXdsJfNAJYpN4E5IOZ
         S68LTpldBbjlPC7pHn6xDxx3koH9J0Lsp9u5M0tcATkFWbCDz+OKu5ajHmkH32srj87f
         4fRJM+lV6OSBeNvIz3ClFjTSWL4+f2oIKlX5WzYSJ8+reYfIkzAs3CIcH+H8aFPNmznQ
         m9vTwjhB1gmMKsthCFYlvrl4Zo+9HHD3spHPor0WDRiFmFrTBHxcqmPrgW+6w9VvKfkm
         YxwropmcLAFUxBRuzAyHodSGBXZXirJFlzHWV7502mTx0OGsVzptCwgAwBvuDeBA3TTs
         tFbg==
X-Gm-Message-State: APjAAAX6DVF6Qh4T2mOapkZ7MsOvWbl+i1a9ZKbl7+dgANMmOQ9ulYBo
        ZCA87vEIcy8pJN20PCxC1A==
X-Google-Smtp-Source: APXvYqwqmUodaynFku7YClU/Ql2xFlbvkHEw7X/q17Yh5pYFol9maQFHH3YaP1av1prEvMzfEF8uMA==
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr2226288ioc.32.1563999397076;
        Wed, 24 Jul 2019 13:16:37 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id i23sm33894203ioj.24.2019.07.24.13.16.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:16:36 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:16:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     yongqiang.niu@mediatek.com
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4, 05/33] dt-bindings: mediatek: add RDMA1 description
 for mt8183 display
Message-ID: <20190724201635.GA18345@bogus>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
 <1562625253-29254-6-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562625253-29254-6-git-send-email-yongqiang.niu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 06:33:45AM +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add RDMA1 description for mt8183 display
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index afd3c90..bb9274a 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -30,6 +30,7 @@ Required properties (all function blocks):
>  	"mediatek,<chip>-disp-ovl"   		- overlay (4 layers, blending, csc)
>  	"mediatek,<chip>-disp-ovl-2l"           - overlay (2 layers, blending, csc)
>  	"mediatek,<chip>-disp-rdma"  		- read DMA / line buffer
> +	"mediatek,<chip>-disp-rdma1"            - function is same with RDMA, fifo size is different

This can't be determined by which chip it is? IOW, a chip may have both 
rdma and rdma1?

>  	"mediatek,<chip>-disp-wdma"  		- write DMA
>  	"mediatek,<chip>-disp-ccorr"            - color correction
>  	"mediatek,<chip>-disp-color" 		- color processor
> -- 
> 1.8.1.1.dirty
> 
