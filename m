Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B7DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6BD20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="U1MGQ6b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfEWQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:04:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27264 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730790AbfEWQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:04:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NG0sFA026679;
        Thu, 23 May 2019 18:03:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=CshXfxU4/xd79yLbQPMejneBfTfn/les3xcKItJgDCk=;
 b=U1MGQ6b0L0k9tiX8Bw01OqR6XxNf1xAn77QuCY7Zg2Ijp42sHMPAuPkgUT7XhNbcYT5+
 W5fpCfQ+/aEzKmU2Ypm7/UuNzvkzPF956NxWkO8E5EPHkceCb83jKGpRrMkR67vDVNne
 tJt5hg4fJUbhF4AFC41fSQRDTO874gqQLTdwp6qGRHxrTEM1RA7LSrD60yDBd7gI8XpM
 o3hBuz3oFWRjKBmfCSpcINdNZCKAVopZR/f99iN3b+10yNdPn1uUxeEJ49TtvoFXR8Z1
 XJIWk0BjKvxee+oHhmRsbETFimsagGvZ7OL64mybYprwV5F0Yl/GYWbSLL0CduVT9og8 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2snrve2898-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 23 May 2019 18:03:56 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A62938;
        Thu, 23 May 2019 16:03:55 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF1DE4E9A;
        Thu, 23 May 2019 16:03:54 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 23 May
 2019 18:03:54 +0200
Received: from localhost (10.48.0.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 23 May 2019 18:03:54 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <arnaud.pouliquen@st.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH v4 0/2] TTY: add rpmsg tty driver
Date:   Thu, 23 May 2019 18:03:19 +0200
Message-ID: <1558627401-1090-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_13:,,
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
-V3 to V4: 
	- update documentation in rst format
	- use tty_insert_flip_string_fixed_flag helper
	- suppress some poinrter check (overprotection)
	- move low_latency set from probe to activate ops. 
	- various corrections and improvements relative to Jiri's comments 

-V2 to V3:
	- suppress error return on rpmsg callback as not tested in rpmsg framework
	- change some flow messages level to debug
	- add missing out of memory checks

-V1 to V2:
	- modify message structure to allow to data transmission but also
	flow control
	- add documentation file to describe message structure for remote
	  implementation
	- add dtr/rts management
	- disable termios modes that generates non optimized behavior on RPMsg
	  transfers
	- replace rpmsg_send by rpmsg_trysend to not block the write
	- suppress useless spinlock on read
	- miscellaneous fixes to improve robustness

Arnaud Pouliquen (2):
  rpmsg: core: add possibility to get message payload length
  tty: add rpmsg driver

 Documentation/serial/tty_rpmsg.rst |  43 ++++
 drivers/rpmsg/rpmsg_core.c         |  20 ++
 drivers/rpmsg/rpmsg_internal.h     |   2 +
 drivers/rpmsg/virtio_rpmsg_bus.c   |  11 +
 drivers/tty/Kconfig                |   9 +
 drivers/tty/Makefile               |   1 +
 drivers/tty/rpmsg_tty.c            | 455 +++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg.h              |  10 +
 8 files changed, 551 insertions(+)
 create mode 100644 Documentation/serial/tty_rpmsg.rst
 create mode 100644 drivers/tty/rpmsg_tty.c

-- 
2.7.4

