Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ADB20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568385372;
	bh=lUBs7/rSDwcq7tVD+ev2KJ1TPSAoTvzSaIknRSLD1Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TN9pGLAI902AlhCoW/qgM0YUMo34VVH8fOri9LsetGkG884TvDISx1SQqVZY8EPKi
	 9n8jgLW7L+o14EFZs49hS2m8v53R9uye29/qnM/PfauQFao6zLfMEK1iDBfaAkVdv2
	 Slrc9zl0S9+Zgk7jGSnn9f3r623bA0C/PxaxhtTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfIMOgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:36:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37031 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbfIMOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:36:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id 11so2824823oix.4;
        Fri, 13 Sep 2019 07:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=x59L5apnJL40NtS0tdeDtuo7G6k5ZSeB+XKw0XxxnFI=;
        b=FD1ecM1H32wUPzCvVXdAafndTauPHO9rXjMXrf9FVpgf29n51sK9NLfwSdMNXMkMxB
         G9L7M5tvo9U1EKe7r2+CfrGhr76jiCs/RddmQmSk8Mh4SOHxkfrHHU511KUFfXYq1jLj
         iziMgSn2kNt/d50zvtRbLDivRio7YB9U7TvlkYQxmSZvcDQD+ODVuU6DuCu2JNtLaBKL
         lWPvI8ssMJRfbcmQJeRGyjxBQXCvr53y/tPnytFUCgrwQSfn9pRGSFc9jcgD2+zxaUW4
         f4jI//Of1jLe0MmCZVyJtCIrFyXAAzXtZrvIg/0ZViFJBfKLCl/p5kY+RvogQUR66w3F
         7r8A==
X-Gm-Message-State: APjAAAU6NbNT+1uE4HpLQn7AguPVnwwQEZr/br+lvTqnX6HyTNPlGrnr
        c+JZcJfg+aOpruvQ1heStw==
X-Google-Smtp-Source: APXvYqwcZJeRHC1PVNC2DKjUVCVr9+SFzeO0M0kOrsz2lu3agim9M0Aj63nSjTgT/vcdVxuD4z+A6g==
X-Received: by 2002:a05:6808:7c1:: with SMTP id f1mr2510604oij.123.1568385369033;
        Fri, 13 Sep 2019 07:36:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s194sm921883oie.19.2019.09.13.07.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:08 -0700 (PDT)
Message-ID: <5d7ba958.1c69fb81.d998a.6602@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:07 +0100
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hhhawa@amazon.com, ronenk@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, barakw@amazon.com
Subject: Re: [PATCH 1/3] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
References: <1567603943-25316-1-git-send-email-talel@amazon.com>
 <1567603943-25316-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567603943-25316-2-git-send-email-talel@amazon.com>
X-Mutt-References: <1567603943-25316-2-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 04:32:21PM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../devicetree/bindings/edac/amazon,al-mc-edac.txt | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt
> new file mode 100644
> index 0000000..9a3803f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.txt
> @@ -0,0 +1,24 @@
> +Amazon's Annapurna Labs Memory Controller EDAC
> +
> +EDAC node is defined to describe on-chip error detection and correction for
> +Amazon's Annapurna Labs Memory Controller.
> +
> +Required properties:
> +- compatible:	Shall be "amazon,al-mc-edac".
> +- reg:		DDR controller resource.
> +
> +Optional:
> +- interrupt-names:	may include "ue", for uncorrectable errors,
> +			and/or "ce", for correctable errors.
> +- interrupts:		should contain the interrupts associated with the
> +			interrupts names.
> +
> +Example:
> +
> +al_mc_edac {

edac@f0080000

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +	compatible = "amazon,al-mc-edac";
> +	reg = <0x0 0xf0080000 0x0 0x00010000>;
> +	interrupt-parent = <&amazon_al_system_fabric>;
> +	interrupt-names = "ue";
> +	interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +};
> -- 
> 2.7.4
> 

