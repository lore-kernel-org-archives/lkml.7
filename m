Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF95C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2496218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="J8eWF0Ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfDYJR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:17:56 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37955 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728151AbfDYJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:17:54 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P91RM4023615;
        Thu, 25 Apr 2019 11:17:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=gWt2Yvp7kFHU0NSj4PHJldddgEcgVYkKXyg6dUFoJn4=;
 b=J8eWF0Ji/OwAmYuP8G/kYjsx24gzjc97wcoqB8kn9lA0hbEWKzWy2pyaJfn3YaNkqiCH
 FkN7Pk7vQMipZK6vwC7g0FLnuPi886oYr4cg27z1sQrtZEfI46ZlFYHl+pBO59HJTaHp
 Usg2oFkIAj5TejEdGI7SAVw+6k6rBN4/nK19YKh4VDxFNok03WKA9PSX821OoXj3XH2q
 SzSI9ELp0EWXsgCMXVXJGIuntrXrxe7CHRsOdhpEWntyvAG0qewlWpeMyqv44t96d5Jn
 we/lto9q6Y3AJmITll34vxmIKCFEAxMrzerg8zIQ2xubfvuqKl60h5+KkDnxNXD/qjzf wQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6s2m2h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 11:17:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE53731;
        Thu, 25 Apr 2019 09:17:33 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 91F4C1615;
        Thu, 25 Apr 2019 09:17:33 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 25 Apr
 2019 11:17:33 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 11:17:32
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 3/6] dt-bindings: hwlock: update STM32 #hwlock-cells value
Date:   Thu, 25 Apr 2019 11:17:20 +0200
Message-ID: <1556183843-28033-4-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
References: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a value of 2, so users can share hwlocks.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
index adf4f000..60a3716 100644
--- a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
+++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
@@ -4,8 +4,8 @@ STM32 Hardware Spinlock Device Binding
 Required properties :
 - compatible : should be "st,stm32-hwspinlock".
 - reg : the register address of hwspinlock.
-- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
-	hwlock, so the number of cells should be <1> here.
+- #hwlock-cells : should be <2> so the hwlock users use the hwlock id to
+	represent a specific hwlock and define its shared / exclusive attribute.
 - clock-names : Must contain "hsem".
 - clocks : Must contain a phandle entry for the clock in clock-names, see the
 	common clock bindings.
@@ -16,7 +16,7 @@ Please look at the generic hwlock binding for usage information for consumers,
 Example of hwlock provider:
 	hwspinlock@4c000000 {
 		compatible = "st,stm32-hwspinlock";
-		#hwlock-cells = <1>;
+		#hwlock-cells = <2>;
 		reg = <0x4c000000 0x400>;
 		clocks = <&rcc HSEM>;
 		clock-names = "hsem";
-- 
2.7.4

