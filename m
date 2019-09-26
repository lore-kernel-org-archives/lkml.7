Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9FEC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B2A217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569489755;
	bh=9rZafcAV7MIXOTETDreA4IFvVobdkioCQkmUQpMkyeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jAIdCjZW3zLDJ8AOcmpiGIGYAs0YsHC8q2674k5w/jHZ0U7S8sDVtm9GdnGh0cmRW
	 ZnJmG+c+esbR72U7z9zkMbfvlfF99p3FN+jF1XzMvnm8JEb4fhkqv9cRfmvrBrTy7s
	 ZWNGyC6XV+CmYRAe9+6qx4vIzjiNKmfHoQUFdXfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfIZJWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:22:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36684 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfIZJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:22:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so1764497wmc.1;
        Thu, 26 Sep 2019 02:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vgFOGD9cQQzr5aVgS0FXDv/JqrPP7fo8C4YuNbx6MHs=;
        b=Z9GE9Zp4eccoo/IVec/bd3xtELk92OjGNpinpRl24yrvFtJGC/fi9y2ZPWFENyznzE
         1LfEAcV7xSJ/0Q7si0Qyig2Wbr21TSHT/to28/uwfYDVA3+Dr9ebOVvBAaNGp7+HjTCI
         Mzb/ebM2Cl3c2/q9J1AaL6H5sTVpB7+J1n75zHqvuEm60KPWvfIAh0bG4Xy9HMh2vHnx
         oy2JcHtnoYRRk5iPSPIKEO9plL6sFJs4KDUoOg7Wc7RSyKkdPhQSd87dSpFRZGij4683
         KFjtx6r3l/l980iu45tNG180oH9vetqWpO0evW3aC0UOk/f8rgkLwj1Zm1sQQHlRfRAW
         XZ2A==
X-Gm-Message-State: APjAAAVI89WoM/kuetZEITkLwEAMWlApgT0PvT/HSfJNp8T0TYePbhxW
        PY62onL/Ff0CuRxmP0tcPZ8=
X-Google-Smtp-Source: APXvYqwcXhG1KCHaxYekItIcx4iwKZ2ODFV3h1DqGAkuOzX3JiLYINdqNPu7SLDMZd7vv2fm67yFwA==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr2290088wmj.6.1569489752065;
        Thu, 26 Sep 2019 02:22:32 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id u22sm2238301wru.72.2019.09.26.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:22:31 -0700 (PDT)
Date:   Thu, 26 Sep 2019 11:22:29 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH v5] dt-bindings: sound: Convert Samsung I2S controller to
 dt-schema
Message-ID: <20190926092229.GB15552@pi3>
References: <CGME20190925132644eucas1p2716a805d184f9bbc4ad7a94cc9cca633@eucas1p2.samsung.com>
 <20190925132628.31858-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925132628.31858-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:26:28PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung I2S controller to newer dt-schema format.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v5:
> - Removed '#clock-cells' property from required properties
> - Added deprecated property to 'clock-output-names'
> and removed corresponding comment. 
> 
> Best regards, 
> Maciej Falkowski
> ---
>  .../devicetree/bindings/sound/samsung-i2s.txt |  84 -----------
>  .../bindings/sound/samsung-i2s.yaml           | 136 ++++++++++++++++++
>  2 files changed, 136 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.yaml

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

