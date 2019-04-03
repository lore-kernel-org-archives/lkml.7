Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EED4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267C720700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDCKrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:47:52 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:33522 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCKrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:47:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id D5853185CF;
        Wed,  3 Apr 2019 12:47:50 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 31ihfar9soAi; Wed,  3 Apr 2019 12:47:50 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id DCFD9185CB;
        Wed,  3 Apr 2019 12:47:49 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C35171E088;
        Wed,  3 Apr 2019 12:47:49 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4F151E07B;
        Wed,  3 Apr 2019 12:47:49 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 12:47:49 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id A628D3155;
        Wed,  3 Apr 2019 12:47:49 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 99C5680D29; Wed,  3 Apr 2019 12:47:49 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v3 0/4] Virtio-over-PCIe loopback
Date:   Wed,  3 Apr 2019 12:47:42 +0200
Message-Id: <20190403104746.16063-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a loopback driver to be able to use/test/evaluate the
drivers/misc/mic/vop/ code without special hardware.

See v1 for more info:
https://lore.kernel.org/lkml/20190116163253.23780-1-vincent.whitchurch@axis.com/

v3:
- Rebase on top of merged patches
- Resend since last posting had duplicate patches

v2:
- Rebase on top of the patches which have merged
- Use unsigned long instead of uintptr_t
- Drop "Use consistent DMA" for now since it's not needed for loopback
- Add race fix
- Build on all architectures, not just ARM and x86
- Add sample userspace code

Vincent Whitchurch (4):
  mic: vop: Fix init race with shared interrupts
  mic: vop: Add loopback driver
  samples: mic: Split out vop code from mpssd
  samples: mic: Add sample VOP userspace

 drivers/misc/mic/Kconfig            |   10 +
 drivers/misc/mic/vop/Makefile       |    2 +
 drivers/misc/mic/vop/vop_loopback.c |  382 ++++++++
 drivers/misc/mic/vop/vop_main.c     |   42 +-
 samples/mic/mpssd/.gitignore        |    1 +
 samples/mic/mpssd/Makefile          |    9 +-
 samples/mic/mpssd/mpssd.c           | 1317 +-------------------------
 samples/mic/mpssd/mpssd.h           |    1 +
 samples/mic/mpssd/vop.c             | 1357 +++++++++++++++++++++++++++
 samples/mic/mpssd/vopd.c            |   25 +
 10 files changed, 1827 insertions(+), 1319 deletions(-)
 create mode 100644 drivers/misc/mic/vop/vop_loopback.c
 create mode 100644 samples/mic/mpssd/vop.c
 create mode 100644 samples/mic/mpssd/vopd.c

-- 
2.20.0

