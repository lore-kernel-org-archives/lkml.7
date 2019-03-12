Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F72C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD32D2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552398328;
	bh=nqlrHWJ20y5gcffjzVN6h7w/oceYfkFUCXKaaqEmGcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sg4nfzmOQE99iltxX228YE5QO638HHoGz3A3JIRZMvlyE7nEQjeU+43QtmRgu21rU
	 7hZjUssBkImnRc+V2NdPqiqhwUqN6ILv+lYIpiZdiBAMfz+axQRKntbG49BPUmAbA6
	 0+Lh3wXFMEFp4Izh64nNGaVwQqpMqUo6R7t4tAdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfCLNp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:45:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38089 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:45:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id a15so1956642oid.5;
        Tue, 12 Mar 2019 06:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJjWhe5cXR18ePUK1tdiW/jaqBI8knZ1Y9/Caryu0/Y=;
        b=jgLbUbJqSSRIcdUz2gB4JbHiMxwP05fHOAo+gSjfvQ8a16s+Yq0w/szbObs/6o8uxN
         Ij99Jt5T9kCmSmYHwWt24DL95qIwN/F3fjM6mMqAaYr5pN2lPjwL1v4ruyll6QFaHWLb
         gvZKSynx++raGDGwSMGzZeJUScRMVNVg2ZSqsKpMR/PGla5QaY1UtBJfe+zpe4/o8ad7
         1FNVGMFgxeoloxvhmWlhMtpRcl2AWvvbApcu4ppW0AcTCnVroGKyTDRMMTu3rn6DXBaz
         zkGS1rY3z8jy5xn+nSG7hwWgWsFIvDRejA1wwa33Q8PDwcWVxmbscoW07VdQVGidLjTG
         7niQ==
X-Gm-Message-State: APjAAAXzf4zLCPb2Qd2u36+bUZuyS4+9YUCeQqiuUKtJFkEp0FeoHNSX
        apzBFpLsIebXlxSs/WjXSA==
X-Google-Smtp-Source: APXvYqwq4rkdCQnsMHHLBGayCL8WrhsvjLxS2/vFo6KKMOiTbNJ7keLSo7CqXLWe7pcTTDBGuo+L+Q==
X-Received: by 2002:aca:4344:: with SMTP id q65mr1649734oia.156.1552398326160;
        Tue, 12 Mar 2019 06:45:26 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id h138sm3725224oic.8.2019.03.12.06.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 06:45:25 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:45:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com, Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v3 01/12] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
Message-ID: <20190312134525.GA9706@bogus>
References: <20190302090505.65542-1-chenyu56@huawei.com>
 <20190302090505.65542-2-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302090505.65542-2-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 05:04:54PM +0800, Yu Chen wrote:
> This patch adds binding documentation for supporting the hi3660 usb
> phy on boards like the HiKey960.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v1:
> * Fix some format error as suggested by Rob.
> v2:
> * Change hi3660 usb PHY to hi3660 USB PHY
> v3:
> * Make device node a subnode of usb3_otg_bc register.
> ---
> ---
>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt    | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> new file mode 100644
> index 000000000000..6096214a2bc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> @@ -0,0 +1,28 @@
> +Hisilicon hi3660 USB PHY
> +-----------------------
> +
> +Required properties:
> +- compatible: should be "hisilicon,hi3660-usb-phy"
> +- #phy-cells: must be 0
> +- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
> +- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
> +- hisilicon,usb3-otg-bc-syscon: phandle of syscon used to control phy.

You can drop this as it is now just the parent node.

> +- hisilicon,eye-diagram-param: parameter set for phy
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> +
> +This is a subnode of usb3_otg_bc register node.
> +
> +Example:
> +	usb3_otg_bc: usb3_otg_bc@ff200000 {
> +		compatible = "syscon", "simple-mfd";

This node should have a specific compatible.

> +		reg = <0x0 0xff200000 0x0 0x1000>;
> +
> +		usb-phy {
> +			compatible = "hisilicon,hi3660-usb-phy";
> +			#phy-cells = <0>;
> +			hisilicon,pericrg-syscon = <&crg_ctrl>;
> +			hisilicon,pctrl-syscon = <&pctrl>;
> +			hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
> +			hisilicon,eye-diagram-param = <0x22466e4>;
> +		};
> +	};
> -- 
> 2.15.0-rc2
> 
