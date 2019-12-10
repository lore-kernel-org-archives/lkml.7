Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F74C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8327D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014639;
	bh=LboDk7qejJ73KZ6hyiJlV7BfnObNJdQAPw/MXwz8OqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CmTvi6xT2aKKps6nCKoxXek/37owmiT9xUR1y6iodB6Md87AkTA/5fciAl8GB8uxp
	 9mYoelpq80mlm03sMDVUUGUeokDVwzxLG5WpxGWHj2KmZy0FyFsYsc2QpsBntcfYVf
	 eiPGUd0cP7DpzZ3IKLzb8FttWATwnxmIIYsz1RtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfLJVuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfLJVIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:08:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DD924684;
        Tue, 10 Dec 2019 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012101;
        bh=LboDk7qejJ73KZ6hyiJlV7BfnObNJdQAPw/MXwz8OqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaWeVrEPfCDzyirTxetvoyMnjZIXFfEJgVG2AJp73hn69SwHKeA83SMgIaOLhxPqt
         OstZfYQvmjcmZBLfazufT1/QpGP8K/RiQU87A87fMWOFjKiu2SSGRAYQClbri3Vql/
         neA5G6HKpE9UwnNzC4Dt4ZJKCvh9FpB2x0UHkrvg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 076/350] staging/octeon: Use stubs for MIPS && !CAVIUM_OCTEON_SOC
Date:   Tue, 10 Dec 2019 16:03:01 -0500
Message-Id: <20191210210735.9077-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 17a29fea086ba18b000d28439bd5cb4f2b0a527b ]

When building for a non-Cavium MIPS system with COMPILE_TEST=y, the
Octeon ethernet driver hits a number of issues due to use of macros
provided only for CONFIG_CAVIUM_OCTEON_SOC=y configurations. For
example:

  drivers/staging/octeon/ethernet-rx.c:190:6: error:
    'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function)
  drivers/staging/octeon/ethernet-rx.c:472:25: error:
    'OCTEON_IRQ_WORKQ0' undeclared (first use in this function)

These come from various asm/ headers that a non-Octeon build will be
using a non-Octeon version of.

Fix this by using the octeon-stubs.h header for non-Cavium MIPS builds,
and only using the real asm/octeon/ headers when building a Cavium
Octeon kernel configuration.

This requires that octeon-stubs.h doesn't redefine XKPHYS_TO_PHYS, which
is defined for MIPS by asm/addrspace.h which is pulled in by many other
common asm/ headers.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
URL: https://lore.kernel.org/linux-mips/CAMuHMdXvu+BppwzsU9imNWVKea_hoLcRt9N+a29Q-QsjW=ip2g@mail.gmail.com/
Fixes: 171a9bae68c7 ("staging/octeon: Allow test build on !MIPS")
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: David S. Miller <davem@davemloft.net>

Link: https://lore.kernel.org/r/20191007231741.2012860-1-paul.burton@mips.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/octeon/octeon-ethernet.h | 2 +-
 drivers/staging/octeon/octeon-stubs.h    | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index a8a864b409135..042220d86d33d 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -14,7 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 
-#ifdef CONFIG_MIPS
+#ifdef CONFIG_CAVIUM_OCTEON_SOC
 
 #include <asm/octeon/octeon.h>
 
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index b78ce9eaab85d..ae014265064af 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1,5 +1,8 @@
 #define CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE	512
-#define XKPHYS_TO_PHYS(p)			(p)
+
+#ifndef XKPHYS_TO_PHYS
+# define XKPHYS_TO_PHYS(p)			(p)
+#endif
 
 #define OCTEON_IRQ_WORKQ0 0
 #define OCTEON_IRQ_RML 0
-- 
2.20.1

