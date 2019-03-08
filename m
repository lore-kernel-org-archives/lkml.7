Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F786C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F202087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049811;
	bh=Jucgem0i9WwQ18f9bEjIqwv2MyPRPKxHVFB4Lz8xAoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yuvnkaNbcbVyYxpWzAa8vMlvl1f1uPMOEL1kiUTK1QSYq7A48EJfUV258yPOiUENn
	 dJoZVOUkevNKCWEsHDxwONy/PlqazQ1RH2RKHhBhcDXN1V7bYPJGNtXyZt1Ee6sX5r
	 gEhhmCqiy/Oa02+OR0HvaxyBAl+MWQ1VgG6hfO6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCHM4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfCHM4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:56:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB1621019;
        Fri,  8 Mar 2019 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049805;
        bh=Jucgem0i9WwQ18f9bEjIqwv2MyPRPKxHVFB4Lz8xAoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/lhgT0j7nIgJF7rot8wkdfnzMV3AZliPtQMk5LE2+/bDu66sjiREiUCV88Fy+zve
         Ten4eDx/JFDVo7OCEZRdfjSG9bRJTkY8TTNyteZxNoKoVIa95fcDU6069ai2+bY2ms
         Dy5cMKElPHizKTGHaDNfRDiXnbw38TzyXRPMqGMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.20 68/76] xtensa: fix get_wchan
Date:   Fri,  8 Mar 2019 13:50:20 +0100
Message-Id: <20190308124917.202790656@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit d90b88fd3653f1fb66ecc6571b860d5a5749fa56 upstream.

Stack unwinding is implemented incorrectly in xtensa get_wchan: instead
of extracting a0 and a1 registers from the spill location under the
stack pointer it extracts a word pointed to by the stack pointer and
subtracts 4 or 3 from it.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/process.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -320,8 +320,8 @@ unsigned long get_wchan(struct task_stru
 
 		/* Stack layout: sp-4: ra, sp-3: sp' */
 
-		pc = MAKE_PC_FROM_RA(*(unsigned long*)sp - 4, sp);
-		sp = *(unsigned long *)sp - 3;
+		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), sp);
+		sp = SPILL_SLOT(sp, 1);
 	} while (count++ < 16);
 	return 0;
 }


