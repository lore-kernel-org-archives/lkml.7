Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18285C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91E1218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Z95wrK0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfDXODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:03:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56529 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbfDXODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:03:51 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ODxVdt018916;
        Wed, 24 Apr 2019 16:03:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=fmAR1ImXozQOeR0JRbY4/5g2t4+nsxQAX1fCujVqWVc=;
 b=Z95wrK0cueUM9Xzi2uqZ04jKWxnJ5yXBtNuCc3HItjFEGaCFcat3sBs96PhPp3W/N3Bw
 L/Ov4s0yycMxuN9L1spWpClLynGCe/+/PWeTT/qirGKYKahf2rbSsyJANZhpoGr+d1Ip
 eJX4kn6UzJKftb4oRiXM0l7JIzW21b/x64Fydh7Su35pRUDT5tOmq9bFBUXpggc70DpQ
 CjVf1OZj8Jz3BTFn+u+EPijbLd7/ecDK3fscqc33BXZxeJLj0gaZi3TVtIFM81l+tCQw
 P6pSRVUb/Fhuct9dMm+IK9R4NHnXvh5XAYYRq6FHveqi3gYnDkku2V5tRnnCKtOUZ9vT Ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6rwu3w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 16:03:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71ED131;
        Wed, 24 Apr 2019 14:03:28 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D4BE2726;
        Wed, 24 Apr 2019 14:03:28 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 16:03:28 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 16:03:27
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH 0/2] drm/stm: ltdc: manage error cases in probe
Date:   Wed, 24 Apr 2019 16:03:19 +0200
Message-ID: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds some check of the returned error code in probe.

Fabien Dessenne (2):
  drm/stm: ltdc: manage the get_irq probe defer case
  drm/stm: ltdc: return appropriate error code during probe

 drivers/gpu/drm/stm/ltdc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.7.4

