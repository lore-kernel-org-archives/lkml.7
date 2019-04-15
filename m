Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B120818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356386;
	bh=y1JV1QDiaC70Wh0bqYFdiYtfJ8Yx9YOJ997lCY8ISMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wxs6aOXFmZzpZDRvfmpLBMw14I7MDDLaA7ZfOT8HFWjUdlZ3CTxSveB+Js8FFxLaf
	 SX6gUPS+Yrsoc0dAunQPJQBM+SRWTVzHYpZjyYSnFkqWgvQEB0zdo6cB/sPgE86fir
	 RF1mGg+7Ara2XwGFnT+JIzLTHJn9aEm6eMJ9wQFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfDOT0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbfDOTEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B022218EA;
        Mon, 15 Apr 2019 19:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355085;
        bh=y1JV1QDiaC70Wh0bqYFdiYtfJ8Yx9YOJ997lCY8ISMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVMIwCKZHwq3rsgyQKXm2V2l9dGwx9HykzVQ4U5TCTVzSo3moam920pKTFkctt81J
         rddH/nAxW+ukx7CD+U6CpmmaZJXqz5AZKaYuBSjDm7GSneh0nC+29sk+5/qvvZtP7b
         PePwE5ZSDfMAFz5QWBN+x6oc/XLda/ZHa7W8wFHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 67/69] dm table: propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum errors
Date:   Mon, 15 Apr 2019 20:59:25 +0200
Message-Id: <20190415183736.670484314@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

commit eb40c0acdc342b815d4d03ae6abb09e80c0f2988 upstream.

Some devices don't use blk_integrity but still want stable pages
because they do their own checksumming.  Examples include rbd and iSCSI
when data digests are negotiated.  Stacking DM (and thus LVM) on top of
these devices results in sporadic checksum errors.

Set BDI_CAP_STABLE_WRITES if any underlying device has it set.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-table.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1789,6 +1789,36 @@ static bool dm_table_supports_discards(s
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
@@ -1838,6 +1868,15 @@ void dm_table_set_restrictions(struct dm
 	dm_table_verify_integrity(t);
 
 	/*
+	 * Some devices don't use blk_integrity but still want stable pages
+	 * because they do their own checksumming.
+	 */
+	if (dm_table_requires_stable_pages(t))
+		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+	else
+		q->backing_dev_info->capabilities &= ~BDI_CAP_STABLE_WRITES;
+
+	/*
 	 * Determine whether or not this queue's I/O timings contribute
 	 * to the entropy pool, Only request-based targets use this.
 	 * Clear QUEUE_FLAG_ADD_RANDOM if any underlying device does not


