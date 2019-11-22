Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C07C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040C620409
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404013;
	bh=Ql9x8nBLRruSTrj/axpdo25m6wC+H80WPeR0h+hYPu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjqILBoSNZ3Qi2FEISDXvE6bw+CatcxEqi8s5iMUXgx2Rrt8kCN9HLEqdRSbE21GY
	 N3Nh8fT62WHbEGIh8hNENxHsA/6JNt9RBK4VK3DC5Ar4Yp/v0X/8PBqxU7fLG6i/+y
	 6YLFU04KBswzl+//at0RyA+bRKjUpwzaLAwyBYQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfKVG0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbfKVFuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0950C2071C;
        Fri, 22 Nov 2019 05:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401839;
        bh=Ql9x8nBLRruSTrj/axpdo25m6wC+H80WPeR0h+hYPu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fa8IE+auH7bNqpDrTWeyFOq3CyzulDLsTcGjS/A5nsP8Wkg1yzHNeMEljkb/Zfwu3
         FY7J0KsmR5RsiqNhE9kGjK+spJFxUJw7fK/pNbDjWJU/xijMji3wQv98IyaE08io5M
         fiS2sL3klxqWZ1U82IMX8nPhnN6hdQll835Kg84I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrea Righi <righi.andrea@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>, xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 4.19 080/219] kprobes/x86/xen: blacklist non-attachable xen interrupt functions
Date:   Fri, 22 Nov 2019 00:46:52 -0500
Message-Id: <20191122054911.1750-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Righi <righi.andrea@gmail.com>

[ Upstream commit bf9445a33ae6ac2f0822d2f1ce1365408387d568 ]

Blacklist symbols in Xen probe-prohibited areas, so that user can see
these prohibited symbols in debugfs.

See also: a50480cb6d61.

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/xen-asm_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 3a6feed76dfc1..a93d8a7cef26c 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -12,6 +12,7 @@
 #include <asm/segment.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
+#include <asm/asm.h>
 
 #include <xen/interface/xen.h>
 
@@ -24,6 +25,7 @@ ENTRY(xen_\name)
 	pop %r11
 	jmp  \name
 END(xen_\name)
+_ASM_NOKPROBE(xen_\name)
 .endm
 
 xen_pv_trap divide_error
-- 
2.20.1

