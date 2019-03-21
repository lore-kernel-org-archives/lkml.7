Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B07218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfCUPrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:47:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62625 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbfCUPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:47:35 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LFkZXb005173;
        Thu, 21 Mar 2019 16:47:26 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r8qg4xapq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Mar 2019 16:47:26 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D889B56;
        Thu, 21 Mar 2019 15:47:25 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BBFD15471;
        Thu, 21 Mar 2019 15:47:25 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Thu, 21 Mar
 2019 16:47:25 +0100
Received: from localhost (10.129.4.239) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Mar 2019 16:47:25
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 0/2] TTY: add rpmsg tty driver
Date:   Thu, 21 Mar 2019 16:47:17 +0100
Message-ID: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.239]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces a TTY console on top of the RPMsg framework
which enables the following use cases:
- Provide a console to communicate easily with the remote processor
  application.
- Provide an interface to get the remote processor log traces without
  ring buffer limitation.
- Ease the migration from MPU + MCU processors to multi core processors
  (MPU and MCU integrated in one processor)

An alternative of this proposed solution would consist in using the virtio
console : the drawback with that solution is that it requires a specific
virtio buffer (in addition to the one already used for RPMsg) which does
not fit with remote processors with little memory.
The proposed solution allows to multiplex the console with the other rpmsg
services, optimizing the memory.

The first patch adds an API to the rpmsg framework ('get buffer size') and
the second one is the rpmsg tty driver itself.

Fabien Dessenne (2):
  rpmsg: core: add possibility to get message payload length
  tty: add rpmsg driver

 drivers/rpmsg/rpmsg_core.c       |  20 +++
 drivers/rpmsg/rpmsg_internal.h   |   2 +
 drivers/rpmsg/virtio_rpmsg_bus.c |  11 ++
 drivers/tty/Kconfig              |   9 ++
 drivers/tty/Makefile             |   1 +
 drivers/tty/rpmsg_tty.c          | 309 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg.h            |  10 ++
 7 files changed, 362 insertions(+)
 create mode 100644 drivers/tty/rpmsg_tty.c

-- 
2.7.4

