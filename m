Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18184C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14482086A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888802;
	bh=zBhu2+KdYMb3Yub8SsyOlnjWpHgy8s+5nopaN6TD0kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s2+Z6CHRV7R+X/l71PiUum57CK2PdTiGvTDdUU1dbd1awWrdXhIlCq0FAoYkRYOwb
	 McIbYYs6uS+jMMB16hxXn1IKkcV1Vbng1uvR9Onnm2wHQWiR56EgXlz+L7bvc6wWue
	 +RReLJ38sq1u83NS5PdEGuRZqOR1EVt32L701Lw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfK0VGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbfK0VGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:06:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A79121843;
        Wed, 27 Nov 2019 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888794;
        bh=zBhu2+KdYMb3Yub8SsyOlnjWpHgy8s+5nopaN6TD0kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y73nsRcdho1bkvi4Hx6fHZhnDHTyDVYSa9HhLqZKlRpaRBIE9BiXwO9UaY3+TB/N5
         d15NYYYL6jRm8+RpGo4YE1WhrH5bqDKM9kbZo5T/z/tXFgrN5ctjhEERUyF8dKSWHl
         xQbx8mKWP7Dc4K2ilsIj4TeytaLmnvtm21UxdiJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org
Subject: [PATCH 4.19 271/306] x86/doublefault/32: Fix stack canaries in the double fault handler
Date:   Wed, 27 Nov 2019 21:32:01 +0100
Message-Id: <20191127203134.623566738@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
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


