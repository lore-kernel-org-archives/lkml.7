Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63998C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2523421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128656;
	bh=k9BLzuJwQ5Xa5RfoGP+O1cfgXNLaWA3XlZEzvq1cypA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GtndL5lJ9F5ht4G+Rykcp7mP6mj4oNDZw8g901ZIGiUOPjoiECm6BOGNmmgYsw90J
	 e+rB987VHT2CmA31riDdY5W5QKfV2QagY6tR4yTKd3kVwB/TA+hcC3G04U0ojhptSH
	 CAWvdz7xnBfHQlOivzAsfQM0zb6cuHPaKd34mTO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390114AbfDXRZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390103AbfDXRZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:25:49 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8771020835;
        Wed, 24 Apr 2019 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126749;
        bh=k9BLzuJwQ5Xa5RfoGP+O1cfgXNLaWA3XlZEzvq1cypA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0atkYX4So8FapSh9daXdmX33S5tW8nAMdxePPCofDMiwtt1at5wpySK+cTaZRvdO
         BkPaQlmOE1DaX7uIi1rmUCj6HHGO51JqQGWelthIKuZGQDNlaOAGBp2DGGj3VWzYEp
         z0MvfH3dDGtf+/NtBSl16R9HK6/D3bKC2zYdFkCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 08/44] vhost: reject zero size iova range
Date:   Wed, 24 Apr 2019 19:09:46 +0200
Message-Id: <20190424170846.045701214@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
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
@@ -863,8 +863,12 @@ static int vhost_new_umem_range(struct v
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
 


