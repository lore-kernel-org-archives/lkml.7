Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8D5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429FB2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127228;
	bh=jjc4nlS43+SDDCbP9YdXP23XiLc1LXmvXpMh1zpjsE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=038SDb4dR8H7oEPIr7c7AosA1oSr02ItSqB5xZP38qhyrWzvzc1R1z+vdTflQsxe+
	 4SLnDIT47hpBD2NHICQbJqbS1+SvC4GX9pvgJYBmlDfYdletA6BwFA5dGDme5ocynv
	 E1M4p5UkXR20+4EU0UzdsnqJ6BQEUIXm8rCFgSZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391569AbfDXRdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390909AbfDXRdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:42 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BB9218B0;
        Wed, 24 Apr 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127221;
        bh=jjc4nlS43+SDDCbP9YdXP23XiLc1LXmvXpMh1zpjsE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRc4Te4/8j/fq5id27KCwjcWSYtSep6YJxy6gOIZO6pb/8/oC3jNPdZsNTr/SSdIC
         Fq5Pq5NIXaJFiJxxyq0ik/cIf5DHyKurk7hHkSwjTFaZX+x/I9mbLLfph96way+nG5
         TyEELhSeRi/syjb0fP0MjYfa8SUrFMABIhHVbj+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 012/115] vhost: reject zero size iova range
Date:   Wed, 24 Apr 2019 19:09:08 +0200
Message-Id: <20190424170925.698947823@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 813dbeb656d6c90266f251d8bd2b02d445afa63f ]

We used to accept zero size iova range which will lead a infinite loop
in translate_desc(). Fixing this by failing the request in this case.

Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -911,8 +911,12 @@ static int vhost_new_umem_range(struct v
 				u64 start, u64 size, u64 end,
 				u64 userspace_addr, int perm)
 {
-	struct vhost_umem_node *tmp, *node = kmalloc(sizeof(*node), GFP_ATOMIC);
+	struct vhost_umem_node *tmp, *node;
 
+	if (!size)
+		return -EFAULT;
+
+	node = kmalloc(sizeof(*node), GFP_ATOMIC);
 	if (!node)
 		return -ENOMEM;
 


