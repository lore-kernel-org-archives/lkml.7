Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE36C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8C120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354994;
	bh=MBQXCTXMfSuX6BsaubJcXwuG1ldzX//Oq/c7ffeG/Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FLoGizapSv6knBflRiWk3Er9Hqi1gb2ErCJY1Ti27lGBN9pkoGIBj1QvJwi8xhkEj
	 dPg9kw4DA21DwNIaj/qXF6Cc/WxwbKDCT2mh96EYIdb+LDPKgY72G5SZaWZY6vKxGO
	 tD9phO4tea/1L7QcxB7qm3ndu8XTidt+03IJjqQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfDOTDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbfDOTDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D641020880;
        Mon, 15 Apr 2019 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354990;
        bh=MBQXCTXMfSuX6BsaubJcXwuG1ldzX//Oq/c7ffeG/Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0jDjjmoVGblMTdKSfdN9K6RP1/6RA78SWSfEDFP9n26OFIRUY6loD0uhwMl/PiIy
         h/+u4NrRNa1tizHkwZ06YQnomaZ4aQxg6BzN24x9O4lkfmOHW0QeeQX9imRiqPV5ce
         n20vGBUEJskpf0tzqplwEtnto0qawczk4XzCa65Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.14 41/69] parisc: regs_return_value() should return gpr28
Date:   Mon, 15 Apr 2019 20:58:59 +0200
Message-Id: <20190415183732.777623370@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
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
 
 #endif


