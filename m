Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D3EC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92362187F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561610854;
	bh=ee2Mq/h/NzrSn+b/TDwwROThTXdyfId0zMmsuBEqsMU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UdOGNIe+s18pMAT8Q1E8QPdvbNywkTK9V0XS2mGTq8Ro6rOjNU4koGPWvfL9ZOymQ
	 RXert2nozHL56DvOm6HzW5OATiGhveH2wswrKyReyssEkwYZitP9Qffi28MIbfNeqp
	 BfOgPBmAt2H/cM/gAFok+9HcEcKNZIEHHOUGG/9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfF0Erd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 00:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0Erd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:47:33 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906C421855;
        Thu, 27 Jun 2019 04:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561610852;
        bh=ee2Mq/h/NzrSn+b/TDwwROThTXdyfId0zMmsuBEqsMU=;
        h=From:To:Cc:Subject:Date:From;
        b=Zc4eXXrCC+my0ISOPpsD7SHbwK4BXOHry6fuWv+QzJmA6E5k0q37IYowiw7w3iRlj
         3WwcSJJ3XONzRL8zvUCluuh9GGE93md4NJt+0WpPuYMkACU9z1R9jW4eIe8BRfuT0L
         fo2hfanS8R3FoK3oUJrGErGCyFUaaUdA8XeLL7Uo=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] mm/gup: Remove some BUG_ONs from get_gate_page()
Date:   Wed, 26 Jun 2019 21:47:30 -0700
Message-Id: <a1d9f4efb75b9d464e59fd6af00104b21c58f6f7.1561610798.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we end up without a PGD or PUD entry backing the gate area, don't
BUG -- just fail gracefully.

It's not entirely implausible that this could happen some day on
x86.  It doesn't right now even with an execute-only emulated
vsyscall page because the fixmap shares the PUD, but the core mm
code shouldn't rely on that particular detail to avoid OOPSing.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 mm/gup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097cf9e4..9883b598fd6f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -585,11 +585,14 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 		pgd = pgd_offset_k(address);
 	else
 		pgd = pgd_offset_gate(mm, address);
-	BUG_ON(pgd_none(*pgd));
+	if (pgd_none(*pgd))
+		return -EFAULT;
 	p4d = p4d_offset(pgd, address);
-	BUG_ON(p4d_none(*p4d));
+	if (p4d_none(*p4d))
+		return -EFAULT;
 	pud = pud_offset(p4d, address);
-	BUG_ON(pud_none(*pud));
+	if (pud_none(*pud))
+		return -EFAULT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return -EFAULT;
-- 
2.21.0

