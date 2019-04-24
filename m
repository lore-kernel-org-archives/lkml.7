Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA9FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B5218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="o0PYQWKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfDXMwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:52:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11130 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729107AbfDXMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:51:59 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OCh4jq001674;
        Wed, 24 Apr 2019 14:51:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=0SZQM29k1vMzi11gHJmCKSfq1WMVmK6sOWEplpQiDnI=;
 b=o0PYQWKTnMFtyi1R4y087BiSsI/B3FWRIZxE7icyKDzrNnxeVzVV1Ly1HrZwSAtMxhLU
 /Z87mDhcYakKaYYc4UoY7TCkXCv67TCdKDq1DJndBi/BH2KrDsHuKElmeE6xARgPwAil
 PNluP4p8Dkf1B5FmVF1MIE2aTYi6KkedpvlLBb0PLZdPcbuyBGxC1TYj8o8uRFbKXVRr
 lxLnB9xNSOB1lLN/lRAxoKY2rCJmt6Q5JMux7ufLs3NrkKLWbu4mr7vIE9eiLPKlVSXc
 LFUhOmB7hQLHL7mcdhOASkeBye0SxeDKTucVF2UYYSXWvOcqupZ3RqvayOhI6ZBVvG70 KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ryrj670dn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 14:51:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 729973A;
        Wed, 24 Apr 2019 12:51:34 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4BE7C25CB;
        Wed, 24 Apr 2019 12:51:34 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 14:51:34 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 14:51:33
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH 0/2] iio: adc: stm32-dfsdm: manage error cases in probe
Date:   Wed, 24 Apr 2019 14:51:24 +0200
Message-ID: <1556110286-1526-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds some check of the returned error code in probe.

Fabien Dessenne (2):
  iio: adc: stm32-dfsdm: manage the get_irq error case
  iio: adc: stm32-dfsdm: missing error case during probe

 drivers/iio/adc/stm32-dfsdm-adc.c  | 6 ++++++
 drivers/iio/adc/stm32-dfsdm-core.c | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.7.4

