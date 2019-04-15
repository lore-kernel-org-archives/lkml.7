Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86767C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5278A2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jlq8+yG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfDONCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:02:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10956 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727117AbfDONCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:02:01 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FCupcD002488;
        Mon, 15 Apr 2019 15:01:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=CA1N0/vdEorrtLK+Jp/G23Dniz8WZDujNf8HqD3viFM=;
 b=jlq8+yG5v5LDQ8EvkywmBOq36ehuFPlVqwYmP0ILBTwaLOrMf8S1ayCSVv1mrbpFWWP0
 z5IPFkxjWbjSPHjonVqr3BOkB6KD69Ta9mYQGsPLHZsXJOoevlLlNFSghvDHXYbGOG21
 FzI1T6XZts8sUn/aA84yvGOsljg05tQ+ZBGJnY7LQFYHx5kye9TrtH/8J8uzzpMRrgPa
 sCK0IC5a5xnDkw3HXJWPv9NdaoJ1RscZ9AGDQ8jbF4hN1WmMd4UYtHXgVwtlsnBHbBqh
 FHm13kqhPpmcj2Gzw21pFSQcongIGVdRc18in9dyvxYkTXt5OnD/73mieJwz3yJyxYCL pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ru5hu29d6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Apr 2019 15:01:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4AC334;
        Mon, 15 Apr 2019 13:01:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD8B92510;
        Mon, 15 Apr 2019 13:01:07 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Apr 2019 15:01:07
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <rdunlap@infradead.org>
CC:     <sfr@canb.auug.org.au>, <benjamin.gaignard@linaro.org>,
        <linux-next@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH 0/2] iio: adc: stm32-dfsdm: fix build dependencies
Date:   Mon, 15 Apr 2019 15:00:49 +0200
Message-ID: <1555333251-4422-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes two build dependencies:
- IIO_BUFFER needs to be selected along with IIO_BUFFER_HW_CONSUMER
- IIO_TRIGGERED_BUFFER needs to be selected now that it supports triggered
  buffer mode.

Fabrice Gasnier (2):
  iio: adc: stm32-dfsdm: fix unmet direct dependencies detected
  iio: adc: stm32-dfsdm: fix triggered buffer build dependency

 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.7.4

