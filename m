Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9EBC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FB22084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RPj+yw/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfDLMym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:54:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38864 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726714AbfDLMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:54:42 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CCl5t4001193;
        Fri, 12 Apr 2019 14:54:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=RLtemCZL9lzmYgqDcvAUxhmFKgU2R8f0ZbX40nXW48M=;
 b=RPj+yw/lZRVNg9cq1w8AkaHVIHeS5K76CJ6ap23XdcXPevQx4UAl1wJB8dBr3+r7e1SD
 NG8+Ss2wNgDq/xMHQnE1C9UWvbJ+5mB2n2XXFtkBn88VHlaRGkmq4qiDo5BEdsAZTzRn
 RNk/Yw/Od8Ex9pCsbaGSPfBtz078TDzF2lpVDzGvj4cPnUMlNpcCniUrWKsvjlqeFcvb
 NPzPLpCWlqA5L7wN4CzVYrbO+J3anVGZ0CbO3gFBHqgVLvhv5TCe9Kq5j2GQSeA+ut3B
 JJezBSJwzjrcO6muRmji3gmDrYPOnhLuqKTULOPIlE8MK8nWkbazN36XZW2BCClhffY5 Fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7x584p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 12 Apr 2019 14:54:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39B1331;
        Fri, 12 Apr 2019 12:54:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1E1CD2520;
        Fri, 12 Apr 2019 12:54:32 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 12 Apr
 2019 14:54:31 +0200
Received: from localhost (10.201.23.25) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 12 Apr 2019 14:54:31
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] HID: rmi: fix devm_add_action_or_reset() parameter
Date:   Fri, 12 Apr 2019 14:54:17 +0200
Message-ID: <1555073657-24386-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second parameter of devm_add_action_or_reset() shall be a function,
not a function address.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/hid/hid-rmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 9e33165..8748d4d 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -623,7 +623,7 @@ static int rmi_setup_irq_domain(struct hid_device *hdev)
 	if (!hdata->domain)
 		return -ENOMEM;
 
-	ret = devm_add_action_or_reset(&hdev->dev, &rmi_irq_teardown, hdata);
+	ret = devm_add_action_or_reset(&hdev->dev, rmi_irq_teardown, hdata);
 	if (ret)
 		return ret;
 
-- 
2.7.4

