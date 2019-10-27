Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9938A205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211900;
	bh=sv62GLlzZY0YW5GNEa6kawtjMTNjMoGLeHqaa5Chwck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xDDWTwLY30W5Mdwj+sAsfPpoUCF/ZVNL76D0jnLtW58r6dLgMFlTC37c61tQhLvRw
	 qaDMZMxmmF0Lrju29iVifJN+Dqz/EcygU2wRkIpJHtLFvNpq57pJDwf3QEOAsteLhN
	 UPvNzF/zEIQKZUQDnxBOld8ohQ9qlDupOGkCI3P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfJ0Vbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbfJ0VQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:16:41 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51B4421848;
        Sun, 27 Oct 2019 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211000;
        bh=sv62GLlzZY0YW5GNEa6kawtjMTNjMoGLeHqaa5Chwck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOBlcMn8oloH0h/r6EOo7ZfDzNcaNmgZ+VAb7rhBK/PWUjM/Df6GjgiJhUNlrdEmp
         lpaWmngRBgVPr6IalfALrRUFSGsDvBoLR4Q6y2W1Y5gpKQ6Mx42jQkEz3khbsGfVYm
         ZDlpqKf5TRdi3NMRrmOKg8XXlE6xfdPnPwzeuHFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 92/93] blk-rq-qos: fix first node deletion of rq_qos_del()
Date:   Sun, 27 Oct 2019 22:01:44 +0100
Message-Id: <20191027203318.353148127@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit 307f4065b9d7c1e887e8bdfb2487e4638559fea1 upstream.

rq_qos_del() incorrectly assigns the node being deleted to the head if
it was the first on the list in the !prev path.  Fix it by iterating
with ** instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Fixes: a79050434b45 ("blk-rq-qos: refactor out common elements of blk-wbt")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-rq-qos.h |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -80,16 +80,13 @@ static inline void rq_qos_add(struct req
 
 static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 {
-	struct rq_qos *cur, *prev = NULL;
-	for (cur = q->rq_qos; cur; cur = cur->next) {
-		if (cur == rqos) {
-			if (prev)
-				prev->next = rqos->next;
-			else
-				q->rq_qos = cur;
+	struct rq_qos **cur;
+
+	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
+		if (*cur == rqos) {
+			*cur = rqos->next;
 			break;
 		}
-		prev = cur;
 	}
 }
 


