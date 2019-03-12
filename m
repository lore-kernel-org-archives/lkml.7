Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC328C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40B72087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412226;
	bh=kjEeexeTVPORnmWdHzANlXcUJ+TwSuCjsVisrGDHkoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RiT+d4+SPG0UCd6FGCk5CGmnQMjsa5huJayiex0G/MLoTQwMr+xXtotHzdhEx/TuD
	 jyo69Zc3o/zT5wxuAXHdRwyEyo0ZM11L9+ILEkyg2Qvcsak9vmWZppL45HdQwxobsn
	 rBex24OUr8HeLXwwjYWoArOOosFsdDUJjose7Q7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfCLRhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfCLRQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:40 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59475217D4;
        Tue, 12 Mar 2019 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410999;
        bh=kjEeexeTVPORnmWdHzANlXcUJ+TwSuCjsVisrGDHkoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAdRZzax3nEYp1UszoP5a2LThgmaPna1XgL6MhDDd5QF+xxGSYCdkKxDLVUeq5Z0f
         6mqXerGkq1PfZzvsL+jKJJbEC46mGVppOZRyQ4XW4Vhu4Ujns1MHQojqUCL7ABoUqc
         nZu/SafAc0X7/Fzm3viRgywfIszZPneicTrylQ9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 099/135] irqchip/gic-v3-its: Fix ITT_entry_size accessor
Date:   Tue, 12 Mar 2019 10:09:06 -0700
Message-Id: <20190312170350.317510913@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 56841070ccc87b463ac037d2d1f2beb8e5e35f0c ]

According to ARM IHI 0069C (ID070116), we should use GITS_TYPER's
bits [7:4] as ITT_entry_size instead of [8:4]. Although this is
pretty annoying, it only results in a potential over-allocation
of memory, and nothing bad happens.

Fixes: 3dfa576bfb45 ("irqchip/gic-v3-its: Add probing for VLPI properties")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
[maz: massaged subject and commit message]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index bacb499c512c..845ff8c51564 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -306,7 +306,7 @@
 #define GITS_TYPER_PLPIS		(1UL << 0)
 #define GITS_TYPER_VLPIS		(1UL << 1)
 #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
-#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
+#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0xf) + 1)
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
-- 
2.19.1



