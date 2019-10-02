Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03850C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EC021783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570007218;
	bh=rMY2CW5QwZ9YmCSz5Nt9u9FCWvjJMbGfqDYE/Eciwzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TxhhlMFfAIKM6Cgj19G7xkPQI8lzERPymEp8em9eHxTiSL0Z4se5MNKcWTi7Ps9Uu
	 fDROaSOyGLDLWUpM4Baco2z+UUQdl5AVfr454WPPxsbkV2ULp3p3T11tkY/T6DvopW
	 mE2qC69FwWX1rjmRkbLJ8XJYWwnNZONIKHwEWYd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJBJG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:06:57 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:52171 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfJBJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:06:56 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFaat-00057p-JN; Wed, 02 Oct 2019 11:06:47 +0200
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: Document ICC_CTLR_EL3.PMHE setting requirements
Date:   Wed,  2 Oct 2019 10:06:13 +0100
Message-Id: <20191002090613.14236-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002090613.14236-1-maz@kernel.org>
References: <20191002090613.14236-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It goes without saying, but better saying it: the kernel expects
ICC_CTLR_EL3.PMHE to have the same value across all CPUs, and
for that setting not to change during the lifetime of the kernel.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/booting.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index d3f3a60fbf25..5d78a6f5b0ae 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -213,6 +213,9 @@ Before jumping into the kernel, the following conditions must be met:
 
       - ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
       - ICC_SRE_EL3.SRE (bit 0) must be initialised to 0b1.
+      - ICC_CTLR_EL3.PMHE (bit 6) must be set to the same value across
+        all CPUs the kernel is executing on, and must stay constant
+        for the lifetime of the kernel.
 
   - If the kernel is entered at EL1:
 
-- 
2.20.1

