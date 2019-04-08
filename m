Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0DCC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5713206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rv9dB+p6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfDHOd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:33:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46355 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfDHOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:33:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id r25so1078696lfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AwC77turM8Fuzoj2lqSX9M7XkjdlrQcSJzhbCyzQM6U=;
        b=rv9dB+p6JpJnN8oVgYEdq7vAGqt3eHcJznDFPLYF0pF06yVOBcDbL8GNBfc94EnMvQ
         3GllB73o7MJB1IlH5r7XJMysYAlFsaGu/kJJ5hiMX3L1aNpodyAMR9/4N91APZaoJJM+
         CJOprlOPqjnABCf/l4tCEpdtMyIE8Osa+8xi3UBiw6FSOnrgtPXeQoz899xhj0ZrJgMm
         rg5+nxdLDXCrT9UQuQ7zxxq3Q0FcRrrVtq55IVoj/cZ34SUKe+EgvFRPalKYQT/ee33I
         xgWipNlYwQsbBSgM063vJHOhXqLevzxVZkhxZoCtrhsYUaVimnUuavRcWZ1Sy6xtBVN2
         cgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AwC77turM8Fuzoj2lqSX9M7XkjdlrQcSJzhbCyzQM6U=;
        b=g7qsW78mS6z36fHjWJpYPBCCLZnlYnLv6dt54/DaY9jc/5h7zsJhQynNyVnWBSUxjw
         9ckbs/L+kMChVl0GykiHEig5HEb1EctPILlP76s/uUIzWqLk2o8plTUIJND2mTG2590F
         V0GKLBy1WLfI4N+56FBhy5akvB/3f6hJT1+Ol1TtPZ8t6Bno+4xLMfeGezpfo1KhLaTX
         CJVH6LYMdCrX5x+yarrHgBNG6/MGXmYuIoU1jybS8c2UEqW1jx58nDWOALG/47FY+beu
         5+0a0lmSqn85aD13NhZIteol9EundMTGIVgnm14JJ85prWFF2vSbYarrc37/C0zPKwXx
         EKcA==
X-Gm-Message-State: APjAAAUbjcuu4rrh06aQbhTqg461MPF9wBTxkRYJQx9srUup61L+nFjm
        9jNvjLSXwf8qmoAI8gN1tGpTmbrroR8=
X-Google-Smtp-Source: APXvYqyUZ9zv89I+9yta9qYe/hP0jmM0eaT9x1dfssq4Z7Tm7CcoTBmlZxgEp9WGoG/ET12OLIVCaQ==
X-Received: by 2002:ac2:59db:: with SMTP id x27mr10067556lfn.108.1554734034826;
        Mon, 08 Apr 2019 07:33:54 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m19sm6340887lji.70.2019.04.08.07.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:33:53 -0700 (PDT)
Subject: Re: [PATCH 2/3] interconnect: qcom: Add QCS404 interconnect provider
 driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-3-georgi.djakov@linaro.org>
 <20190405145756.GN1843@tuxbook-pro>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <0ca7862f-31ba-748a-945d-a925a40a16de@linaro.org>
Date:   Mon, 8 Apr 2019 17:33:53 +0300
MIME-Version: 1.0
In-Reply-To: <20190405145756.GN1843@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for reviewing!

On 4/5/19 17:57, Bjorn Andersson wrote:
> On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
> [..]
>> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
>> new file mode 100644
>> index 000000000000..42d36db13ec0
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/qcs404.c
>> @@ -0,0 +1,488 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 Linaro Ltd
>> + */
>> +
>> +#include <dt-bindings/interconnect/qcom,qcs404.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/soc/qcom/smd-rpm.h>
>> +
>> +#include "qcs404_ids.h"
>> +
>> +#define RPM_BUS_MASTER_REQ	0x73616d62
>> +#define RPM_BUS_SLAVE_REQ	0x766c7362
>> +#define RPM_KEY_BW		0x00007762
>> +
>> +#define to_qcom_provider(_provider) \
>> +	container_of(_provider, struct qcom_icc_provider, provider)
>> +
>> +struct qcom_smd_rpm *qcs404_rpm;
> 
> static

Ok!

>> +
> [..]
>> +#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
>> +		     _numlinks, ...)					\
>> +		static struct qcom_icc_node _name = {			\
>> +		.name = #_name,						\
>> +		.id = _id,						\
>> +		.buswidth = _buswidth,					\
>> +		.mas_rpm_id = _mas_rpm_id,				\
>> +		.slv_rpm_id = _slv_rpm_id,				\
>> +		.num_links = _numlinks,					\
> 
> If you write this as ARRAY_SIZE(((int[]){ __VA_ARGS__ })), you don't
> need the manually entered _numlinks number.

This is a really nice idea!

> 
>> +		.links = { __VA_ARGS__ },				\
>> +	}
>> +
> [..]
[..]
>> +
>> +	return ret;
> 
> ret is 0, return 0; and you can skip setting ret = 0 above.

Ok!

>> +}
>> +
>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +	const struct qcom_icc_desc *desc;
>> +	struct icc_onecell_data *data;
>> +	struct icc_provider *provider;
>> +	struct qcom_icc_node **qnodes;
>> +	struct qcom_icc_provider *qp;
>> +	struct icc_node *node;
>> +	size_t num_nodes, i;
>> +	int ret;
>> +
>> +	/* wait for RPM */
> 
> This isn't waiting, it's getting the reference. That said if you make
> these sit on mmio bus you would need to EPROBE_DEFER on the rpm-child
> not being probed yet (and by that it would be a wait).

Agree that it's a reference. The mmio registers are mostly qos related
and seem not required for just requesting bandwidth, so we can add them
later if we want to support priorities and different port modes like
limiter, regulator etc.

>> +	qcs404_rpm = dev_get_drvdata(pdev->dev.parent);
>> +	if (!qcs404_rpm) {
>> +		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	desc = of_device_get_match_data(&pdev->dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	qnodes = desc->nodes;
>> +	num_nodes = desc->num_nodes;
>> +
>> +	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
>> +	if (!qp)
>> +		return -ENOMEM;
>> +
>> +	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> 
> Please use the clk_bulk interface instead.

Ok, will do.

>> +	if (IS_ERR(qp->bus_clk))
>> +		return PTR_ERR(qp->bus_clk);
>> +
>> +	ret = clk_prepare_enable(qp->bus_clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "error enabling bus_clk: %d\n", ret);
> 
> clk_prepare_enable() will complain if it fails to enable the clock, so
> no need to add another print.

Ok, right!

[..]>> +
>> +	platform_set_drvdata(pdev, qp);
>> +
>> +	return ret;
> 
> ret is 0 here, so just return 0;

Ok!

>> +err:
>> +	list_for_each_entry(node, &provider->nodes, node_list) {
>> +		icc_node_del(node);
>> +		icc_node_destroy(node->id);
>> +	}
>> +	clk_disable_unprepare(qp->bus_clk);
>> +	clk_disable_unprepare(qp->bus_a_clk);
>> +	icc_provider_del(provider);
>> +
>> +	return ret;
>> +}
> [..]
>> diff --git a/drivers/interconnect/qcom/qcs404_ids.h b/drivers/interconnect/qcom/qcs404_ids.h
> 
> You use these defines in the driver, so I think this file should be the
> one in include/dt-bindings...

The ids in this header are in a single global namespace in order to
build the internal topology and could be used for drivers that support
only platform data (although not sure if there would be any).

> 
> [..]
>> diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h
> 

These header is using per NoC local ids and should be used on DT enabled
platforms.

Thanks,
Georgi
