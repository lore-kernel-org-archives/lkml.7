Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD598C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AF420836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688075;
	bh=gEjvsT8BlNK4m4KopsRBifCMh7l9JuUI0IKVOWHArd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T61r5CxRYuKC3jQXN/bBTc0xtkKUxG2akDogo/eQj7NYn5GYBi7qm9zYuzc+F0xSq
	 MIDR4S8sJu+s+qa1JN84jBxgXrnI9Lkpe3bU0scBS+do2Ji2lV0XvTK0VM/6rXypF8
	 okyVMkioYmL0D0Yr56QL953gA6H4W4vwGg1UKeUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfCDI1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfCDI1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:27:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A62B20823;
        Mon,  4 Mar 2019 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688069;
        bh=gEjvsT8BlNK4m4KopsRBifCMh7l9JuUI0IKVOWHArd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSr8kFX235M1EnL26jWcXTd4zvhgCilG2Njl0S6a4df3EQ0iXm78T1bE8E3Wvg885
         u61oKaALPKmTGgRUs5jCrsyQEh0J/NL6ZYpeGksLzAEaiMZgwnJxaBsRVLQRkfYFIp
         S/GjuDrrs5BeBmWa4ep+ZPb72vMGdXph8VesVl/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "A. Wilcox" <awilfox@adelielinux.org>
Subject: [PATCH 4.14 44/52] powerpc: Always initialize input array when calling epapr_hypercall()
Date:   Mon,  4 Mar 2019 09:22:42 +0100
Message-Id: <20190304081619.650866477@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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


