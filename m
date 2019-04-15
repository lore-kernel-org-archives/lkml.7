Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3839C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2016218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354962;
	bh=6Ai6kGjJWEbGw37IbbQbxsmFWPVI252hG3ClNzAzMEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tX02Jp91OMyrU1k41QcVkPaqJDNKnJUUXDvg+8B89ziCv6H3PSIMnScCzpZbbxBVa
	 aQCi07gktvUKwxouhVq0JjOzin3OfcCzT8r5jui4OcxUNG/CVHZDbEz4N8LXude4M4
	 8qb0y33cGzl7xBhvqqzyvAcy1I78PG0dDVXilM4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfDOTCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbfDOTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B173F21906;
        Mon, 15 Apr 2019 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354956;
        bh=6Ai6kGjJWEbGw37IbbQbxsmFWPVI252hG3ClNzAzMEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnRiEe6xjU2DyzYXzJnLwWuDCNf0QFPM68O3VOUFVOLPYJgaDQoCc+vKYEFyX9lbT
         LR4zG1g4EJCgoUoFaEETHwEKFY7sF4cejDj9Pb5ZEZZCpD/cuChNR9pYQIcGKrfZ03
         av4MMnzijXd9HBexVYYfDL99S4ovtIs5Vvakftwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        liyueyi <liyueyi@live.com>, Will Deacon <will.deacon@arm.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 13/69] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region
Date:   Mon, 15 Apr 2019 20:58:31 +0200
Message-Id: <20190415183729.452650602@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c8a43c18a97845e7f94ed7d181c11f41964976a2 ]

When KASLR is enabled (CONFIG_RANDOMIZE_BASE=y), the top 4K of kernel
virtual address space may be mapped to physical addresses despite being
reserved for ERR_PTR values.

Fix the randomization of the linear region so that we avoid mapping the
last page of the virtual address space.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: liyueyi <liyueyi@live.com>
[will: rewrote commit message; merged in suggestion from Ard]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index caa295cd5d09..9e6c822d458d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
 		 * memory spans, randomize the linear region as well.
 		 */
 		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
-			range = range / ARM64_MEMSTART_ALIGN + 1;
+			range /= ARM64_MEMSTART_ALIGN;
 			memstart_addr -= ARM64_MEMSTART_ALIGN *
 					 ((range * memstart_offset_seed) >> 16);
 		}
-- 
2.19.1



