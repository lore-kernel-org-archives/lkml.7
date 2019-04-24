Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736A5218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RSJuy2TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfDXKT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:19:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15904 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728254AbfDXKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:19:56 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OA6nMV020600;
        Wed, 24 Apr 2019 12:19:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=DZCGDDaeC9/R/3CsQpYN8bY55QcNjOX1xXG1bktllLY=;
 b=RSJuy2TQJOZGWY/pQgtebRrvZuv/Cw1I9vp1ASP0jxS2CAZdcqzhSkUekVlqAK4EUhja
 MHKxkROwJdhG613iUyepe5gMnK9nQxgpsYYiwH8RVrB7aX3M8Izzq5KD3LJ8y0ab8+6w
 MX7/FHEcNE5jamKtnkJSMe83jb8Hd73R7MyAp6sU0rJ1ov/ZtI2aWpE6BSRUqhIRCJn0
 URzgADy7vvds6FerGUKQmDUea4DKUFzb46YdtbWWfj7M5xKWSaz8uTnKz9PNrwAOWvk5
 vGnrFxu07NMgT2edfmjBJdeoOyqMcMLoBl85uSZbAZOKROycC3T7/DoIo/j/NshBvHMc Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxcus6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 12:19:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB0AD41;
        Wed, 24 Apr 2019 10:19:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86F03164C;
        Wed, 24 Apr 2019 10:19:42 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 12:19:42 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr 2019 12:19:39
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
Subject: [PATCH 4/5] Input: goodix: Document links-add property
Date:   Wed, 24 Apr 2019 12:19:12 +0200
Message-ID: <20190424101913.1534-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190424101913.1534-1-benjamin.gaignard@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain the purpose of links_add property.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8cf0b4d38a7e..0447151608c6 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -24,6 +24,8 @@ Optional properties:
  - touchscreen-size-x
  - touchscreen-size-y
  - touchscreen-swapped-x-y
+ - links-add		: List of suppliers handles, suppliers will be
+			  suspended after goodix device and resume before it.
 
 The touchscreen-* properties are documented in touchscreen.txt in this
 directory.
-- 
2.15.0

