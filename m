Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B2FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB4A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140026;
	bh=Ff6QY2Mz3TmfbFq63ECDcrDjdQCQ+2NZ+goDmr7HIXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bz/2QM5gxDRkJTR9KHTxu5VmmLURlDODvt6gLcRVxGFQQ31v52urd8QIhwUEXZwr+
	 rFgw/A3FA5y4jf/nZ19crbvysD1mo0GKfnpgzVsjT3jaVYQMmomplemV0BqqMUDCsV
	 MYHGrQLHsRGktb2AMPA/pA7S7c5BvtcbK9d7yFdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbfDARdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbfDARdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D496E2070B;
        Mon,  1 Apr 2019 17:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140020;
        bh=Ff6QY2Mz3TmfbFq63ECDcrDjdQCQ+2NZ+goDmr7HIXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jOFrZFKvkm4ssX0rWBNz5rkXu/RvkR9wckjnJO1JKGi3pzlElkTpNDFJzl3h/f9f
         RU6fsnXtj5iXd/3DuZrOy6S3KNnLidbdVRaqDQ2KyZMvPNb6G4dxpKocwSbnSibhE4
         k1gHOFBylPSM2N2+JWxep9GIdZBm5xJt1rhLHESM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jungseung Lee <js07.lee@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 045/131] ARM: 8494/1: mm: Enable PXN when running non-LPAE kernel on LPAE processor
Date:   Mon,  1 Apr 2019 19:01:55 +0200
Message-Id: <20190401170056.076456035@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ad84f56bf6d620fe6ed4d57ce6ec9945684d7f35 ]

The VMSA field of MMFR0 (bottom 4 bits) is incremented for each
added feature.  PXN is supported if the value is >= 4 and LPAE
is supported if it is >= 5.

In case a kernel with CONFIG_ARM_LPAE disabled is used on a
processor that supports LPAE, we can still use PXN in short
descriptors.  So check for >= 4 not == 4.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e47cffd25c6c..aead23f15213 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -572,7 +572,7 @@ static void __init build_mem_type_table(void)
 	 * in the Short-descriptor translation table format descriptors.
 	 */
 	if (cpu_arch == CPU_ARCH_ARMv7 &&
-		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) == 4) {
+		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) >= 4) {
 		user_pmd_table |= PMD_PXNTABLE;
 	}
 #endif
-- 
2.19.1



