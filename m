Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D0AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE342081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482659;
	bh=10mWWT/+sQJ8k9+SlcHH9VNCLlTJmEdm5aHgXpgbuHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0RYV6s5yI6A7xmoPbUHskfj4R0PvBplI+1SjT9L8NBFhU268X2ozcVSszryj5S0pF
	 VKnwvnohNGzdYCmPWBno7els2X1jpAQ/74fpg3GqKKmnoeFmxoOmMRFC8UAcxUgyOQ
	 ugg074241ext92syBuUv3wGcfpT2zEOO+u273qkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfLDSER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:04:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbfLDSEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:04:01 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A29F20675;
        Wed,  4 Dec 2019 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482641;
        bh=10mWWT/+sQJ8k9+SlcHH9VNCLlTJmEdm5aHgXpgbuHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKnOLJP5O20QeZ/rae1JGVq7vkF80OWteQ/fWOTFF2rxi5F+exCqIihVW1xay2Uog
         i2oFxbIPiM8/eynelpBbgEFFI83Y+PDBzvL76pxXIbWysKhR9mLkuzbDJIFK9PZ28Q
         fpQ2oILFzB70+UvO7ZEhccbhPY+ZBcO+NUER+KVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 076/209] gfs2: take jdata unstuff into account in do_grow
Date:   Wed,  4 Dec 2019 18:54:48 +0100
Message-Id: <20191204175326.642173640@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
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
index 09432b25fe9b8..b3a1b16d4e3e3 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1445,6 +1445,8 @@ static int do_grow(struct inode *inode, u64 size)
 	}
 
 	error = gfs2_trans_begin(sdp, RES_DINODE + RES_STATFS + RES_RG_BIT +
+				 (unstuff &&
+				  gfs2_is_jdata(ip) ? RES_JDATA : 0) +
 				 (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF ?
 				  0 : RES_QUOTA), 0);
 	if (error)
-- 
2.20.1



