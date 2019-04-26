Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A28C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61D9206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uHDrqvgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfDZHrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:47:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46466 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbfDZHrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:47:04 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q7fqWA006575;
        Fri, 26 Apr 2019 09:46:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=qG1VfsI3fxdSj6pt9TWh5gXyJBxhTVY7G8wRmG7VLxI=;
 b=uHDrqvgR2tJiKspUjumvUdrt86Bh1P5O5Nj51TrrlE0VwP+yytnz87AoKyg4kmVZ1mZL
 SdEfGTHO+tTLSiHSIXtXSfBpzZ+NXSCAbdUE7yZqO8UeisOLXMcDDQG2OyFkLgAjWSiP
 7aTHewjXlcnJKVNnvQO1rEFnXoDvxrVZTPRS7GJZUaz9CelGDwonGnoSgWvLa7Q6Pfll
 jeJ16f+ubsD5ZnZLB7lOi7HQ7wcgKgRaCer0kWJqpq+lK7I+4VLIhTofJAqbQJJvLwx9
 8FluNObS9p0Niu1NOXFQOenHE47ogg78Q+LBg8yI9jgeg59vkfLMkciMa+PEwQNW9fgR QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytadjmmw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Apr 2019 09:46:49 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3A163D;
        Fri, 26 Apr 2019 07:46:47 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE7CE130F;
        Fri, 26 Apr 2019 07:46:47 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 26 Apr
 2019 09:46:47 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 26 Apr
 2019 09:46:47 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 0/5] mmc: mmci: add busy detect for stm32 sdmmc variant
Date:   Fri, 26 Apr 2019 09:46:33 +0200
Message-ID: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds busy detect for stm32 sdmmc variant.
Some adaptations are required:
-Avoid to check and poll busy status when is not expected.
-Clear busy status bit if busy_detect_flag and busy_detect_mask are
 different.
-Add hardware busy timeout with MMCIDATATIMER register.

V2:
-mmci_cmd_irq cleanup in separate patch.
-simplify the busy_detect_flag exclude
-replace sdmmc specific comment in
"mmc: mmci: avoid fake busy polling in mmci_irq"
to focus on common behavior

Ludovic Barre (5):
  mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
  mmc: mmci: avoid fake busy polling in mmci_irq
  mmc: mmci: fix clear of busy detect status
  mmc: mmci: add hardware busy timeout feature
  mmc: mmci: add busy detect for stm32 sdmmc variant

 drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/mmci.h |  3 +++
 2 files changed, 51 insertions(+), 13 deletions(-)

-- 
2.7.4

