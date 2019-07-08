Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB1C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B57A2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599241;
	bh=RuCd3mBU/YnHzV8tqwPc4vB+QugbZ7+ubgJ+TwVioV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nGL1ADlTmCE4YXTMv9A64RbjZUCbjYibN/j6k8bwmHituliXGbmCoKpdPnAx11NAv
	 rFMwe8LoNC2K36fILAAYMrgeGdQ5dnKQw/OZXn71LBtozTVaS31/UVXNvLt15k809v
	 YP6gH7xawYN1Uh/9QxW0ekaBqwg/Jd5zb7MgdJoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbfGHPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387599AbfGHPUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:20:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8153621707;
        Mon,  8 Jul 2019 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599238;
        bh=RuCd3mBU/YnHzV8tqwPc4vB+QugbZ7+ubgJ+TwVioV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYi4yF7yb9uLuWWaz/U5zah44YC8QO3qCL8HgLIlkGD1U8l66kiZrfyRwqJTk3SWz
         KEvqa83qq3hmVg9Aydmu3hqRqPMMaTg5iBx8FI9DVlLAQs2AJvAlJGkRwtLtcToWgL
         MGIEUskWGPSQXWsoIaIgwOG8Za9PpgQrylbFyrHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 042/102] 9p/rdma: remove useless check in cm_event_handler
Date:   Mon,  8 Jul 2019 17:12:35 +0200
Message-Id: <20190708150528.598293344@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
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
index 9662c2747be7..8e4313ad3f02 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -254,8 +254,7 @@ p9_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
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



