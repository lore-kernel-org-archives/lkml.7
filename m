Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3388C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A829D218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfCUWAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:00:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:53197 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfCUWAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216357246"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 77D4930214C; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, yi.y.sun@linux.intel.com,
        kys@microsoft.com, haiyangz@microsoft.com
Subject: [PATCH 15/17] x86/hyperv: Make hv_vcpu_is_preempted visible
Date:   Thu, 21 Mar 2019 15:00:07 -0700
Message-Id: <20190321220009.29334-16-andi@firstfloor.org>
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

This function is referrenced from assembler, so need to be marked
visible for LTO.

Cc: yi.y.sun@linux.intel.com
Cc: kys@microsoft.com
Cc: haiyangz@microsoft.com
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

