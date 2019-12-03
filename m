Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F5C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B86020803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412656;
	bh=bbv4kIv0JEg2XdqcHA1mlb5X4tvo2jsrDB0t8sD3azE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V3Ah4x+D2OfppjhSyiqgzXCeoPPdYkM97OE4lItF8q+zGQUmwXWdp25FdmJMyTrPA
	 A3X1GBo9aMUTTgAJ+21p92ZHgI4Ec4rRU/f6prMn7FVQHv3qpLR/CR92/r2C3NZIJV
	 VkiOEHdCSscw0/HqYK4I7fMP8LqURhqXtDkwXpNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfLCWhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfLCWhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:37:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC162073C;
        Tue,  3 Dec 2019 22:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412650;
        bh=bbv4kIv0JEg2XdqcHA1mlb5X4tvo2jsrDB0t8sD3azE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqrwwWzuyV3i/miRhjReZh5tdtyehjQWD75dBZEp+m7XV9i0siJPuP1fawYzXZMaD
         yy0kq9bJ6Egp+Ie64odMfacN4XUbkyppkz4JrZB/VkF759r4Xqdt7p3DvAr3hLUN3R
         Z6M1Yd/xtjulcGrKjbhsUyN2LfDRLFkM/6n1u86k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 04/46] crypto: inside-secure - Fix stability issue with Macchiatobin
Date:   Tue,  3 Dec 2019 23:35:24 +0100
Message-Id: <20191203212714.413552019@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pascal van Leeuwen <pascalvanl@gmail.com>

commit b8c5d882c8334d05754b69dcdf1cfd6bc48a9e12 upstream.

This patch corrects an error in the Transform Record Cache initialization
code that was causing intermittent stability problems on the Macchiatobin
board.

Unfortunately, due to HW platform specifics, the problem could not happen
on the main development platform, being the VCU118 Xilinx development
board. And since it was a problem with hash table access, it was very
dependent on the actual physical context record DMA buffers being used,
i.e. with some (bad) luck it could seemingly work quit stable for a while.

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/inside-secure/safexcel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -221,9 +221,9 @@ static void eip197_trc_cache_init(struct
 	/* Step #3: Determine log2 of hash table size */
 	cs_ht_sz = __fls(asize - cs_rc_max) - 2;
 	/* Step #4: determine current size of hash table in dwords */
-	cs_ht_wc = 16<<cs_ht_sz; /* dwords, not admin words */
+	cs_ht_wc = 16 << cs_ht_sz; /* dwords, not admin words */
 	/* Step #5: add back excess words and see if we can fit more records */
-	cs_rc_max = min_t(uint, cs_rc_abs_max, asize - (cs_ht_wc >> 4));
+	cs_rc_max = min_t(uint, cs_rc_abs_max, asize - (cs_ht_wc >> 2));
 
 	/* Clear the cache RAMs */
 	eip197_trc_cache_clear(priv, cs_rc_max, cs_ht_wc);


