Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43769C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B452184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054939;
	bh=wNWS8nkr5rgx+OzTX5n5GmmC/NfndRbcytkcoy3MqBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7h7WElw4dHqYntH1Hjt+QxKTVL5XvM4Q+BWuHpPaWe9W+bfcDU2gpXPN89LQawAt
	 Av1VCVY0JK1Rta9ugCUp0RmKyEKolhVLKferzotohOICa/48gYPsHnr5sfVLHgtA04
	 x9ms/fhyjN9DNhLhUrR94WgZVTEQjmMI7pqS2yhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfGBII5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbfGBIIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:08:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87E52064A;
        Tue,  2 Jul 2019 08:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054934;
        bh=wNWS8nkr5rgx+OzTX5n5GmmC/NfndRbcytkcoy3MqBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xc5jv2gX36pdtXTRJQejnwUXfQmH1gzoZVp4ZkQc2SigA9sXOk+3jn8Ym4nKVyrFz
         226R/dnYRwmRlB/blA6uv7wWj9xpq071nRKIumxerbnCm7UW4r9iPH1Hnez0LFua2C
         FzmeU99XG6oYLOgKLbvkmhXFJAkpq12w30reo+qY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 11/43] 9p/rdma: remove useless check in cm_event_handler
Date:   Tue,  2 Jul 2019 10:01:51 +0200
Message-Id: <20190702080124.406606983@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
References: <20190702080123.904399496@linuxfoundation.org>
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
index b7648b12bb1a..16a4a31f16e0 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -276,8 +276,7 @@ p9_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
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



