Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24912075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onlISp6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfCZTT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:19:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40308 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfCZTT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:19:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so101494wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcVELMKFp4IxiMIX/M4XKcsfjFYZx5YLZPdrknKOL5A=;
        b=onlISp6Pabfm+ShWj7I9Ilzushc5RD02k+4Tn3Nn5B+E9h9Cog7ixfcoCHcHPUy1Hl
         vCKv5EgGudt3ixU1jm7xyFezH58lfvfvDnuZKRo+fg6lqKeZ/QC4r0dzAC0Lf5nMkDMX
         7vrgakCwvVtChT7y3pxXbgbht0PXikdF2IehmBOskyLGYx2W28RLgXJXCRHoG+Xr8XXT
         4Q/Nk4fhk4MqOD+q6pvJK2RFtU5pijVbODZUMt0ionF3zFkhmMXX1Va9D5kzJyvjPGKh
         p7SZjFEVDozV669D2/vUZ4zxFh9yveHjGoWaJo+CtoNbi8URxv23MjlnHgEFru503eYq
         wrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcVELMKFp4IxiMIX/M4XKcsfjFYZx5YLZPdrknKOL5A=;
        b=W1b61DSZnHI62ND+K6lc3fsMDzTHMWbKnPL71PYfRtusgS0zRV2dAs58ChbEwVWq1V
         vmV+UW5gfHlWBE6rGP1wuhz4AyEarB6JTa0eGnCqnTOJoL7z9DGqazoeda8+O2oap6m8
         OnWA/bKXShYw9X3tHKp8oakKnBBYfWTbMHfYjE4Parnr+Pmtu48mErm+dCUsXjeQ7TGL
         p9bENAC4nzC2nViPh/CzXS2Pj6XZEiVnimor/4sj4SoF7jTD5+eDCTuWjKNXn6A3Ul2E
         f6ORmyrkHJlWf3FsPyVb39eTFZSUgp93u84ZaCS9DQYFSMDbp19OjUfmRD3bIuOpeIDb
         hKuw==
X-Gm-Message-State: APjAAAXROBeNR2EA2V7e8rNqa3O5QDdDCk/VZ3LqPoN6JlHV9UKCfIIU
        el7l4cyuV3hPEtt5o69bPx8=
X-Google-Smtp-Source: APXvYqxJA+fD/cYqxEe/sWBic5a0p1DxEVz1+gjoQTkbYQOlVuthMAgfaxJ6Ydln49WV5iC9wliung==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr20008004wrp.197.1553627995780;
        Tue, 26 Mar 2019 12:19:55 -0700 (PDT)
Received: from kwango.redhat.com (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id c20sm25135672wre.28.2019.03.26.12.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 12:19:54 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dm table: propagate BDI_CAP_STABLE_WRITES
Date:   Tue, 26 Mar 2019 20:20:58 +0100
Message-Id: <20190326192058.21844-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices don't use blk_integrity but still want stable pages
because they do their own checksumming.  Examples include rbd and iSCSI
when data digests are negotiated.  Stacking DM (and thus LVM) on top of
these devices results in sporadic checksum errors.

Set BDI_CAP_STABLE_WRITES if any underlying device has it set.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/md/dm-table.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ba9481f1bf3c..cde3b49b2a91 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1844,6 +1844,36 @@ static bool dm_table_supports_secure_erase(struct dm_table *t)
 	return true;
 }
 
+static int device_requires_stable_pages(struct dm_target *ti,
+					struct dm_dev *dev, sector_t start,
+					sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return q && bdi_cap_stable_pages_required(q->backing_dev_info);
+}
+
+/*
+ * If any underlying device requires stable pages, a table must require
+ * them as well.  Only targets that support iterate_devices are considered:
+ * don't want error, zero, etc to require stable pages.
+ */
+static bool dm_table_requires_stable_pages(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned i;
+
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (ti->type->iterate_devices &&
+		    ti->type->iterate_devices(ti, device_requires_stable_pages, NULL))
+			return true;
+	}
+
+	return false;
+}
+
 void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			       struct queue_limits *limits)
 {
@@ -1896,6 +1926,15 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 
 	dm_table_verify_integrity(t);
 
+	/*
+	 * Some devices don't use blk_integrity but still want stable pages
+	 * because they do their own checksumming.
+	 */
+	if (dm_table_requires_stable_pages(t))
+		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+	else
+		q->backing_dev_info->capabilities &= ~BDI_CAP_STABLE_WRITES;
+
 	/*
 	 * Determine whether or not this queue's I/O timings contribute
 	 * to the entropy pool, Only request-based targets use this.
-- 
2.19.2

