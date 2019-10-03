Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7AFC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CE1215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119756;
	bh=fmlxxnJ480Io5eqOvswOFa+zlg0R9OXICjXhQt1jpOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CRDduL8N9QV09RUlOboO3vpccGRNFcLkdoVtN0Kr0IjWzTl1rY0qK90XMrr4FjNxw
	 eKkRxGw+Tedq3UsFAWayKsUrnERdjDZrRczPDBHB0Hcx45YzhxwASA8E7IRP4A4CNk
	 wsMVI5L8+0vIQ7YFxLbDNnozaqmc/UzQG5Hs86rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbfJCQWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390284AbfJCQWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:22:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D4420659;
        Thu,  3 Oct 2019 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119745;
        bh=fmlxxnJ480Io5eqOvswOFa+zlg0R9OXICjXhQt1jpOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDECIQtIKNAtnlxr/rEMvfTGYpW70yGu3A+Wouzjdu/LQaJjazSWSC7na8rxCAbVS
         1XhykSh8G30DboHV+pXY7UBV6GMf2AemLf0cLz7KERTvWoRV6YYYKqwlltBGfKCiHu
         2Wy7x1NW3+/m8G5tPtENrdUVEXTYEzb5ljnnE2Ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.19 177/211] arm64: tlb: Ensure we execute an ISB following walk cache invalidation
Date:   Thu,  3 Oct 2019 17:54:03 +0200
Message-Id: <20191003154526.982149582@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 51696d346c49c6cf4f29e9b20d6e15832a2e3408 upstream.

05f2d2f83b5a ("arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable")
added a new TLB invalidation helper which is used when freeing
intermediate levels of page table used for kernel mappings, but is
missing the required ISB instruction after completion of the TLBI
instruction.

Add the missing barrier.

Cc: <stable@vger.kernel.org>
Fixes: 05f2d2f83b5a ("arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable")
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/tlbflush.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -224,6 +224,7 @@ static inline void __flush_tlb_kernel_pg
 
 	__tlbi(vaae1is, addr);
 	dsb(ish);
+	isb();
 }
 #endif
 


