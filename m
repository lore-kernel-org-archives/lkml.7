Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB832C4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 23:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9697320828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 23:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567984726;
	bh=FxEKbz5lcvL7U59ZQw9i2X+8b1UWgWWC/e1PbuEqGdU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vFmRrjf0WmnudGKlyu4xGEmYrLWhjUod9JewwCJD+CufmE0kpVdK9bKq7XzyR9My8
	 6dFKl3iBIbsb/+fNJ7tQCEIjLl7WcDF0C1SMasPCUEVYdcsGtpXk5G30HEXkXWo4RY
	 i6Ga2PcUM1xDu9EdWFJBIbHL+F+uLaHzSAHSsx4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfIHXSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 19:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731201AbfIHXSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:18:14 -0400
Received: from earth.universe (bl10-94-171.dsl.telepac.pt [85.243.94.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F4720828;
        Sun,  8 Sep 2019 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567984694;
        bh=FxEKbz5lcvL7U59ZQw9i2X+8b1UWgWWC/e1PbuEqGdU=;
        h=From:To:Cc:Subject:Date:From;
        b=UuSwRV0C8jh+MxBesClQ/bbEmYh/cbjbAnRvcx/ZABBsbATJjVgivORzaOVUkO66X
         iqOHpGTeJxobkduQJVARXe0L/mfbCaGQxDaysUw1aOumkydZAhnfYQNeRMEqL0jlky
         AXXASEENA+NZK1ZbeJucjCQoNPaDYy87kijaLCyg=
Received: by earth.universe (Postfix, from userid 1000)
        id 56CD73C0CFA; Sun,  8 Sep 2019 14:10:39 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kbuild test robot <lkp@intel.com>,
        Han Nandor <nandor.han@vaisala.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: core: fix nvmem_cell_write inline function
Date:   Sun,  8 Sep 2019 14:10:38 +0200
Message-Id: <20190908121038.6877-1-sre@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

nvmem_cell_write's buf argument uses different types based on
the configuration of CONFIG_NVMEM. The function prototype for
enabled NVMEM uses 'void *' type, but the static dummy function
for disabled NVMEM uses 'const char *' instead. Fix the different
behaviour by always expecting a 'void *' typed buf argument.

Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Han Nandor <nandor.han@vaisala.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 include/linux/nvmem-consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 8f8be5b00060..5c17cb733224 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -118,7 +118,7 @@ static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 }
 
 static inline int nvmem_cell_write(struct nvmem_cell *cell,
-				    const char *buf, size_t len)
+				   void *buf, size_t len)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.23.0.rc1

