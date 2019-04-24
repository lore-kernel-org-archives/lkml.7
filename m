Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A759EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7697C21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126829;
	bh=fkrAo3CRXQJ5cpYWNgNdmKqKn5QfHn5vc3gBPPoj/1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n3Vk6JqFVLJ6QLhXJNT+dw6OuT23xLD1h2Bsu1dNe1KDdz9XIslE+6YL+MK3t8YPe
	 +VjcYTkIMlajULVJWDwU+DgVhXaUtSJPNQO1JznmFqydSBam2QxK7yYcptzXAwwB95
	 tEwlrKDxEWqE2X7UxFcbxhKP5co5Lgdlo8i1/+p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390384AbfDXR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390244AbfDXR07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:26:59 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC162054F;
        Wed, 24 Apr 2019 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126818;
        bh=fkrAo3CRXQJ5cpYWNgNdmKqKn5QfHn5vc3gBPPoj/1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixZKLo5qLAR84vJH0jMYDLJjP3EhOJeM/2wO46+DadYinpuEvm+l9PTNzDLqnNOTH
         Zc/STC9iKBfRYb7pdW3fDiO7cwoIsOq4baFMWYGRtfulGXSPbX+mIWzeWOmW62GrW+
         QTLv0axfWZcFN9aZzpjEkG1B70iDQ/00a/ymI2y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/70] vhost: reject zero size iova range
Date:   Wed, 24 Apr 2019 19:09:28 +0200
Message-Id: <20190424170908.437752211@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
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
@@ -918,8 +918,12 @@ static int vhost_new_umem_range(struct v
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
 


