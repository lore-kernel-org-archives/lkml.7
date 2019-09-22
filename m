Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F367120869
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179768;
	bh=URUZzsuEtvmqgS69CvYyDYYGVRNJ0Jzif+eoUQ1PBvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DztsJFbqSrgxsDnsS428HoedGIhn4MTQlG3mMJ+uXgZ8IrSZuLjJFkCL9LovxSdru
	 b04W6FKYoU7i6K49bUH1lmEqsVpkPZfmwn5IqYeej5YU0fRptBk05rPAZZPCarMxJo
	 +90NQeTLEsfn9BU86mPHJMT33+vpeyc4RWuebm9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395527AbfIVTQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391327AbfIVS4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:56:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E4B2186A;
        Sun, 22 Sep 2019 18:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178576;
        bh=URUZzsuEtvmqgS69CvYyDYYGVRNJ0Jzif+eoUQ1PBvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9KmqqrrKHOREFwViGGxz3d+YTu9E6Mhp3QOCi/CI9pSy7k8qdykA0FMxym/26rbh
         yOce+Ag8dJ66N32dx8IP2N8U/pxKOiO6N2MNMeGcEzYYZGc5qKYDGuyqzgc0I9Rqb6
         NOg1KUfOxtE3oaCFLiiFzo+OkPPkPJShZ8n2thHc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 087/128] arm64: kpti: ensure patched kernel text is fetched from PoU
Date:   Sun, 22 Sep 2019 14:53:37 -0400
Message-Id: <20190922185418.2158-87-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit f32c7a8e45105bd0af76872bf6eef0438ff12fb2 ]

While the MMUs is disabled, I-cache speculation can result in
instructions being fetched from the PoC. During boot we may patch
instructions (e.g. for alternatives and jump labels), and these may be
dirty at the PoU (and stale at the PoC).

Thus, while the MMU is disabled in the KPTI pagetable fixup code we may
load stale instructions into the I-cache, potentially leading to
subsequent crashes when executing regions of code which have been
modified at runtime.

Similarly to commit:

  8ec41987436d566f ("arm64: mm: ensure patched kernel text is fetched from PoU")

... we can invalidate the I-cache after enabling the MMU to prevent such
issues.

The KPTI pagetable fixup code itself should be clean to the PoC per the
boot protocol, so no maintenance is required for this code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/proc.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 8cce091b6c21e..ec6aa18633162 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -294,6 +294,15 @@ skip_pgd:
 	msr	sctlr_el1, x18
 	isb
 
+	/*
+	 * Invalidate the local I-cache so that any instructions fetched
+	 * speculatively from the PoC are discarded, since they may have
+	 * been dynamically patched at the PoU.
+	 */
+	ic	iallu
+	dsb	nsh
+	isb
+
 	/* Set the flag to zero to indicate that we're all done */
 	str	wzr, [flag_ptr]
 	ret
-- 
2.20.1

