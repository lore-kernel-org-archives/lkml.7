Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC8DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36DC20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dap6GC6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436743AbfFLNfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:35:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40779 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfFLNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560346506; x=1591882506;
  h=from:to:cc:subject:date:message-id;
  bh=g/hnuUwnFuH6qtFig5Ggh85b17S9rmWi19B6ciJrMz8=;
  b=dap6GC6qTrQvVW+oSucu+vn5O07cwPFFzsYwSIW0cDivfkSvysetmTfy
   w7PuZ6zJp53otha6XUyB7VBzx0zuzQRhGXIc9h7/1RvZ+EHJBlT1JtYGh
   rzp+YwjoCL3CtPjgblNbcIEyx+VCd7S1R8nHYJBrmpvB+FNzmOWZDNI4s
   np0JyC5Rh22uCzc2ukSCf/brO0+2QIW6ztidC6eAkZcdefj3ZsbHuuozF
   OFppwEwXR7Y//B7X6m0ErQMRl8VPDCNLaBy2wHJ37vtRq4ahddH/ExZr1
   ZvxL7jpwnUuvrxVp9jJtXC4G1NvGsu7GEB006amirSzwQCUggo68Jy1Jm
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,366,1557158400"; 
   d="scan'208";a="210060896"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2019 21:35:06 +0800
IronPort-SDR: EVZKtWSQo/bbnntur7E6ae6oeM8HDbrGUJhskdN0PV+E8BiZtBREtkwa5cCFPyAWvfP4j8yAx9
 elaQpxtX+y8bP98tI6soCNcVxFMx+yLzhMElaeXtgzhD3BxIokx7A+yPeyPxfTDaAsnqYXDy1m
 yd30G9i6oUIJjXsxYG29DpBcgVV1wbNX/PeurBcVYwOkNooL7jmWSPlGDuu0UTbm27ruvY4HN+
 kc2fGEkXIbZLDMKCEZ8VCbNs2ixs2qNqavJ0CIrkU/0FXuCesA5V6XLbuFrQbDdtuE5BO5eZvQ
 NV99Wb2a+vk9ZirJ8Xsbwggo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Jun 2019 06:34:51 -0700
IronPort-SDR: Btbm0nQU2UKlfJilRuPCjxkY/ldwKK5VBFW+MKBZ4OP22bI9MnGfdNQYYI2yPDqIV1SshWqQwA
 /cH9cGxrywvO7joo7lFNO90j7g4xwf2/89fmAa/BJon7ww5TMJVBov6p7bsayXvK+SIZHTb7sc
 gTy6O9iTrjhoAnMAvNTO4p8oaMGrZHAg9PmHZkG3dleN5Bwc6+6Z+v8/qnBvzrpbxQ4Cz22qKm
 uKMm3CdldXblU3VH/t2Y5GjfaiasCu60z95EQiC59Wtrg66miaRdwxHaXjf/S8U6fdKzU9XeAT
 dc8=
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Jun 2019 06:35:00 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Date:   Wed, 12 Jun 2019 16:34:37 +0300
Message-Id: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added 'WITH Linux-syscall-note' exception, which is the officially
assigned exception identifier for the kernel syscall exception.
This exception makes it possible to include GPL headers into non GPL
code, without confusing license compliance tools.

fixes: a851b2bd3632 (scsi: uapi: ufs: Make utp_upiu_req visible to user
		     space)

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 include/uapi/scsi/scsi_bsg_ufs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 17c7abd..9988db6 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * UFS Transport SGIO v4 BSG Message Support
  *
-- 
1.9.1

