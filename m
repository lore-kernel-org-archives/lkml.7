Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7C4C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91BB205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483836;
	bh=Ql9x8nBLRruSTrj/axpdo25m6wC+H80WPeR0h+hYPu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DlShAoPM655jGU2mvt6bASqKeireLMGEushHdPmwu+JTNBOsjJu0BB2OBrLAF1rYi
	 faGpqvV8i8pH295D0jczwjVbXZHHoW9xK9tT28NRgUVtY2P9ggx9wosBzEryP/0qQH
	 6xCU3xvAGbDCQd+4ZQQwd98RKZx41KLUspK7r/bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfLDSXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbfLDSDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:03:25 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1504820675;
        Wed,  4 Dec 2019 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482604;
        bh=Ql9x8nBLRruSTrj/axpdo25m6wC+H80WPeR0h+hYPu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aS4IYgy4Pkwf6wRbD7V3m1CKW0mDmuMnuJomaq3261RmCOTNetn/AWw2nFuzTdHho
         QLS73GmfDIwEQO1xBk3DXeWer4/wAJTtvbtmx+/2q5h4fRhV8+a/jkQwXAYeMYXfkr
         oBkwFqq7eicvCKBU3q0o1dqJ20DW9qIbu7SslAcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Righi <righi.andrea@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/209] kprobes/x86/xen: blacklist non-attachable xen interrupt functions
Date:   Wed,  4 Dec 2019 18:54:35 +0100
Message-Id: <20191204175325.651022463@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



