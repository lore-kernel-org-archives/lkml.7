Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0542080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="u3n2tZjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfFRKDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:03:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53102 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729120AbfFRKDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:03:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5I9utiI016658;
        Tue, 18 Jun 2019 12:02:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=MfAHlgSdxpurzh3a1xtW23vEPvxHZgpi0SmFk2u5Ijk=;
 b=u3n2tZjQplZWnblLBre5vzHMDdGgJ2eJuZU/7L/a97xCBbZeoK8F53nKy+rI0MQsGNjF
 JhVClAbzQezkSyKrEyj1ckRug956mgjuZX29a8LtqYkdWNmZ16FVGcpy6I+V7DkdDcKU
 RpVgcnHWNBwcr6CQkIaFl8GNJpfbv3qa0UTbDo2E0Qn/66w629C6QaPJq9XY3PwVr7lo
 X+JTqxe1f+/0g3HPxUUQJjzm9YzM2TXKCQrmIjh4UeXn38D9tpH+M/rF9Fqn3EyGzwLg
 hB7IfV/94mUexzdokIm12TwebK2q0e8yVQPOoZf9FLyG5UOF8jLD28hN7CSx++84idxh nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4qjhyq1n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 12:02:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2120742;
        Tue, 18 Jun 2019 10:02:33 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E497625DD;
        Tue, 18 Jun 2019 10:02:32 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 12:02:33 +0200
Received: from localhost (10.201.23.31) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun 2019 12:02:30
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Erwan Le Ray" <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/5] STM32 usart FIFO handling
Date:   Tue, 18 Jun 2019 12:02:21 +0200
Message-ID: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series delivers RX and TX FIFO features to improve system 
performances during data transfer.

Erwan Le Ray (5):
  serial: stm32: add support of timeout interrupt for RX
  serial: stm32: update PIO transmission
  serial: stm32: add support of TX FIFO threshold
  serial: stm32: add support of RX FIFO threshold
  serial: stm32: add RX and TX FIFO flush

 drivers/tty/serial/stm32-usart.c | 132 +++++++++++++++++++++++++++++++--------
 drivers/tty/serial/stm32-usart.h |  19 ++++++
 2 files changed, 124 insertions(+), 27 deletions(-)

-- 
1.9.1

