Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C63AC004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A72F2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfECN5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:57:42 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:64539 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbfECN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:57:41 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hMYh0-0000Tx-H3; Fri, 03 May 2019 15:57:38 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hMYh0-0003ks-8i; Fri, 03 May 2019 15:57:38 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     dev@pschenker.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] iio: stmpe-adc: Make wait_completion non interruptible
Date:   Fri,  3 May 2019 15:57:24 +0200
Message-Id: <20190503135725.9959-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503135725.9959-1-dev@pschenker.ch>
References: <20190503135725.9959-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

In some cases, the wait_completion got interrupted. This caused the
error-handling to mutex_unlock the function. The before turned on
interrupt then got called anyway. In the ISR then completion()
was called causing problems.

Making this wait_completion non interruptible solves the problem.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/iio/adc/stmpe-adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index 87141177fbda..baa41ffc0d76 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -78,8 +78,7 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
 	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
 			STMPE_ADC_CH(info->channel));
 
-	ret = wait_for_completion_interruptible_timeout
-		(&info->completion, STMPE_ADC_TIMEOUT);
+	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
 
 	if (ret <= 0) {
 		mutex_unlock(&info->lock);
@@ -113,8 +112,7 @@ static int stmpe_read_temp(struct stmpe_adc *info,
 	stmpe_reg_write(info->stmpe, STMPE_REG_TEMP_CTRL,
 			STMPE_START_ONE_TEMP_CONV);
 
-	ret = wait_for_completion_interruptible_timeout
-		(&info->completion, STMPE_ADC_TIMEOUT);
+	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
 
 	if (ret <= 0) {
 		mutex_unlock(&info->lock);
-- 
2.21.0

