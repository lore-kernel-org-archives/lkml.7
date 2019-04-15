Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94562C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FDC218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355557;
	bh=Qp5m+y5f4JqSzO5Ap/rSF/9E2Y4DP0dE6YDjItcgY9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JxyFxfqQKf7RwuAtU3hQfEQoifmxBnSsY/pJMtQetWo8Clt4BPhfWifYZIYZkak6g
	 yTuqegS4GxALd3hQqOz5FaGs99YvNvXuj1ar6WG8yaZBTfNRfkoClEq5szkl+ZZ4ad
	 F1mZbeXb2HRjFfGWpz3DCs5k4GfhMYCAnBqSlsMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfDOTMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731415AbfDOTMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDD86218FE;
        Mon, 15 Apr 2019 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355552;
        bh=Qp5m+y5f4JqSzO5Ap/rSF/9E2Y4DP0dE6YDjItcgY9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDiidjNS3ONtxXs1Zr00pDuAVfhB6zlGaU3x7uM/gUA+hNI4VNxMkCYN+o6uqxiJB
         0u1hyfFBEOQhjSrlftMwF3YkRqMPVL6HWKHX8Ic6trW+0b2sY0d5I27SzzImqHOAoK
         vov6T9DcxRt1UrTaCo2FL57RqctdJ8d11IqtGEt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.0 063/117] parisc: regs_return_value() should return gpr28
Date:   Mon, 15 Apr 2019 21:00:33 +0200
Message-Id: <20190415183748.146578844@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@stackframe.org>

commit 45efd871bf0a47648f119d1b41467f70484de5bc upstream.

While working on kretprobes for PA-RISC I was wondering while the
kprobes sanity test always fails on kretprobes. This is caused by
returning gpr20 instead of gpr28.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/ptrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/parisc/include/asm/ptrace.h
+++ b/arch/parisc/include/asm/ptrace.h
@@ -22,7 +22,7 @@ unsigned long profile_pc(struct pt_regs
 
 static inline unsigned long regs_return_value(struct pt_regs *regs)
 {
-	return regs->gr[20];
+	return regs->gr[28];
 }
 
 static inline void instruction_pointer_set(struct pt_regs *regs,


