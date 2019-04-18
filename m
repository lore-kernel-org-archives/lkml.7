Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7688BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9D5217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610734;
	bh=GEtfArTNNegvXnptjXA++0sGJmQn1/VWV0XD/0Zzh7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0FMJnrIQUbVhbzF9yPMrx3JL3Y5pcJbj2EnZNQs40CenzGvaS0DCL7i5/37l5ZqTQ
	 avb4bpyfz3z5NGyBYLVsvc/hfGGjDf+QbJ8hv9KR2SCP/wI+dP5FMFyrIsMqHtZ5Zu
	 WVrw9INSVcQd+4sJKwfCDicFiROfBN8BWAOTulB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbfDRSFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390694AbfDRSFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FB621872;
        Thu, 18 Apr 2019 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610729;
        bh=GEtfArTNNegvXnptjXA++0sGJmQn1/VWV0XD/0Zzh7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMZovp+4UvJK3B5w+Y0WzS/rj3wA4yVP0bzXnyspuH3/WVR1qPiWavChSnBoKamOA
         TAYggbjPUmSonOrDtx/gbeeqLVSp1rtubf6s//l32uxaopnp6UIM/25cnFoLBZBcI8
         W6tNj3LGjNZxVrnyJpyOEB3K+EEngtUz4k8rdO+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Persson <larper@axis.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 62/92] crypto: axis - fix for recursive locking from bottom half
Date:   Thu, 18 Apr 2019 19:57:20 +0200
Message-Id: <20190418160435.625170630@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c34a83820f59bb275e5f2d55cd5ea99c64f6ef23 ]

Clients may submit a new requests from the completion callback
context. The driver was not prepared to receive a request in this
state because it already held the request queue lock and a recursive
lock error is triggered.

Now all completions are queued up until we are ready to drop the queue
lock and then delivered.

The fault was triggered by TCP over an IPsec connection in the LTP
test suite:
  LTP: starting tcp4_ipsec02 (tcp_ipsec.sh -p ah -m transport -s "100 1000 65535")
  BUG: spinlock recursion on CPU#1, genload/943
   lock: 0xbf3c3094, .magic: dead4ead, .owner: genload/943, .owner_cpu: 1
  CPU: 1 PID: 943 Comm: genload Tainted: G           O    4.9.62-axis5-devel #6
  Hardware name: Axis ARTPEC-6 Platform
   (unwind_backtrace) from [<8010d134>] (show_stack+0x18/0x1c)
   (show_stack) from [<803a289c>] (dump_stack+0x84/0x98)
   (dump_stack) from [<8016e164>] (do_raw_spin_lock+0x124/0x128)
   (do_raw_spin_lock) from [<804de1a4>] (artpec6_crypto_submit+0x2c/0xa0)
   (artpec6_crypto_submit) from [<804def38>] (artpec6_crypto_prepare_submit_hash+0xd0/0x54c)
   (artpec6_crypto_prepare_submit_hash) from [<7f3165f0>] (ah_output+0x2a4/0x3dc [ah4])
   (ah_output [ah4]) from [<805df9bc>] (xfrm_output_resume+0x178/0x4a4)
   (xfrm_output_resume) from [<805d283c>] (xfrm4_output+0xac/0xbc)
   (xfrm4_output) from [<80587928>] (ip_queue_xmit+0x140/0x3b4)
   (ip_queue_xmit) from [<805a13b4>] (tcp_transmit_skb+0x4c4/0x95c)
   (tcp_transmit_skb) from [<8059f218>] (tcp_rcv_state_process+0xdf4/0xdfc)
   (tcp_rcv_state_process) from [<805a7530>] (tcp_v4_do_rcv+0x64/0x1ac)
   (tcp_v4_do_rcv) from [<805a9724>] (tcp_v4_rcv+0xa34/0xb74)
   (tcp_v4_rcv) from [<80581d34>] (ip_local_deliver_finish+0x78/0x2b0)
   (ip_local_deliver_finish) from [<8058259c>] (ip_local_deliver+0xe4/0x104)
   (ip_local_deliver) from [<805d23ec>] (xfrm4_transport_finish+0xf4/0x144)
   (xfrm4_transport_finish) from [<805df564>] (xfrm_input+0x4f4/0x74c)
   (xfrm_input) from [<804de420>] (artpec6_crypto_task+0x208/0x38c)
   (artpec6_crypto_task) from [<801271b0>] (tasklet_action+0x60/0xec)
   (tasklet_action) from [<801266d4>] (__do_softirq+0xcc/0x3a4)
   (__do_softirq) from [<80126d20>] (irq_exit+0xf4/0x15c)
   (irq_exit) from [<801741e8>] (__handle_domain_irq+0x68/0xbc)
   (__handle_domain_irq) from [<801014f0>] (gic_handle_irq+0x50/0x94)
   (gic_handle_irq) from [<80657370>] (__irq_usr+0x50/0x80)

Signed-off-by: Lars Persson <larper@axis.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/axis/artpec6_crypto.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 6eb5cb92b986..9f82e14983f6 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -284,6 +284,7 @@ enum artpec6_crypto_hash_flags {
 
 struct artpec6_crypto_req_common {
 	struct list_head list;
+	struct list_head complete_in_progress;
 	struct artpec6_crypto_dma_descriptors *dma;
 	struct crypto_async_request *req;
 	void (*complete)(struct crypto_async_request *req);
@@ -2046,7 +2047,8 @@ static int artpec6_crypto_prepare_aead(struct aead_request *areq)
 	return artpec6_crypto_dma_map_descs(common);
 }
 
-static void artpec6_crypto_process_queue(struct artpec6_crypto *ac)
+static void artpec6_crypto_process_queue(struct artpec6_crypto *ac,
+	    struct list_head *completions)
 {
 	struct artpec6_crypto_req_common *req;
 
@@ -2057,7 +2059,7 @@ static void artpec6_crypto_process_queue(struct artpec6_crypto *ac)
 		list_move_tail(&req->list, &ac->pending);
 		artpec6_crypto_start_dma(req);
 
-		req->req->complete(req->req, -EINPROGRESS);
+		list_add_tail(&req->complete_in_progress, completions);
 	}
 
 	/*
@@ -2087,6 +2089,11 @@ static void artpec6_crypto_task(unsigned long data)
 	struct artpec6_crypto *ac = (struct artpec6_crypto *)data;
 	struct artpec6_crypto_req_common *req;
 	struct artpec6_crypto_req_common *n;
+	struct list_head complete_done;
+	struct list_head complete_in_progress;
+
+	INIT_LIST_HEAD(&complete_done);
+	INIT_LIST_HEAD(&complete_in_progress);
 
 	if (list_empty(&ac->pending)) {
 		pr_debug("Spurious IRQ\n");
@@ -2120,19 +2127,30 @@ static void artpec6_crypto_task(unsigned long data)
 
 		pr_debug("Completing request %p\n", req);
 
-		list_del(&req->list);
+		list_move_tail(&req->list, &complete_done);
 
 		artpec6_crypto_dma_unmap_all(req);
 		artpec6_crypto_copy_bounce_buffers(req);
 
 		ac->pending_count--;
 		artpec6_crypto_common_destroy(req);
-		req->complete(req->req);
 	}
 
-	artpec6_crypto_process_queue(ac);
+	artpec6_crypto_process_queue(ac, &complete_in_progress);
 
 	spin_unlock_bh(&ac->queue_lock);
+
+	/* Perform the completion callbacks without holding the queue lock
+	 * to allow new request submissions from the callbacks.
+	 */
+	list_for_each_entry_safe(req, n, &complete_done, list) {
+		req->complete(req->req);
+	}
+
+	list_for_each_entry_safe(req, n, &complete_in_progress,
+				 complete_in_progress) {
+		req->req->complete(req->req, -EINPROGRESS);
+	}
 }
 
 static void artpec6_crypto_complete_crypto(struct crypto_async_request *req)
-- 
2.19.1



