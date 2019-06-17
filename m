Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54904C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315DF2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfFQLT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:19:59 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfFQLT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:19:59 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N0Fl9-1iW9Fr2hwl-00xL9C; Mon, 17 Jun 2019 13:19:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ondrej Zary <linux@zary.sk>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fdomain: fix building pcmcia front-end
Date:   Mon, 17 Jun 2019 13:19:17 +0200
Message-Id: <20190617111937.2355936-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ft7A+L+Rr9iEQAM1pAHYVAEso0+XdaZFK2sYmt+ngiJcm0laXJ1
 +o16oKqC3FRm99GEeCbWW7/pIFVs6UsAK8OhiPNLl8aGcSWI31a+Wtx3g2I61iVoBiUvoKc
 royoq8jozOIZBwCDMtFcO0q6nTa9PSANsErViZUz0ygbNXVIjgr/ou5m82EwWjfSjoe0V1f
 iRI/q0izxIvGXPQtxkJ9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q8l1WVXaUlI=:BUJ+7U6WS0M//LNrl2MEVu
 Kqex6414Zc60ujZ3auqcDTuSlEpwE/PJjDDLZ9/NoMqcg5LhQtfIpjnDKhTynoI7zVmYZjbP5
 vI3JpBtz8v1Tj8WrjjV6GJhXAoo21aXh0OZ4z75e6A/9Z3HnoJcBooHs5X4V2c6jGiJ658thc
 Tp2WYs3s1ZAbejnOfome6axeLy6l9vC1cwcgxbJeG9hovDgg7yqt+pzUB3g1LxMp+4awnEnNA
 pVV+ibuTbzj5L7twFEzl4pHCJtVS+NsjU6RFl0dvjpw07qocS4SZxkR/HgCM0KkGctOpBq9Ok
 PHp6hjbN+8xwEIgMcJkG9hNf8dqV6UsgLmqiVGZQ3ViW1vccNMDPEXN1eEr6lqa14y3MD2Y04
 w1ZSRaG451NPF5jGXh+/WObN7TGqzaodTa7bWrECEOZMabJpVuYVQSMCM5LJDvwVa35OvS82+
 HPYIw3T85UVTFAN/TC0STC0nmzi5QO6Ld+kfYlwU487siZ6ITQEooztQb4ylxsdNbukTPR0Hr
 gFak5Ue/dPUn20RdTq1aF15JnCZqUWFBn+pmg06+f94I8FnOpoxM6G2TEKyhQ/Y8Brl33n8Qb
 pFq2nqcuuJYVn7DmgbN5VrOF2ouxzj4KxMd0uDtry2rXQkl0T44SLmKVNRrCa2+LRkGN25USc
 9AxLhjCy63uaRoyL1+3N/YFpxqBKmsC4F4mWEEDPkncGmXBs99dC3Gt9zBl4os0hM1cikkQLV
 D8MP/WoKnfg1gNyAdbuxaMJIw4md5wxv4vUEfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when CONFIG_SCSI_LOWLEVEL is disabled here:

WARNING: unmet direct dependencies detected for SCSI_FDOMAIN
  Depends on [n]: SCSI_LOWLEVEL [=n] && SCSI [=y]
  Selected by [m]:
  - PCMCIA_FDOMAIN [=m] && SCSI_LOWLEVEL_PCMCIA [=y] && SCSI [=y] && PCMCIA [=y] && m && MODULES [=y]

Move the common support outside of the SCSI_LOWLEVEL section.
Alternatively, we could move all of SCSI_LOWLEVEL_PCMCIA into
SCSI_LOWLEVEL. This would be more sensible, but might cause
surprises for users that have SCSI_LOWLEVEL disabled.

Fixes: 7d47fa065e62 ("scsi: fdomain: Add PCMCIA support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 75f66f8ad3ea..dffe4b31e205 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -642,10 +642,6 @@ config SCSI_DMX3191D
 	  To compile this driver as a module, choose M here: the
 	  module will be called dmx3191d.
 
-config SCSI_FDOMAIN
-	tristate
-	depends on SCSI
-
 config SCSI_FDOMAIN_PCI
 	tristate "Future Domain TMC-3260/AHA-2920A PCI SCSI support"
 	depends on PCI && SCSI
@@ -1527,6 +1523,10 @@ endif # SCSI_LOWLEVEL
 
 source "drivers/scsi/pcmcia/Kconfig"
 
+config SCSI_FDOMAIN
+	tristate
+	depends on SCSI
+
 source "drivers/scsi/device_handler/Kconfig"
 
 endmenu
-- 
2.20.0

