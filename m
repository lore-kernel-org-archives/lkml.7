Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E097EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCFC2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625403;
	bh=ZjSnPPE3GJxDV7BkqDZlz1xwMuO9b69kcF0NnUB0768=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QBoX4k4Dj/BQBoTnfBdASl39hwq4lKDW6/X3dNXbAT/v+w3mUFxEefiWPF2hUs+s9
	 D0ZVsJU/RJjXtB1bUBZZ1HnHRfeduzdeMiwkD+dvDI45nsu2M7tjApMWrabFl9vm/H
	 8bFTqVM9KEIzxXy8JK1h1h1foaa5Mxg+TcHDovOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfD3L4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbfD3Lsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:48:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FFC520449;
        Tue, 30 Apr 2019 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624915;
        bh=ZjSnPPE3GJxDV7BkqDZlz1xwMuO9b69kcF0NnUB0768=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aG2XUpM6BO/3Txynx4zXmYTbE0uvEiEDlXpaThnyxPiZ5IL3NIFd8IGyJWF7sCD9v
         KXQSUSM5Oyfh0Vaj/htIwsDvUcH7tsL3B9wW8hVmzP/vzrITlgTUa23kRKzHT9Fz+T
         fOZohROoE3KYCy3SmTjlxM1Xm6d5npzyzjyrYcn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.0 21/89] arm64: mm: Ensure tail of unaligned initrd is reserved
Date:   Tue, 30 Apr 2019 13:38:12 +0200
Message-Id: <20190430113611.059391513@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit d4d18e3ec6091843f607e8929a56723e28f393a6 upstream.

In the event that the start address of the initrd is not aligned, but
has an aligned size, the base + size will not cover the entire initrd
image and there is a chance that the kernel will corrupt the tail of the
image.

By aligning the end of the initrd to a page boundary and then
subtracting the adjusted start address the memblock reservation will
cover all pages that contains the initrd.

Fixes: c756c592e442 ("arm64: Utilize phys_initrd_start/phys_initrd_size")
Cc: stable@vger.kernel.org
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -406,7 +406,7 @@ void __init arm64_memblock_init(void)
 		 * Otherwise, this is a no-op
 		 */
 		u64 base = phys_initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(phys_initrd_size);
+		u64 size = PAGE_ALIGN(phys_initrd_start + phys_initrd_size) - base;
 
 		/*
 		 * We can only add back the initrd memory if we don't end up


