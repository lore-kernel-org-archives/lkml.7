Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DCAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB2B21848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kgo2lgzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfHZPjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53067 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732222AbfHZPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:39:33 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QFPrAb018373;
        Mon, 26 Aug 2019 17:39:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=G1q9jXeOe+jObYadbTKDBN2nCaQ4doShrwDMtgHwCfo=;
 b=kgo2lgzxQKE25bsuS4y4FQwg+AF0ctGg/uEnPyfmNh9pUqZkRZcv3f7fE1QoBOG1jX+v
 93oONfwSE0K5hgnpW8ChGifG4bSX8cQ1b9GYhb6Fl56rViAmXT0ZRknFPxKsQAkB4Cmr
 xpsRK2P0Ugi3JSEa0CRWsBo1gBFZSk+R/EPaN7vkM8xrFOC2x7EW/KohqnHsZj09luyo
 mkpE4NGpaxspIAz4l24bRJGyqtkkhkD8yE3qcvbg6fnrrL795TQBX/Yni/hjI2XCKfGv
 6CUrvrlLZ9MDi3XXWyi1F6SyUOsnK33gWyJ3kdorzPCyfJx/yVg1SUhyjHlVgd86Erxi 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uju0vmgkd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Aug 2019 17:39:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5FA49235;
        Mon, 26 Aug 2019 15:39:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2CD062BC1CE;
        Mon, 26 Aug 2019 17:38:52 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 17:38:52 +0200
Received: from localhost (10.201.23.25) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 17:38:51
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 1/2] dt-bindings: remoteproc: stm32: add wakeup-source
Date:   Mon, 26 Aug 2019 17:38:42 +0200
Message-ID: <1566833923-16718-2-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566833923-16718-1-git-send-email-fabien.dessenne@st.com>
References: <1566833923-16718-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "wakeup-source" property: if the optional wdg interrupt is
defined, then this property may be defined too.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
index 5fa915a..ac54b5b 100644
--- a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
+++ b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
@@ -21,6 +21,9 @@ Required properties:
 
 Optional properties:
 - interrupts:	Should contain the watchdog interrupt
+- wakeup-source: Flag indicating whether remoteproc can wake up the system by
+		the watchdog interrupt. Only meaningful if the "interrupts"
+		property is defined.
 - mboxes:	This property is required only if the rpmsg/virtio functionality
 		is used. List of phandle and mailbox channel specifiers:
 		- a channel (a) used to communicate through virtqueues with the
-- 
2.7.4

