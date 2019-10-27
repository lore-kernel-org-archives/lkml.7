Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B0CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FBF222CE
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211568;
	bh=zJJ8f/jSEkfvId2/8PLTXAWRo/PhgYsPR5zxT/49t4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m+8BrPXTDvbEB9H4/60LVd4qCTGBr8g4XCMrsob7r/evFuUVFe1W+uKxiAUfmQgoK
	 VlvqyyW1QHi7zNBe3MPPN+Sjds4Q5pK90qApQzIi8jIUWlFRtukaNlJiFhfz40QiaP
	 RZeLlugHtdFffIWIue6RsBffHET+gKCklZtn1L2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfJ0V0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732850AbfJ0V0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:26:03 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E88D21D80;
        Sun, 27 Oct 2019 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211563;
        bh=zJJ8f/jSEkfvId2/8PLTXAWRo/PhgYsPR5zxT/49t4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtuAxAG7YJUZhy200SddT/tl6yVdNcE9qo4hlycWoaO842Xlkw6aEZ4nuIxDtGXqs
         R29w69VK5hgGGVM021oak7Prmuc8HJPO3yYd2IcpUwLbmOckrUyzwLBdQMT79KPP5C
         S/akNwiPaariIf5Bwrs1C07ddUDaIos8G+xum044=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.3 196/197] blk-rq-qos: fix first node deletion of rq_qos_del()
Date:   Sun, 27 Oct 2019 22:01:54 +0100
Message-Id: <20191027203407.066172421@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
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
@@ -103,16 +103,13 @@ static inline void rq_qos_add(struct req
 
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
 
 	blk_mq_debugfs_unregister_rqos(rqos);


