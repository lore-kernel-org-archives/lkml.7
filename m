Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A22C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E6421A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931063;
	bh=sgpC2KLS/4Rjhn2ZMgXWoTc6xu05EmuS7/jOsnoo6nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0C5RGl5Mvl//RxIac9Leqqq04jR+nt93kVy/CI5nWCSdeF6kAPC4ORfH41fWUCERt
	 WGqAeuaju0quj5oLeA1r/1WIhdrjD2O7Ds63ZO9i9GmTcVnJO/wnt1KZHXZt13V1CW
	 JQYBpRwAOx4ZVAzdfRLDYA5KC+mh4YxD8x8mH34Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405824AbfISWLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389407AbfISWK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:10:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA850218AF;
        Thu, 19 Sep 2019 22:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931058;
        bh=sgpC2KLS/4Rjhn2ZMgXWoTc6xu05EmuS7/jOsnoo6nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwgA2yXphFnXjqScztzRSskqnC2D6a/RGhIHUfxRgIg2rCPiTiLwRMpIGaz0TBqrC
         s3hJAUno/nwtVeD8pxmw62DBJodwoaYYNePOVA+IIPzyZaFpkh4IVqZg/VBA459Ydq
         0xZdPoCC5UmI3nGie8uv8K0gieX2665emfiZg3QY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jong Hyun Park <park.jonghyun@yonsei.ac.kr>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 113/124] x86/hyper-v: Fix overflow bug in fill_gva_list()
Date:   Fri, 20 Sep 2019 00:03:21 +0200
Message-Id: <20190919214823.298130011@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

[ Upstream commit 4030b4c585c41eeefec7bd20ce3d0e100a0f2e4d ]

When the 'start' parameter is >=  0xFF000000 on 32-bit
systems, or >= 0xFFFFFFFF'FF000000 on 64-bit systems,
fill_gva_list() gets into an infinite loop.

With such inputs, 'cur' overflows after adding HV_TLB_FLUSH_UNIT
and always compares as less than end.  Memory is filled with
guest virtual addresses until the system crashes.

Fix this by never incrementing 'cur' to be larger than 'end'.

Reported-by: Jong Hyun Park <park.jonghyun@yonsei.ac.kr>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 2ffd9e33ce4a ("x86/hyper-v: Use hypercall for remote TLB flush")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/mmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index e65d7fe6489f3..5208ba49c89a9 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -37,12 +37,14 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 		 * Lower 12 bits encode the number of additional
 		 * pages to flush (in addition to the 'cur' page).
 		 */
-		if (diff >= HV_TLB_FLUSH_UNIT)
+		if (diff >= HV_TLB_FLUSH_UNIT) {
 			gva_list[gva_n] |= ~PAGE_MASK;
-		else if (diff)
+			cur += HV_TLB_FLUSH_UNIT;
+		}  else if (diff) {
 			gva_list[gva_n] |= (diff - 1) >> PAGE_SHIFT;
+			cur = end;
+		}
 
-		cur += HV_TLB_FLUSH_UNIT;
 		gva_n++;
 
 	} while (cur < end);
-- 
2.20.1



