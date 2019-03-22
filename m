Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5056F20449
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254166;
	bh=tEDAn5NCBhkAPbUQMsBp/76lYB5vwoCsVdmee3mRqts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e0emQNH83WYD3gToS/eTZq7821zkNCpM6lg/KaaFzD58bowpe/Nv6471Bc5lPdkQ1
	 bWwp3u1Sn9ZxjiELK08iAJATN3gjtvBpJaFLqwUdLXP0OHDz+1bsU5P51aN68iauk2
	 rTYKBAd/DaxrW4ZHKG2ERFT1OVmsQgMTBWjn441g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfCVL3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfCVL3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6DC20449;
        Fri, 22 Mar 2019 11:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254162;
        bh=tEDAn5NCBhkAPbUQMsBp/76lYB5vwoCsVdmee3mRqts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2qZl5fU9PQ5aaiv+LBVVCDuJjj7GilTuaTiIccXb41c+fnyGWwnLqW+5UxPMKCVc
         fOGca3Y4rWOfAqI5TArstoWchru9WXOxo1dTYDSAh2JtxrisPIFOMP1nzcSlZlhDKN
         j3Kd4n8sL9CME2MDqA58VCFjHE8sDAeQE2TW3Nb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "A. Wilcox" <awilfox@adelielinux.org>
Subject: [PATCH 4.4 051/230] powerpc: Always initialize input array when calling epapr_hypercall()
Date:   Fri, 22 Mar 2019 12:13:09 +0100
Message-Id: <20190322111240.272958816@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seth Forshee <seth.forshee@canonical.com>

commit 186b8f1587c79c2fa04bfa392fdf084443e398c1 upstream.

Several callers to epapr_hypercall() pass an uninitialized stack
allocated array for the input arguments, presumably because they
have no input arguments. However this can produce errors like
this one

 arch/powerpc/include/asm/epapr_hcalls.h:470:42: error: 'in' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  unsigned long register r3 asm("r3") = in[0];
                                        ~~^~~

Fix callers to this function to always zero-initialize the input
arguments array to prevent this.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: "A. Wilcox" <awilfox@adelielinux.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/epapr_hcalls.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -508,7 +508,7 @@ static unsigned long epapr_hypercall(uns
 
 static inline long epapr_hypercall0_1(unsigned int nr, unsigned long *r2)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 	unsigned long r;
 
@@ -520,7 +520,7 @@ static inline long epapr_hypercall0_1(un
 
 static inline long epapr_hypercall0(unsigned int nr)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	return epapr_hypercall(in, out, nr);
@@ -528,7 +528,7 @@ static inline long epapr_hypercall0(unsi
 
 static inline long epapr_hypercall1(unsigned int nr, unsigned long p1)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	in[0] = p1;
@@ -538,7 +538,7 @@ static inline long epapr_hypercall1(unsi
 static inline long epapr_hypercall2(unsigned int nr, unsigned long p1,
 				    unsigned long p2)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	in[0] = p1;
@@ -549,7 +549,7 @@ static inline long epapr_hypercall2(unsi
 static inline long epapr_hypercall3(unsigned int nr, unsigned long p1,
 				    unsigned long p2, unsigned long p3)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	in[0] = p1;
@@ -562,7 +562,7 @@ static inline long epapr_hypercall4(unsi
 				    unsigned long p2, unsigned long p3,
 				    unsigned long p4)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	in[0] = p1;


