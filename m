Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82E5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886BF217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610389;
	bh=Y7CGsYJxBxRuOgDHHUseqWqqQPVywHCix9nRlMpzOrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ayu+yTJF2bHOC2kzhGtFd+OD6oI3d+LXVne9Cnw4e0/7mVgNs8+z8GnTygsba6dHm
	 MvB24CxpXYXrhafk2DTcFXDsDS34+v6m4nTBfPxYYkS/yPdJzfMhaKoyHt8swHhiMM
	 bhSxG0PPCMxtDn56AQLLq+EPdYilrsaQs/pMJ6m8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbfDRR7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390187AbfDRR7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:59:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D3A21872;
        Thu, 18 Apr 2019 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610384;
        bh=Y7CGsYJxBxRuOgDHHUseqWqqQPVywHCix9nRlMpzOrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CapW9kxom+fh/IPOKTIEl0cLm7sal0odrqQjHQnrE4OLfFWbe+JdcV0kbKBIEMNkI
         2sZQCs5ENZxPb8jJ/kokDaiZuexEMcitMtdVDp6JdYHgrhNmi47vejajPo70FBBlDT
         UJQ5b6VGwt/Lni60gEsj9Sc6d1z6ESsRPgwtBI08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/110] blk-iolatency: #include "blk.h"
Date:   Thu, 18 Apr 2019 19:56:29 +0200
Message-Id: <20190418160442.780004344@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 373e915cd8e84544609eced57a44fbc084f8d60f ]

This patch avoids that the following warning is reported when building
with W=1:

block/blk-iolatency.c:734:5: warning: no previous prototype for 'blk_iolatency_init' [-Wmissing-prototypes]

Cc: Josef Bacik <jbacik@fb.com>
Fixes: d70675121546 ("block: introduce blk-iolatency io controller") # v4.19
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iolatency.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index b154e057ca67..6b8396ccb5c4 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -75,6 +75,7 @@
 #include <linux/blk-mq.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
+#include "blk.h"
 
 #define DEFAULT_SCALE_COOKIE 1000000U
 
-- 
2.19.1



