Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DB3C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0FF2168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="EzPcr5Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfIDNPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:15:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11084 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727544AbfIDNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:15:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x84DB8Aa026328;
        Wed, 4 Sep 2019 15:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=jVdvsAqrkKcaztUEMhmOldH3Mc7TxkW+m7444Y0BJCY=;
 b=EzPcr5Wa4octVn6q6xQY/z/BydtyCmxo0Zh4eGUn1XSbiPGvygefGsNf1SduP21Ti36J
 GqiKxPOAlSUZYpx0iTK4qEZCYm3lZmA41LxOGShEq2O8oNBXvWa+FNMXSkXyGhi5XQIc
 BsaOi4+bDko1gHVLFK97Dj8VRU84qgjVNmiMtdoTV+EXD8JbEhtA9cIJBqIwjEos8ZAF
 EkpEjKAhpEinBcDULjdXa6hAGLFpSp8bdRvIel5KQFtp0JW0UQomAhZ+4FbokLYt2hMR
 LN8j5DXg/Veox5+CaPXz81ISUE4i583u82yaSIxj/60FuicB7IaAxchtTHAtlK5x7liu GA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uqec31j66-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 04 Sep 2019 15:15:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5638F58;
        Wed,  4 Sep 2019 13:15:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A6C82D517A;
        Wed,  4 Sep 2019 15:15:07 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 15:15:06 +0200
Received: from localhost (10.48.0.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019 15:15:05 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     <arnaud.pouliquen@st.com>, Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        "Alan Cox" <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH v6 0/2] TTY: add rpmsg tty driver
Date:   Wed, 4 Sep 2019 15:09:52 +0200
Message-ID: <1567602594-2913-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_04:2019-09-03,2019-09-04 signatures=0
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

The first patch adds an API to the rpmsg framework ('get max transmission unit') and the
second one is the rpmsg tty driver itself.

History:
-V5 to V6: 
	minor fixes reported by Suman Anna and sparse tools

-V4 to V5: 
	rework RPMSG channels to offer 2 modes: with and without flow control
	  - remove the use of the first message byte to differentiate data and control
	  - allow communication without flow control using a single RPMsg channel
	  - implement flow control with creating of 2 endpoints
		- default one for the control
		- second one for the data
	  - data endpoint address is transmitted to the remote side trougnt the control channel

-V3 to V4: 
	- reformat documentation in rst format
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
  rpmsg: core: add API to get message length
  tty: add rpmsg driver

 Documentation/serial/tty_rpmsg.rst |  45 ++++
 drivers/rpmsg/rpmsg_core.c         |  21 ++
 drivers/rpmsg/rpmsg_internal.h     |   2 +
 drivers/rpmsg/virtio_rpmsg_bus.c   |  10 +
 drivers/tty/Kconfig                |   9 +
 drivers/tty/Makefile               |   1 +
 drivers/tty/rpmsg_tty.c            | 418 +++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg.h              |  10 +
 8 files changed, 516 insertions(+)
 create mode 100644 Documentation/serial/tty_rpmsg.rst
 create mode 100644 drivers/tty/rpmsg_tty.c

-- 
2.7.4

