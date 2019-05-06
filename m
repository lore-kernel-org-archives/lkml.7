Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA892C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B402120B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153361;
	bh=Cw5hhRwDUAOELZyul9Nmi2Wf+0JI+FFNTIywjwjoTVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jqPk70bPW5rFKG6YvPoEKVCiuDhmWWPvFdkcLjxuDA9cMAN1WQGmkPtms0/dzdBGH
	 m64Tjskn11ytUbTlNqZyXvW8mBV02VCfN7pIOAWJlomouDS/khYV7acHDIrUFKkE4A
	 vQSPWVSCu+uTq98y5/zuK+dfYHq45f+pKuc3tIR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfEFOgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEFOf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:35:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A6D20C01;
        Mon,  6 May 2019 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153358;
        bh=Cw5hhRwDUAOELZyul9Nmi2Wf+0JI+FFNTIywjwjoTVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXEgVl7n7ZvmfiXJ2i5i5fm7qdbgQr03ztsQVmug9jAELbmowoLJXQ+K8jnsIFllJ
         Gg6Ch4uRKfa+RPk+dFtPZMniFgJl+DTzO5A8L65ZiNoaQX0ydf4Enqm1o3LJ6RwRxc
         KEFI1M1IeeD6hgPcf/sCcQooerXkOzhCDgheFunQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 059/122] block: use blk_free_flush_queue() to free hctx->fq in blk_mq_init_hctx
Date:   Mon,  6 May 2019 16:31:57 +0200
Message-Id: <20190506143100.317630354@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b9a1ff504b9492ad6beb7d5606e0e3365d4d8499 ]

kfree() can leak the hctx->fq->flush_rq field.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 16f9675c57e6..97eba6d23425 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2341,7 +2341,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	return 0;
 
  free_fq:
-	kfree(hctx->fq);
+	blk_free_flush_queue(hctx->fq);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
-- 
2.20.1



