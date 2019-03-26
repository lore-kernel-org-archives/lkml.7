Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270B82084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vsBiRBF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfCZHqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:46:50 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48072 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfCZHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:46:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2Q7kjAx095938;
        Tue, 26 Mar 2019 02:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553586405;
        bh=C2EN2f9MtOKjpoVMhew+uY0nqr8EQyyjIgAFG/KHlNo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vsBiRBF2L0G7FbtCD+TK+A7Ep6KtZIOEYgOz+ZPz0p03L7wodjBy2t9Xc7P6WUYqx
         0smLsoIgc4nBy7WRxzThV4Dwngu61E3dgmRiu+xwUiacs7THcOORv4QKDmogB+vXSJ
         rP0vLdbaOOA/8s68BQGgL+9CtXkDGyExGk81Qncw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2Q7kjkr066800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Mar 2019 02:46:45 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 26
 Mar 2019 02:46:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 26 Mar 2019 02:46:44 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2Q7kfrH084022;
        Tue, 26 Mar 2019 02:46:42 -0500
Subject: Re: [PATCH v1] phy: qcom-qmp: Add msm8998 PCIe QMP PHY support
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
CC:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <a897277d-23b3-9746-81dc-28f8925a9992@free.fr>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <136857e7-0fe1-6fc6-729e-2cbf6ea72386@ti.com>
Date:   Tue, 26 Mar 2019 13:15:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a897277d-23b3-9746-81dc-28f8925a9992@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/03/19 9:42 PM, Marc Gonzalez wrote:
> Copy init sequence from downstream:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998-v2.dtsi?h=LE.UM.1.3.r3.25#n372

Can't we instead have reference to HW manual or datasheet?
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   5 +
>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 110 ++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |  12 ++
>  3 files changed, 127 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 5d181fc3cc18..6000ae34b12b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -11,6 +11,7 @@ Required properties:
>  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>  	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
>  	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
> +	       "qcom,msm8998-qmp-pcie-phy" for PCIe QMP phy on msm8998,
>  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>  	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
>  	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> @@ -48,6 +49,8 @@ Required properties:
>  			"aux", "cfg_ahb", "ref".
>  		For "qcom,msm8998-qmp-ufs-phy" must contain:
>  			"ref", "ref_aux".
> +		For "qcom,msm8998-qmp-pcie-phy" must contain:
> +			"aux", "cfg_ahb", "ref".
>  		For "qcom,sdm845-qmp-usb3-phy" must contain:
>  			"aux", "cfg_ahb", "ref", "com_aux".
>  		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
> @@ -70,6 +73,8 @@ Required properties:
>  		For "qcom,msm8998-qmp-usb3-phy" must contain
>  			"phy", "common".
>  		For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
> +		For "qcom,msm8998-qmp-pcie-phy" must contain:
> +			"phy", "common", "cfg".
>  		For "qcom,sdm845-qmp-usb3-phy" must contain:
>  			"phy", "common".
>  		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:

Please send the dt binding in a separate patch.

Thanks
Kishon
