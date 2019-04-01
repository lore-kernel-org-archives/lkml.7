Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FF5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968DD206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139372;
	bh=EeLiKeyasPTnJtvs+o3NG8YvkitM+GWen6JX2rK4zIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DFIuq2EdSk2NCV33AfMc47mkUe5e0m5JCvUCqGCNPi+dW+bFxfVYl5C85+NMeKyb+
	 ylMn+4gWrJWNCHwDevyr5P7nsyRbNavEuwv+3p5GNi9h6VsP7bDiIhWaAUbfZCPnog
	 QN/O1uORqgUkEfmej2uGJpKjrH/oPEF4Icvla8Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfDARWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731595AbfDARWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:22:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87074206C0;
        Mon,  1 Apr 2019 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139365;
        bh=EeLiKeyasPTnJtvs+o3NG8YvkitM+GWen6JX2rK4zIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MI1lBmpYV7Pms3Pl8Ts6oFwTw/c/f+QP/U6hioDggj9E30IuEdhg/dxnYms+2Eh/w
         D+A/NVTx61JvKuLp3rfBIq619YMVzWocm2Q5RBtwKdTrOMFQFxgVRYRDj2IALi+l6k
         kgvGyO4O9yBewny6cnDl7ik7/GkOXniWYd9z1pWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH 4.14 055/107] powerpc/security: Fix spectre_v2 reporting
Date:   Mon,  1 Apr 2019 19:02:10 +0200
Message-Id: <20190401170050.774995185@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit 92edf8df0ff2ae86cc632eeca0e651fd8431d40d upstream.

When I updated the spectre_v2 reporting to handle software count cache
flush I got the logic wrong when there's no software count cache
enabled at all.

The result is that on systems with the software count cache flush
disabled we print:

  Mitigation: Indirect branch cache disabled, Software count cache flush

Which correctly indicates that the count cache is disabled, but
incorrectly says the software count cache flush is enabled.

The root of the problem is that we are trying to handle all
combinations of options. But we know now that we only expect to see
the software count cache flush enabled if the other options are false.

So split the two cases, which simplifies the logic and fixes the bug.
We were also missing a space before "(hardware accelerated)".

The result is we see one of:

  Mitigation: Indirect branch serialisation (kernel only)
  Mitigation: Indirect branch cache disabled
  Mitigation: Software count cache flush
  Mitigation: Software count cache flush (hardware accelerated)

Fixes: ee13cb249fab ("powerpc/64s: Add support for software count cache flush")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -189,29 +189,22 @@ ssize_t cpu_show_spectre_v2(struct devic
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
 
-	if (bcs || ccd || count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
-		bool comma = false;
+	if (bcs || ccd) {
 		seq_buf_printf(&s, "Mitigation: ");
 
-		if (bcs) {
+		if (bcs)
 			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
-			comma = true;
-		}
 
-		if (ccd) {
-			if (comma)
-				seq_buf_printf(&s, ", ");
-			seq_buf_printf(&s, "Indirect branch cache disabled");
-			comma = true;
-		}
-
-		if (comma)
+		if (bcs && ccd)
 			seq_buf_printf(&s, ", ");
 
-		seq_buf_printf(&s, "Software count cache flush");
+		if (ccd)
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+	} else if (count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
+		seq_buf_printf(&s, "Mitigation: Software count cache flush");
 
 		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
-			seq_buf_printf(&s, "(hardware accelerated)");
+			seq_buf_printf(&s, " (hardware accelerated)");
 	} else if (btb_flush_enabled) {
 		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
 	} else {


