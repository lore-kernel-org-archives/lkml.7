Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6BDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9502175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ie7++s9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfDXKTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:19:55 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21652 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbfDXKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:19:54 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OAI3L2023663;
        Wed, 24 Apr 2019 12:19:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=7Auhlb+EZOSaqeM3ITlq3V+bUysVL60SvofLk1lpDJs=;
 b=ie7++s9Tq+m/dQSH0sNjCb8h6CY4huq/CaCjoZvQdI5m3Ro3rjhv6CPoE8RZW9sKTzun
 QozPEtJwYWk6apPMQBcQmgWZno0U3FlrOg+2C1M/YAc9BsFPh5iC5QQwTmS878Gl0gjy
 fd+79z27KjNXz0Clfnkgy9M2VZlmXTQvHPAJPZslgNWwFvQyVceviDfuEBcfFgTeqsoM
 +f2SJBJ0V3yN39LPKJfZ7kcXxoUKFtHYPjuGMAOyXQtwsYk8Ehi8NwQna8VMXBWkU3Jp
 aO6rntNPBsbjGpM+uP07/RTt8+kxlUk4BHvFJSpl3je7ZNH9tjR1GUEIp0YDeibiArOo lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6rvs6m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 12:19:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16CBE41;
        Wed, 24 Apr 2019 10:19:39 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E48291654;
        Wed, 24 Apr 2019 10:19:38 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 12:19:38 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr 2019 12:19:36
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rafael.j.wysocki@intel.com>, <dmitry.torokhov@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <hadess@hadess.net>,
        <frowand.list@gmail.com>, <m.felsch@pengutronix.de>,
        <agx@sigxcpu.org>, <yannick.fertre@st.com>, <arnd@arndb.de>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 3/5] input: edt-ft5x06 - Call devm_of_device_links_add() to create links
Date:   Wed, 24 Apr 2019 12:19:11 +0200
Message-ID: <20190424101913.1534-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190424101913.1534-1-benjamin.gaignard@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick FertrÃ© <yannick.fertre@st.com>

Add a call to devm_of_device_links_add() to create links with suppliers
at probe time.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 702bfda7ee77..ac9f7e85efb0 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1167,6 +1167,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, tsdata);
 
+	devm_of_device_links_add(&client->dev);
+
 	irq_flags = irq_get_trigger_type(client->irq);
 	if (irq_flags == IRQF_TRIGGER_NONE)
 		irq_flags = IRQF_TRIGGER_FALLING;
-- 
2.15.0

