Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7541FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4218D2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802574;
	bh=bMsK2oFPbruaZw4mTKjzxcr+KGodWlB7UpdOisVetwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0lIGH3sy+k75whpcRZTfK+Yv29ORhALN9MrRMVqij1YeWOSQQM9ghLlVDb/KadjDB
	 KLOZ21E+qH33javZorda/KbfxpUXfZkAPDvx2PYGpJY7SNjunzTjtADzBJaSr/p3ux
	 5WQKQfdb31bIrfSzF4zYMrV8yUhuUxveONCzV2cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfHNRJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfHNRJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:09:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D149217F4;
        Wed, 14 Aug 2019 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802569;
        bh=bMsK2oFPbruaZw4mTKjzxcr+KGodWlB7UpdOisVetwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoWNYr476/lK2+QcrCvrTYNOspdFCgCDxkxAI7Zlcp5GgkXJejPG611u+XAm1X1ZB
         Ha8V2zTaUVCm2cmWbQmHyqC0azgt73l0YIN27mRZAlOS0Xc7Y6jLQIBUnzLJXWLrYk
         z0xtlz3MKrlliGTzcFubhJ8gRc9RLcWYilFIcNjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 05/91] crypto: ccp - Fix oops by properly managing allocated structures
Date:   Wed, 14 Aug 2019 19:00:28 +0200
Message-Id: <20190814165749.293699173@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary R Hook <gary.hook@amd.com>

commit 25e44338321af545ab34243a6081c3f0fc6107d0 upstream.

A plaintext or ciphertext length of 0 is allowed in AES, in which case
no encryption occurs. Ensure that we don't clean up data structures
that were never allocated.

Fixes: 36cf515b9bbe2 ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-ops.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -862,11 +862,11 @@ e_tag:
 	ccp_dm_free(&final_wa);
 
 e_dst:
-	if (aes->src_len && !in_place)
+	if (ilen > 0 && !in_place)
 		ccp_free_data(&dst, cmd_q);
 
 e_src:
-	if (aes->src_len)
+	if (ilen > 0)
 		ccp_free_data(&src, cmd_q);
 
 e_aad:


