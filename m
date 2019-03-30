Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3804DC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA43218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfC3Arx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:47:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:6268 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbfC3Arv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:47:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 17:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="311618921"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2019 17:47:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 09D5E301C79; Fri, 29 Mar 2019 17:47:51 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        yi.y.sun@linux.intel.com, kys@microsoft.com, haiyangz@microsoft.com
Subject: [PATCH v2 6/9] x86/hyperv: Make hv_vcpu_is_preempted visible
Date:   Fri, 29 Mar 2019 17:47:40 -0700
Message-Id: <20190330004743.29541-6-andi@firstfloor.org>
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

This function is referrenced from assembler, so need to be marked
visible for LTO.

Cc: yi.y.sun@linux.intel.com
Cc: kys@microsoft.com
Cc: haiyangz@microsoft.com
Reviewed-by: Yi Sun <yi.y.sun@linux.intel.com>
Fixes: 3a025de64bf8 x86/hyperv: Enable PV qspinlock for Hyper-V
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/hyperv/hv_spinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index a861b0456b1a..07f21a06392f 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -56,7 +56,7 @@ static void hv_qlock_wait(u8 *byte, u8 val)
 /*
  * Hyper-V does not support this so far.
  */
-bool hv_vcpu_is_preempted(int vcpu)
+__visible bool hv_vcpu_is_preempted(int vcpu)
 {
 	return false;
 }
-- 
2.20.1

