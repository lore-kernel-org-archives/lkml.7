Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEE4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69E3222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781555;
	bh=Vmz3wYOJbZc0L0QOMOlJVhOavn4fujjmfqInOPz+33k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mD5vcdNoFP/wcWZUTGxsL+/FZHt/unZdv6UcmgtY6c3hbuhcdIiNaHk+/QoDuPd8D
	 M3sKEBvTX0GWVm7kJpDi2bZ96IXSltAQTg0aNJca6G1vWHZq2CW898ZefZHItAi+7c
	 9q4Y9u9UFDhASs9uS/r2/yS1G9g4+PvNN5BGCJWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfLSSwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:52:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfLSSw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:52:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49DB222C2;
        Thu, 19 Dec 2019 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781547;
        bh=Vmz3wYOJbZc0L0QOMOlJVhOavn4fujjmfqInOPz+33k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBRkrpSy24Z+J0vXZHAaK+/hJ05TAEc8gw6UW0X30nJZKlvlsdLFyx3er3YQE2hVY
         88B7rtGz2hkgq47pOavaKsQSApQ3UtSVUFRIr8BRKqP2hwawNlJ0Y51sPC/e4SMmUl
         k0zaTbQFu265386LrM6LASGe94tr4G+94t581xp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.19 29/47] rpmsg: glink: Dont send pending rx_done during remove
Date:   Thu, 19 Dec 2019 19:34:43 +0100
Message-Id: <20191219182933.427327141@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182857.659088743@linuxfoundation.org>
References: <20191219182857.659088743@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit c3dadc19b7564c732598b30d637c6f275c3b77b6 upstream.

Attempting to transmit rx_done messages after the GLINK instance is
being torn down will cause use after free and memory leaks. So cancel
the intent_work and free up the pending intents.

With this there are no concurrent accessors of the channel left during
qcom_glink_native_remove() and there is therefor no need to hold the
spinlock during this operation - which would prohibit the use of
cancel_work_sync() in the release function. So remove this.

Fixes: 1d2ea36eead9 ("rpmsg: glink: Add rx done command")
Cc: stable@vger.kernel.org
Acked-by: Chris Lew <clew@codeaurora.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rpmsg/qcom_glink_native.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -241,11 +241,23 @@ static void qcom_glink_channel_release(s
 {
 	struct glink_channel *channel = container_of(ref, struct glink_channel,
 						     refcount);
+	struct glink_core_rx_intent *intent;
 	struct glink_core_rx_intent *tmp;
 	unsigned long flags;
 	int iid;
 
+	/* cancel pending rx_done work */
+	cancel_work_sync(&channel->intent_work);
+
 	spin_lock_irqsave(&channel->intent_lock, flags);
+	/* Free all non-reuse intents pending rx_done work */
+	list_for_each_entry_safe(intent, tmp, &channel->done_intents, node) {
+		if (!intent->reuse) {
+			kfree(intent->data);
+			kfree(intent);
+		}
+	}
+
 	idr_for_each_entry(&channel->liids, tmp, iid) {
 		kfree(tmp->data);
 		kfree(tmp);
@@ -1628,7 +1640,6 @@ void qcom_glink_native_remove(struct qco
 	struct glink_channel *channel;
 	int cid;
 	int ret;
-	unsigned long flags;
 
 	disable_irq(glink->irq);
 	cancel_work_sync(&glink->rx_work);
@@ -1637,7 +1648,6 @@ void qcom_glink_native_remove(struct qco
 	if (ret)
 		dev_warn(glink->dev, "Can't remove GLINK devices: %d\n", ret);
 
-	spin_lock_irqsave(&glink->idr_lock, flags);
 	/* Release any defunct local channels, waiting for close-ack */
 	idr_for_each_entry(&glink->lcids, channel, cid)
 		kref_put(&channel->refcount, qcom_glink_channel_release);
@@ -1648,7 +1658,6 @@ void qcom_glink_native_remove(struct qco
 
 	idr_destroy(&glink->lcids);
 	idr_destroy(&glink->rcids);
-	spin_unlock_irqrestore(&glink->idr_lock, flags);
 	mbox_free_channel(glink->mbox_chan);
 }
 EXPORT_SYMBOL_GPL(qcom_glink_native_remove);


