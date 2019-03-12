Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05138C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECA4205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413326;
	bh=hXgZwx5AHo4pu3xvnX/pKwDNy2OCJi5MyOA0WVwiBAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lK66B0ANNRuANrJBZvKAwUP8hT+O4f/WAIYdHAQlcVep4DMtdEZLxr3NGhb06TgJW
	 VJt56CixhAUbuOE9A5/W+KycCaZoAnzPMKJix1v1pBWO+5P6vHIFWgoyEA/+judO2P
	 sOfzsSFcuX61dpTTPcABXZrLp2ZFR0lnNn+fmDqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfCLRzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfCLROE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:04 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBCD206DF;
        Tue, 12 Mar 2019 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410843;
        bh=hXgZwx5AHo4pu3xvnX/pKwDNy2OCJi5MyOA0WVwiBAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dsbcr6d+5xji+BLKOU4dUyTppVyhjqjmRbtan1KVNL0Vf5OwbOzRU7kFykR9BszMd
         ZnxbsbW4G3l62X/UgRAPM+YubEThaRcmUflMxCzifj4fbQquAxQ8nQK1fZ5NFa/V6Y
         8VH/N9mwcvfI2Lhsbx99WAzImevBOUzC06rwzOR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandre Ghiti <aghiti@upmem.com>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/149] riscv: Adjust mmap base address at a third of task size
Date:   Tue, 12 Mar 2019 10:07:14 -0700
Message-Id: <20190312170350.953206922@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ae662eec8a515ab550524e04c793b5ddf1aae3a1 ]

This ratio is the most used among all other architectures and make
icache_hygiene libhugetlbfs test pass: this test mmap lots of
hugepages whose addresses, without this patch, reach the end of
the process user address space.

Signed-off-by: Alexandre Ghiti <aghiti@upmem.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3fe4af8147d2..c23578a37b44 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -22,7 +22,7 @@
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE >> 1)
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
 
 #define STACK_TOP		TASK_SIZE
 #define STACK_TOP_MAX		STACK_TOP
-- 
2.19.1



