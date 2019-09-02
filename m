Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B1DC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22647217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ndt+7K7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfIBQBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:01:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58873 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbfIBQBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:01:37 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82FuY5k013492;
        Mon, 2 Sep 2019 18:01:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=A1tIJTckSXBg8Z/io9D6CqOqXnYC7QIubFt7XKXGFpU=;
 b=ndt+7K7jTG/ChIkddPX8Q7P6b7hUs+rbtGqCjelcGPTvcbD3hI/mh2ZYAoXZV9z/r/zB
 IZFIPahF39sWNUBsuvNWrpT00MAroTJIl+vUrIJ449b/pTS2cTf3Jh+kcJ4AHSyaXmqQ
 RDcWVyqbtTBayLCLJoyLP1TheqHy+QCmCssnFPsYvKwNBhQrB5v+yKXiL0znrMwomioC
 wseCkKAkrbtuLHlfZAPQ0USz7BKrZu3bwH6DAgjfGfrjO3GotvU+hT65GOyTH4nhlLbw
 8BV/uYRqQe5eM0KaOZWnCgVy3Hy71kUP6pdNUVs5C5IgIyIW7XpwibQpTNJn9NocSqFF hw== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uqenuwenv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 02 Sep 2019 18:01:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 29F2A4D;
        Mon,  2 Sep 2019 16:01:00 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C7232B6BC5;
        Mon,  2 Sep 2019 18:01:00 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 2 Sep 2019
 18:01:00 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 2 Sep 2019 18:00:59
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <alexandre.torgue@st.com>, <olof@lixom.net>,
        <horms+renesas@verge.net.au>, <arnd@arndb.de>, <krzk@kernel.org>,
        <yannick.fertre@st.com>, <tony@atomide.com>,
        <m.szyprowski@samsung.com>, <fabrice.gasnier@st.com>,
        <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <olivier.moysan@st.com>
Subject: [PATCH 0/4] ARM: multi_v7_defconfig: add audio support for stm32mp157a-dk1
Date:   Mon, 2 Sep 2019 18:00:37 +0200
Message-ID: <1567440041-19220-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_06:2019-08-29,2019-09-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds audio support for stm32mp157a-dk1 board.

Olivier Moysan (4):
  ARM: multi_v7_defconfig: enable stm32 sai support
  ARM: multi_v7_defconfig: enable stm32 i2s support
  ARM: multi_v7_defconfig: enable cs42l51 codec support
  ARM: multi_v7_defconfig: enable audio graph card support

 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.7.4

