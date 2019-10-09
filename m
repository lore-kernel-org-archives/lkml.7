Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63327ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9DF218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ci1oD7hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfJIONJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:13:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57253 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727769AbfJIONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:13:08 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x99EBPcN006631;
        Wed, 9 Oct 2019 16:12:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=OB/Kw3Xu+9/OMKoLR8YLudGPfymGdZ3on5onGlH4suA=;
 b=Ci1oD7hg9ivEp3gFRKu+kueOUBRk7BoYYImtpFFbFuLFvf+XWnyyEdQAUuDPF01n62fQ
 B4yLE0cv+fYP1jxkNCylwPLNLbCQYmsjVIB6b+WtG8OEDdIRQcKQhOjv7XKb+G6YUW1+
 +QPG9Zng7ccsjGcQ6Q/kdROCLawG8JxOjahLScfiIQ9CHxMz80oTjJwA9IfYs7jnxtJ0
 lAXc4wZr5IYtCOKNmdCeFAnGCREn4qImagsNAiMg+4UyXpx3kBJEpgS3TVE3PJ/MkC3c
 Aj9vKDJCez/OpBywgkxMHgKX8WnO+Gena6loTC0GBfCKc2n0GWjmvLBQ4O3SnXNaUKl/ zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxvxcx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 16:12:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9518A100038;
        Wed,  9 Oct 2019 16:12:56 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7FB3E21E6AF;
        Wed,  9 Oct 2019 16:12:56 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019
 16:12:56 +0200
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019 16:12:55 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 0/2] Add support for DAC on stm32mp157c-ed1
Date:   Wed, 9 Oct 2019 16:12:50 +0200
Message-ID: <1570630372-24579-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_06:2019-10-08,2019-10-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for digital-to-analog converter on
stm32mp157c-ed1 board:
- define pins that can be used for DAC
- configure DAC channels to use these

Fabrice Gasnier (2):
  ARM: dts: stm32: Add DAC pins used on stm32mp157c-ed1
  ARM: dts: stm32: Add DAC support to stm32mp157c-ed1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     | 13 +++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.7.4

