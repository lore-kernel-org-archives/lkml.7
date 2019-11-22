Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C509C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A102084F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420910;
	bh=m+qnqZ/ShNKNjyAacelus/FWNvJ3XrIxXhEmoCmrUqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Qb2kTsCFGeSoexIIkusjBAoVcR2pxT8Bzzbfzdr69Qa4vU5vFwkZdR4ekn/0J6wa
	 WVYH0FkJ9FCbEycXJCM8Apv2LElvsxW2Qqbrv9lgs+UdfVAbj23qSZYYiv6dTR7zXq
	 WnEVnf5PiBO1nPWqCGelrLZgsOk4KHiNTg5AyZr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfKVLI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731527AbfKVLEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:04:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FCB920659;
        Fri, 22 Nov 2019 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420652;
        bh=m+qnqZ/ShNKNjyAacelus/FWNvJ3XrIxXhEmoCmrUqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eREajUEGjnKTwQGmQ3/w49UbdJCuLIKK9t2Wx6mAPWYph8/VXsfYVf0F7b9d75lk/
         cN3EuECApCTkA/8u/WRItS4BMgYRKoXwB4efqVJvUJVKf9AUfQdKcmsF8d9M0Lx72e
         qZ3m5METfmKinJUROBbMDhI54Mzgh9RUd7lX6i5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 181/220] lightnvm: pblk: guarantee emeta on line close
Date:   Fri, 22 Nov 2019 11:29:06 +0100
Message-Id: <20191122100927.321487329@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

[ Upstream commit 9cc85bc761f83da41935cdd6edcdb7c122bc90bf ]

If a line is recovered from open chunks, the memory structures for
emeta have not necessarily been properly set on line initialization.
When closing a line, make sure that emeta is consistent so that the line
can be recovered on the fast path on next reboot.

Also, remove a couple of empty lines at the end of the function.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index fd322565fb0f9..8dce31dbf2cbc 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1773,6 +1773,17 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 	wa->pad = cpu_to_le64(atomic64_read(&pblk->pad_wa));
 	wa->gc = cpu_to_le64(atomic64_read(&pblk->gc_wa));
 
+	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
+		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
+		memcpy(emeta_buf->header.uuid, pblk->instance_uuid, 16);
+		emeta_buf->header.id = cpu_to_le32(line->id);
+		emeta_buf->header.type = cpu_to_le16(line->type);
+		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
+		emeta_buf->header.version_minor = EMETA_VERSION_MINOR;
+		emeta_buf->header.crc = cpu_to_le32(
+			pblk_calc_meta_header_crc(pblk, &emeta_buf->header));
+	}
+
 	emeta_buf->nr_valid_lbas = cpu_to_le64(line->nr_valid_lbas);
 	emeta_buf->crc = cpu_to_le32(pblk_calc_emeta_crc(pblk, emeta_buf));
 
@@ -1790,8 +1801,6 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 	spin_unlock(&l_mg->close_lock);
 
 	pblk_line_should_sync_meta(pblk);
-
-
 }
 
 static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line *line)
-- 
2.20.1



