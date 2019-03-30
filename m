Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17953C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B94218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfC3AsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:48:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:64235 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730471AbfC3Arx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:47:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 17:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="129912803"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2019 17:47:51 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 01BD9301BE3; Fri, 29 Mar 2019 17:47:51 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        jgross@suse.com, boris.ostrovsky@oracle.com
Subject: [PATCH v2 5/9] x86/xen: Mark xen_vcpu_stolen as __visible
Date:   Fri, 29 Mar 2019 17:47:39 -0700
Message-Id: <20190330004743.29541-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330004743.29541-1-andi@firstfloor.org>
References: <20190330004743.29541-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

This function is referenced from assembler, so needs to be marked
__visible for LTO.

Cc: jgross@suse.com
Cc: boris.ostrovsky@oracle.com
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 0968859c29d0..04b59dab30f5 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -144,7 +144,7 @@ void xen_get_runstate_snapshot(struct vcpu_runstate_info *res)
 }
 
 /* return true when a vcpu could run but has no real cpu to run on */
-bool xen_vcpu_stolen(int vcpu)
+__visible bool xen_vcpu_stolen(int vcpu)
 {
 	return per_cpu(xen_runstate, vcpu).state == RUNSTATE_runnable;
 }
-- 
2.20.1

