Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8EBC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906B220644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Q1ftzGys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfDYOLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:11:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfDYOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:11:49 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PDuwv1030065;
        Thu, 25 Apr 2019 16:11:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=tAwrT9TCGh3VrIjt0sfUMRAdMzZhO68z/jF8P5ayLxM=;
 b=Q1ftzGysZFDwi4WfEGtdjRhcIo/whFfUwBmmFPJbE8eumsYPqVWKItUjBpi82C6qsOCv
 d9kXTP2+b/3N/fS3gczcMWksZNHIJISLlCdKFey9S0z4Pcp8sxUcxjbqd+wspnP4NbU6
 myn7mvqTaKK86r6avmBfjuUlXmSbGi1dYMpn0ZfCTcB9gpuv4LIg1UEmyvCBEwLmZ8rX
 5Lha86E3fudxZo1Ro0FEK1igL3pGegDSkqW3bAgsZi6pilSNjLUn7a/1j8Bm13yvbq3l
 kdxqSyn3+8mDoQVtymSYhQffixxwQlt0YCS/kcEC8QIiQaKZs//ZglTYg5uhg66L7oBB hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ryrj6dqfq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 16:11:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4BE1E4D;
        Thu, 25 Apr 2019 14:10:44 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1ED5427E6;
        Thu, 25 Apr 2019 14:10:44 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr
 2019 16:10:44 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 16:10:43
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [Linux-stm32][PATCH 0/4] ARM: dts: stm32: add i2s and sai support on stm32mp157c
Date:   Thu, 25 Apr 2019 16:10:36 +0200
Message-ID: <1556201440-5540-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support of STM32 SAI and I2S on stm32mp157c

Olivier Moysan (4):
  ARM: dts: stm32: add sai support on stm32mp157c
  ARM: dts: stm32: add sai pins muxing on stm32mp157
  ARM: dts: stm32: add i2s support on stm32mp157c
  ARM: dts: stm32: add i2s pins muxing on stm32mp157

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  92 +++++++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 158 ++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)

-- 
2.7.4

