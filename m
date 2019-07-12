Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28779C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E78216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934088;
	bh=MtxjDmJkgosiEDlBS85alGVGA9k3LeekgI7UBvXb4os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oi/gZ6Q51ZGKcPkN8Wu+DYnX5KhTMTns25OyCnu83XoEkSnyfRchw1Qnbbt4ig0J8
	 L3asFQcbbcD7a65AoJGV7FfXKs8OuiXhLpXQzmRq1N1Whwp6qjKUVqNsfgKMPLTET+
	 H2CJLRHgJUEoEoAYYbRXOnoeYZUJpbDVTjbGuvcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGLMV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfGLMVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:21:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456BD21019;
        Fri, 12 Jul 2019 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934082;
        bh=MtxjDmJkgosiEDlBS85alGVGA9k3LeekgI7UBvXb4os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3sMJtyJKZ90LUFIiyUqbYKzW3U2TfZpmhOota6rtzr8W72dWsUCPMGbyG3yMYUPP
         o6ZZZ3aMagT2sjq+XXnmpFeFOXrzu2IBwhMF+D+iqCXQNUBHW9MJdnGJZcXU4nGL41
         pa0cQ9KGJix+b8tjK+r1zbli/xM6ikXY0RZlXcVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 39/91] bpf, devmap: Add missing bulk queue free
Date:   Fri, 12 Jul 2019 14:18:42 +0200
Message-Id: <20190712121623.535046534@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit edabf4d9dd905acd60048ea1579943801e3a4876 ]

dev_map_free() forgot to free bulk queue when freeing its entries.

Fixes: 5d053f9da431 ("bpf: devmap prepare xdp frames for bulking")
Signed-off-by: Toshiaki Makita <toshiaki.makita1@gmail.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 99353ac28cd4..357d456d57b9 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -186,6 +186,7 @@ static void dev_map_free(struct bpf_map *map)
 		if (!dev)
 			continue;
 
+		free_percpu(dev->bulkq);
 		dev_put(dev->dev);
 		kfree(dev);
 	}
-- 
2.20.1



