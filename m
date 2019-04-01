Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E84C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1877A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140265;
	bh=aYSk/CYVTmVZHYQ+Sh0WvSeMZny+t4cf6+TUjedRIpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eXzXqr6++Wp+oEN5+Ps0tumji3i5pUsMXYU2UqdApK+rAgO/Qng9QbyIrw/RZTkiF
	 0xxiC3z2NMHJUGFs4LwHVvshd50PYFyLwP1Oq4ny1RZY/8IqD6CYBKQ1AOyn4Ihrgh
	 k+IFT4SUSfXcExgfR/J+0GAIPjd4dEAWkAPgk4B4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbfDARho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388203AbfDARhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC0C20830;
        Mon,  1 Apr 2019 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140255;
        bh=aYSk/CYVTmVZHYQ+Sh0WvSeMZny+t4cf6+TUjedRIpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zq0ppL7/huRAOL7he2QGgTfigMWE4Hjb1B+1cW1qy/MPun186FoSc7Ewv+Ul8MDjh
         fSlRoE6fR1fVLR6fd+n10KXl/kp5OAlYcgtbuBs5ow8RRvs1v/NjtFEDejDAwGGRdZ
         OBh947OtqRj1vXgI3pfKuURj2vCfBgTt/zxh/lMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 21/50] arm64: kernel: Include _AC definition in page.h
Date:   Mon,  1 Apr 2019 19:03:04 +0200
Message-Id: <20190401170043.851066231@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 812264550dcba6cdbe84bfac2f27e7d23b5b8733 ]

page.h uses '_AC' in the definition of PAGE_SIZE, but doesn't include
linux/const.h where this is defined. This produces build warnings when only
asm/page.h is included by asm code.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 22b16232bd60..677c2bcc3318 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_PAGE_H
 #define __ASM_PAGE_H
 
+#include <linux/const.h>
+
 /* PAGE_SHIFT determines the page size */
 #ifdef CONFIG_ARM64_64K_PAGES
 #define PAGE_SHIFT		16
-- 
2.19.1



