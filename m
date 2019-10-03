Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7064DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB5215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119946;
	bh=kvo8e6FkZ7qO+5CeiOkhJiM1oUsYCDpijb9DiyqS2Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QewuXnF5AL/L4pLWqoFA6wCKcbLz97b057IkPY2X6xwVCnbAvDEAYHQLgk3WZ1yWF
	 N9XIqFgrQLDI8aMMp/A/itNxz4HOd8hI8vua+3PN7vbT+gr4z5JdaADUaHz2tX1HH6
	 vAFmzthHB5fV4fqwNPQx7/PClJG+/yn3K9orC1No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390967AbfJCQZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390958AbfJCQZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:25:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B4220867;
        Thu,  3 Oct 2019 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119942;
        bh=kvo8e6FkZ7qO+5CeiOkhJiM1oUsYCDpijb9DiyqS2Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUh30/eWyVuCo3Wqxh2PoCYnVuuJE4ezug3WJfCIzrlqDM7zxZMaYmEGhSfUB1Gjb
         XSjCG7N1jkQt8cLxdR+DMUyZ2LuW9TX1jNV2LW6a3LTGPJZ3d0Rop+oFxdqLWu2jz6
         MXkS01c4xEql6ta2KVvninDI5XzdgKpHxxkGQouM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 5.2 006/313] net: qrtr: Stop rx_worker before freeing node
Date:   Thu,  3 Oct 2019 17:49:44 +0200
Message-Id: <20191003154534.142045176@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 73f0c11d11329a0d6d205d4312b6e5d2512af7c5 ]

As the endpoint is unregistered there might still be work pending to
handle incoming messages, which will result in a use after free
scenario. The plan is to remove the rx_worker, but until then (and for
stable@) ensure that the work is stopped before the node is freed.

Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/qrtr/qrtr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -150,6 +150,7 @@ static void __qrtr_node_release(struct k
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
+	cancel_work_sync(&node->work);
 	skb_queue_purge(&node->rx_queue);
 	kfree(node);
 }


