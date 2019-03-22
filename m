Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE95EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD0520693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255623;
	bh=ic9yBBX2lWZfq43wNDlo6LfoqqWT+47XvcKAqLNgm64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vs3Ae8H0hwkg1pm8ngTkIwYaND2ut9mbIrg8k/L0+pE4DEJ9KYgyZl4+hIHeTV516
	 IoNIBs8IgB6QBH6sXyOGw1hRQF5qv5bFaw7EBi1ugHK6Jon6UhsCmVKgr2twPBJaAx
	 H3lsxwuVIYQ2rRNOKkncgFzOLkQcunX0iW4zk2Ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbfCVLxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732365AbfCVLxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44AF21939;
        Fri, 22 Mar 2019 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255618;
        bh=ic9yBBX2lWZfq43wNDlo6LfoqqWT+47XvcKAqLNgm64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fL3JyexhtNl31VR4n0qzpUZkGIQ5mRNlB6nhS6eyzaygH4EZ2Jnai0EzqU+dh4QhB
         ZjbB44KrCfXkiJrEjzkXWAK8gz3D82YYFtu7C1dicxhMUHwaZ8ZBo1ra6JER3VWnqb
         pkI3dY3eeRx9J/d5mh0yVEEF6vVi7SePlOd0659o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 146/183] powerpc/traps: Fix the message printed when stack overflows
Date:   Fri, 22 Mar 2019 12:16:14 +0100
Message-Id: <20190322111252.382851750@linuxfoundation.org>
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
@@ -1292,8 +1292,8 @@ void slb_miss_bad_addr(struct pt_regs *r
 
 void StackOverflow(struct pt_regs *regs)
 {
-	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
-	       current, regs->gpr[1]);
+	pr_crit("Kernel stack overflow in process %s[%d], r1=%lx\n",
+		current->comm, task_pid_nr(current), regs->gpr[1]);
 	debugger(regs);
 	show_regs(regs);
 	panic("kernel stack overflow");


