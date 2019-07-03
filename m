Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C98C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFE621874
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120322;
	bh=hJWBrA4XlxLq7geA1Mb2y33j+IkLYP6GrMjtjDJdwsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yfyI1Z9YhZdZKZJ9VwjaUpHymrtJd7ux4qybPbSHJaFpWCIy9QQ8UrJFb3tS6xf/2
	 kzxkA2UWysfMqKAmyrJb79eBqk2dWaP1n6HbgaWX27D8sdi61gPgpU3DPJI1s3XS+G
	 18kXVidTKM0LIGp6zUcOjRmCxie8Nb5+XRwoPc5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfGCCSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbfGCCS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:18:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F9C21874;
        Wed,  3 Jul 2019 02:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120307;
        bh=hJWBrA4XlxLq7geA1Mb2y33j+IkLYP6GrMjtjDJdwsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1VLI1D21LS8bBf3GTdLyfzBN6YCVEn2M3wq3fOaiIqXqn0J/F3DY03kqgljMX6eY
         teueACOt5geThqR+O608b4zADILsPEwXEYdex0Hc7AXVWG68514ay1eJzQ9vrVQDDA
         8jYJh/MGjvTqXRFQv99+Coh/3YUwKdcxJojudzeo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 10/13] dm verity: use message limit for data block corruption message
Date:   Tue,  2 Jul 2019 22:18:11 -0400
Message-Id: <20190703021814.18385-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021814.18385-1-sashal@kernel.org>
References: <20190703021814.18385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <gmazyland@gmail.com>

[ Upstream commit 2eba4e640b2c4161e31ae20090a53ee02a518657 ]

DM verity should also use DMERR_LIMIT to limit repeat data block
corruption messages.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 8573c70a1880..e705799976c2 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -276,8 +276,8 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 		BUG();
 	}
 
-	DMERR("%s: %s block %llu is corrupted", v->data_dev->name, type_str,
-		block);
+	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
+		    type_str, block);
 
 	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
 		DMERR("%s: reached maximum errors", v->data_dev->name);
-- 
2.20.1

