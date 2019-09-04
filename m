Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA5C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EC4208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkR3B3MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbfIDStH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:49:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47076 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387735AbfIDStH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:49:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id t1so1716908plq.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4HfkEeQk6I+D7BmR6a2frxKQaAhSKWflYGopMu8Mlwc=;
        b=dkR3B3MFFv52z1dcgS9nVth+FYdUnIpV50tp+MSiTsu3juQyvVpvv9qbJyLpBC6NWu
         Omr0qBpDm6LSMDUgkS9hfYz0ABJH+zIc2ro6xd+ySTfotVQvw01Iw9GPLgnOyMV5BNe+
         YragKuWslI/BMXjrvnfwgpy4idWkdfonkbsQEzxw0YyKHmMAq3r8ZQvPKAo1OcTuCHRz
         Ikok6wgO1s0S0385KTjMWGHRyVrwoqn+CVmk+bKxOqaZGBMKVXE87/Ke8rffE/HVi7hm
         /sJDxtZxcI/JO9d9BwRaf3lByKxK5DS5e45xAfFjE/qjQR6LKxqp4g2jZWgM7Kt8Pjwc
         DyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4HfkEeQk6I+D7BmR6a2frxKQaAhSKWflYGopMu8Mlwc=;
        b=Ej7sqGDoqOf/cRPFjPlhkA9jIgdzUq8dealq3aWdVOEB0T6CK7GwZYTGidZLRkKCwk
         NgeHe6muaHvXWJCxqtC+GuDdq/VDC1zKqA8YIJP5HzuKlBeD7iTuDxZTo/L9vWSUxPdU
         /atOiMeSTsKmfbLHhRGjZyP8t2cUvPU9Qfj1QeNxdcuFHnc7gWQEHAq+4G1GCw0/jPMn
         oyQ9lFJiAAkM9UlIRzyWSnS8lsdVdmrHXkaSp6eg42/iP5mFWFz6n9oNUcy+YgMPgU9a
         c/xiQi01Ew5i4zAb8al3w89T2odDQXMIQY7xe3eaW5vYCaXMEU0As61K4Y+whridXjvD
         dTmw==
X-Gm-Message-State: APjAAAUWgFsyA5My6bL6sifHdukzcz9gyPfxy9Zub2fqpEXsd+YmIpGu
        QHePBEiPwQvJvm4o08F0mv1BOQ==
X-Google-Smtp-Source: APXvYqyY9dqgp6RiwU1DtONDAbn1FYQoy2MOEogTOM025b5l2Pl8aexINaf1twTLwuBXzUdXFNeXtg==
X-Received: by 2002:a17:902:a983:: with SMTP id bh3mr2004318plb.311.1567622946187;
        Wed, 04 Sep 2019 11:49:06 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d14sm2920384pfh.36.2019.09.04.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 11:49:05 -0700 (PDT)
Date:   Wed, 4 Sep 2019 11:49:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: ufs: Add sm8150 compatible string
Message-ID: <20190904184902.GF574@tuxbook-pro>
References: <20190904100835.6099-1-vkoul@kernel.org>
 <20190904100835.6099-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904100835.6099-2-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Sep 03:08 PDT 2019, Vinod Koul wrote:

> Document "qcom,sm8150-ufshc" compatible string for UFS HC found on
> SM8150.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index a74720486ee2..7529e2c26127 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -13,6 +13,7 @@ Required properties:
>  			    "qcom,msm8996-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
>  			    "qcom,msm8998-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
>  			    "qcom,sdm845-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> +			    "qcom,sm8150-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
>  - interrupts        : <interrupt mapping for UFS host controller IRQ>
>  - reg               : <registers mapping>
>  
> -- 
> 2.20.1
> 
