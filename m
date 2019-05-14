Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EAAC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EEA20873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557865920;
	bh=elKW6oeLTVN3X+kQPCbzf+uocNKqQ4z65wMZc+dpMLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qEM68VmhiRq9rvVkIc3V6tg6NBtm3C0TXXAwn8hKRQmmNlL6i6SH64sRVKk+xXEWU
	 knaCqCIIe7kUsOA65xS47o9ez9dxS92nAc4Fb/lIgrzc0b0Mam+iiOZSgDSj9jU0O3
	 /aNbP7rPI6dXbUGCB2BSHo0HNAOxWBQubdKssmus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfENUb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:31:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36933 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENUb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:31:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id f4so138717oib.4;
        Tue, 14 May 2019 13:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YjL/NO0p+mAa79u2Dxd50/GNPObZERJpL2+IFfkzaF8=;
        b=D0oUnXoE0I+YtObE33rxZSfDzlhWqJyq5C505DgUj0HebGmJWYFCDxiEywW9batpb4
         liQbXj2qzRh+45549g52qLa+uc2TNYj/o7HtS82fHeUNDp8tohR6c+t7c/0N+VXJ222U
         16n1ZVHqmBcLZEfOkH8DwjZUMdRNrIe2viMtzcDPI4tuC1ZhJQOFYDvYLiSogmZGffhq
         YRcNd5dbb914Q/ttN8MImnT7Ck47vwvhPnyyhVPGiL+DiNGMsJuJYU4rxLggnwwnw/Ja
         f2HryHfx2WbDynWDBkRkUAwALDvIKXNHlCP5bWrVkNwFBiWEf6EJAZU9/pG+AU2pvRYM
         7sNQ==
X-Gm-Message-State: APjAAAWdHgyhB7p0yuHOFDvWuKR5V7ZzIGJRTRwryf0BFfjtBv3xxnct
        FO3OXYBJKo9rIPk4vk6m1w==
X-Google-Smtp-Source: APXvYqw/MbsPeIjo4+IkAQdkLBVa4RuZxpAvyfeJ4IbH7xYxg4CqthUnaxBNffPoyTkXoH2kmFKyxQ==
X-Received: by 2002:aca:5c44:: with SMTP id q65mr4181493oib.16.1557865917510;
        Tue, 14 May 2019 13:31:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v89sm2933228otb.14.2019.05.14.13.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:31:56 -0700 (PDT)
Date:   Tue, 14 May 2019 15:31:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, wenzhen.yu@mediatek.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: audsys: add support for MT8516
Message-ID: <20190514203156.GA28188@bogus>
References: <20190502121843.14493-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502121843.14493-1-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 May 2019 14:18:42 +0200, Fabien Parent wrote:
> Add AUDSYS device tree bindings documentation for MediaTek MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/arm/mediatek/mediatek,audsys.txt   |  1 +
>  include/dt-bindings/clock/mt8516-clk.h          | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
