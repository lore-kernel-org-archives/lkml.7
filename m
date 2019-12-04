Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F38C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC6620675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483472;
	bh=rbDfZ37pyFkTziq+H9O55VekzIqVmSm6qVNT7/Ygp88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R2y+CYCDduHT6PZHT/An+szHpOUb8xKGvHvlxQwCn1Zlsuflg+TkTc17wMjVhu0Ic
	 2bsArqyhWGKrswr1y8k6HGKvkio8+2NAJyYDqP4iav5t17mzikNWKx52xS5ScSSQXa
	 ki6380YPn50yn4x+vGctNK5GWKSfDQf5uoHq3I2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfLDSRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:17:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbfLDSLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:11:24 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D71802084B;
        Wed,  4 Dec 2019 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483084;
        bh=rbDfZ37pyFkTziq+H9O55VekzIqVmSm6qVNT7/Ygp88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFX5VbZZMwZCWOrSRZEo7YI/qstubkYWoFCXcYD1oEwR7MfD30kIxG6fzwnYQfpQT
         i6M4263QBPjZ38QA9+Nu0PUzioEjSdr+dCenz8vc5ygRKt2tc3UUT1vLFg9xqeDqQ9
         7Ohob/eWrE1T2oXpqOLPjUBnwZarqtzEf9N5PPGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 046/125] gfs2: take jdata unstuff into account in do_grow
Date:   Wed,  4 Dec 2019 18:55:51 +0100
Message-Id: <20191204175321.766471076@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
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
index 39af17b407f00..d83e99fa98b3a 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1236,6 +1236,8 @@ static int do_grow(struct inode *inode, u64 size)
 	}
 
 	error = gfs2_trans_begin(sdp, RES_DINODE + RES_STATFS + RES_RG_BIT +
+				 (unstuff &&
+				  gfs2_is_jdata(ip) ? RES_JDATA : 0) +
 				 (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF ?
 				  0 : RES_QUOTA), 0);
 	if (error)
-- 
2.20.1



