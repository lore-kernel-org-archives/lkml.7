Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F59120652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCGP6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:58:43 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56214 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbfCGP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:58:42 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27FkQwR025817;
        Thu, 7 Mar 2019 16:58:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r315usxv2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 16:58:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BBB1331;
        Thu,  7 Mar 2019 15:58:36 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A0860531C;
        Thu,  7 Mar 2019 15:58:36 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 16:58:36 +0100
Received: from localhost (10.129.4.33) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019 16:58:36 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-remoteproc@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 0/2] hwspinlock: add the 'in_atomic' API
Date:   Thu, 7 Mar 2019 16:58:21 +0100
Message-ID: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.33]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In its current implementation, the hwspinlock framework relies on jiffies
to handle the timeout of the hwspin_lock_timeout_xxx() API.
In an atomic context (or more precisely when irq are disabled) jiffies does not
increase, which prevents the timeout to reach its target value (infinite loop).

Note that there is already an hwspinlock user that runs in atomic context
(drivers/irqchip/irq-stm32-exti.c) and that has to handle by itself the
timeout.

The first patch of the series completes the Documentation (the 'raw' API
is not documented), and the second patch provides with the 'in_atomic' API.

Fabien Dessenne (2):
  hwspinlock: document the hwspinlock 'raw' API
  hwspinlock: add the 'in_atomic' API

 Documentation/hwspinlock.txt         | 81 ++++++++++++++++++++++++++++++++++++
 drivers/hwspinlock/hwspinlock_core.c | 43 +++++++++++++------
 include/linux/hwspinlock.h           | 61 +++++++++++++++++++++++++--
 3 files changed, 169 insertions(+), 16 deletions(-)

-- 
2.7.4

