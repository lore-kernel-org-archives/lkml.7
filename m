Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99FDC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B896C222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="iYel5SRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKMK1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:27:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727374AbfKMK1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:27:44 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADALxjA021509;
        Wed, 13 Nov 2019 11:27:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=tPNeF+gUJ+p9FLYAaHm+hEv7Xx4wJqHeqgH5XViL1ro=;
 b=iYel5SRoBGMshMr6OiqvlGHPStiBrjVszL1KYY85seAkF4FkTXtxlF0xbsbKOl8E8kiE
 3h67NHTX9l1ov19E8qZpmFENFqNnkiq6sVX04ITvIfXUxGLS2Xj3b9rv8+Da9P5KDeTG
 z5JrSM0KXm/5G4e7QCyqrp3JomAAhnaoDwg4YveTpV++MS0BrhOLiHsNrug9lQgZlWRq
 epZbiTKltXew8JfSmRE0zYpaDixZwkkfFUdkIUbwjJpZ+7jsXgAWPZs/E189rTkjycPe
 lkflhg6Y719d+VYRfyDaCc0szsLSDuquYjHwe+H5Wcn+i0jdex4Pk0p8McQPNCY78Nv7 6g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w7psf7jbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 11:27:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9FF0C100039;
        Wed, 13 Nov 2019 11:27:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 955102B52FE;
        Wed, 13 Nov 2019 11:27:38 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Nov 2019 11:27:38
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [RFC] regulator: core: Let boot-on regulators be powered off
Date:   Wed, 13 Nov 2019 11:27:37 +0100
Message-ID: <20191113102737.27831-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_02:2019-11-13,2019-11-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot-on regulators are always kept on because their use_count value
is now incremented at boot time and never cleaned.

Only increment count value for alway-on regulators.
regulator_late_cleanup() is now able to power off boot-on regulators
when unused.

Fixes: 05f224ca6693 ("regulator: core: Clean enabling always-on regulators + their supplies")
Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/regulator/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 970905124382..f01862844da6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1403,7 +1403,9 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 			rdev_err(rdev, "failed to enable\n");
 			return ret;
 		}
-		rdev->use_count++;
+
+		if (rdev->constraints->always_on)
+			rdev->use_count++;
 	}
 
 	print_constraints(rdev);
-- 
2.17.1

