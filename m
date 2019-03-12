Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD969206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412480;
	bh=/IdeVm0/4542vrPuwrotFYem9go8EmNZytEV1a7lqxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wavcquVHgYYDR5Sag/6ptIf7vNYl+o6uAvI0d0JBLW2f3KJygTZ6XfgVrWNkMKzfb
	 6SXMArqZ2CNTYNCLRZou+JSoxXVxlqYEP7M34lTpFRBuBv7VxfxB+aZscgqN498Dk8
	 OMAWd2AIEea5weC1puVigKdGPmR0AzXu5qhP9aT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfCLRlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfCLRQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:06 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102AF21741;
        Tue, 12 Mar 2019 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410966;
        bh=/IdeVm0/4542vrPuwrotFYem9go8EmNZytEV1a7lqxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0R/u7dZcX4wHFt+p+zRdehK2fE2RS/iaTKsVQUS4Hhno6QTi/eF1PX4eFd3yDCJP
         lJJYm/wxNIt7bWQTmwt7LDd+JdGCWboQbeH8Z6WiBLlB6NSMDy8AXOr/Wx6iZdOgoe
         PF188z+mHW5INoCf87d2uSBZPTzVhMvXHVof4/BQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.14 039/135] xtensa: fix get_wchan
Date:   Tue, 12 Mar 2019 10:08:06 -0700
Message-Id: <20190312170344.703159139@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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
@@ -314,8 +314,8 @@ unsigned long get_wchan(struct task_stru
 
 		/* Stack layout: sp-4: ra, sp-3: sp' */
 
-		pc = MAKE_PC_FROM_RA(*(unsigned long*)sp - 4, sp);
-		sp = *(unsigned long *)sp - 3;
+		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), sp);
+		sp = SPILL_SLOT(sp, 1);
 	} while (count++ < 16);
 	return 0;
 }


