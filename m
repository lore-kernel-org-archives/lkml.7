Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6895BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B28522304
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W9MTRIqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfKSP0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:26:20 -0500
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:43226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbfKSP0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:26:19 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5E4B0C2584;
        Tue, 19 Nov 2019 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574177179; bh=mgDty1pLbITJzm26Ei8U20OJqO/x9UJ2NsqDSy4MQbs=;
        h=From:To:Cc:Subject:Date:From;
        b=W9MTRIqgL7Wxs/n1aQ7kP1f1q4jgrGeD3IeXO8qvoO4WBksKQL5M0IncIniFM15KW
         tWpxibs2Myq9gzzaAQoEE0tvbEey7qZOydUQh1r8/AGnaQnRJhILkzxGaWkQEYdsEe
         Eu2TbKBKJ/Le0+x8jm96aKdwZ+2BVPu3+JISh/OWCrpsbvqZJ9prB9arirtVMWKVX3
         04nDjqnInhZieeUxbWbqCy0h76rzbAgjd4CH7hMRiP5ZXtJTBcumbKYHqurhtrW/3M
         EeuMgGiGgTmXWGnVtg0l9h+xfBbTi58qA4V8UP3XTpktPNm+VGwtM0Q70K3Ky3QFq5
         kJaseiUa5eNKQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id A5DA2A0057;
        Tue, 19 Nov 2019 15:26:17 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: add kmemleak support
Date:   Tue, 19 Nov 2019 18:26:15 +0300
Message-Id: <20191119152615.14078-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak is used internally for a long time and as there isn't
any issue with it we can finally enable it in upstream.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 8383155c8c82..c147ebe51b65 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -30,6 +30,7 @@ config ARC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_IOREMAP_PROT
 	select HAVE_KERNEL_GZIP
-- 
2.21.0

