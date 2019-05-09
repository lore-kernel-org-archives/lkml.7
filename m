Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A52C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBDF204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428071;
	bh=zxR1iS372/HBPbflDvjoOuYk9gDbDXGjCZR08oSYC7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IejqxTH9PRrvyDXp5Mb4ehdp+heIhodJFWggECkEV0tMHbjNDy45m9jW/LhCZzCwa
	 UzgjrShyQpAOsnfnsaeGRPV4AGLklYV7EZmxgRsGE6DYCuhWlDtz4hVdavtHIg87R9
	 L2WxDhm4dDCGjJU6bRSigAG0Oyu/CTS3C6/vQ9b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfEISyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbfEISy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:54:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39B52183F;
        Thu,  9 May 2019 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428067;
        bh=zxR1iS372/HBPbflDvjoOuYk9gDbDXGjCZR08oSYC7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ziemxIfj6EvYLnBW1Hv3G6GM5ACl1dZ3FwPGB0LL5Lvy63nYGaPCSRNQxPedHllwD
         A/uf9AN5olWpQKp/CKcTP3Yf1m+j6wGSvEhVbHdC7lRUG79AiUf3XkcA9G3T3Ds10z
         Q4Oq6Lc9ZRWN9Wn378pWSNKQRfHjyv0FLvjAhRYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.1 14/30] iio: adc: qcom-spmi-adc5: Fix of-based module autoloading
Date:   Thu,  9 May 2019 20:42:46 +0200
Message-Id: <20190509181253.883706841@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit 447ccb4e0834a9f9f0dd5643e421c7f1a1649e6a upstream.

The of_device_id table needs to be registered as module alias in order
for automatic module loading to pick the kernel module based on the
DeviceTree compatible. So add MODULE_DEVICE_TABLE() to make this happen.

Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/qcom-spmi-adc5.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -664,6 +664,7 @@ static const struct of_device_id adc5_ma
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, adc5_match_table);
 
 static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *node)
 {


