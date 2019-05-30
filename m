Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E164AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B276E24520
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185931;
	bh=8P0hArzw97X371q2PY5OPUCciW9Z6QhGDji7tsRwruQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YPfhxpGuLbG3dKlQSkqhm1u5N/S8u8B6SCprIJgHnACJznXvxBmCk65T0cW7hf5/V
	 Z/TkZCOgpTVv+k0Jvbr0glgh18dswQ8p1dlxBkw4bBFPB7yaB6praaaYQ/knrgbWGu
	 31f+3Z+wroJbZYM7UH5rrS+yEXxOYuepgkefSco0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfE3DML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbfE3DKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:43 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26BB5244D1;
        Thu, 30 May 2019 03:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185843;
        bh=8P0hArzw97X371q2PY5OPUCciW9Z6QhGDji7tsRwruQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpiEssVaL7Z0YAVn8jSA9oPL9LACkWzUM6qWR/DaBU14cmJPCKZuuerP6FxdtU1Yz
         4I1to4TwiliwOCd6tCkrGjiPUmrlojh3NgJyqWnYmzeUY7a0dDuUU/2BHwwh7Y3ykm
         Ms5m1AbFlbyzgOGpb78Ym3Rc6v/LZqpZ0j1Y2Ks0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 161/405] iio: adc: stm32-dfsdm: fix unmet direct dependencies detected
Date:   Wed, 29 May 2019 20:02:39 -0700
Message-Id: <20190530030549.284998500@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ba7ecfe43d6bf12e2aa76705c45f7d187ae3d7c0 ]

This fixes unmet direct dependencies seen when CONFIG_STM32_DFSDM_ADC
is selected:

WARNING: unmet direct dependencies detected for IIO_BUFFER_HW_CONSUMER
  Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
  Selected by [y]:
  - STM32_DFSDM_ADC [=y] && IIO [=y] && (ARCH_STM32 [=y] && OF [=y] ||
    COMPILE_TEST [=n])

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 76db6e5cc2961..9ca21a8dfcd71 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -809,6 +809,7 @@ config STM32_DFSDM_ADC
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
 	select STM32_DFSDM_CORE
 	select REGMAP_MMIO
+	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
 	help
 	  Select this option to support ADCSigma delta modulator for
-- 
2.20.1



