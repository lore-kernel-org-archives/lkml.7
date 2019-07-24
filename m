Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD28C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6062238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996508;
	bh=+E7l2ji47+QPKyzCYtnJU/gcwcZY0L7QrDYr5U6InH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mpJfRERVSW8XANgjy7gIzpQdoK77ANh/piZmntfASDOVAkjx4KvU+SgOFPd0zVe7U
	 536wbaRoSWihLjHW9NMekXuToQpC1C1Q3fxpPM5bdytRK+rrDjqw/8YKHC1oE7YOva
	 e1JHRTPuGAJOM7lKYiKjXL7GtWWbWFg5p82LzJKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfGXT2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbfGXT2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:28:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48B321951;
        Wed, 24 Jul 2019 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996500;
        bh=+E7l2ji47+QPKyzCYtnJU/gcwcZY0L7QrDYr5U6InH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBtYh1A4Cf46UhJmYjGAQG1UhwDgmt8EjzO4TkSMfPuQxrLxHSUvg7FGlftOMTK23
         8pDRHct3Z6oRzcNJkdC71kXj+ZSJ5MUk9SB3vqMrmVFF2bGw72CqmKQXrJ2LkM7Y6J
         hf32G2FSgdfelruvVYzZfJuDg3bS7cyQO7jgyE9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 116/413] vhost_net: disable zerocopy by default
Date:   Wed, 24 Jul 2019 21:16:47 +0200
Message-Id: <20190724191743.595313393@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 098eadce3c622c07b328d0a43dda379b38cf7c5e ]

Vhost_net was known to suffer from HOL[1] issues which is not easy to
fix. Several downstream disable the feature by default. What's more,
the datapath was split and datacopy path got the support of batching
and XDP support recently which makes it faster than zerocopy part for
small packets transmission.

It looks to me that disable zerocopy by default is more
appropriate. It cold be enabled by default again in the future if we
fix the above issues.

[1] https://patchwork.kernel.org/patch/3787671/

Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index d57ebdd616d9..247e5585af5d 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -35,7 +35,7 @@
 
 #include "vhost.h"
 
-static int experimental_zcopytx = 1;
+static int experimental_zcopytx = 0;
 module_param(experimental_zcopytx, int, 0444);
 MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 		                       " 1 -Enable; 0 - Disable");
-- 
2.20.1



