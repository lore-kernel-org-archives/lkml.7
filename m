Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F68C468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 03:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B267208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 03:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZnuo1om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfFHD16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 23:27:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40093 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfFHD16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 23:27:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so2113152pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 20:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=73rlx0Al8Bi2D+T3uFyrwNuDhtIRdfkSfNSwNdqApLY=;
        b=vZnuo1omaf1ebaOYnIivvcEKMipbWLSXSetiJzjAuMDkwFvEejTvw/LERyGnyTtTFD
         Ut/KBH2OgucYOakJ3plFjqVP2fvA4EA6KgyKv5PHmzdtl7dSUlO7jVHUCmNAk4zNViXh
         pKGSg82xwCrwAUhhUNdijgGe48Eal15iGLO+rrKF3pUswZcPEdRRUXAa7WX8c4x90r2a
         ibzcUYjSYhTrrD3IDphUlAXAX9JJvjekdKspwLeNpKUjPyFbTFB57z13q+YsY8RTEyW4
         djtelDTKb5XyY1rK5bbAxOwrhja/IYeH4U5HhA4o4Pu9+b9HFxOAh4wtCClptpI3FMnd
         CRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=73rlx0Al8Bi2D+T3uFyrwNuDhtIRdfkSfNSwNdqApLY=;
        b=Wdpcu57K0oIv2ucYrMQykTshZF3O8huPkDDC2YC/F92bGTNTAMwVKNlBf2kySHT5J1
         ULHUSsjTpKloggtjxWu5hDRlBiXz+CCaTDPs34UzASpddOGmzKXno5/V3IuJZFNRBwGj
         8U9Fb+4oQDX3zTaB5Aao6Hv87fMV+uu55eCt7sS20w4/SA4//hfJYaH3Uls3Xbho2oJn
         mYvNIwsmLBDevO7Ux01zks2d/op4AzSgFr2GGBCAKq9chRMrzRaTdJZCKiilXwybKj9y
         MmpNh6lHFAO6sAXG3Z1a1uRCSt09DOUIaQc8AxFq0ywPDAAeIB0TBwSEMFkRFK7fhHK/
         bLgg==
X-Gm-Message-State: APjAAAXQ6Wx4jKHnExuv7pJC3dDIRBnVOcGsz/krmLlyklcLbGknm8oQ
        2fMDrzfXFWnKJ2wcUUhWYhVI9g==
X-Google-Smtp-Source: APXvYqzoWjPhd12ySZSr68F6QXinc6DRO2r16B7jrtAvC5fo2zqsmgssrm3j46hlC4Q0mg/vp7bIdw==
X-Received: by 2002:a63:1650:: with SMTP id 16mr5875706pgw.164.1559964477334;
        Fri, 07 Jun 2019 20:27:57 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j37sm3189251pgj.58.2019.06.07.20.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:27:56 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:27:54 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     robh+dt@kernel.org, sboyd@codeaurora.org, linus.walleij@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] dt-bindings: qcom: Add ipq6018 bindings
Message-ID: <20190608032754.GD24059@builder>
References: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org>
 <1559754961-26783-3-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559754961-26783-3-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Jun 10:15 PDT 2019, Sricharan R wrote:

> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: speriaka <speriaka@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index f6316ab..7b19028 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -36,6 +36,7 @@ description: |
>    	mdm9615
>    	ipq8074
>    	sdm845
> +	ipq6018

It would be nice if these lists where sorted, but as that's not the
case, please sort it wrt the other ipq at least.

Regards,
Bjorn

>  
>    The 'board' element must be one of the following strings:
>  
> @@ -45,6 +46,7 @@ description: |
>    	mtp
>    	sbc
>    	hk01
> +	cp01-c1
>  
>    The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
>    where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
