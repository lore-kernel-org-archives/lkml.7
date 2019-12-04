Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27336C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08502073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kEWbENSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfLDK4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:56:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50618 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727445AbfLDK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:56:42 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4AqbBm000700;
        Wed, 4 Dec 2019 11:56:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=rJSQOyKapDq+fBaxlzb265FeaVRs5hLYOgiTghRAZAk=;
 b=kEWbENSKsYE5KWxPGPGjJUJE52f1lMJ6mXkJcCxSr77KqphCsZu0ghrnjU/7Voa5yakK
 EHA/8MhSCbU2CPxRen+4HC7zsjhExP1yVZE0ZttsZDOkvq3FrzSVIbMOxOpxrlSE+RaV
 bv9NP+IJo500y7Sr0M+IIJsN7RB6B8O9ph6i7Cssi7bhMK+amN6ETA5SHn5OD4j5NjeM
 WFH7YCatSov8IBgEAlY7FTVyiytnnQ+A3GP6Bq+Q2kPdZJZ+RLQNJ4w2LFHsVhJtzhfx
 73XGnu0zWtMfdO6BrxajEguXmUHPDMZzE9/65wrpm1bvkxiov52i57NuOHCFOdREDfPb Fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkg6kmk01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 11:56:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 946F710002A;
        Wed,  4 Dec 2019 11:56:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C2312AFD07;
        Wed,  4 Dec 2019 11:56:31 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Dec 2019 11:56:31
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <bbrezillon@kernel.org>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH] i3c: master: make i3c_bus_set_mode static
Date:   Wed, 4 Dec 2019 11:56:30 +0100
Message-ID: <20191204105630.27445-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i3c_bus_set_mode function is only used in master.c.
Make it static to avoid warning when compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/i3c/master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 043691656245..7f8f896fa0c3 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -527,8 +527,8 @@ static const struct device_type i3c_masterdev_type = {
 	.groups	= i3c_masterdev_groups,
 };
 
-int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
-		     unsigned long max_i2c_scl_rate)
+static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
+			    unsigned long max_i2c_scl_rate)
 {
 	struct i3c_master_controller *master = i3c_bus_to_i3c_master(i3cbus);
 
-- 
2.15.0

