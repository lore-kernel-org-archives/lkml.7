Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC7C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED85720652
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054972;
	bh=NyC9PH7p/AXAVNh4o5PPa/b01sXVyxqXRA3P2gRCTl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1eCcEQo0WaW9wV6cfnxIM8FjGkFn0BMzPUQMFf+eLMlErzID3qKXqRKIGfGraHkwO
	 yq/ZG6/Gp9UvCePy37eyT0P2IyaDMQBc9nmZ4LOgeZ47mtJzQakZYvvTkqmXHGhz/2
	 /UyUumHziWAYpKubWNFuIsJFqYQfWQbsjzQx7WUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfFTSKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbfFTSKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:10:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408A021530;
        Thu, 20 Jun 2019 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054208;
        bh=NyC9PH7p/AXAVNh4o5PPa/b01sXVyxqXRA3P2gRCTl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sb2MTtVyYKgc/4/51R6xtVBrBW47N1jrPdBJbDhpZU1csQSUjOT1ZUOawBGjjp35l
         p1yLuet5CcZWPsk7VGN6+VjLT1xtDF3lnqYB/s5dDxYe7I5L/ke0/CWQJYy22vL9Js
         kRSyaHdxwjNxECGrnT+cPHCok9DgIiaBe6/N5/c0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 03/61] hv_netvsc: Set probe mode to sync
Date:   Thu, 20 Jun 2019 19:56:58 +0200
Message-Id: <20190620174338.037054513@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 9a33629ba6b26caebd73e3c581ba1e6068c696a7 ]

For better consistency of synthetic NIC names, we set the probe mode to
PROBE_FORCE_SYNCHRONOUS. So the names can be aligned with the vmbus
channel offer sequence.

Fixes: af0a5646cb8d ("use the new async probing feature for the hyperv drivers")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2405,7 +2405,7 @@ static struct  hv_driver netvsc_drv = {
 	.probe = netvsc_probe,
 	.remove = netvsc_remove,
 	.driver = {
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 


