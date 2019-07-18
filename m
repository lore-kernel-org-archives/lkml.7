Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D55C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5718A2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419973;
	bh=So2IzkUzWuSWIEvrnZ2Sd5ac5Zv8IyALlkmo6shTAX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AYCMr9ON2m/OWham15uWjCXExjPgNnAOejJ8XBhdZkkzL/uC+eW0TdPvyCzjMa140
	 yc/icBohkvoHlea6lvsOnJ9Hfv5tOgyh0hLTgH+CiteELzNFkWWtmFbA1RYjmZUsNN
	 AQjy9M51uVph4pwwE/c8v8ZlSPUGkW6YnJmKgd5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403896AbfGRDL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391457AbfGRDLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:11:41 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F4E2053B;
        Thu, 18 Jul 2019 03:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419499;
        bh=So2IzkUzWuSWIEvrnZ2Sd5ac5Zv8IyALlkmo6shTAX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAegneOQKEZGYiqqNGXxz7twwBLvWZMo7WUL94zlNJvfLqvuYVyLwPbJ8XWfa78OJ
         VNbK1iHTAQG6qFRuolLsCcvacbaNanZGsDqMFDINrx5fx6puSKVpZqJXUggEwcghHy
         sLVzfu0iONe5BSa3C+zG68Gr7ATqYnuFju1vvAJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 78/80] crypto/NX: Set receive window credits to max number of CRBs in RxFIFO
Date:   Thu, 18 Jul 2019 12:02:09 +0900
Message-Id: <20190718030105.614570703@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haren Myneni <haren@linux.vnet.ibm.com>

commit e52d484d9869eb291140545746ccbe5ffc7c9306 upstream.

System gets checkstop if RxFIFO overruns with more requests than the
maximum possible number of CRBs in FIFO at the same time. The max number
of requests per window is controlled by window credits. So find max
CRBs from FIFO size and set it to receive window credits.

Fixes: b0d6c9bab5e4 ("crypto/nx: Add P9 NX support for 842 compression engine")
CC: stable@vger.kernel.org # v4.14+
Signed-off-by:Haren Myneni <haren@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

---
 drivers/crypto/nx/nx-842-powernv.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -34,8 +34,6 @@ MODULE_ALIAS_CRYPTO("842-nx");
 #define WORKMEM_ALIGN	(CRB_ALIGN)
 #define CSB_WAIT_MAX	(5000) /* ms */
 #define VAS_RETRIES	(10)
-/* # of requests allowed per RxFIFO at a time. 0 for unlimited */
-#define MAX_CREDITS_PER_RXFIFO	(1024)
 
 struct nx842_workmem {
 	/* Below fields must be properly aligned */
@@ -801,7 +799,11 @@ static int __init vas_cfg_coproc_info(st
 	rxattr.lnotify_lpid = lpid;
 	rxattr.lnotify_pid = pid;
 	rxattr.lnotify_tid = tid;
-	rxattr.wcreds_max = MAX_CREDITS_PER_RXFIFO;
+	/*
+	 * Maximum RX window credits can not be more than #CRBs in
+	 * RxFIFO. Otherwise, can get checkstop if RxFIFO overruns.
+	 */
+	rxattr.wcreds_max = fifo_size / CRB_SIZE;
 
 	/*
 	 * Open a VAS receice window which is used to configure RxFIFO


