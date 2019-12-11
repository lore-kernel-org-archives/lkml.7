Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F3020663
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077318;
	bh=2PlYeuMl+pQ40hi98kVKuffiABfW5E7NEm5+J9Tr5AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xYdma78eB2ebDSsoR/4ub8bLS4khPyRbak87YmXMLJ3qca1NltTgXuxAoHOcbsmQ4
	 q/2KFtQ5QoRRWTRzOdjZV/YJJr6pmWVBuAt+mB79F0SEbl4SgNGg82pyQMxE5xafkY
	 EH1BnJBhZHSl2CUkBn7rgrR8xH84PBdI/ocoGEfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfLKPPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731585AbfLKPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3AC2465C;
        Wed, 11 Dec 2019 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077249;
        bh=2PlYeuMl+pQ40hi98kVKuffiABfW5E7NEm5+J9Tr5AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmF3eJKV6BYJLol+9VqodH0Zng/d6vw+BnVPJeP1HDyezFxTCuCQWV3f6hW+VklX5
         cGsE/tOiAu2Y+GLEskBE+mm7qN0gOw1iNr3MVvk5/cxPxZzxyCTXii1/22jorYW6fl
         YfWzW0tlYMHcJ4hhayXBw/ZRGRYoicQ2xcDG56U8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 126/134] s390/unwind: filter out unreliable bogus %r14
Date:   Wed, 11 Dec 2019 10:11:42 -0500
Message-Id: <20191211151150.19073-126-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit bf018ee644897d7982e1b8dd8b15e97db6e1a4da ]

Currently unwinder unconditionally returns %r14 from the first frame
pointed by %r15 from pt_regs. A task could be interrupted when a function
already allocated this frame (if it needs it) for its callees or to
store local variables. In that case this frame would contain random
values from stack or values stored there by a callee. As we are only
interested in %r14 to get potential return address, skip bogus return
addresses which doesn't belong to kernel text.

This helps to avoid duplicating filtering logic in unwider users, most
of which use unwind_get_return_address() and would choke on bogus 0
address returned by it otherwise.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/unwind_bc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.c
index a8204f952315d..6e609b13c0cec 100644
--- a/arch/s390/kernel/unwind_bc.c
+++ b/arch/s390/kernel/unwind_bc.c
@@ -60,6 +60,11 @@ bool unwind_next_frame(struct unwind_state *state)
 		ip = READ_ONCE_NOCHECK(sf->gprs[8]);
 		reliable = false;
 		regs = NULL;
+		if (!__kernel_text_address(ip)) {
+			/* skip bogus %r14 */
+			state->regs = NULL;
+			return unwind_next_frame(state);
+		}
 	} else {
 		sf = (struct stack_frame *) state->sp;
 		sp = READ_ONCE_NOCHECK(sf->back_chain);
-- 
2.20.1

