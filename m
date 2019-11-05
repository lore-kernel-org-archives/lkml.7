Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E26CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EF220717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572918550;
	bh=r3WQrk84jPPxhTeFH4hhfL76QR7dyoujo6QWsvP56mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xu6+4m3x950zbGETBxQU5pV8AoYdp3uwsZ5NGy1b1KlJWNFhCDCnorG45bTQAcQwA
	 JvUYglrdaQpGbcN+8FTEfMP2pWWKNXl4qEJWc50F+Q+EVZAeQWAd+PNUSd0+y4K8Vd
	 +n+bsAi/0mCbCPpMxk1OHYn0kxeLS+D+KGPrjos0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfKEBtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:49:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43923 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbfKEBtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:49:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id l14so1924959oti.10;
        Mon, 04 Nov 2019 17:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hlVzf6PgNkFlTYTpcjjgSLO975l5JkVV5k5/cMONFVk=;
        b=Wfpj9PCbMqkcnpHHKubgqEdTzAkhaeqmYDe0tnHsDZ7/V/8pDodbGoUi8oFqU0ivqK
         Fd8RGOsL31lWXQ8oj4XQJQe44iM3bKC2D2hwrkTP+xTsgRCEhxbHWoJNE0QROuLC4zNx
         kVOW0BvaXGGw9A999J8bW/5BECQ01IiGTvVC3/9VG7N1HUWoA29aez9MaZGCsa6dKnzD
         wKSklOlSFwiEtV0y8YYCuYrkcBR1ukpQwKl6PnBLku1P2uKDnHx/fPsZcC5lhQxGIpb4
         0/ZPJNkdIz9DYhrJ132rsCu6iR7S7O1rjwiKIoNBu21zBHYIJCfSdSk7GGIrZi3UqcoL
         kB3Q==
X-Gm-Message-State: APjAAAVX1p/L0z3GTrR3FEtYLEbrdQZMZTjWI4NUNnxPuovpcgGzWHAT
        N85YmPFqM57LZYtd9PJGrw==
X-Google-Smtp-Source: APXvYqxmSwLREneFxL2iChIptQVtsinbuf+3c/76RepT4oB0/BK9ayp+PNO4bYzLHlq06MWKq7ivrw==
X-Received: by 2002:a9d:6b90:: with SMTP id b16mr4509521otq.37.1572918548251;
        Mon, 04 Nov 2019 17:49:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v26sm2040889oic.5.2019.11.04.17.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 17:49:07 -0800 (PST)
Date:   Mon, 4 Nov 2019 19:49:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, vkoul@kernel.org, broonie@kernel.org,
        bgoswami@codeaurora.org, pierre-louis.bossart@linux.intel.com,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: soundwire: add bindings for Qcom
 controller
Message-ID: <20191105014906.GA32550@bogus>
References: <20191030153150.18303-1-srinivas.kandagatla@linaro.org>
 <20191030153150.18303-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030153150.18303-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 15:31:49 +0000, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm soundwire controller.
> 
> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> either integrated as part of WCD audio codecs via slimbus or
> as part of SOC I/O.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soundwire/qcom,sdw.txt           | 179 ++++++++++++++++++
>  1 file changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
