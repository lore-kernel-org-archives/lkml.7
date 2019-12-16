Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C7DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3197220717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520419;
	bh=0m+v6H9Fd21s2brOZh9gxKLQOaqwQ5KrQ0ayV+iB150=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JiJhy29C+y3T+0IxM1H2gGst/9xKIhOsdxC3y/qbqjBlw1y8QBjJbzg2DjpTfwMGY
	 NNTNH7ioS/OAY1cGKk6/LT+8F3JZHqFH+YIJwTyNvNGqKq1wGvG4lB63xlZO7AdSYc
	 Q5zgCY/dzIs1c7Q+nO4gJ946S3T5drWqQcA2W7Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfLPSUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfLPSUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:20:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B7320717;
        Mon, 16 Dec 2019 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520415;
        bh=0m+v6H9Fd21s2brOZh9gxKLQOaqwQ5KrQ0ayV+iB150=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpN/kpAFW8AucpKv6u/MXX5AKzJUPjqnC9v6bdSDMpD7cLaboPqjb9RGQoe5HtvoR
         BPhj6bllmcxiVp4/e4B04jqSQ/q4BZ5j90EAN5HHMEw4i7+JyksrAahmst19aiAShR
         yEVekn4IyXVVPiA69v7QERCgwT399KWUI/5mkyEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alastair DSilva <alastair@d-silva.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 146/177] powerpc: Allow flush_icache_range to work across ranges >4GB
Date:   Mon, 16 Dec 2019 18:50:02 +0100
Message-Id: <20191216174847.361689471@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

commit 29430fae82073d39b1b881a3cd507416a56a363f upstream.

When calling flush_icache_range with a size >4GB, we were masking
off the upper 32 bits, so we would incorrectly flush a range smaller
than intended.

This patch replaces the 32 bit shifts with 64 bit ones, so that
the full size is accounted for.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191104023305.9581-2-alastair@au1.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/misc_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -82,7 +82,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_I
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
 	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of cache block size */
-	srw.	r8,r8,r9		/* compute line count */
+	srd.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	mtctr	r8
 1:	dcbst	0,r6
@@ -98,7 +98,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_I
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5
 	lwz	r9,ICACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of Icache block size */
-	srw.	r8,r8,r9		/* compute line count */
+	srd.	r8,r8,r9		/* compute line count */
 	beqlr				/* nothing to do? */
 	mtctr	r8
 2:	icbi	0,r6


