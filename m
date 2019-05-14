Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23856C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D492020873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557865880;
	bh=FskvUTDJQzAj/MQ+BVdgeqCPsjIDUr68yObfG00qqi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NzspbB+RCP/SjihqHC3HPoRwyYsfptW/u7ioRtea8xIayeafDaOBXlA6ykThsrxNH
	 3EVksNW4VNrumvq1g2+eVCoJ5nujcNwDgsaqfVi2VR60Y7WJC14ojyLcvWIbcwEGGO
	 w2jJkGHsyUYIl1AjNuXOwMjiCoHCqqxorE9YprCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfENUbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:31:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36440 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:31:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so141617oia.3;
        Tue, 14 May 2019 13:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uj/aNb3lhudAxuL9yVxzedyisH6/evVA53ck6BzySPY=;
        b=aVxhJ7JI3YEYNTSnKBXyUcw8dfJdGabGo91KGA010wDpFrQK9zsW8zJiu5guNj0GwX
         dlMnafg3tNLs/qi0IAw0LbI8mQi3M3nNoHeroYEcvGeJf5mZjKWQQYFZDS+v6+QiSko3
         GWpUW/yp1vGMVyCc/sjlDkGnzR2IYWC1CgG8Dbq5MYilbGH3S3I0/o4LbKNk3pGDWaWX
         jhxDFHe4tIeZDjgdPTyOavkWqrKDvM1Ko7gIYluZoTOHJXtmWgPXmb2gs6J4n6+90XPf
         P2cItsCMSKXDio38lrni5snupmRGht+ZYnHLaT69x1o7aQQZ+06Xf4X2FZaYugh4QCBd
         cfUg==
X-Gm-Message-State: APjAAAWCaQr33aZxVswxd3GwyikO9OTiEOHXT7kKJtIibvSK8cnqDhpB
        cdYKgDx209wGChPOKa04lA==
X-Google-Smtp-Source: APXvYqzdjUlWTvBq+1madUv/8ZYMJ50qHKkthS9BLDmfCh7nxydKkUzHB56DapylG98G+Oz/KHde/A==
X-Received: by 2002:aca:5041:: with SMTP id e62mr4403410oib.60.1557865878559;
        Tue, 14 May 2019 13:31:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m8sm6538868otl.40.2019.05.14.13.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:31:17 -0700 (PDT)
Date:   Tue, 14 May 2019 15:31:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz,
        tiwai@suse.com, kaichieh.chuang@mediatek.com,
        shunli.wang@mediatek.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 2/5] dt-bindings: sound: Add MT8516 AFE PCM bindings
Message-ID: <20190514203117.GA26954@bogus>
References: <20190502121041.8045-1-fparent@baylibre.com>
 <20190502121041.8045-3-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502121041.8045-3-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 May 2019 14:10:38 +0200, Fabien Parent wrote:
> Add documentation for the bindings of the MT8516 AFE PCM driver.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/sound/mt8516-afe-pcm.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
