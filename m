Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C360C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA14221872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419727;
	bh=6wmrga3ZcLr1yMrWaBJLuMHhuIkPguBpD00SQX/+ps0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UIbdC4TMVwL+SWsV2LTG9HHqbvyZQEFfRSa2ZlaGmFdsjDgK9cL8NLFpJZ7/uk/It
	 kIvWCJfGvbAXCQRoUj8aMr6yxmrxrIoxcNY3i89Ina/r4YKXblQyEMQpHznEANzEZU
	 xPGTo1boNqGMTiYjHJ+XrreC6j+iPJ3l18T53TKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392046AbfGRDP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391955AbfGRDPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:15:07 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B48A72173E;
        Thu, 18 Jul 2019 03:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419707;
        bh=6wmrga3ZcLr1yMrWaBJLuMHhuIkPguBpD00SQX/+ps0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Inc9eW14W1pCbelnpUkfpQF4o9UhmGmBJvXDEZ6dAx0C86UDcSCKw04W63UnTxWEE
         1PPGua2tQr+pcQkT6AC4aP6dzC1qzCLxNllD5me9TMUMkhXzajFA/8JB0IZfjkqMV+
         sj9Sf3DfqIFX7blMJ/tsBuWCGiDgzHLp6nPkpCcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 34/40] dm verity: use message limit for data block corruption message
Date:   Thu, 18 Jul 2019 12:02:30 +0900
Message-Id: <20190718030050.031337379@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030039.676518610@linuxfoundation.org>
References: <20190718030039.676518610@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2eba4e640b2c4161e31ae20090a53ee02a518657 ]

DM verity should also use DMERR_LIMIT to limit repeat data block
corruption messages.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity.c b/drivers/md/dm-verity.c
index ccf41886ebcf..7054afd49f82 100644
--- a/drivers/md/dm-verity.c
+++ b/drivers/md/dm-verity.c
@@ -221,8 +221,8 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
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



