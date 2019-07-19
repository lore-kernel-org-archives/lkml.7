Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3021872
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509533;
	bh=dadbWTTfA+a9TyCYUTZpbI5C6fc9slr9cQtbHGDF6VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GKUetZnIRdCkfDAHAo1jMC9Amh4LbYP0BFb7lmad9DPKqUal4C8YOc8YnvlSctqlA
	 37A+YWb5Z72ysMU11EiGzmyXkniXOLWb2MeIajK9vzMjKaHbjSbCxjZl4PEn8wKxy5
	 84MHPTcqGA+Zh0hlI2+yYqtQJHhXeWNrMBdmDYCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfGSEML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388671AbfGSEMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:12:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086192189D;
        Fri, 19 Jul 2019 04:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509526;
        bh=dadbWTTfA+a9TyCYUTZpbI5C6fc9slr9cQtbHGDF6VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7q5MgMSAUcPTlTxqkkh9dzMlU3WULDrIb/gxK8tGqyiLlfMy4nn4GPNZcdfkpf4U
         nVwFzTt8HqGbovxKCH/Pj+dJxR7weV5w4bnk2Zm8pKks4yG97AzTgZFXiDG/RAC8AA
         lXKu3Sg6AufRqBp0gr82KnVf33C6X68J5riF90ZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 31/60] powerpc/xmon: Fix disabling tracing while in xmon
Date:   Fri, 19 Jul 2019 00:10:40 -0400
Message-Id: <20190719041109.18262-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041109.18262-1-sashal@kernel.org>
References: <20190719041109.18262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit aaf06665f7ea3ee9f9754e16c1a507a89f1de5b1 ]

Commit ed49f7fd6438d ("powerpc/xmon: Disable tracing when entering
xmon") added code to disable recording trace entries while in xmon. The
commit introduced a variable 'tracing_enabled' to record if tracing was
enabled on xmon entry, and used this to conditionally enable tracing
during exit from xmon.

However, we are not checking the value of 'fromipi' variable in
xmon_core() when setting 'tracing_enabled'. Due to this, when secondary
cpus enter xmon, they will see tracing as being disabled already and
tracing won't be re-enabled on exit. Fix the same.

Fixes: ed49f7fd6438d ("powerpc/xmon: Disable tracing when entering xmon")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index f752f771f29d..6b9038a3e79f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -465,8 +465,10 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	local_irq_save(flags);
 	hard_irq_disable();
 
-	tracing_enabled = tracing_is_on();
-	tracing_off();
+	if (!fromipi) {
+		tracing_enabled = tracing_is_on();
+		tracing_off();
+	}
 
 	bp = in_breakpoint_table(regs->nip, &offset);
 	if (bp != NULL) {
-- 
2.20.1

