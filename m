Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E1C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B621655
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576798865;
	bh=qU0AYjQ3Wt/z+EkJGVcRfZu2Rkl4zsRX9qrUSPHANUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GI6wNPU7nas5roYIWQohnBMp+TgX27Vy+YBYrGiAk91TjQMMxUav5yZ+kI4w/XTUh
	 WMZRXMqSVjPgYSkYu4D4RoNF051jIJP+CeU9AOR9RUvcZwlasj89LaUfdjeLw/B0F0
	 5l8ZXLGQY9mWE3s+7sDiWVejh/RLqq8pkK6n1nnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfLSXlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 18:41:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40577 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfLSXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:41:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so1583502otj.7;
        Thu, 19 Dec 2019 15:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3NfDG7avH+ujpcCBpbFffoQ4me1PnPp49OU9/9ftPuE=;
        b=QNVJURKqy99mz8SlvQjSgapNbZc3lVtDbzBYq3sINJnpJICcBwEvKVBcy01mTzZEqu
         fx52bbtwyQTEvfDq0yfOA1ATxGu+uwoooYBvhoAr9RYBsP8BHvFTzT+b6mwD6czx0SRC
         341jziKyAXFilnNUCysIwg3ToPJpR8zvBat7ZNfAT643ekTB/qImuYlBAtn0Zj8ff1N1
         80PUdMVMoW87Q22docLQjcwjV23iLURmtBY3hGd9a1Cy2rpeNab6wJEj5Fv9IqyS7sDK
         0hk+EXnCqMFVb0hbByMdOao6auHaE/ym2UKUleJec79HRy0ajE5/qoQsLYf18G9br9KE
         wYag==
X-Gm-Message-State: APjAAAV8ws0Dy4CvU6I1rv8mEe8piHurOAoD1OlQXnFV2zTCctkgPpXi
        ZRhIssg0bSD8sd0KwcOMAQ==
X-Google-Smtp-Source: APXvYqzAQ3Wpwz3g5jix2Do+I3Pb2ucPQFPn2hVTxMKOwUBxxicCkn6k6qUaRkAyoO5pODcIC0pAJw==
X-Received: by 2002:a9d:5c02:: with SMTP id o2mr2095128otk.176.1576798863533;
        Thu, 19 Dec 2019 15:41:03 -0800 (PST)
Received: from localhost (ip-184-205-174-147.ftwttx.spcsdns.net. [184.205.174.147])
        by smtp.gmail.com with ESMTPSA id 4sm2767680otu.0.2019.12.19.15.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:41:02 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:41:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com,
        ping.bai@nxp.com, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/7] soc: imx: gpcv2: Update imx8m-power.h to include
 iMX8M Mini
Message-ID: <20191219234100.GA19269@bogus>
References: <20191213160542.15757-1-aford173@gmail.com>
 <20191213160542.15757-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213160542.15757-3-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 10:05:37AM -0600, Adam Ford wrote:
> In preparation for i.MX8M Mini support in the GPC driver, the
> include file used by both the device tree and the source needs to
> have the appropriate references for it.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  No Change
> 
>  include/dt-bindings/power/imx8m-power.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/dt-bindings/power/imx8m-power.h b/include/dt-bindings/power/imx8m-power.h
> index 8a513bd9166e..0054bba744b8 100644
> --- a/include/dt-bindings/power/imx8m-power.h
> +++ b/include/dt-bindings/power/imx8m-power.h
> @@ -18,4 +18,18 @@
>  #define IMX8M_POWER_DOMAIN_MIPI_CSI2	9
>  #define IMX8M_POWER_DOMAIN_PCIE2	10
>  
> +#define IMX8MM_POWER_DOMAIN_MIPI	0
> +#define IMX8MM_POWER_DOMAIN_PCIE	1
> +#define IMX8MM_POWER_DOMAIN_USB_OTG1	2
> +#define IMX8MM_POWER_DOMAIN_USB_OTG2	3
> +#define IMX8MM_POWER_DOMAIN_DDR1	4
> +#define IMX8MM_POWER_DOMAIN_GPU2D	5
> +#define IMX8MM_POWER_DOMAIN_GPU	6
> +#define IMX8MM_POWER_DOMAIN_VPU	7
> +#define IMX8MM_POWER_DOMAIN_GPU3D	8
> +#define IMX8MM_POWER_DOMAIN_DISP	9
> +#define IMX8MM_POWER_VPU_G1		10
> +#define IMX8MM_POWER_VPU_G2		11
> +#define IMX8MM_POWER_VPU_H1		12

Why is _DOMAIN missing from the last 3?

> +
>  #endif
> -- 
> 2.20.1
> 
