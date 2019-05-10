Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D5C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F932177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HTxwKAv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfEJPDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:03:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39152 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727346AbfEJPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:03:44 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AF1SGw024827;
        Fri, 10 May 2019 17:03:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=lKyNfPMxjeNEOTVeoxdaJaRQWuSGzvXAvpttJx+3BqI=;
 b=HTxwKAv4ORkCmeJ8x744pOg4vmUsTyoACZLbIgTRRUc7FzQJHUSPs60riHvLjRNHtGyp
 vs/ubWMTnxeEg72laGrlehF8r/D0BZoWqfXz7Cn6bAzxCYdJlSHuVbK2277dZhWyry6z
 KjnQB8TmYjDtLgD5nUT3yfC5g/6b+Q/PRrTw2F3wTjzyXyAnevFJeMAP3Dqqf9h+cb7D
 rXj9Y4vWHsLFOjD6gZZZNfLUpDL+2d0qGVTE+DDUmnn8y43i6Gu7UlFtOgyghHkVKcSo
 wrvTkyvwu2cp0kgIQAjPdmgw6ZfFPlGkO/C9ZI7kP/O0txxUkMjdpvb5L++XxBiBcZod pA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2scdjp9rnq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 17:03:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 401CE34;
        Fri, 10 May 2019 15:03:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 191F92ABA;
        Fri, 10 May 2019 15:03:07 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May
 2019 17:03:06 +0200
Received: from localhost (10.48.0.131) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May 2019 17:03:06 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     <arnaud.pouliquen@st.com>, Fabien DESSENNE <fabien.dessenne@st.com>
Subject: [PATCH v2 0/2] TTY: add rpmsg tty driver
Date:   Fri, 10 May 2019 17:02:55 +0200
Message-ID: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces a TTY console on top of the RPMsg framework which
enables the following use cases:
- Provide a console to communicate easily with the remote processor
  application.
- Provide an interface to get the remote processor log traces without
  ring buffer limitation.
- Ease the migration from MPU + MCU processors to multi core processors
  (MPU and MCU integrated in one processor)

An alternative of this proposed solution would consist in using the virtio
console:
The drawback with that solution is that it requires a specific virtio buffer
(in addition to the one already used for RPMsg) which does not fit with remote
processors with little memory. The proposed solution allows to multiplex the
console with the other rpmsg services, optimizing the memory.

The first patch adds an API to the rpmsg framework ('get buffer size') and the
second one is the rpmsg tty driver itself.

History:
-V1 to V2:
	- modify message structure to allow to data transmission but also
	flow control
	- add documentation file to describe message structure for remote
	  implementation. 
	- add dtr/rts management
	- disable termios modes that generates non optimized behavior on RPMsg
	  transfers
	- replace rpmsg_send by rpmsg_trysend to not block the write
	- suppress useless spinlock on read.
	- miscellaneous fixes to improve robustness

Arnaud Pouliquen (2):
  rpmsg: core: add possibility to get message payload length
  tty: add rpmsg driver

 Documentation/serial/tty_rpmsg.txt |  38 +++
 drivers/rpmsg/rpmsg_core.c         |  20 ++
 drivers/rpmsg/rpmsg_internal.h     |   2 +
 drivers/rpmsg/virtio_rpmsg_bus.c   |  11 +
 drivers/tty/Kconfig                |   9 +
 drivers/tty/Makefile               |   1 +
 drivers/tty/rpmsg_tty.c            | 479 +++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg.h              |  10 +
 8 files changed, 570 insertions(+)
 create mode 100644 Documentation/serial/tty_rpmsg.txt
 create mode 100644 drivers/tty/rpmsg_tty.c

-- 
2.7.4

