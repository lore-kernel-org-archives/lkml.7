Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CD3C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 05:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823B620700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 05:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L+Bu+F01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfLOE7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:59:10 -0500
Received: from m12-14.163.com ([220.181.12.14]:45633 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfLOE7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=PYN07ga9WIDB+wBivG
        eJEHKHI7/5TcO/bz7l88Gx8yA=; b=L+Bu+F01N14FGWcFmkeFL3oNfVS2XuqJdh
        OTZ1ZtAK6KEpMKSpynu+KUA/Kj0Nrhy22GvvEpze3aCh0c96Yw9Qx/N7FauK5iKJ
        PrNYwMmf9pijfNcNkjAUp7Y0RdEJy/n+crYTsLA2quo6cr4wk/2muS2/fZkFFIIL
        zmA5KfVow=
Received: from localhost.localdomain (unknown [59.63.206.36])
        by smtp10 (Coremail) with SMTP id DsCowADndU6KvfVds3q4HA--.46459S4;
        Sun, 15 Dec 2019 12:58:52 +0800 (CST)
From:   xianrong_zhou@163.com
To:     dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        haizhou.song@transsion.com, xianrong.zhou@transsion.com,
        xianrong_zhou <xianrong_zhou@163.com>,
        "yuanjiong . gao" <yuanjiong.gao@transsion.com>,
        "ruxian . feng" <ruxian.feng@transsion.com>
Subject: dm: shrink data blocks using bitmap for hash reading
Date:   Sun, 15 Dec 2019 12:58:40 +0800
Message-Id: <20191215045840.9834-1-xianrong_zhou@163.com>
X-Mailer: git-send-email 2.17.2
X-CM-TRANSID: DsCowADndU6KvfVds3q4HA--.46459S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWrJFW7CFyUCr13ZFWxXrb_yoW8GFW5pa
        4jvryY9r18GFW7Wa13Za4xZF15CaykGFW2kryxW3s5ZFZ0yrWftr1kJrW3uFW7tFZxXr9a
        vF43ZrWjka1qvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b6DG5UUUUU=
X-Originating-IP: [59.63.206.36]
X-CM-SenderInfo: h0ld02prqjs6xkrxqiywtou0bp/xtbBzwyMz1aD5wFXkQAAs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xianrong_zhou <xianrong_zhou@163.com>

If check_at_most_once enabled, just like verity work,
the prefetching work should check for data block bitmap
firstly before reading hash block as well.This can reduce
99.28% data blocks which need not to read hash blocks.

The reduced data blocks would be enlarged again by cluster
reading later.

Signed-off-by: xianrong_zhou <xianrong_zhou@163.com>
Signed-off-by: yuanjiong.gao <yuanjiong.gao@transsion.com>
Signed-off-by: ruxian.feng <ruxian.feng@transsion.com>
---
 drivers/md/dm-verity-target.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 4fb33e7562c5..fe4c15a0723c 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -581,6 +581,23 @@ static void verity_prefetch_io(struct work_struct *work)
 	struct dm_verity *v = pw->v;
 	int i;
 
+	if (v->validated_blocks) {
+		while (pw->n_blocks) {
+			if (unlikely(!test_bit(pw->block, v->validated_blocks)))
+				break;
+			pw->block++;
+			pw->n_blocks--;
+		}
+		while (pw->n_blocks) {
+			if (unlikely(!test_bit(pw->block + pw->n_blocks - 1,
+				v->validated_blocks)))
+				break;
+			pw->n_blocks--;
+		}
+		if (!pw->n_blocks)
+			return;
+	}
+
 	for (i = v->levels - 2; i >= 0; i--) {
 		sector_t hash_block_start;
 		sector_t hash_block_end;
-- 
2.17.2


