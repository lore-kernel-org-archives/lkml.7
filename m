Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C827C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5768214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413485;
	bh=VuJLFF+98QvkWxdbK4hp/Y/tQqKfJY/Eub1jtxof0Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cYsNV2WXXfqK8I1BubNcDP0TBFZNzSEyt973EZvBhMU6weH/UjiBZRv7uwxHBbwd6
	 /PkZh8P+VGRCaJ6lN4yKJWRVSZaxf16ysZCpxARQ+wchY4i8/IqiEP8TJeWryOE5EN
	 3K8bFvY/HhSc8Ns4xtC9x+MPUVmTeQBPtW1gRF90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfLCWvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbfLCWvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:51:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F68520848;
        Tue,  3 Dec 2019 22:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413481;
        bh=VuJLFF+98QvkWxdbK4hp/Y/tQqKfJY/Eub1jtxof0Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlP0QjhPtl1HrVpr+lZ/abMjpEKXHhvTo2Up4ZeGaTZCGPTw6gXOUh117wpRFjK2Z
         ALEUh71OjNN3TSts8tYOosExUNeXHEw5Yt6ou9NF+WPkjX7BYCT1bw5rDqFFoI49uJ
         sDn1XSTwzuTLKdt8dgP/2Gxgf1GUBThY/1P3e9M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 145/321] gfs2: take jdata unstuff into account in do_grow
Date:   Tue,  3 Dec 2019 23:33:31 +0100
Message-Id: <20191203223434.699057037@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit bc0205612bbd4dd4026d4ba6287f5643c37366ec ]

Before this patch, function do_grow would not reserve enough journal
blocks in the transaction to unstuff jdata files while growing them.
This patch adds the logic to add one more block if the file to grow
is jdata.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/bmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 52feccedd7a44..096b479721395 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2122,6 +2122,8 @@ static int do_grow(struct inode *inode, u64 size)
 	}
 
 	error = gfs2_trans_begin(sdp, RES_DINODE + RES_STATFS + RES_RG_BIT +
+				 (unstuff &&
+				  gfs2_is_jdata(ip) ? RES_JDATA : 0) +
 				 (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF ?
 				  0 : RES_QUOTA), 0);
 	if (error)
-- 
2.20.1



