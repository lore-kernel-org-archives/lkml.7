Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60014C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303442171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411654;
	bh=8S2BTWNSK1iEI2bxfh8jiyaVlcJxKYnOO2OOzJSyzE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MUaCQqkV74TdZd3r3R6Df2vUJ3VUEdmsf/hmW85T6VxWtcePI+i+GjOCQ4knJU5hY
	 6YRu4P2Jww9tbJd2ZVdtPeG2OPBqurA1DIyFK/Yq1X99r+YnWaZODWrN3r+m596Cjn
	 avTgE3xrq7UXH6nGVfLAdjAONiIQxbP89zFsTPls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfCLR1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbfCLRRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:37 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54E721850;
        Tue, 12 Mar 2019 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411057;
        bh=8S2BTWNSK1iEI2bxfh8jiyaVlcJxKYnOO2OOzJSyzE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fwDJMxGUTMdYviYevJuu2QXTY7SUFlugYddRueD4YXSfEUh/UvARdVy8ccC5Z20Ou
         GeOkDmlr522824NXITlfvj6IENxznwRqzE/+370/1ZNmdWbCB4vMTjWnzPmKgNy3KW
         uitGPmKpvYkjdJC2hnYVmCYQaZfg2YSateM976rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Celik <mail@timurcelik.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 25/96] tun: fix blocking read
Date:   Tue, 12 Mar 2019 10:09:43 -0700
Message-Id: <20190312171036.408681722@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Celik <mail@timurcelik.de>

[ Upstream commit 71828b2240692cec0e68b8d867bc00e1745e7fae ]

This patch moves setting of the current state into the loop. Otherwise
the task may end up in a busy wait loop if none of the break conditions
are met.

Signed-off-by: Timur Celik <mail@timurcelik.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1471,9 +1471,9 @@ static struct sk_buff *tun_ring_recv(str
 	}
 
 	add_wait_queue(&tfile->wq.wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
 
 	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		skb = skb_array_consume(&tfile->tx_array);
 		if (skb)
 			break;
@@ -1489,7 +1489,7 @@ static struct sk_buff *tun_ring_recv(str
 		schedule();
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:


