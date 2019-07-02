Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6EBC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1852421850
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054801;
	bh=yjCcY9DRKK+2KTOoUZ8WFBGZWZAX7LGFvjpLvoKNIWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xxpVpn4WcFTLOqPTZdE4GD7CGL1gEenWTJ6ecuFvcHduHYhWWeFM+r6OSq7mTptZL
	 N0fVUveMmtRFKIX7erqCuekeZxxxjTFerR1TSC37bokbqn1ewdqbS2vX7OdG7Gkvsm
	 VIVDwAvCoid7TQ4QzM3N+f1pFw+j9AUupxnE2xJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfGBIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbfGBIGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:06:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7690221841;
        Tue,  2 Jul 2019 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054795;
        bh=yjCcY9DRKK+2KTOoUZ8WFBGZWZAX7LGFvjpLvoKNIWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxA3HuD0G6UKvQQGl6rypTtKdETA2bH/uf8ACDfOv7xR5a+feyTkw1ARLcla2mOX3
         +UIahwao9cur1HexT/ad2pJyvTtyNpJX/cUAxlyDTyrnq3hu5EI139L8dVag25hQca
         JQWDSxG+GFiUEDNp+SPGvlmTtBTo+gYKyZ/5x+h4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/72] 9p/trans_fd: put worker reqs on destroy
Date:   Tue,  2 Jul 2019 10:01:21 +0200
Message-Id: <20190702080125.710733925@linuxfoundation.org>
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

[ Upstream commit fb488fc1f2b4c5128540b032892ddec91edaf8d9 ]

p9_read_work/p9_write_work might still hold references to a req after
having been cancelled; make sure we put any of these to avoid potential
request leak on disconnect.

Fixes: 728356dedeff8 ("9p: Add refcount to p9_req_t")
Link: http://lkml.kernel.org/r/1539057956-23741-2-git-send-email-asmadeus@codewreck.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_fd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index a0317d459cde..f868cf6fba79 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -876,7 +876,15 @@ static void p9_conn_destroy(struct p9_conn *m)
 
 	p9_mux_poll_stop(m);
 	cancel_work_sync(&m->rq);
+	if (m->rreq) {
+		p9_req_put(m->rreq);
+		m->rreq = NULL;
+	}
 	cancel_work_sync(&m->wq);
+	if (m->wreq) {
+		p9_req_put(m->wreq);
+		m->wreq = NULL;
+	}
 
 	p9_conn_cancel(m, -ECONNRESET);
 
-- 
2.20.1



