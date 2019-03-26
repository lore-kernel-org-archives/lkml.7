Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B36C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73CA20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582345;
	bh=e6i2jCMXun9qMo/nQ5cXNw/iQrVXnj9mi1DMu1Irfr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tIC3oC7tsPdfsQ5e1DHtbXL0L+NhzlSGMlMfrhXTbnSUK1hSUPG+2IXdRfLyPg2LF
	 F7Ob1YZAcG0pk7Tb/jN4Bk1ywu923nmnMhioJyRBHiVGyhWE0K1K/t0rKa/QUo4uES
	 bd3TaL/mM/d2GGNm5iygiJok4gbnajPaBWLT6mfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfCZGjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732620AbfCZGjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:01 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE3520879;
        Tue, 26 Mar 2019 06:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582341;
        bh=e6i2jCMXun9qMo/nQ5cXNw/iQrVXnj9mi1DMu1Irfr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFdXdZ3lSoyxHIGn1weHf7nZn6uS9AeirUpdmSJ+cv7YekFq78njLnPvIDnG+VscN
         YS3jDu3Zf+/mryDtLftKoCvffESHBTJVJb35t0MY1S+VFssJ9aG61aYC/HfxfUE5+Y
         IqI8hcaawg4qQTX2P24wsIIzlBJyVK/O6qa4/XUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH 5.0 18/52] powerpc/security: Fix spectre_v2 reporting
Date:   Tue, 26 Mar 2019 15:30:05 +0900
Message-Id: <20190326042701.828130213@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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
@@ -190,29 +190,22 @@ ssize_t cpu_show_spectre_v2(struct devic
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


