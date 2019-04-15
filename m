Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81C1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76170218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354033;
	bh=4gxW72HfJr5+kkJDdtE9i6Nz5A/Ke0uzBsjxdhn05vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rzRlaoRI41Fzh8P3A2mjgOYzScOD6kX/hA3xbz+q2Nd71HIF31fZlFx2FUfGYuLtt
	 aLKp3+XAFP5AUvEsRw30HdH2upV0YaTS0KQ4pGeNjrbUOxy2UKsB2csbqSX9QymtSy
	 lFvsy27O1wKjli/ouQL46ZKJibsGwJ0Uf1UEeM98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfDOSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfDOSrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60DD218DA;
        Mon, 15 Apr 2019 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354027;
        bh=4gxW72HfJr5+kkJDdtE9i6Nz5A/Ke0uzBsjxdhn05vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkTF9hlgAkQTg2ur8jdoQygXNC9hTUet7w53TiMmIVwdeg+y0J52aSM4D2pNqx1gH
         qOhyEMlpatMkJ4TCnvB0wvHAQYEOYoxtzCP5wOzoUxzf+jS/gWH5lrC1ELYTkduNvV
         jH4TeprnxY6GDbosyGmC08MUOmcl4Bynllzwb4Fw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        liyueyi <liyueyi@live.com>, Will Deacon <will.deacon@arm.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.9 45/76] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region
Date:   Mon, 15 Apr 2019 20:44:09 +0200
Message-Id: <20190415183720.131293717@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
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
index fa6b2fad7a3d..5d3df68272f5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -272,7 +272,7 @@ void __init arm64_memblock_init(void)
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



