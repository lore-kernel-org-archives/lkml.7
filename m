Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB25C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441F0222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782024;
	bh=CAsP/cz+uN6p3m+stKxFiBXB48v0Z5X4p7HEq9Umdws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAE7lBxvlg1UMXg7ijaugzX9u+VDtjXPP33+m5sK1MQZcAXtDcgaNFblYszTpQ2KE
	 6//hgyKj1D14UqhP4/Wpc7pAF/U76YSFu7wZZSkj9RbfbMi/Xtc6BRWqG1mN/09Q+T
	 Bh0SU2e+hdUC0DYD5i09iOF30xjLarsDYc4+zKaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfLSTAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730238AbfLSSwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:52:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06888227BF;
        Thu, 19 Dec 2019 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781532;
        bh=CAsP/cz+uN6p3m+stKxFiBXB48v0Z5X4p7HEq9Umdws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZugztOwSl+NStGeVDEY1AIQalLzKVqNNcXAUr+iks+RPUTEw7IJ3vQJqEyhl2ag0
         mIcKdKkuzi9JFzCXY5mn4qM+I1cuPI2OOKhe76elaGTzTeSeQhIWQ4+slIJAPQgkfw
         J82sO6ZxBrVc0KzPP/FBTiYXZHU8sTeZuDj8UHRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.19 23/47] xtensa: fix TLB sanity checker
Date:   Thu, 19 Dec 2019 19:34:37 +0100
Message-Id: <20191219182927.391060732@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182857.659088743@linuxfoundation.org>
References: <20191219182857.659088743@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit 36de10c4788efc6efe6ff9aa10d38cb7eea4c818 upstream.

Virtual and translated addresses retrieved by the xtensa TLB sanity
checker must be consistent, i.e. correspond to the same state of the
checked TLB entry. KASAN shadow memory is mapped dynamically using
auto-refill TLB entries and thus may change TLB state between the
virtual and translated address retrieval, resulting in false TLB
insanity report.
Move read_xtlb_translation close to read_xtlb_virtual to make sure that
read values are consistent.

Cc: stable@vger.kernel.org
Fixes: a99e07ee5e88 ("xtensa: check TLB sanity on return to userspace")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/mm/tlb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -216,6 +216,8 @@ static int check_tlb_entry(unsigned w, u
 	unsigned tlbidx = w | (e << PAGE_SHIFT);
 	unsigned r0 = dtlb ?
 		read_dtlb_virtual(tlbidx) : read_itlb_virtual(tlbidx);
+	unsigned r1 = dtlb ?
+		read_dtlb_translation(tlbidx) : read_itlb_translation(tlbidx);
 	unsigned vpn = (r0 & PAGE_MASK) | (e << PAGE_SHIFT);
 	unsigned pte = get_pte_for_vaddr(vpn);
 	unsigned mm_asid = (get_rasid_register() >> 8) & ASID_MASK;
@@ -231,8 +233,6 @@ static int check_tlb_entry(unsigned w, u
 	}
 
 	if (tlb_asid == mm_asid) {
-		unsigned r1 = dtlb ? read_dtlb_translation(tlbidx) :
-			read_itlb_translation(tlbidx);
 		if ((pte ^ r1) & PAGE_MASK) {
 			pr_err("%cTLB: way: %u, entry: %u, mapping: %08x->%08x, PTE: %08x\n",
 					dtlb ? 'D' : 'I', w, e, r0, r1, pte);


