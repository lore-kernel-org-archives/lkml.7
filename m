Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0215C2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfFGPOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:14:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfFGPO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:14:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53046499;
        Fri,  7 Jun 2019 08:14:28 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 345403F718;
        Fri,  7 Jun 2019 08:14:27 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-doc@vger.kernel.org, x86@kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
Subject: [PATCH 2/4] Documentation: x86: Remove cdpl2 unspported statement and fix capitalisation
Date:   Fri,  7 Jun 2019 16:14:07 +0100
Message-Id: <20190607151409.15476-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607151409.15476-1-james.morse@arm.com>
References: <20190607151409.15476-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"L2 cache does not support code and data prioritization". This isn't
true, elsewhere the document says it can be enabled with the cdpl2
mount option.

While we're here, these sample strings have lower-case code/data,
which isn't how the kernel exports them.

Signed-off-by: James Morse <james.morse@arm.com>
---
 Documentation/x86/resctrl_ui.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 066f94e53418..638cd987937d 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -418,16 +418,22 @@ L3 schemata file details (CDP enabled via mount option to resctrl)
 When CDP is enabled L3 control is split into two separate resources
 so you can specify independent masks for code and data like this::
 
-	L3data:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
-	L3code:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
+	L3DATA:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
+	L3CODE:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
 
 L2 schemata file details
 ------------------------
-L2 cache does not support code and data prioritization, so the
-schemata format is always::
+CDP is supported at L2 using the 'cdpl2' mount option. The schemata
+format is either::
 
 	L2:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
 
+or
+
+	L2DATA:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
+	L2CODE:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
+
+
 Memory bandwidth Allocation (default mode)
 ------------------------------------------
 
-- 
2.20.1

