Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2720C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7587D2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VqBYZ77C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfFSMb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:31:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58168 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731971AbfFSMbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:31:25 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCQrS2023568;
        Wed, 19 Jun 2019 14:30:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=bzhhQbF+EghlPd0ppy5gsSz3pP65YLphRbT0+QfA15k=;
 b=VqBYZ77Cuz/Ki3iKSGawYaytDDaO/OLyizLN2pm7hwZS+ecG4P8biTqLdECamOFZY4fG
 yNUtBtg6XQslQc5Ir8PhdEn8GNSBE2bBKmx3zH068DlglMly4MymNPlzE2/EgdyN6L1e
 DEyrbUxPP/NxASpVULEkwBs7rQoALTxquKFh37p1hoJtfnyNaEOMed/Gu6h6FX1fVqSE
 hpIDzIs0JcL1p+8PpE5htH2kerz+1ICma+XlW2wAcy8flLvduJFduwUgfnYaTPRTIrF8
 ARdbjiym5r85VoJIT+ivwFPmhbHBBekmJRZHzCXDPbqcdcy+OACMv0jKCBcNYO+f6EYm 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t7812uxwm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 14:30:53 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D2A43D;
        Wed, 19 Jun 2019 12:30:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44B7727A6;
        Wed, 19 Jun 2019 12:30:52 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 14:30:51
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] dt-bindings: iio: adc: stm32: add missing vdda supply
Date:   Wed, 19 Jun 2019 14:29:54 +0200
Message-ID: <1560947398-11592-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
References: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing vdda-supply, analog power supply, to STM32 ADC. It's required
to properly supply the ADC.

Fixes: 841fcea454fe ("Documentation: dt-bindings: Document STM32 ADC DT
bindings")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 8346bcb..93a0bd2 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -38,6 +38,7 @@ Required properties:
     It's required on stm32h7.
 - clock-names: Must be "adc" and/or "bus" depending on part used.
 - interrupt-controller: Identifies the controller node as interrupt-parent
+- vdda-supply: Phandle to the vdda input analog voltage.
 - vref-supply: Phandle to the vref input analog reference voltage.
 - #interrupt-cells = <1>;
 - #address-cells = <1>;
-- 
2.7.4

