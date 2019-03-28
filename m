Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BE3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF76121773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779964;
	bh=Pq3cpm4ySy5KwLPxWSM1vwrv5NGNzl1FqDRRzb2qfpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IFRqYix8xKtLqmpr0J/Qngieoo3Wy6FDKo1fSypmQVrIaFBAKRQTBtXXgSM1gsHaM
	 +kXRz2H2TZT0dvpnn/zgCRKuVP8/a4TGGDc2CTIl1yt54UfCaxtEvOa4cjwQ2M8llv
	 HwPWPwRveaar0irqQRcdOwFMElYZr3ittkQAPS0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfC1Nco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:32:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35524 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfC1Ncn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:32:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id j132so15773469oib.2;
        Thu, 28 Mar 2019 06:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0MuQabebR0D8wRamQEWKlpccqRnfgOFXuLdzlWOisk=;
        b=Sr936U7YkMJshrtMuakvXudcf81jUSIPVrfu3hTY6YOdaBg5OYQSw/p4arJUqbNGOs
         M1SsO9hvznm1VjcBgd6tGUHpOIKsVM/KyuYHfBxXyukeUqKRweMW0BjuwzywlxSTgtIf
         mHvngHjdy6c7boJDEgyoXIr6wUMoR2rh39Q7gN3NsIfAhlKcizTC3uTjtJ6lgICSwie+
         F8V0qTJyS6pkksIprbOwYBgs4eJ8jtlHajvW6PEK9b0r42nyW/GHnwL5XNh39+gSmZEI
         3VNMLYz8WviLyuyhp3gUf8vq8MEQc0+1eqaFGXnAZK5ius0RB5MEY8tVXMLGQ1rdRXTJ
         01/Q==
X-Gm-Message-State: APjAAAWOKwjULw3a96PDDBIy3qiWSZCCOB1acATWJKKEuDzmx+1vxvWF
        N/VFzyZpd2QKAbw92ovjSZEJsP0=
X-Google-Smtp-Source: APXvYqwKX0Y8WDJ2ofAQO7UhuYwHp9HUEsH3aZC6BZSTPSLG/uRpSAQj4Ic2yvc0EJ+GoBItTPBFXg==
X-Received: by 2002:aca:304e:: with SMTP id w75mr9161oiw.176.1553779962575;
        Thu, 28 Mar 2019 06:32:42 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id j1sm7129850otn.59.2019.03.28.06.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:32:15 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:32:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 3/4] dt-bindings: drm/msm/gpu: Document a5xx / a6xx
 zap shader region
Message-ID: <20190328133215.GA14020@bogus>
References: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
 <1552414422-9568-4-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552414422-9568-4-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:13:41PM -0600, Jordan Crouse wrote:
> Describe the zap-shader node that defines a reserved memory region
> to store the zap shader.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index aad1aef..1e6d870 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -25,6 +25,9 @@ Required properties:
>  - qcom,gmu: For GMU attached devices a phandle to the GMU device that will
>    control the power for the GPU. Applicable targets:
>      - qcom,adreno-630.2
> +- zap-shader: For a5xx and a6xx devices this node contains a memory-region that
> +  points to reserved memory to store the zap shader that can be used to help
> +  bring the GPU out of secure mode.

This is the properties section and zap-shader is not a property.

But why do you need a child node in the first place? Just add 
'memory-region' to the parent.

>  
>  Example 3xx/4xx/a5xx:
>  
> @@ -71,5 +74,9 @@ Example a6xx (with GMU):
>  		operating-points-v2 = <&gpu_opp_table>;
>  
>  		qcom,gmu = <&gmu>;
> +
> +		zap-shader {
> +			memory-region = <&zap_shader_region>;
> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
