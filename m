Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE342054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155181;
	bh=isWgQL8oAvhDesX3jX8Kg4zXgZ+BM6SzrDwebKcjy+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WMWM9Ly7fBV255h/brEHiz4/Mi/zEf0S/OVwgTMu7SDIixh9MP0Zc7k49uzS188dO
	 5rIxOIDkG380hXJxRbW7ktnI6G/5SBOqZzdbB+rM2ayVmLhJ+Zd1FlBa1xIjOkkxlW
	 oUjRHYxOx1MLfd4xJGMBOrHnNVK3mn50q+ak1e5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbfGZPdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfGZPc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:32:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0F120644;
        Fri, 26 Jul 2019 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155177;
        bh=isWgQL8oAvhDesX3jX8Kg4zXgZ+BM6SzrDwebKcjy+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtBQbE+s7n74aqnhDUdxxBJnXqK9GsSBxLMRkGKNsYCcmDymXndNU5FBbpSp6kb7t
         CWqL/ERMFQ/wNsMXx/tdC0amYRAQpfU57tkp53HALmn6Bjw4X5vIX8+uIGrwO+qYmw
         GYlnjonBhs8Z3ynl4LMOFle1xTEkqRLGjvkQuVJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 03/50] hv_netvsc: Fix extra rcu_read_unlock in netvsc_recv_callback()
Date:   Fri, 26 Jul 2019 17:24:38 +0200
Message-Id: <20190726152301.083757733@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152300.760439618@linuxfoundation.org>
References: <20190726152300.760439618@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit be4363bdf0ce9530f15aa0a03d1060304d116b15 ]

There is an extra rcu_read_unlock left in netvsc_recv_callback(),
after a previous patch that removes RCU from this function.
This patch removes the extra RCU unlock.

Fixes: 345ac08990b8 ("hv_netvsc: pass netvsc_device to receive callback")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -847,7 +847,6 @@ int netvsc_recv_callback(struct net_devi
 				    csum_info, vlan, data, len);
 	if (unlikely(!skb)) {
 		++net_device_ctx->eth_stats.rx_no_memory;
-		rcu_read_unlock();
 		return NVSP_STAT_FAIL;
 	}
 


