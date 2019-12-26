Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBE1C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00C02080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577402788;
	bh=x+9RDdDZOGqlkhKVgTzNbCkGHMxR6XQP/+TD6CDGJGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YsuFfJaY92FWBjKnw61VqOweGBRCUaS30ETECDlcCOlgNqzdF0IjvJfkNx/k0U69F
	 DFC338Ytb7QntCc6g6r33uh8Bw7OeTsPCOy3nlKN7HYBt6DCHVWBivY59OHDP/M5dM
	 ilYUppkyuC8+fIDoKpSEkBwy/WyQkQgRPpiNsBBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLZX02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 18:26:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45024 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLZX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 18:26:27 -0500
Received: by mail-io1-f68.google.com with SMTP id b10so24402642iof.11;
        Thu, 26 Dec 2019 15:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZuxmXzQcdoI42Mq4JA2i4xvs2lzIVFQfZ8EfJUFcq0=;
        b=ihDW2uypdf8JXF75qIqYLmwwdnPCdfCnD5enXLpNL4UHGQOvU1h6cGtB3bg/Tk4r0S
         fQ5/vJomHFvm7zskkoXrV7DS/a7H5iEFPo+kxt0ozKgKDApTb+j0qBQRNmvvBkrlri/i
         Cy5OD4IGz76KvBFEVbKBaX4xHwBYwsE+e8bmB5s0x/CUKV8mMEP66c0h8cCUygBLSbxF
         6b+emZ5YyKWG/YEToEVXhUF+Iit1+Ug/D/rWDtbe3CdE4U9OAd1lkxQet7JUvpz/xn3M
         oQWpTq0WmH+dbWQRBtg00j7DMWBiP9RXnTLQPoVPprUrEmtyqPjO5oV0m3sYOu/z894H
         mE+Q==
X-Gm-Message-State: APjAAAV94sm5ori38I4IJfGZiCppzQ6gOuayXrxOI+pvsoHOtk5/SGnz
        fVOLllZ6vw/VM76fbiGSIQ==
X-Google-Smtp-Source: APXvYqwqCzA89iI/xF2Ft9CPX5Wc/iIOn5+cdeR3NY72+uSYXHb2Pr8bL2zXpNXwKojRCsGNhQTHaA==
X-Received: by 2002:a6b:7d02:: with SMTP id c2mr20203518ioq.146.1577402786899;
        Thu, 26 Dec 2019 15:26:26 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t15sm12696417ili.50.2019.12.26.15.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 15:26:26 -0800 (PST)
Date:   Thu, 26 Dec 2019 16:26:25 -0700
From:   Rob Herring <robh@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana
 i.MX6DL/Q compatibles
Message-ID: <20191226232625.GA2186@bogus>
References: <20191224010020.15969-1-rjones@gateworks.com>
 <20191224010020.15969-2-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224010020.15969-2-rjones@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 05:00:16PM -0800, Robert Jones wrote:
> Add the compatible enum entries for Gateworks Ventana boards.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index f79683a..a02e980 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -126,6 +126,7 @@ properties:
>                - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
>                - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
>                - variscite,dt6customboard
> +              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana

Keep entries sorted.

>            - const: fsl,imx6q
>  
>        - description: i.MX6QP based Boards
> @@ -152,6 +153,7 @@ properties:
>                - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
>                - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
>                - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
> +              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
>            - const: fsl,imx6dl
>  
>        - description: i.MX6SL based Boards
> -- 
> 2.9.2
> 
