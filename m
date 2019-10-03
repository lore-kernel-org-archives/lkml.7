Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FFCC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B4621783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122143;
	bh=vXDkuYne+Hy4F82vAvYwB/USPCaWPvacv5O9Bg8gQqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4bN6iSLWtgBWKFbdMGuRnP4zvzqdIxfsud3Ez4wTn4m1+6xiOaTnLzoSZ9hRzfP5
	 k58jP/N+6TTJMlv4SwZfQuYVilz7oTfAdFWm48gQ/gGhLyEPpIW8bh/ZU9Hxts1+Ro
	 sNBoVRrsRoXankRuqnYWIRqratd+hLOnB/FSdtkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfJCQnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404849AbfJCQnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:43:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3584321783;
        Thu,  3 Oct 2019 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120995;
        bh=vXDkuYne+Hy4F82vAvYwB/USPCaWPvacv5O9Bg8gQqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tpl5xkjqI0E1hQAUe1jR/1S1pHEq1dOTHhWI6xjrnhWHO8Z/NSLFNlUuRPb4gOZWe
         BvwNcSgb4gLFKj7E/pX+X8ygHsQPzKc4Uh/7ppXPHG9XBMj2zW8N6CbRqi+3V9JIbI
         Y4t7rp1KMLWjaX3Y3blnNUXGgjV+RbImTk8klA3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 116/344] media: vsp1: fix memory leak of dl on error return path
Date:   Thu,  3 Oct 2019 17:51:21 +0200
Message-Id: <20191003154551.648830907@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 70c55c1ad1a76e804ee5330e134674f5d2741cb7 ]

Currently when the call vsp1_dl_body_get fails and returns null the
error return path leaks the allocation of dl. Fix this by kfree'ing
dl before returning.

Addresses-Coverity: ("Resource leak")

Fixes: 5d7936b8e27d ("media: vsp1: Convert display lists to use new body pool")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vsp1/vsp1_dl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_dl.c b/drivers/media/platform/vsp1/vsp1_dl.c
index 104b6f5145364..d7b43037e500a 100644
--- a/drivers/media/platform/vsp1/vsp1_dl.c
+++ b/drivers/media/platform/vsp1/vsp1_dl.c
@@ -557,8 +557,10 @@ static struct vsp1_dl_list *vsp1_dl_list_alloc(struct vsp1_dl_manager *dlm)
 
 	/* Get a default body for our list. */
 	dl->body0 = vsp1_dl_body_get(dlm->pool);
-	if (!dl->body0)
+	if (!dl->body0) {
+		kfree(dl);
 		return NULL;
+	}
 
 	header_offset = dl->body0->max_entries * sizeof(*dl->body0->entries);
 
-- 
2.20.1



