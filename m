Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CAA2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZBYG5KyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCLQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:59:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33659 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:59:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so2279063pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oZb6CACGM6VZGvUR+Ibx4EQn2QmozkbR6QSAW+dYXLM=;
        b=ZBYG5KyFEqg9qtHysYtsux5REdr5/Qo34GKc4sM/GAFU9HTtpiNrI2jZ4f1KZ5OUh5
         h2ckGFXe61F6zTG4AFfpTsqtfdXBwdcR3u8jtCT28kuRymKnTpnfcumMsmEmY96oLqhu
         fgqobwQchJTVwZs4YQi4R/ZIIxiNjw+rddNCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oZb6CACGM6VZGvUR+Ibx4EQn2QmozkbR6QSAW+dYXLM=;
        b=V9XRGpP13fM7Ro986PGn1Va4llRe8c0JDLVCTjLxmGrYg4LJ1A6gwNBvK11Nm2sqy8
         Uaty2L0EDRstEJwx9T6MMYb/4cHyuqafJrX4lVM+mD2SGmi2OAxUoyqxukydu5JsHLVa
         udgvY2UD0NnH6xvXpTCM1GBekaEVn5QXm+rjAluevItJfIXfui/mz6DcUicGKOBJN5cJ
         aUHmcXiyyaAL6lQ1+MmdondxeKW6wF4955hC20yZ4bUjeZZhBaDeb7Nxis7RUhxg3WYa
         xVwqBEw7mz1UONklp+IwWfHbxME6hErtkrIU8g066CS3DqGwOPr0UheootT+lEQwOkdU
         BmyA==
X-Gm-Message-State: APjAAAVH054BG7O4iVyU4hTPW6GG+TQhOMGHM4oFNNtCfpDOTqOwvOAH
        ZNrCwt0iDdt9JPBmKn9C6Tf6CQ==
X-Google-Smtp-Source: APXvYqxe5SwJVhPUTSQTsEzA0IpvKFD5QTPFOxGNLcPJAHj5DVSb5/WICaW9jbI6RmUpHtZ9sCWyig==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr41681710plo.265.1552409969614;
        Tue, 12 Mar 2019 09:59:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 11sm11887958pfh.131.2019.03.12.09.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:59:28 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:59:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3998
Message-ID: <20190312165928.GD200579@google.com>
References: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
 <1552393379-26330-3-git-send-email-c-hbandi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552393379-26330-3-git-send-email-c-hbandi@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+DT folks

Please add them in future versions (script/scripts/get_maintainer.pl
<patches> should have listed them)

On Tue, Mar 12, 2019 at 05:52:59PM +0530, Harish Bandi wrote:
> This patch enables regulators for the Qualcomm Bluetooth wcn3998
> controller.

No, it doesn't.

The next version should probably say something like "Add compatible
string for the Qualcomm WCN3998 Bluetooth controller.

Is there any particular reason why QCA drivers folks use 'wcn' instead
of 'WCN'? The QCA documentations calls it WCN399x, so I'd suggest to
consistently use the uppercase name in comments and documentation (and
log messages?).

> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> ---
> changes in v3:
> - updated to latest code base.

This comment is useless, please describe what changed wrt the previous
version.

> ---
>  .../devicetree/bindings/net/qualcomm-bluetooth.txt        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 824c0e2..1221535 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -53,3 +53,18 @@ serial@898000 {
>  		max-speed = <3200000>;
>  	};
>  };
> +
> +&blsp1_uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&blsp1_uart3_default>;
> +	status = "okay";
> +
> +	bluetooth: wcn3998-bt {
> +		compatible = "qcom,wcn3998-bt";
> +		vddio-supply = <&vreg_l6_1p8>;
> +		vddxo-supply = <&vreg_l5_1p8>;
> +		vddrf-supply = <&vreg_s5_1p35>;
> +		vddch0-supply = <&vdd_ch0_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> \ No newline at end of file

I think the example isn't really needed since it's essentially the
same as the one for 'qcom,wcn3990-bt'.

But the important part is missing: add the new compatible string under
´Required properties´. You also want to update the documentation that
mentiones 'qcom,wcn3990-bt' to 'qcom,wcn399x-bt' (assuming for now
that other possible WCN399x chips would be similar).

You mentioned in an earlier version of the series that there are
multiple WCN3998 variants with different requirements for
voltage/current. This seems to suggests that multiple compatible
strings are needed to distinguish between them.

Thanks

Matthias
