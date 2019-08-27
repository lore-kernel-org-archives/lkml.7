Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D78CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE292173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893278;
	bh=dwOkGa4skEce3Rb+ErAgW4rMp+8999ceDJaADA8L/kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0GyQiX8oMaRHtCy3+rgmZC86tz9FKvvqdHxmdSD2EgAxquvq8+r0zp5qP2qBX3nP
	 F+YRNF2vL2PDQHqpcGBP4Vu/qJIvjjFwfVf3vMxdjwkidLlLPfnSaUTPRfqenBP796
	 m6Yntw2SpQhgf/q7A0akNuoz3CKh74IuNvgTE3EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbfH0IH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732751AbfH0IGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:06:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB872173E;
        Tue, 27 Aug 2019 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893212;
        bh=dwOkGa4skEce3Rb+ErAgW4rMp+8999ceDJaADA8L/kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCLlvgRFXvmFV3eugjHASDVFYVPT0GczoSpJepM7cm+SEq8HXIAJ6AgBrzoQDkPYA
         KZg+8Ap1PVUAI7mSwWXb+Wd9nD8DpJ8myWOiD+nGNz6x8Ydf3unFe2qOzjXg/+v28J
         npKqZyV4TAdH4khhKfzSsnyOPZe5ijUyRTCdtAjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, alastair@d-silva.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.2 160/162] powerpc: Allow flush_(inval_)dcache_range to work across ranges >4GB
Date:   Tue, 27 Aug 2019 09:51:28 +0200
Message-Id: <20190827072744.406948686@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Alastair D'Silva <alastair@d-silva.org>

The upstream commit:
22e9c88d486a ("powerpc/64: reuse PPC32 static inline flush_dcache_range()")
has a similar effect, but since it is a rewrite of the assembler to C, is
too invasive for stable. This patch is a minimal fix to address the issue in
assembler.

This patch applies cleanly to v5.2, v4.19 & v4.14.

When calling flush_(inval_)dcache_range with a size >4GB, we were masking
off the upper 32 bits, so we would incorrectly flush a range smaller
than intended.

This patch replaces the 32 bit shifts with 64 bit ones, so that
the full size is accounted for.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/misc_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -130,7 +130,7 @@ _GLOBAL_TOC(flush_dcache_range)
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
 	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of dcache block size */
-	srw.	r8,r8,r9		/* compute line count */
+	srd.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	mtctr	r8
 0:	dcbst	0,r6
@@ -148,7 +148,7 @@ _GLOBAL(flush_inval_dcache_range)
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
 	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)/* Get log-2 of dcache block size */
-	srw.	r8,r8,r9		/* compute line count */
+	srd.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	sync
 	isync


