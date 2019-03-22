Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB56C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120CD20693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255620;
	bh=oIFGWsTkpXGts48RBjEXLGdKV0btrVxr6t6IHYuErcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTucjNoCAY6vDateh3RykSxLJO/A/KzZPtTUw+lLtksMfv2jLWlm6gZXqaYavRSeX
	 Zxq4UB4nGa/5+PkuuMVcSuKFYSRGMPBPIrzdLfX3HRnjoh5xzqqrFL45EETbFM0hBz
	 CxBDhXLWQvjfcwT4QSM/y2TvOBnlCc17GEuJgtBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbfCVLxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733052AbfCVLxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEEEB20693;
        Fri, 22 Mar 2019 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255615;
        bh=oIFGWsTkpXGts48RBjEXLGdKV0btrVxr6t6IHYuErcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=taGzrPvAborSalqxJ1qT4g0aUxCm10YvKPyy5ZeBqZeoJpJxZeb8iqeGxVNaH/yrT
         u7dmcXrTw7Qv/B1kX78hLgowK/T5rnktnujKkZOLq0lH32Ssmzt3OmTY2EyCPKvYla
         73SNQNdh8QmAYt86j7jxxDx5YrokZnQj2taiIN7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 145/183] powerpc/traps: fix recoverability of machine check handling on book3s/32
Date:   Fri, 22 Mar 2019 12:16:13 +0100
Message-Id: <20190322111252.309604010@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 0bbea75c476b77fa7d7811d6be911cc7583e640f upstream.

Looks like book3s/32 doesn't set RI on machine check, so
checking RI before calling die() will always be fatal
allthought this is not an issue in most cases.

Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
Fixes: daf00ae71dad ("powerpc/traps: restore recoverability of machine_check interrupts")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/traps.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -694,15 +694,15 @@ void machine_check_exception(struct pt_r
 	if (check_io_access(regs))
 		goto bail;
 
-	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
-		nmi_panic(regs, "Unrecoverable Machine check");
-
 	if (!nested)
 		nmi_exit();
 
 	die("Machine check", regs, SIGBUS);
 
+	/* Must die if the interrupt is not recoverable */
+	if (!(regs->msr & MSR_RI))
+		nmi_panic(regs, "Unrecoverable Machine check");
+
 	return;
 
 bail:


