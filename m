Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A73C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ADB2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901254;
	bh=bACvmnHqpjdiM0WNpuRegXcDV/r7bpbC6dzlm5dR2Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=keIIHnxBdq60vupJk1ksfZRuIt3yQOB84djaAaK9/vlqEuSFfYkBpGOYOENPf2O+w
	 iVkiAP2Te+M4nh4zwm+P1MLNgf2uViGbxlwlHAOs1K1h/oK4LnIFWG1HNbaZWskMxZ
	 tWa8rrwwFBSV5uz5Ii0K8mCC2HIrnRVUqB60rdGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfCRJ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:32830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfCRJ1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:31 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071EB2075C;
        Mon, 18 Mar 2019 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901250;
        bh=bACvmnHqpjdiM0WNpuRegXcDV/r7bpbC6dzlm5dR2Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZCmwWHPCCsC7YQnljKE2EqrgUEFjBetYmwnR2NGdM/AedYHAkIzK9M7Jm8Bq6ApN
         zVZZYevTDrlE5b1fbXvr6NnmG2isIB28L2ukRsj+6PIH/YB4y1Uuwy2udd652MvJ28
         mHMYBkOI2ERKUzMCE4SeuYXz9e+fERJnju70Iypo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Buslov <vladbu@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 30/43] net: sched: flower: insert new filter to idr after setting its mask
Date:   Mon, 18 Mar 2019 10:24:22 +0100
Message-Id: <20190318083716.755134580@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@mellanox.com>

[ Upstream commit ecb3dea400d3beaf611ce76ac7a51d4230492cf2 ]

When adding new filter to flower classifier, fl_change() inserts it to
handle_idr before initializing filter extensions and assigning it a mask.
Normally this ordering doesn't matter because all flower classifier ops
callbacks assume rtnl lock protection. However, when filter has an action
that doesn't have its kernel module loaded, rtnl lock is released before
call to request_module(). During this time the filter can be accessed bu
concurrent task before its initialization is completed, which can lead to a
crash.

Example case of NULL pointer dereference in concurrent dump:

Task 1                           Task 2

tc_new_tfilter()
 fl_change()
  idr_alloc_u32(fnew)
  fl_set_parms()
   tcf_exts_validate()
    tcf_action_init()
     tcf_action_init_1()
      rtnl_unlock()
      request_module()
      ...                        rtnl_lock()
      				 tc_dump_tfilter()
      				  tcf_chain_dump()
				   fl_walk()
				    idr_get_next_ul()
				    tcf_node_dump()
				     tcf_fill_node()
				      fl_dump()
				       mask = &f->mask->key; <- NULL ptr
      rtnl_lock()

Extension initialization and mask assignment don't depend on fnew->handle
that is allocated by idr_alloc_u32(). Move idr allocation code after action
creation and mask assignment in fl_change() to prevent concurrent access
to not fully initialized filter when rtnl lock is released to load action
module.

Fixes: 01683a146999 ("net: sched: refactor flower walk to iterate over idr")
Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_flower.c |   43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1327,46 +1327,46 @@ static int fl_change(struct net *net, st
 	if (err < 0)
 		goto errout;
 
-	if (!handle) {
-		handle = 1;
-		err = idr_alloc_u32(&head->handle_idr, fnew, &handle,
-				    INT_MAX, GFP_KERNEL);
-	} else if (!fold) {
-		/* user specifies a handle and it doesn't exist */
-		err = idr_alloc_u32(&head->handle_idr, fnew, &handle,
-				    handle, GFP_KERNEL);
-	}
-	if (err)
-		goto errout;
-	fnew->handle = handle;
-
 	if (tb[TCA_FLOWER_FLAGS]) {
 		fnew->flags = nla_get_u32(tb[TCA_FLOWER_FLAGS]);
 
 		if (!tc_flags_valid(fnew->flags)) {
 			err = -EINVAL;
-			goto errout_idr;
+			goto errout;
 		}
 	}
 
 	err = fl_set_parms(net, tp, fnew, mask, base, tb, tca[TCA_RATE], ovr,
 			   tp->chain->tmplt_priv, extack);
 	if (err)
-		goto errout_idr;
+		goto errout;
 
 	err = fl_check_assign_mask(head, fnew, fold, mask);
 	if (err)
-		goto errout_idr;
+		goto errout;
+
+	if (!handle) {
+		handle = 1;
+		err = idr_alloc_u32(&head->handle_idr, fnew, &handle,
+				    INT_MAX, GFP_KERNEL);
+	} else if (!fold) {
+		/* user specifies a handle and it doesn't exist */
+		err = idr_alloc_u32(&head->handle_idr, fnew, &handle,
+				    handle, GFP_KERNEL);
+	}
+	if (err)
+		goto errout_mask;
+	fnew->handle = handle;
 
 	if (!fold && __fl_lookup(fnew->mask, &fnew->mkey)) {
 		err = -EEXIST;
-		goto errout_mask;
+		goto errout_idr;
 	}
 
 	err = rhashtable_insert_fast(&fnew->mask->ht, &fnew->ht_node,
 				     fnew->mask->filter_ht_params);
 	if (err)
-		goto errout_mask;
+		goto errout_idr;
 
 	if (!tc_skip_hw(fnew->flags)) {
 		err = fl_hw_replace_filter(tp, fnew, extack);
@@ -1405,12 +1405,13 @@ errout_mask_ht:
 	rhashtable_remove_fast(&fnew->mask->ht, &fnew->ht_node,
 			       fnew->mask->filter_ht_params);
 
-errout_mask:
-	fl_mask_put(head, fnew->mask, false);
-
 errout_idr:
 	if (!fold)
 		idr_remove(&head->handle_idr, fnew->handle);
+
+errout_mask:
+	fl_mask_put(head, fnew->mask, false);
+
 errout:
 	tcf_exts_destroy(&fnew->exts);
 	kfree(fnew);


