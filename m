Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45ADC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FAA233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="q6mm2xgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfH1PU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:20:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41629 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbfH1PUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:20:23 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SF10NH021908;
        Wed, 28 Aug 2019 17:20:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=PPbR2wLIawhk8Ml/k1+P15CZ+bHPxkPytEuN2gCnbfs=;
 b=q6mm2xgdim5e3nSxnNumGIMirAAWPs8X9K7qqHeNbpsswhjc92dBij+cJTFBQBh5U4m8
 QTFBvHjpj9Sh2xhJxhRzT73/9VqyM+KuFdmMLnkXkPcTD72IdxaEqG0+9/mqd0or/MKM
 26zuSi9Xv4DRQ+p7B822DLJ0vc3e/qh4C7Co1ZZnZFDjTVtAugmw/0tbFmUHIkAjslWi
 FXk9L72mfqvU/oJr3hplXqDB1uOLSNn3YeAgnXkGr6FP1coyWMsYFt5b9kS5V4Ax8ceT
 L24UbNRQBw7+BI6bxqVfPwaOzDE+elHka4DyWWYdU+fOjFhWpcuoZ/zkMas2MlBVKIKk 6A== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2unujk05vj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:20:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1E5DD22;
        Wed, 28 Aug 2019 15:19:54 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 79A512B4F40;
        Wed, 28 Aug 2019 17:19:53 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 28 Aug
 2019 17:19:53 +0200
Received: from localhost (10.48.0.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 28 Aug 2019 17:19:53 +0200
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
Subject: [PATCH v5 0/2] TTY: add rpmsg tty driver
Date:   Wed, 28 Aug 2019 17:19:24 +0200
Message-ID: <1567005566-10986-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_07:,,
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

The first patch adds an API to the rpmsg framework ('get max transmission unit') and the
second one is the rpmsg tty driver itself.

History:
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

