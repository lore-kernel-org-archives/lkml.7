Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA74DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997942083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725102;
	bh=t6KXPx9TiLltdM4N2pImByRyPUW6oOs38VC2hEClX8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LpANpmcYvaMWCSek3QlwyY9I+JYaze1KTfu1fZCekfOzZVOB9eQtjoXNo7yZNryf5
	 Pkcp1SMenFrqaO1ldyJZ+EkgjI2nzJMe9xyMD2Yue2UJ5zbElljxIX78Bx3lUxlfMa
	 MO0APQvB9Wuc1T/R07i5J3uUaBUWgU8WBq0x0ykc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfF1Mbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:31:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfF1Map (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/ACtFTJ8t0rgRWDNSeADECk30Wwk28wX2Poo52xAGI8=; b=e+2o4PfTUqmLAP9+yVgRTSMqCY
        Tnf5U0x2uPJDPkns5j2lSPUa//SkDRojN/zK7V3DPohSOh24J2v2XKdQVQPgWUQRkknLsIsR2a8sw
        vIAtdmC4K3NnPyXm2z2HalcpZEHRSrjqde3msUjYzWYE60G4cwtqKGBoAYWj4cxEpZ9n8vkk4NQTY
        1+enRTu9Mq7VFZJn9umR7TD5TBCMyx72vxi0UDfoSYRsI6HfJ0L9lPadMMeWB5FaFlAffVzHajfi7
        eN3oY5WswA3cPdrB9qfCaBwvbmkCjuN4BFIdR7nw0X6L23eBpFfBVPgLZAKHqt7pbT7NyOgMG4Gb8
        qPMmGZ4w==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055C-Fo; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Rx-94; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 13/39] docs: add arch doc directories to the index
Date:   Fri, 28 Jun 2019 09:30:06 -0300
Message-Id: <df4b7dbf72f2ca0695adc6e5997ad852be2332a7.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that several arch documents were converted to ReST,
add their indexes to Documentation/index.rst and remove the
:orphan:  from them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/arm/index.rst     |  2 --
 Documentation/arm64/index.rst   |  2 --
 Documentation/ia64/index.rst    |  2 --
 Documentation/index.rst         | 10 ++++++++++
 Documentation/m68k/index.rst    |  2 +-
 Documentation/powerpc/index.rst |  2 +-
 Documentation/riscv/index.rst   |  2 --
 Documentation/s390/index.rst    |  2 --
 Documentation/sparc/index.rst   |  2 --
 Documentation/xtensa/index.rst  |  2 +-
 10 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index bd316d1a1802..9c2f781f4685 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -1,5 +1,3 @@
-﻿:orphan:
-
 ================
 ARM Architecture
 ================
diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 018b7836ecb7..96b696ba4e6c 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 ARM64 Architecture
 ==================
diff --git a/Documentation/ia64/index.rst b/Documentation/ia64/index.rst
index a3e3052ad6e2..ef99475f672b 100644
--- a/Documentation/ia64/index.rst
+++ b/Documentation/ia64/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 IA-64 Architecture
 ==================
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 95db26bf2899..f898def833f4 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -118,7 +118,17 @@ implementation.
    :maxdepth: 2
 
    sh/index
+   arm/index
+   arm64/index
+   ia64/index
+   m68k/index
+   powerpc/index
+   riscv/index
+   s390/index
+   sh/index
+   sparc/index
    x86/index
+   xtensa/index
 
 Filesystem Documentation
 ------------------------
diff --git a/Documentation/m68k/index.rst b/Documentation/m68k/index.rst
index f3273ec075c3..3a5ba7fe1703 100644
--- a/Documentation/m68k/index.rst
+++ b/Documentation/m68k/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 =================
 m68k Architecture
diff --git a/Documentation/powerpc/index.rst b/Documentation/powerpc/index.rst
index 1ff17268db46..549b1cdd77ae 100644
--- a/Documentation/powerpc/index.rst
+++ b/Documentation/powerpc/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 =======
 powerpc
diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index c4b906d9b5a7..e3ca0922a8c2 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===================
 RISC-V architecture
 ===================
diff --git a/Documentation/s390/index.rst b/Documentation/s390/index.rst
index 1a914da2a07b..4602312909d3 100644
--- a/Documentation/s390/index.rst
+++ b/Documentation/s390/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =================
 s390 Architecture
 =================
diff --git a/Documentation/sparc/index.rst b/Documentation/sparc/index.rst
index 91f7d6643dd5..71cff621f243 100644
--- a/Documentation/sparc/index.rst
+++ b/Documentation/sparc/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 Sparc Architecture
 ==================
diff --git a/Documentation/xtensa/index.rst b/Documentation/xtensa/index.rst
index 5a24e365e35f..52fa04eb39a3 100644
--- a/Documentation/xtensa/index.rst
+++ b/Documentation/xtensa/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ===================
 Xtensa Architecture
-- 
2.21.0

