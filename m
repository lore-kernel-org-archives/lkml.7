Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3344DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0571E20880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430948;
	bh=Ci5sgc3iE/AfrRiDW7MgemDHV0cCMcu9/2DaqSbO1JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nJKBz90RCnnHUJlwVtTAqfuM7YFGZkyyqd1+O+e5SXGwFswpAUlLb9i1HLIfK4M8J
	 Glv6Bd1T6MrMT+XOXzGpyZRbWxRh//Q9xxIZMO/K6VUyb00Cnf+hnA+YFQbQm3ysH/
	 GcTaoqnF9AJGCMqv8iCrLB72EwsCtkXBz6kRubbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgAGVC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:02:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgAGVCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:02:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3988F20880;
        Tue,  7 Jan 2020 21:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430942;
        bh=Ci5sgc3iE/AfrRiDW7MgemDHV0cCMcu9/2DaqSbO1JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMGdwhR6teQ9M0f77mUxAQyhAlOY1XP2CzlcboPpWwF8rB2W2Kidk5JjNeMaMUV77
         hUWWDQCFVIFt74DiAWhMilE6hQZkwsDbHlr8Y+LTvYtGRnsekhVMctPMTZL5deBb3z
         eGcelEiEFa8YUod9FX6RMA2ePzLdVmxSo9o3MoMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.4 159/191] Bluetooth: delete a stray unlock
Date:   Tue,  7 Jan 2020 21:54:39 +0100
Message-Id: <20200107205341.484533562@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit df66499a1fab340c167250a5743931dc50d5f0fa upstream.

We used to take a lock in amp_physical_cfm() but then we moved it to
the caller function.  Unfortunately the unlock on this error path was
overlooked so it leads to a double unlock.

Fixes: a514b17fab51 ("Bluetooth: Refactor locking in amp_physical_cfm")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/l2cap_core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4936,10 +4936,8 @@ void __l2cap_physical_cfm(struct l2cap_c
 	BT_DBG("chan %p, result %d, local_amp_id %d, remote_amp_id %d",
 	       chan, result, local_amp_id, remote_amp_id);
 
-	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED) {
-		l2cap_chan_unlock(chan);
+	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED)
 		return;
-	}
 
 	if (chan->state != BT_CONNECTED) {
 		l2cap_do_create(chan, result, local_amp_id, remote_amp_id);


