Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38226C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80E8222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vv9eVlJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfHGJl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:41:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21804 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbfHGJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:41:29 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x779aCO3014067;
        Wed, 7 Aug 2019 11:41:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=qS4DePYK3LoLrsVbTANrZZhVUCfmfeWUeshitfyIKXA=;
 b=vv9eVlJPjRfxmVNy8iRX8uPgnISgaeWsF/X9Z32xZR76QKpVWNmqakos3us0BkLqHCHR
 Wor3M9x/CEXUBz2yL390fM+/5CKmkmVFtugLUBb6U+atR+r2ROmc4TLfFw8Z20byZEKP
 V/M/ZvEHeywnQ7l9BcgAEWxcxeRIliTNwkmiqCTI1bPo6Tw0FM7E5fOelouUCabauDtr
 EfKZE+tu2OOvdVmSKZEFUQ6HmM8WT9JxW/eciwkMurqvuxTQP54BMNCe1qSKn9T4IU24
 6XkGeXh39QNhq+IxkKwb8GCoIH3FmG9iCeapvLtY+zsoVz1Po0cmPHogiTBqFwAkgAVZ Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u4yr264d4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 07 Aug 2019 11:41:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 217DF31;
        Wed,  7 Aug 2019 09:41:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 11CE12D9041;
        Wed,  7 Aug 2019 11:41:23 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 7 Aug 2019
 11:41:22 +0200
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 7 Aug 2019 11:41:22
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>, <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [RESEND 0/2] remoteproc: add support for preloaded firmware
Date:   Wed, 7 Aug 2019 11:41:17 +0200
Message-ID: <1565170879-3185-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces a new flag in remoteproc core to add
support of remote processor having their firmware loading by another
way than standard remoteproc core sequence.

Firmware could be ROMed, loaded by security or bootloader before kernel
boot or loaded by a special rproc platform driver interface.

When "preloaded" flag is set by rproc platform driver, remoteproc core
doesn't request firmware and execute rproc_start sequence as usual allocating
associated rproc resources.
It is rproc platform driver responsibility to implement the right firmware
load operations according to HW specificities like resource table location
or firmware definition if needed.

Regards,
Loic

Loic Pallardy (2):
  remoteproc: replace bool from struct rproc by u8
  remoteproc: add support for co-processor booted before kernel

 drivers/remoteproc/remoteproc_core.c | 37 +++++++++++++++++++++++++++---------
 include/linux/remoteproc.h           | 14 ++++++++------
 2 files changed, 36 insertions(+), 15 deletions(-)

-- 
2.7.4

