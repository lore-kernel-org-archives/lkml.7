Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421E7C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184802183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054736;
	bh=tmrRpToP0yBZBOWOYKJ630REmNkOgHXMERgKfsDOU+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zI4ZIyHnvHjlthq9NDXZ+TXhgpbPXFWf9S+kXiCpaqMnWXHksPrTULwxjMNLB32Sg
	 9Nf74/5xASXVeQ2a/tKQJIHM4EHXJo31xs+y0IMOfu7+h1HUJpc2cUNpiNOr8vbNm5
	 jz9xDH6XSpYj9hx7o4ZzL4Qew6cT+fplWUKBZaPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfGBIFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfGBIFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:05:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8415C21479;
        Tue,  2 Jul 2019 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054731;
        bh=tmrRpToP0yBZBOWOYKJ630REmNkOgHXMERgKfsDOU+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPlBJ/A5VTotnJYtnO+5TNWFqvkOC7I/EDN3sqdxjs6g086PS5Gr3LTJYzlVoJjs0
         xCrzwLIiFV4WGbXGIQtU8e9Z0SX2mAmZQB9AkQxqdKCRPn9vaq//8om3pkF0o8cTgX
         OQGj0lKAl2FMqB5WChol3wON+DGdA2Wa0o/PCT2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 16/72] 9p/rdma: remove useless check in cm_event_handler
Date:   Tue,  2 Jul 2019 10:01:17 +0200
Message-Id: <20190702080125.471040955@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 473c7dd1d7b59ff8f88a5154737e3eac78a96e5b ]

the client c is always dereferenced to get the rdma struct, so c has to
be a valid pointer at this point.
Gcc would optimize that away but let's make coverity happy...

Link: http://lkml.kernel.org/r/1536339057-21974-3-git-send-email-asmadeus@codewreck.org
Addresses-Coverity-ID: 102778 ("Dereference before null check")
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_rdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 9719bc4d9424..119103bfa82e 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -274,8 +274,7 @@ p9_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	case RDMA_CM_EVENT_DISCONNECTED:
 		if (rdma)
 			rdma->state = P9_RDMA_CLOSED;
-		if (c)
-			c->status = Disconnected;
+		c->status = Disconnected;
 		break;
 
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-- 
2.20.1



