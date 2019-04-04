Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FCFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570EA206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371318;
	bh=of87jsM+rHuEVl0svtfaTXlFdX9tnwNNu0werUnqz/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XAkvVz2fdepX6sdZ8e2e3qrYtfTsjcGG6HnALYcHhsUl6eo9sXpVkaYl3LpEEzavo
	 z8/8IZqni28uDXijuA2TyrAZszQKun8l9BhkzqUYWn8INVdEEJEfJMJNrHur0hq3rw
	 f2sWMcWRiQzIGFVRGNCT+qXWZaYOynmXEdu6N5e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfDDI5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730614AbfDDI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:57:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7DC72177E;
        Thu,  4 Apr 2019 08:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368225;
        bh=of87jsM+rHuEVl0svtfaTXlFdX9tnwNNu0werUnqz/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1J+fh6McxFBFpRFQoyvQLwQH7IbpaMHurIROt0xpj+P17ZMqnGef5kW9kGBfeoWN
         hmmXGC+uaNsy4vq0MsOqACVf1HRZGhzC3evKXMFK/JtAnuTjLiEkv0JJfSf7LaqRrK
         5GBAaZtD9QbtI7rGGmKg3YVvwvWB/gBCD+oegx5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 068/121] iwlwifi: pcie: fix emergency path
Date:   Thu,  4 Apr 2019 10:47:36 +0200
Message-Id: <20190404084548.959197639@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c6ac9f9fb98851f47b978a9476594fc3c477a34d ]

Allocator swaps the pending requests with 0 when it starts
working. This means that relying on it n RX path to decide if
to move to emergency is not always a good idea, since it may
be zero, but there are still a lot of unallocated RBs in the
system. Change allocator to decrement the pending requests on
real time. It is more expensive since it accesses the atomic
variable more times, but it gives the RX path a better idea
of the system's status.

Reported-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Fixes: 868a1e863f95 ("iwlwifi: pcie: avoid empty free RB queue")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 5a15362ef671..a40ad4675e19 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -475,7 +475,7 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	struct list_head local_empty;
-	int pending = atomic_xchg(&rba->req_pending, 0);
+	int pending = atomic_read(&rba->req_pending);
 
 	IWL_DEBUG_RX(trans, "Pending allocation requests = %d\n", pending);
 
@@ -530,11 +530,13 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 			i++;
 		}
 
+		atomic_dec(&rba->req_pending);
 		pending--;
+
 		if (!pending) {
-			pending = atomic_xchg(&rba->req_pending, 0);
+			pending = atomic_read(&rba->req_pending);
 			IWL_DEBUG_RX(trans,
-				     "Pending allocation requests = %d\n",
+				     "Got more pending allocation requests = %d\n",
 				     pending);
 		}
 
@@ -546,12 +548,15 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 		spin_unlock(&rba->lock);
 
 		atomic_inc(&rba->req_ready);
+
 	}
 
 	spin_lock(&rba->lock);
 	/* return unused rbds to the allocator empty list */
 	list_splice_tail(&local_empty, &rba->rbd_empty);
 	spin_unlock(&rba->lock);
+
+	IWL_DEBUG_RX(trans, "%s, exit.\n", __func__);
 }
 
 /*
-- 
2.19.1



