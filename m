Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C83C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97608204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963269;
	bh=Zl/SdUUDIJr4Qb4gdRngfELW4MGeRxPUNwgbO9pkDKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sUPzNvoYGXGuOdrZ1WugrXEoV2IxQA+fE+SxL/CCpSJNS2kSI2DWXbfGCeYHoK12F
	 1H/BsDLlGeuE20o0hbOYuw8YEJHRylT/Ji3eDL8dDpUySWltI6U1eF1sIuyCcoW2+Y
	 zb8h1XTirIekPIA85Ks6wnB6Qno45P5VHwRR7Fuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfDVUBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbfDVTrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5961A21909;
        Mon, 22 Apr 2019 19:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962423;
        bh=Zl/SdUUDIJr4Qb4gdRngfELW4MGeRxPUNwgbO9pkDKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2EfAanzas8jQnHrnVePIbEr8whsiAhuC6rY42+tr+uC/JgRIO0kLVORWDOvRdu/j2
         BXLbhO4MOfqhsjvgdK1GRRbyEQ0wuTdfZUc5F3X55s4JPZ5B5NaXdncGm28ug0dFrt
         DmuJx8NMcH4vyLCtk1ECzNQAmZIurjGDD+P4XoSU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matteo Croce <mcroce@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 54/68] x86/realmode: Don't leak the trampoline kernel address
Date:   Mon, 22 Apr 2019 15:45:02 -0400
Message-Id: <20190422194516.11634-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit b929a500d68479163c48739d809cbf4c1335db6f ]

Since commit

  ad67b74d2469 ("printk: hash addresses printed with %p")

at boot "____ptrval____" is printed instead of the trampoline addresses:

  Base memory trampoline at [(____ptrval____)] 99000 size 24576

Remove the print as we don't want to leak kernel addresses and this
statement is not needed anymore.

Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190326203046.20787-1-mcroce@redhat.com
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/x86/realmode/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index d10105825d57..47d097946872 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -20,8 +20,6 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
 	void *base = __va(mem);
 
 	real_mode_header = (struct real_mode_header *) base;
-	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
-	       base, (unsigned long long)mem, size);
 }
 
 void __init reserve_real_mode(void)
-- 
2.19.1

