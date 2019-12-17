Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FBC206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pq32bIRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfLQUMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:12:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfLQUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JrPNw1xqWhalZX2E4G40ImbRJBJbFB1eZ7m4nQw4xcs=; b=Pq32bIRDfVvgqHNTwuGZyEapY
        nVVq9FBbLHpryr/yI8F5sMrmHfHtMdS1i1yezfB7S7ZKuYJ3o2NBEvOcf8uK1wM/iReFrYd5qaCtV
        j2Q7TwOSDA0BigjmlWP7IO982wohwNUU5dIRGotFSUTzbyuq2fVs3uO7MNpsJxXGwTs34OdTg2gOm
        eUCJxvj652+cOrqzXSXrON9Jhqwb4DoXP3YiqDtBCb4XNujBt4VYkpPmViw5zMFmQ6OkVo5HeXJhg
        kJGBZxIEsb6Uf1QZ67lHvMfYrvwTFk+eJgM9b4Da3CMZ3OPdvNbxob87d3hILeGjSOwn3AQM502YW
        1AKOdEWNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihJCV-0003aT-Eo; Tue, 17 Dec 2019 20:12:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCF453066B3;
        Tue, 17 Dec 2019 21:10:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57B082B2B0509; Tue, 17 Dec 2019 21:12:08 +0100 (CET)
Date:   Tue, 17 Dec 2019 21:12:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>
Subject: [PATCH] asm-generic/tlb: Avoid potential double flush
Message-ID: <20191217201208.GQ2871@hirez.programming.kicks-ass.net>
References: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com>
 <20191217071713.93399-2-aneesh.kumar@linux.ibm.com>
 <20191217085854.GW2844@hirez.programming.kicks-ass.net>
 <32404765-ad4f-6612-d1a9-43f9acdc8a62@linux.ibm.com>
 <20191217123416.GH2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217123416.GH2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:34:16PM +0100, Peter Zijlstra wrote:
> Perhaps if we replace !tlb->end with something like:
> 
>   !tlb->freed_tables && !tlb->cleared_p*
> 
> (which GCC should be able to do with a single load and mask)
> 
> I've not really thought too hard about it yet, I need to run some
> errands, but I'll look at it more closely when I get back.

AFAICT this should work.

---
Subject: asm-generic/tlb: Avoid potential double flush

Aneesh reported that:

	tlb_flush_mmu()
	  tlb_flush_mmu_tlbonly()
	    tlb_flush()			<-- #1
	  tlb_flush_mmu_free()
	    tlb_table_flush()
	      tlb_table_invalidate()
	        tlb_flush_mmu_tlbonly()
		  tlb_flush()		<-- #2

does two TLBIs when tlb->fullmm, because __tlb_reset_range() will not
clear tlb->end in that case.

Observe that any caller to __tlb_adjust_range() also sets at least one
of the tlb->freed_tables || tlb->cleared_p* bits, and those are
unconditionally cleared by __tlb_reset_range().

Change the condition for actually issuing TLBI to having one of those
bits set, as opposed to having tlb->end != 0.

Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fe0ea6ff3636..c9a25c5a83e8 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -402,7 +402,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
-	if (!tlb->end)
+	/*
+	 * Anything calling __tlb_adjust_range() also sets at least one of
+	 * these bits.
+	 */
+	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
+	      tlb->cleared_puds || tlb->cleared_p4ds))
 		return;
 
 	tlb_flush(tlb);
