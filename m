Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A930C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB78D206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="W+ZH91T5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEFMzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:55:15 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59199 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfEFMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:55:14 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46CkfHF028690;
        Mon, 6 May 2019 14:54:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Bf6BzLVHhrobFAhDVUpC7IRGuKGCU+Zv3v7QzNgJX+k=;
 b=W+ZH91T5+ZGLRYnRD4nkR6mwLJwoXbL04P8RegkOVeLaIEksSqhvT2TWZYDvJ61WucbC
 tctaEe9QZRej1RWsIo/G41WfaNWImrm0M0MPIGhQJlLGz7l8Znpn6osUwofkK14W6Yb4
 e12z6hMarMWTiVxgUmNlVXf29dqzs3kEmrK/+luKXRrGDi/d0cjUZY9we1s5L8IjV7R7
 xwblMQ9lpU/lFsEv5XOl2e5DyM63kzx6hmYhXApxc+PR6iEwnPfEDtMNjE6yytKZvlPU
 0x3SwjZPrNg7pR0DQNsFcPRNBNTy/1elMSwXg/vIY08sLXGcAd98az+7uibUhYrVFbUX gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s94bvhbp1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 06 May 2019 14:54:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5B7A31;
        Mon,  6 May 2019 12:54:24 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 805B425B8;
        Mon,  6 May 2019 12:54:24 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 6 May 2019
 14:54:24 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 6 May 2019 14:54:23
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
CC:     <benjamin.gaignard@st.com>
Subject: [PATCH 0/2] ASoC: stm32: i2s: add some features
Date:   Mon, 6 May 2019 14:54:10 +0200
Message-ID: <1557147252-18679-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update and add some features in STM32 I2S driver.
- update pcm hardware constraints
- add management of identification registers

Olivier Moysan (2):
  ASoC: stm32: i2s: update pcm hardware constraints
  ASoC: stm32: i2s: manage identification registers

 sound/soc/stm/stm32_i2s.c | 63 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

-- 
2.7.4

