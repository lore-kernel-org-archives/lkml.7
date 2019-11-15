Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59992C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B692053B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798989;
	bh=c+L6FNSbEbluDnQBJNCYdxJd5Y4TDhx5J6OUqGg7FPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b01pnog+O/SHM90+7tfePVK8oCpB4pJ4uO1nKQLKHsp/8sVDQSs5dSL1FQvObC65B
	 J73tmMX2C0In0N8OLL9WMM6p4tQZdaqVuPwreowznTpN6prSvLZ5HTNSEZUcVkRJAz
	 dY3ktNzFJGTLMgUbtVsBiG0+O02wMFVi8oY9pz/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfKOGXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfKOGXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:23:02 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F21220740;
        Fri, 15 Nov 2019 06:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798982;
        bh=c+L6FNSbEbluDnQBJNCYdxJd5Y4TDhx5J6OUqGg7FPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDauLwXCwEuxABCbkAyoju4t509Mb2Q7iDX2uDuIif1TW/ZPvvqAn0pfyMlkhMLFt
         RGa2sX/vtRFoqeGkX5M5oLFdaaoG4Ag/NWFZkHFpPa6Nk7NdoNcyGf3UDQv+Hy0tbX
         NOSmbIvLUve7MH8G+AtB1KKApkDrZYrO2tgrYGYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 23/31] KVM: x86: Add is_executable_pte()
Date:   Fri, 15 Nov 2019 14:20:52 +0800
Message-Id: <20191115062018.378810254@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

Extracted from commit d3e328f2cb01 "kvm: x86: mmu: Verify that
restored PTE has needed perms in fast page fault".

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -338,6 +338,11 @@ static int is_last_spte(u64 pte, int lev
 	return 0;
 }
 
+static bool is_executable_pte(u64 spte)
+{
+	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
+}
+
 static kvm_pfn_t spte_to_pfn(u64 pte)
 {
 	return (pte & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;


