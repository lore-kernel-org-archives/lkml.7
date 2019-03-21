Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2424BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC5521917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfCUWBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:20537 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfCUWAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="157183552"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0C77A300AB8; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, arnd@arndb.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 01/17] kbuild: Disable -Waddress-of-packed-member for gcc 9
Date:   Thu, 21 Mar 2019 14:59:53 -0700
Message-Id: <20190321220009.29334-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

This warning is very noisy in a default build with gcc 9.
Move it into W=2 only.

Cc: arnd@arndb.de
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Makefile                   | 1 +
 scripts/Makefile.extrawarn | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 71c2c482e2a2..78efbb172991 100644
--- a/Makefile
+++ b/Makefile
@@ -676,6 +676,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 768306add591..ed974a0f4a47 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -43,6 +43,7 @@ warning-2 += $(call cc-option, -Wmissing-field-initializers)
 warning-2 += $(call cc-option, -Wsign-compare)
 warning-2 += $(call cc-option, -Wmaybe-uninitialized)
 warning-2 += $(call cc-option, -Wunused-macros)
+warning-2 += $(call cc-option, -Waddress-of-packed-member)
 
 warning-3 := -Wbad-function-cast
 warning-3 += -Wcast-qual
-- 
2.20.1

