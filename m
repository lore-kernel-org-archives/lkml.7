Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454ECC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C17F2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578501024;
	bh=ODslVDAuh7de65gW/tg9WQIQROKBdslx9dSRBnp52xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wDi8YNXvVLB/XIs8ULFGges95XZ6kBu4SWrU8ewZDnp5dBj9AGMxB4/QTrj1FVW5Q
	 dl67m6EDjOgnJ31TM4z/wKEHjkUP216p3IEautF9WufXFCU/J5tZUoHRWxx/2VkNHy
	 mbELjKzlFCIPruD4F/zP+GouSbYOk2Bq3uxsSWKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgAHQaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:30:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35359 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:30:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id i15so4180460oto.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eh1a1EgozWErHHqGLEoauZ/x7T61NxvHf+uJt4V80kQ=;
        b=FwyWURrqIQ0C0HxAT5peIN+VFqRhdOpFnD+BnKPivVYUgZUlygwN3d43ldYCCAt4eI
         fUX4xaVsekIOQsMGfHIVVWC2o6H+R3aGPRuCDvCjc56RXOOJ5hQc6+WMeTZMAM2Lx4fU
         u+ir+YS5E9cpgFs0ZlGPIVMmr2FXvsS+sejKYwY1C2PNvdQs17pYlIHQqW1ZYK5iewjb
         cCDDewZV3rD30YmiYL3aMf+ks7mH7Y2LqcO2gOz4TqpPgWFBDEjvUh/y6208PT3ho53+
         DxfLnVyGXviK8VuH4XXmFWutM8ApIaFXEDV0LI2ppHtG9xaa4uccZi7ufCHz39x7JcZO
         mCDA==
X-Gm-Message-State: APjAAAVngpCv/iFtjrvhncMxkQIpyC69rB8k00478iGa19qQj4UytAm5
        P8FoNTL+powLpvERwtU+NVf/UEs=
X-Google-Smtp-Source: APXvYqxKsjx9+cwiBTktFXebBt0H8xPQPd+Y2hQEzTrD8HHEX023K4NyG5ueTwbyI7Aom8YgEyGMjw==
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr4923504otk.363.1578501021618;
        Wed, 08 Jan 2020 08:30:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k26sm1214456oiw.34.2020.01.08.08.30.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:30:21 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:25:49 -0600
Date:   Wed, 8 Jan 2020 10:25:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add configuration for
 sc7180 in yaml
Message-ID: <20200108162549.GA24298@bogus>
References: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org>
 <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019 18:44:31 +0530, Rajeshwari wrote:
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
