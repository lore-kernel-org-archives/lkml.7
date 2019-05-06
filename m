Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279B8C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F1A20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="eH544rpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEFMoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:44:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14196 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbfEFMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:44:36 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46CaCNt024824;
        Mon, 6 May 2019 14:44:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=HcUcOaTSxNRSHfChXOh8afB0SuVIe92QW4amRAQNihQ=;
 b=eH544rpHGPR9xBm7uk7Y71brxiGS03XZC82Xzr0sDpVNMbckNm9W1fb3J+w0yqNfxVDo
 m8UoN3ybLtOnyVJLZotVpPzRt/EZlI2JX8I3jp5RJ2ghtggMrbgU2vlKAGn/kV8BW0Jc
 jzVgYkzBSwl9AvnLby0Y35tn0N0RIqsSAEBH3cR99C5lg/3xjYAG/kACAQmE9W+006uf
 wRxrkzlz42TAlJCCSdaWr4AhIod6bNMEL9Zf2QubC4JBnFAiPzltp5bEkkOv2CsR7aMU
 ivlmA74IfYDVqpw4b6mhSj81KSg3MtwkLkJZfhBj855OGSRjm7OOBfUEjO4ReFDW/Nel Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s94cd9a95-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 06 May 2019 14:44:12 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 000A938;
        Mon,  6 May 2019 12:44:10 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B431A2583;
        Mon,  6 May 2019 12:44:10 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 6 May 2019
 14:44:10 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 6 May 2019 14:44:10
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
Subject: [PATCH 0/3] ASoC: stm32: spdifrx: add some features
Date:   Mon, 6 May 2019 14:44:03 +0200
Message-ID: <1557146646-18150-1-git-send-email-olivier.moysan@st.com>
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

Update and add some features in STM32 SPDIFRX driver.
- pdate pcm hardware constraints
- change trace level on iec control
- add management of identification registers

Olivier Moysan (3):
  ASoC: stm32: spdifrx: update pcm hardware constraints
  ASoC: stm32: spdifrx: change trace level on iec control
  ASoC: stm32: spdifrx: manage identification registers

 sound/soc/stm/stm32_spdifrx.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

-- 
2.7.4

