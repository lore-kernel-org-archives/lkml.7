Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F55C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C02220700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119347;
	bh=wzC2i8rWj55dG81tZm2kN6D/gSngbg12o66ItecxI1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AK9zHY4qJAfksu/rwNlXFDygJ0l84vzm1uOXBrjs4yNQiWdVGNNA6cJJI3nG4FLyQ
	 rKOlPU3QOsWVMJVaSiHC/rYfTewGpIh88sTKXfXPThRV/L900vM+p4Ej5KN6qjdcWW
	 7+A5/Zy04s2WREuFqhEnNuPLySY8dcUkOLoC0bD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfJCQPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732566AbfJCQPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:15:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996AF20700;
        Thu,  3 Oct 2019 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119344;
        bh=wzC2i8rWj55dG81tZm2kN6D/gSngbg12o66ItecxI1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVo+SH951+aKYddvjpIW8qQtuE6VcUfwAOqOwycnt5UD6lLDRgy3AicxxnztGoR/w
         vlvElBy8c7NSA7HGACu/4MGMh0X2dzWfW6Ym8Z6PUActhIJLCCIvj2upKpZ9g2maUS
         VpWL9GNynjOG14EJSJ0RDUTSSSu+yETf5e5Etz6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 4.19 005/211] net: qrtr: Stop rx_worker before freeing node
Date:   Thu,  3 Oct 2019 17:51:11 +0200
Message-Id: <20191003154448.374654811@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
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
@@ -157,6 +157,7 @@ static void __qrtr_node_release(struct k
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
+	cancel_work_sync(&node->work);
 	skb_queue_purge(&node->rx_queue);
 	kfree(node);
 }


