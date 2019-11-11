Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6D2C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5302173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498555;
	bh=N5Y94iEJO5/xbZaziSmMSrfzRjsAshog1+XNa+q9lD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=icv3J4GNrOMOpAI4rA1+VKNsD543T7tnA0V/sMJy+3UZqRGJvrd261tZEPN1ELEBe
	 ncCOQ5vECRR8Qfs/5ndzoI98oMvDnt9c7l8gW+ZDUVFKU8ByANwmWsMMyRJgFVk7Z6
	 w+ixjWo8oA6Frqil7YuNon0bVgpSYKrY8l95DVEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfKKSzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:55:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730670AbfKKSzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:55:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADA721783;
        Mon, 11 Nov 2019 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498550;
        bh=N5Y94iEJO5/xbZaziSmMSrfzRjsAshog1+XNa+q9lD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcjFJs5UrMs2Bnb869L9h7MrI6Wfl51IXhxnPkV5NtFyJFlwOExp3hD57VPcUjtxS
         7FJ3WoNrzuZO29iOExrb/Gwv7uBOLqYSmd/c/wK0LAdME3RPR/TBpEr1hXdDdPp+Qe
         DbXC4Zz1rlWojnq9DmdFZGQY4zAkTtFTRi6e6vvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dakshaja Uppalapati <dakshaja@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 150/193] RDMA/iw_cxgb4: Avoid freeing skb twice in arp failure case
Date:   Mon, 11 Nov 2019 19:28:52 +0100
Message-Id: <20191111181512.215440860@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Potnuri Bharat Teja <bharat@chelsio.com>

[ Upstream commit d4934f45693651ea15357dd6c7c36be28b6da884 ]

_put_ep_safe() and _put_pass_ep_safe() free the skb before it is freed by
process_work(). fix double free by freeing the skb only in process_work().

Fixes: 1dad0ebeea1c ("iw_cxgb4: Avoid touch after free error in ARP failure handlers")
Link: https://lore.kernel.org/r/1572006880-5800-1-git-send-email-bharat@chelsio.com
Signed-off-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/cxgb4/cm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 9e8eca7b613c0..347dc242fb882 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -495,7 +495,6 @@ static int _put_ep_safe(struct c4iw_dev *dev, struct sk_buff *skb)
 
 	ep = *((struct c4iw_ep **)(skb->cb + 2 * sizeof(void *)));
 	release_ep_resources(ep);
-	kfree_skb(skb);
 	return 0;
 }
 
@@ -506,7 +505,6 @@ static int _put_pass_ep_safe(struct c4iw_dev *dev, struct sk_buff *skb)
 	ep = *((struct c4iw_ep **)(skb->cb + 2 * sizeof(void *)));
 	c4iw_put_ep(&ep->parent_ep->com);
 	release_ep_resources(ep);
-	kfree_skb(skb);
 	return 0;
 }
 
-- 
2.20.1



