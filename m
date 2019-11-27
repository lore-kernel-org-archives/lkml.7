Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15765C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF3821556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889177;
	bh=zBhu2+KdYMb3Yub8SsyOlnjWpHgy8s+5nopaN6TD0kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HPB/9rZCg+eY6B/DdybZix5ySceKMWa6HsgmPk2epZWojKLmw/wFxHy/2fIShxh74
	 +r1yrBzT69aavFeUrfhvR5THMTu+UZYfgJTGSculjMvjQ4v3BnxM0WKnnWI3VS7yb9
	 PimFbtaBq1KJ+hGruFESN4OIQHcQaovFkhswEqr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbfK0VM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:12:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733307AbfK0VMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:12:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37222178F;
        Wed, 27 Nov 2019 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889171;
        bh=zBhu2+KdYMb3Yub8SsyOlnjWpHgy8s+5nopaN6TD0kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvXKbpZ9CAsA646dmObeOb7ZSei05LXFU29v/Xuv1soHAJyll2Ant59EIacQHO0s9
         qnRntJcYrU1VPXTJfwudUA7RlWvtVpc3LsJcRwWZ+0qlQNPr8PisNGBfBeNKQYhbv8
         TpQRjNtsPKAASPk83wKNZFtWmHi4bDum3lLcLDbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org
Subject: [PATCH 5.4 16/66] x86/doublefault/32: Fix stack canaries in the double fault handler
Date:   Wed, 27 Nov 2019 21:32:11 +0100
Message-Id: <20191127202651.983020622@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202632.536277063@linuxfoundation.org>
References: <20191127202632.536277063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit 3580d0b29cab08483f84a16ce6a1151a1013695f upstream.

The double fault TSS was missing GS setup, which is needed for stack
canaries to work.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/doublefault.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/doublefault.c
+++ b/arch/x86/kernel/doublefault.c
@@ -65,6 +65,9 @@ struct x86_hw_tss doublefault_tss __cach
 	.ss		= __KERNEL_DS,
 	.ds		= __USER_DS,
 	.fs		= __KERNEL_PERCPU,
+#ifndef CONFIG_X86_32_LAZY_GS
+	.gs		= __KERNEL_STACK_CANARY,
+#endif
 
 	.__cr3		= __pa_nodebug(swapper_pg_dir),
 };


