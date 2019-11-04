Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4387CCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220CA2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfKDRAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:00:32 -0500
Received: from mailscanner02.zoner.fi ([84.34.166.11]:45024 "EHLO
        mailscanner02.zoner.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:00:32 -0500
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 12:00:31 EST
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
        by mailscanner02.zoner.fi (Postfix) with ESMTPS id 3464240AB9;
        Mon,  4 Nov 2019 18:51:12 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
        by www25.zoner.fi with esmtp (Exim 4.92.3)
        (envelope-from <lasse.collin@tukaani.org>)
        id 1iRfZU-0003Ur-E0; Mon, 04 Nov 2019 18:51:16 +0200
Date:   Mon, 4 Nov 2019 18:51:07 +0200
From:   Lasse Collin <lasse.collin@tukaani.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, "Yu Sun (yusun2)" <yusun2@cisco.com>,
        "Yixia Si (yisi)" <yisi@cisco.com>
Subject: [PATCH] lib/xz: Fix XZ_DYNALLOC to avoid useless memory
 reallocations
Message-ID: <20191104185107.3b6330df@tukaani.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lasse Collin <lasse.collin@tukaani.org>

s->dict.allocated was initialized to 0 but never set after a successful
allocation, thus the code always thought that the dictionary buffer has
to be reallocated.

Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
Reported-by: Yu Sun <yusun2@cisco.com>
---

diff -Nrup linux-5.3-vanilla/lib/xz/xz_dec_lzma2.c linux-5.3/lib/xz/xz_dec_lzma2.c
--- linux-5.3-vanilla/lib/xz/xz_dec_lzma2.c	2019-09-16 00:19:32.000000000 +0300
+++ linux-5.3/lib/xz/xz_dec_lzma2.c	2019-10-30 20:33:15.460857851 +0200
@@ -1146,6 +1146,7 @@ XZ_EXTERN enum xz_ret xz_dec_lzma2_reset
 
 		if (DEC_IS_DYNALLOC(s->dict.mode)) {
 			if (s->dict.allocated < s->dict.size) {
+				s->dict.allocated = s->dict.size;
 				vfree(s->dict.buf);
 				s->dict.buf = vmalloc(s->dict.size);
 				if (s->dict.buf == NULL) {
