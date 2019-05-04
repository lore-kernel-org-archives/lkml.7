Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9AFC04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5B8205F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="IN6g+teZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfEDSir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46106 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfEDSih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so7809313ljk.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/OOtnTLbHkDmzeoCsG8b330LBNfWdHUw38JK4lULhs=;
        b=IN6g+teZxJLSd4CWb8gsZxUB2CnlGhDdLwQwDmgt543orjSm9K4ZMFa2vMCP26xjjB
         bzzlZqa2QKzkBH97Am//OgCK2cC+hDYLIrKloGM/Ga9pZgnNyMozYokSm0/iSZnnjypI
         8i6nCNp/Blx2FZR5a1rwfUwtTAiQCoyyijpsDIIT2jNNERxdm6zX48wIiPAKDH8z2kb1
         oX0j1lxIwIJ4mS8F6EF9fzX5OhEeqO6tmIIqSidWNDEVTDn1H3IDWt+S1Z8qXduwqdhU
         qo4GCV8gL6xUvtF9dq5fNI5t5oFQdvYFBB+tMxGxb+u/skKOt6rpB3QdMFthW1Dib9bi
         6DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/OOtnTLbHkDmzeoCsG8b330LBNfWdHUw38JK4lULhs=;
        b=enE+T9e+hClSkys8tcaSiBSX727wiBOvgjl827kxnM9rANjAW/g8z1zAccZzZqM8NC
         ZelF5y539jZeMN4q6JBZpbjOcxLPgbz35nAQvfA6GQ2ckkxCBLFEqdN5Vo4TSHqmo/5u
         2j/SEkacTMiTgxJ+iILTh3iK8not96k7iBi5wFelSAZlDGz0CtfHEIPBKXVx9ktHd4vN
         MYl3YODKSWgNOWmsuFL0ZEiSyrzOY90QMw9dn/0tVGjO36w0qQ/TLSp6ufnO4DqQ/7+q
         aMe8vExJ79+YAAb493iv4+5ML2ovsl2XA2n7mbgNm80mmqTMVS4mvz2TAyLr7K4CnxtT
         +wIg==
X-Gm-Message-State: APjAAAWozBzYQqHe6kBNDzToorggCot/mGZ5V5/wZZ9SPNXsS2yuxsPF
        +BQCcQb9XIBscnMsZfkxR6yaiQ==
X-Google-Smtp-Source: APXvYqwCBbVrVJ42C8dYk6IwZdpxKKDIBPiA5fmRH/vaXVj4OGdepioKvN4ghGhmbXpYOQZhP8pHhA==
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr8892126lja.193.1556995115668;
        Sat, 04 May 2019 11:38:35 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:35 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/26] lightnvm: Inherit mdts from the parent nvme device
Date:   Sat,  4 May 2019 20:37:55 +0200
Message-Id: <20190504183811.18725-11-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Current lightnvm and pblk implementation does not care about NVMe max
data transfer size, which can be smaller than 64*K=256K. There are
existing NVMe controllers which NVMe max data transfer size is lower
that 256K (for example 128K, which happens for existing NVMe
controllers which are NVMe spec compliant). Such a controllers are not
able to handle command which contains 64 PPAs, since the the size of
DMAed buffer will be above the capabilities of such a controller.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 9 +++++++--
 drivers/nvme/host/lightnvm.c | 1 +
 include/linux/lightnvm.h     | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5f82036fe322..c01f83b8fbaf 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	struct nvm_target *t;
 	struct nvm_tgt_dev *tgt_dev;
 	void *targetdata;
+	unsigned int mdts;
 	int ret;
 
 	switch (create->conf.type) {
@@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->private_data = targetdata;
 	tqueue->queuedata = targetdata;
 
-	blk_queue_max_hw_sectors(tqueue,
-			(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
+	mdts = (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
+	if (dev->geo.mdts) {
+		mdts = min_t(u32, dev->geo.mdts,
+				(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
+	}
+	blk_queue_max_hw_sectors(tqueue, mdts);
 
 	set_capacity(tdisk, tt->capacity(targetdata));
 	add_disk(tdisk);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 949e29e1d782..4f20a10b39d3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -977,6 +977,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
 	geo->ext = ns->ext;
+	geo->mdts = ns->ctrl->max_hw_sectors;
 
 	dev->q = q;
 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 5d865a5d5cdc..d3b02708e5f0 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -358,6 +358,7 @@ struct nvm_geo {
 	u16	csecs;		/* sector size */
 	u16	sos;		/* out-of-band area size */
 	bool	ext;		/* metadata in extended data buffer */
+	u32	mdts;		/* Max data transfer size*/
 
 	/* device write constrains */
 	u32	ws_min;		/* minimum write size */
-- 
2.19.1

