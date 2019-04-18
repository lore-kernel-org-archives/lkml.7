Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB675214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/1gTLai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfDRXC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:02:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42472 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfDRXC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:02:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so1835249pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 16:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bIwZNepkZcafS+Ng1sIJ4koMH/C8FpxZ1rR7ZlajLIo=;
        b=G/1gTLaiw/xumtLmXzgDeQ80a2DT3YeDeCy1LeDRzgS1vothcQgfRHKAnG6pLb79MQ
         pgLmklO1IMt0r+YPJvXQVTavBbggtBAwAGC1EECInlX9Vm7bBBSFaay9KHwNup7o6hew
         xhhn/pDZnIZMr/236Rb7GmKaNzize3p7X2gpFOnv9aGhaemsAwd7J5ei0+2pw/0TZ6w0
         PBk6V4/rT4NSnl762uLLpuXoDlt5z2AxKr090HYrbUxA2TS0LeMANvY/I2us9Oio8teE
         ozhZ4RdqKulFc+ETItJGAkQ1+k61CNmTqz6j3eMO/T+cI7oiaBoKWWX7lZA+ero1p+YO
         U+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bIwZNepkZcafS+Ng1sIJ4koMH/C8FpxZ1rR7ZlajLIo=;
        b=qDDswQm/eC/VeNbX/jTdMxDKxqkuQGeXHBlYIBAqcUw31AON6/DdoSEDpgxLFiT2a6
         H/OUJqOmNnpiiQM8Y3MK/v8qBJcJ9Aj9bUlX+kOmJk63GDLuBmXMauGSr2Sd2XoBgvBs
         7Exf8v4PXNQJ0hMX7qvU4vU1wNqMfEVNMMJWTZSi0kOyzYtbf09tCk0KLn9sTKkFCC7q
         MrI6v1YarIWs9Xa6cKbptl9X/nPU6RMjOhbsiGsbCJ+vlge4wND7f2+bJjQwyd9RtYQI
         xpGQuxLUhNXRmE3MgwqIkgu4AB0yP2BA7M0/mpQgPHOI4P52zDvgjUjP3m6c+RFGstA5
         TzJA==
X-Gm-Message-State: APjAAAXo0a5aL+R/iXYdL5Wg1A3sO++6wrZ/q4laNGbe1tnaC6d0YDgL
        5uJSUwVte76eZ2WdKQEiisxnaw==
X-Google-Smtp-Source: APXvYqy3Vu6VEEuKSPs2A32zkYU3bb+Szv6RngDNlkweLJE4fxGGcBdGfxQzUu71UGSaD8nDlvVqcg==
X-Received: by 2002:aa7:8284:: with SMTP id s4mr246400pfm.235.1555628576166;
        Thu, 18 Apr 2019 16:02:56 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d20sm4156327pfo.77.2019.04.18.16.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 16:02:55 -0700 (PDT)
Date:   Thu, 18 Apr 2019 16:02:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] interconnect: qcom: Add QCS404 interconnect
 provider driver
Message-ID: <20190418230253.GO27005@builder>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
 <20190415104357.5305-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415104357.5305-3-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15 Apr 03:43 PDT 2019, Georgi Djakov wrote:
> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
[..]
> +#define QCS404_MASTER_AMPSS_M0			0
> +#define QCS404_MASTER_GRAPHICS_3D		1
> +#define QCS404_MASTER_MDP_PORT0			2
> +#define QCS404_SNOC_BIMC_1_MAS			3
> +#define QCS404_MASTER_TCU_0			4
> +#define QCS404_MASTER_SPDM			5
> +#define QCS404_MASTER_BLSP_1			6
> +#define QCS404_MASTER_BLSP_2			7
> +#define QCS404_MASTER_XM_USB_HS1		8
> +#define QCS404_MASTER_CRYPTO_CORE0		9
> +#define QCS404_MASTER_SDCC_1			10
> +#define QCS404_MASTER_SDCC_2			11
> +#define QCS404_SNOC_PNOC_MAS			12
> +#define QCS404_MASTER_QPIC			13
> +#define QCS404_MASTER_QDSS_BAM			14
> +#define QCS404_BIMC_SNOC_MAS			15
> +#define QCS404_PNOC_SNOC_MAS			16
> +#define QCS404_MASTER_QDSS_ETR			17
> +#define QCS404_MASTER_EMAC			18
> +#define QCS404_MASTER_PCIE			19
> +#define QCS404_MASTER_USB3			20
> +#define QCS404_PNOC_INT_0			21
> +#define QCS404_PNOC_INT_2			22
> +#define QCS404_PNOC_INT_3			23
> +#define QCS404_PNOC_SLV_0			24
> +#define QCS404_PNOC_SLV_1			25
> +#define QCS404_PNOC_SLV_2			26
> +#define QCS404_PNOC_SLV_3			27
> +#define QCS404_PNOC_SLV_4			28
> +#define QCS404_PNOC_SLV_6			29
> +#define QCS404_PNOC_SLV_7			30
> +#define QCS404_PNOC_SLV_8			31
> +#define QCS404_PNOC_SLV_9			32
> +#define QCS404_PNOC_SLV_10			33
> +#define QCS404_PNOC_SLV_11			34
> +#define QCS404_SNOC_QDSS_INT			35
> +#define QCS404_SNOC_INT_0			36
> +#define QCS404_SNOC_INT_1			37
> +#define QCS404_SNOC_INT_2			38
> +#define QCS404_SLAVE_EBI_CH0			39
> +#define QCS404_BIMC_SNOC_SLV			40
> +#define QCS404_SLAVE_SPDM_WRAPPER		41
> +#define QCS404_SLAVE_PDM			42
> +#define QCS404_SLAVE_PRNG			43
> +#define QCS404_SLAVE_TCSR			44
> +#define QCS404_SLAVE_SNOC_CFG			45
> +#define QCS404_SLAVE_MESSAGE_RAM		46
> +#define QCS404_SLAVE_DISPLAY_CFG		47
> +#define QCS404_SLAVE_GRAPHICS_3D_CFG		48
> +#define QCS404_SLAVE_BLSP_1			49
> +#define QCS404_SLAVE_TLMM_NORTH			50
> +#define QCS404_SLAVE_PCIE_1			51
> +#define QCS404_SLAVE_EMAC_CFG			52
> +#define QCS404_SLAVE_BLSP_2			53
> +#define QCS404_SLAVE_TLMM_EAST			54
> +#define QCS404_SLAVE_TCU			55
> +#define QCS404_SLAVE_PMIC_ARB			56
> +#define QCS404_SLAVE_SDCC_1			57
> +#define QCS404_SLAVE_SDCC_2			58
> +#define QCS404_SLAVE_TLMM_SOUTH			59
> +#define QCS404_SLAVE_USB_HS			60
> +#define QCS404_SLAVE_USB3			61
> +#define QCS404_SLAVE_CRYPTO_0_CFG		62
> +#define QCS404_PNOC_SNOC_SLV			63
> +#define QCS404_SLAVE_APPSS			64
> +#define QCS404_SLAVE_WCSS			65
> +#define QCS404_SNOC_BIMC_1_SLV			66
> +#define QCS404_SLAVE_OCIMEM			67
> +#define QCS404_SNOC_PNOC_SLV			68
> +#define QCS404_SLAVE_QDSS_STM			69
> +#define QCS404_SLAVE_CATS_128			70
> +#define QCS404_SLAVE_OCMEM_64			71
> +#define QCS404_SLAVE_LPASS			72

An enum would probably be cleaner, given that the actual values are not
significant.

[..]
> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct qcom_icc_desc *desc;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct qcom_icc_node **qnodes;
> +	struct qcom_icc_provider *qp;
> +	struct icc_node *node;
> +	size_t num_nodes, i;
> +	int ret;
> +
> +	rpm = dev_get_drvdata(dev->parent);
> +	if (!rpm) {
> +		dev_err(dev, "unable to retrieve handle to RPM\n");
> +		return -ENODEV;
> +	}

In line with my feedback on the DT binding I would prefer if this driver
deals with the devices on the mmio/soc bus and you move the SMD/RPM part
to a separate driver - then perform the SMD/RPM operation by calling
into the other driver.

Given how much of this driver is platforms specific then I think it's a
pretty clean split for adding further (SMD/RPM based) platforms.


Except for the decision on where in the device tree this sits I think
the implementation looks good now!

Regards,
Bjorn
