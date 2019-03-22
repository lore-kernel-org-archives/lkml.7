Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF73FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7CE2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257720;
	bh=8iRjdkPoULPbbnqHkLjnfjzYLmrTlF1EWn3ugggg6Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0L1Um6808KeJxsKKxhWmatgn1w6vmhRNKNEkK8iDXyQRv9qO0pvnQ14beNBVW3C9
	 qwAquVeWKwwZ0gSWPzRC98DX5U5pfJRigYosclcpBylO07knNJZ/jVDEPZ3R2iA94M
	 YxCvki2tVqEkAHK1bAtvd6ysgeifYMA8IuPtp0po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390835AbfCVM2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390579AbfCVMU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:20:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D46218A1;
        Fri, 22 Mar 2019 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257226;
        bh=8iRjdkPoULPbbnqHkLjnfjzYLmrTlF1EWn3ugggg6Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DIVKbbr0vdNXgUWbbuXEZubCLjHMiQzhNom8vKuBf5IJ7gVsrpajgKwpcpgK6F0+
         RtH8wNC3cLw6DBO60MfRvy4jouXVhPytIg9nn7nfatA5vPi7PaWQdvNQdf0ESVCqiw
         JwJQkkmJWmHLdR9nFPI8defknjDpLB/8DNWxns84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 169/238] powerpc/traps: Fix the message printed when stack overflows
Date:   Fri, 22 Mar 2019 12:16:28 +0100
Message-Id: <20190322111308.261467624@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 9bf3d3c4e4fd82c7174f4856df372ab2a71005b9 upstream.

Today's message is useless:

  [   42.253267] Kernel stack overflow in process (ptrval), r1=c65500b0

This patch fixes it:

  [   66.905235] Kernel stack overflow in process sh[356], r1=c65560b0

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Use task_pid_nr()]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/traps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1542,8 +1542,8 @@ bail:
 
 void StackOverflow(struct pt_regs *regs)
 {
-	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
-	       current, regs->gpr[1]);
+	pr_crit("Kernel stack overflow in process %s[%d], r1=%lx\n",
+		current->comm, task_pid_nr(current), regs->gpr[1]);
 	debugger(regs);
 	show_regs(regs);
 	panic("kernel stack overflow");


