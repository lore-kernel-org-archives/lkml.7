Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A29FC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB54020830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122179;
	bh=CiyScJoSbjEh1dk6sz0/OoVDGfhZZEA9aBDwuupZISg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rRPfIGS2GdDyv64qV1/o1v+yDuELh2klFba5CuqsxZBbP7zJbiLXtnEm37cxkhEEq
	 Yb4HCZSqcQq075juDto7+WroJd/8+8J0xRGef429Ui5VJI+HxTfGPTPU07Tl/ADpDS
	 jS+zIcee4FMP4iW2FhMRSaCAtvIszC52X4FC7AZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392626AbfJCQmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392611AbfJCQmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:42:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39F52070B;
        Thu,  3 Oct 2019 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120934;
        bh=CiyScJoSbjEh1dk6sz0/OoVDGfhZZEA9aBDwuupZISg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auZdpDU89bZCtc2nR0VRT6PJIfgBiOI216nbLMHtvKz+QRnHzKcXhPSCJ+FlBI/zU
         3mH10JNQSv4mtu8OVm4pjBewKozuSqmxkgvENHrCaF1xnSSbAUYOxQx9ao7EAD1HVf
         KppePnIjjwFjzu9/O2jkCq1Mo1akc0Lkco2QfySk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 092/344] RAS: Build debugfs.o only when enabled in Kconfig
Date:   Thu,  3 Oct 2019 17:50:57 +0200
Message-Id: <20191003154549.261953614@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis Kletnieks <valdis.kletnieks@vt.edu>

[ Upstream commit b6ff24f7b5101101ff897dfdde3f37924e676bc2 ]

In addition, the 0day bot reported this build error:

  >> drivers/ras/debugfs.c:10:5: error: redefinition of 'ras_userspace_consumers'
      int ras_userspace_consumers(void)
          ^~~~~~~~~~~~~~~~~~~~~~~
     In file included from drivers/ras/debugfs.c:3:0:
     include/linux/ras.h:14:19: note: previous definition of 'ras_userspace_consumers' was here
      static inline int ras_userspace_consumers(void) { return 0; }
                      ^~~~~~~~~~~~~~~~~~~~~~~

for a riscv-specific .config where CONFIG_DEBUG_FS is not set. Fix all
that by making debugfs.o depend on that define.

 [ bp: Rewrite commit message. ]

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/7053.1565218556@turing-police
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ras/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index ef6777e14d3df..6f0404f501071 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_RAS)	+= ras.o debugfs.o
+obj-$(CONFIG_RAS)	+= ras.o
+obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
-- 
2.20.1



