Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C790CC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81670204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430461;
	bh=sizR6Xq3/RQtR4jQO/vuWDORMl5pzGPn+/xcWFwpwYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=inaUvQFrNtIedDOu0GrieD4M168n4CpC6QGnG9VkdOXYhctLbKm88Zb9/0q3zuYlj
	 lum4FXnGkXjN4JVJ0lM6xc2sPoSYa9UbX8Am4kyB6WJWeXl9My5dg8haBHUaHxC4p8
	 KQ6F41rAtVYB55jdoTFmNPvdINFtt3hQZCtGy1Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391140AbfG2UBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403887AbfG2Tvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:51:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC2B204EC;
        Mon, 29 Jul 2019 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429907;
        bh=sizR6Xq3/RQtR4jQO/vuWDORMl5pzGPn+/xcWFwpwYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxSrKCH9yVK1Ie1P5NPiOt4lpwafiOTCASNo5XZNg4LHeakJy7MDqsWq05HTbc0vC
         7h/qwnXnyPF5QpQvZNZi2MjOf8mKmn4wTIAZCS3h/eGBbe3ZLfd9WCyN9KPoHbVYfH
         mBGQ2wWX4fdHsAQ0DgLzz0UAvfG/EEbI9xRDMbmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 134/215] nvme-tcp: dont use sendpage for SLAB pages
Date:   Mon, 29 Jul 2019 21:22:10 +0200
Message-Id: <20190729190802.778876364@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 37c15219599f7a4baa73f6e3432afc69ba7cc530 ]

According to commit a10674bf2406 ("tcp: detecting the misuse of
.sendpage for Slab objects") and previous discussion, tcp_sendpage
should not be used for pages that is managed by SLAB, as SLAB is not
taking page reference counters into consideration.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08a2501b9357..606b13d35d16 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -860,7 +860,14 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE;
 
-		ret = kernel_sendpage(queue->sock, page, offset, len, flags);
+		/* can't zcopy slab pages */
+		if (unlikely(PageSlab(page))) {
+			ret = sock_no_sendpage(queue->sock, page, offset, len,
+					flags);
+		} else {
+			ret = kernel_sendpage(queue->sock, page, offset, len,
+					flags);
+		}
 		if (ret <= 0)
 			return ret;
 
-- 
2.20.1



