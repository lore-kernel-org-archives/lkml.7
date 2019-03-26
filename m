Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D540C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309812054F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfCZMow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:44:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22095 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbfCZMow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:44:52 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QChIXC016487;
        Tue, 26 Mar 2019 13:44:14 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddhta1xh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 13:44:14 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DE35E31;
        Tue, 26 Mar 2019 12:44:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9A995807;
        Tue, 26 Mar 2019 12:44:13 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar 2019 13:44:13
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32: fix sleep inside atomic section when using DMA
Date:   Tue, 26 Mar 2019 13:44:04 +0100
Message-ID: <1553604244-10922-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG_DEBUG_ATOMIC_SLEEP=y triggers this BUG message:
BUG: sleeping function called from invalid context at kernel/irq/chip.c...

Call stack is as follows:
- __might_sleep
- handle_nested_irq          <-- Expects threaded irq
- iio_trigger_poll_chained
- stm32_adc_dma_buffer_done
- vchan_complete
- tasklet_action_common
- tasklet_action
- __do_softirq               <-- DMA completion raises a tasklet
- irq_exit
- __handle_domain_irq        <-- DMA IRQ
- gic_handle_irq

IIO expects threaded interrupt context when calling:
- iio_trigger_poll_chained()
Or it expects interrupt context when calling:
- iio_trigger_poll()

This patch triggers an IRQ upon stm32_adc_dma_buffer_done() DMA callback
call, so the IIO trigger poll API gets called from IRQ context.

Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/Kconfig     |  1 +
 drivers/iio/adc/stm32-adc.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 76db6e5..059407a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -775,6 +775,7 @@ config STM32_ADC_CORE
 	select MFD_STM32_TIMERS
 	select IIO_STM32_TIMER_TRIGGER
 	select IIO_TRIGGERED_BUFFER
+	select IRQ_WORK
 	help
 	  Select this option to enable the core driver for STMicroelectronics
 	  STM32 analog-to-digital converter (ADC).
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 205e169..1aa3189 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -297,6 +298,7 @@ struct stm32_adc_cfg {
  * @smpr_val:		sampling time settings (e.g. smpr1 / smpr2)
  * @cal:		optional calibration data on some devices
  * @chan_name:		channel name array
+ * @work:		irq work used to call trigger poll routine
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -320,6 +322,7 @@ struct stm32_adc {
 	u32			smpr_val[2];
 	struct stm32_adc_calib	cal;
 	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
+	struct irq_work		work;
 };
 
 struct stm32_adc_diff_channel {
@@ -1473,11 +1476,32 @@ static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
 	return 0;
 }
 
+static void stm32_adc_dma_irq_work(struct irq_work *work)
+{
+	struct stm32_adc *adc = container_of(work, struct stm32_adc, work);
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+
+	/*
+	 * iio_trigger_poll calls generic_handle_irq(). So, it requires hard
+	 * irq context, and cannot be called directly from dma callback,
+	 * dma cb has to schedule this work instead.
+	 */
+	iio_trigger_poll(indio_dev->trig);
+}
+
 static void stm32_adc_dma_buffer_done(void *data)
 {
 	struct iio_dev *indio_dev = data;
+	struct stm32_adc *adc = iio_priv(indio_dev);
 
-	iio_trigger_poll_chained(indio_dev->trig);
+	/*
+	 * Invoques iio_trigger_poll() from hard irq context: We can't
+	 * call iio_trigger_poll() nor iio_trigger_poll_chained()
+	 * directly from DMA callback (under tasklet e.g. softirq).
+	 * They require respectively HW IRQ and threaded IRQ context
+	 * as it might sleep.
+	 */
+	irq_work_queue(&adc->work);
 }
 
 static int stm32_adc_dma_start(struct iio_dev *indio_dev)
@@ -1585,8 +1609,10 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (!adc->dma_chan)
 		stm32_adc_conv_irq_disable(adc);
 
-	if (adc->dma_chan)
+	if (adc->dma_chan) {
 		dmaengine_terminate_all(adc->dma_chan);
+		irq_work_sync(&adc->work);
+	}
 
 	if (stm32_adc_set_trig(indio_dev, NULL))
 		dev_err(&indio_dev->dev, "Can't clear trigger\n");
@@ -1872,6 +1898,8 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
 	if (ret)
 		goto err_free;
 
+	init_irq_work(&adc->work, stm32_adc_dma_irq_work);
+
 	return 0;
 
 err_free:
-- 
2.7.4

