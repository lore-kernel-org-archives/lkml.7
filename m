Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12774C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73A720833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="O6oNtu+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDOJsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:48:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22228 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbfDOJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:48:49 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3F9k3Qi011233;
        Mon, 15 Apr 2019 11:47:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=jMielUvtFlnnNMz3h26ZklBL+HQCFxVpPNAWKuTSjPk=;
 b=O6oNtu+1T8UuAE4/oGkpCwo6yDjkDoJWx7CI4/fmZpyehbTkgrUBt7UsO7kXyAM16I77
 hkApZqeTZEZ11EyR7cAMSAU8SpukR6hBP1FRzrLx1dwzqpNTNEpB/r+VsYsoZI6P+B9L
 NFCSJi387bzYPWjo09OeqYztvcmhJSRknk+NVz4IbL/wRy1mzxYnMnI9H6pQq+THZbzr
 XJCDILsMH0aC71KQV8Sh4OkX9z+RXXSE1DHJabJncE6CWlDSE6buqMAl/yQ7jrH9mflt
 Ca1HfHY3kWiV4vFxZNNsOo75lJri6Jxdxl7Iezw23mJxy58ITI5xdYCZ+pZTg94o2KFK ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ru4w823v9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Apr 2019 11:47:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5B9131;
        Mon, 15 Apr 2019 09:47:48 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 54E1613E4;
        Mon, 15 Apr 2019 09:47:48 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Apr 2019 11:47:47
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <rdunlap@infradead.org>
CC:     <sfr@canb.auug.org.au>, <benjamin.gaignard@linaro.org>,
        <linux-next@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH] iio: trigger: stm32-timer: fix build issue when disabled
Date:   Mon, 15 Apr 2019 11:47:22 +0200
Message-ID: <1555321642-482-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a build issue when CONFIG_IIO_STM32_TIMER_TRIGGER isn't set but
used in stm32-dfsdm-adc driver (e.g. CONFIG_STM32_DFSDM_ADC is set):
ERROR: "is_stm32_timer_trigger" [drivers/iio/adc/stm32-dfsdm-adc.ko]
undefined!

There are two possible options to fix this issue:
- select IIO_STM32_TIMER_TRIGGER along with CONFIG_STM32_DFSDM_ADC.
  This is what's being done currently for CONFIG_STM32_ADC.
- stub "is_stm32_timer_trigger" function

Choice is made to stub this function as suggested in [1]. This is also
inspired by similar "is_stm32_lptim_trigger" function (see [2]) in
include/linux/iio/timer/stm32-lptim-trigger.h

[1]
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1977377.html
[2] https://lkml.org/lkml/2017/9/10/124

Fixes: 11646e81d775 ("iio: adc: stm32-dfsdm: add support for buffer modes")

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fix-suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 include/linux/iio/timer/stm32-timer-trigger.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
index d68add8..cbb7c7a 100644
--- a/include/linux/iio/timer/stm32-timer-trigger.h
+++ b/include/linux/iio/timer/stm32-timer-trigger.h
@@ -73,6 +73,15 @@
 
 #define TIM17_OC1	"tim17_oc1"
 
+#if IS_REACHABLE(CONFIG_IIO_STM32_TIMER_TRIGGER)
 bool is_stm32_timer_trigger(struct iio_trigger *trig);
-
+#else
+static inline bool is_stm32_timer_trigger(struct iio_trigger *trig)
+{
+#if IS_ENABLED(CONFIG_IIO_STM32_TIMER_TRIGGER)
+	pr_warn_once("stm32-timer-trigger not linked in\n");
+#endif
+	return false;
+}
+#endif
 #endif
-- 
2.7.4

