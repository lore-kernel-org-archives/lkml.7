Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D6C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3035F205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575484021;
	bh=sM+AeCQ6ERjnYdYm8roDi2IYLxWxY31PNUF27m3Id24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JrCRjMDYwYkh8sXS+Y5GpZWn+GWQqOWKUUf3AE93MpJC0axskevRXcjQ0UNpJqgY8
	 L+j+j59yLdEA+QHmnVXfHkYYWuq0DArRgvthQOa5p0sW5ZnI5/LnFHpj4B+bArOM65
	 vaboi28aetq6gOctUt7l1Lw+swCJoefP7Y46SEJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfLDS1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfLDR6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:58:47 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF262073B;
        Wed,  4 Dec 2019 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482326;
        bh=sM+AeCQ6ERjnYdYm8roDi2IYLxWxY31PNUF27m3Id24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrXTzKDmHK7RfnccygBLbSsJQ/YUDYiZExhHRUaiBO/lsIyhrt+FqZkXyRI4OPISd
         kFq9Qeibwg3+fxykFA+hlD9JQmDM1WDPHZRUMUNNOrkpZ1XCsDbEzTO+SH3tflrEDx
         RBG5qHL9mCTjfOqIiGDCep+Pv5OXq1pwvbwC2g+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 08/92] block: drbd: remove a stray unlock in __drbd_send_protocol()
Date:   Wed,  4 Dec 2019 18:49:08 +0100
Message-Id: <20191204174329.568015570@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8e9c523016cf9983b295e4bc659183d1fa6ef8e0 ]

There are two callers of this function and they both unlock the mutex so
this ends up being a double unlock.

Fixes: 44ed167da748 ("drbd: rcu_read_lock() and rcu_dereference() for tconn->net_conf")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1d58854c4a9fa..385ec4ae33945 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -792,7 +792,6 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 
 	if (nc->tentative && connection->agreed_pro_version < 92) {
 		rcu_read_unlock();
-		mutex_unlock(&sock->mutex);
 		drbd_err(connection, "--dry-run is not supported by peer");
 		return -EOPNOTSUPP;
 	}
-- 
2.20.1



