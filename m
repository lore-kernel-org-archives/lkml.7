Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ABDC47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74342084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571653322;
	bh=ldV1AAAsdREXDXeQW+llqEafSolwVY1a907bgC7rUUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nM6rvkM6gQ8G1bY5x3PNPU6an4dOjVrFUOEIDUNZHeqVCz7jgTio2Xn2CVT/bvAj4
	 9oOodYfAcuOu0zWQmDGq5y9RxOJpf1kIS5f28+hEYDvuuGtFHPtaGSNzYOBxfxLtbr
	 KEkS4EhOLrHIEGuYdAJkZEThPi/zQQcRT27L95Ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfJUKWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:22:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34698 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUKWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:22:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id b72so624815edf.1;
        Mon, 21 Oct 2019 03:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTXwyuKPtae41ucu10e0jfWsFbRgsyPTHworMEWDZyQ=;
        b=pb+E/4ap3q0bRrAJk5CIzfayBk+FbTM76eQBLlXweruslA5z5v6RTjvoWXC5iXK07l
         qLYgS/FhmXMS0L8uO2p+tPpK8Oi5G3JR12ZQjyMRfZzVeuUy2sN/r739tOko6v+upw+k
         DRwwOR3QmieoUVm2juw8G0dI0deuzS/UYqRjkVmn0GKsC0N/kVw3snhbE9CepEQUxLkz
         ncCs6awHyV6eCYzucufd2CT2kU8TmYDOQUgxPYzuyHlIvRnJmNn3EACkSlDIv4DtVXMh
         0UpveYp4YQZL3Pco6qKaSpFGTXOYQZvAHX0vhYoYaBH4Y/fdQPlBt1uT5/ZCerV7n6i7
         ljTg==
X-Gm-Message-State: APjAAAXROgvpXeoiMZr8v0cKQUue1Gwygm1Yp23S41t8CmAGIowu0xY5
        n2KZhx/1SPmcysCy/40kEGE=
X-Google-Smtp-Source: APXvYqwXeK2/2BY3ORkuBAxMultEP+lVNX/1OoZXMoqOvq9xllY1syL/7QofFUXQ2efCb4ja3MbPsQ==
X-Received: by 2002:a50:ec0f:: with SMTP id g15mr24142459edr.59.1571653317618;
        Mon, 21 Oct 2019 03:21:57 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id ay16sm181628edb.47.2019.10.21.03.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:21:56 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:21:54 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH v2] dt-bindings: sound: Convert Samsung Exynos Odroid
 XU3/XU4 audio complex to dt-schema
Message-ID: <20191021102154.GA1903@pi3>
References: <CGME20191017100534eucas1p1407cf6ef5606d6bd6a4140502cc95984@eucas1p1.samsung.com>
 <20191017100529.4183-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017100529.4183-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:05:29PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
> to newer dt-schema format.
> 
> 'clocks' property is unneeded in the bindings and is left undefined in 'properties'.
> 
> 'samsung,audio-widgets' and 'samsung,audio-routing' are optional from driver
> perspective and they are set as unrequired.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> [mszyprow: reordered non-standard properties]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/sound/samsung,odroid.txt         | 54 -----------
>  .../bindings/sound/samsung,odroid.yaml        | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.yaml

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

