Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E68C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCBC217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752449;
	bh=lVRu5drw9Uzo59lkXq7jFD9QSEgeZnwG5k4rrkToQpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xLWj+KtS0wh1W/3nUtyCbs1QJfK36mzgZm/2aHfh1RmNBKYIg31k+RagGanrrGlbr
	 LCHP1Yrb9/KA04EPZMwMd3gbzrZ+QFRyUbaw+rGd0Bfs06hwHW6JMit7JfiTfv6ck3
	 AqawLouAWWwib0kW49i8lUFQlca/VNNs0v23s64g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394697AbfHBN04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394638AbfHBN0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:26:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC7621855;
        Fri,  2 Aug 2019 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752412;
        bh=lVRu5drw9Uzo59lkXq7jFD9QSEgeZnwG5k4rrkToQpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3nkIuCITir6+d43VoPJ1S5TstnE80HoumXohL+LZl2yVG9c/7Ppe0BBqwcvD460K
         ajnB84Oo5tXFRKpEfgLkPuSDiSHdslJC5N895/fPPHb4QM2t8pOgA7ecBT2W+EwqrZ
         Uc+6CLALyrjkFC+rIO7B2v1v67oGOp6oGoxS8HX8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 08/17] s390/qdio: add sanity checks to the fast-requeue path
Date:   Fri,  2 Aug 2019 09:26:25 -0400
Message-Id: <20190802132635.14885-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132635.14885-1-sashal@kernel.org>
References: <20190802132635.14885-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit a6ec414a4dd529eeac5c3ea51c661daba3397108 ]

If the device driver were to send out a full queue's worth of SBALs,
current code would end up discovering the last of those SBALs as PRIMED
and erroneously skip the SIGA-w. This immediately stalls the queue.

Add a check to not attempt fast-requeue in this case. While at it also
make sure that the state of the previous SBAL was successfully extracted
before inspecting it.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/qdio_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index d64b401f3d058..51cdccaec1648 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -1575,13 +1575,13 @@ static int handle_outbound(struct qdio_q *q, unsigned int callflags,
 		rc = qdio_kick_outbound_q(q, phys_aob);
 	} else if (need_siga_sync(q)) {
 		rc = qdio_siga_sync_q(q);
+	} else if (count < QDIO_MAX_BUFFERS_PER_Q &&
+		   get_buf_state(q, prev_buf(bufnr), &state, 0) > 0 &&
+		   state == SLSB_CU_OUTPUT_PRIMED) {
+		/* The previous buffer is not processed yet, tack on. */
+		qperf_inc(q, fast_requeue);
 	} else {
-		/* try to fast requeue buffers */
-		get_buf_state(q, prev_buf(bufnr), &state, 0);
-		if (state != SLSB_CU_OUTPUT_PRIMED)
-			rc = qdio_kick_outbound_q(q, 0);
-		else
-			qperf_inc(q, fast_requeue);
+		rc = qdio_kick_outbound_q(q, 0);
 	}
 
 	/* in case of SIGA errors we must process the error immediately */
-- 
2.20.1

