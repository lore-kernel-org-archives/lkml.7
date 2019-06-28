Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A77C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D00208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561736178;
	bh=P0q2UFfbUHYwfmb/JPMOVIIGnfRXLzPGQwS42qAp73E=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=aWOPklmkrI0c3IWqvMv1dJYOf+ghEKvjD0TpWMPlhsjg/icddzMnTjfTCNbsKF+To
	 Tbp31AIB81DjzDg8OmkYZ4yN2YZeV+ye1vhRCIeX7WoNamzk91mTzkt/KslspBEm3Y
	 xdsNV9GmVJ4SYnquHvOsYJXWwQjNenePA7Gao+JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF1PgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1PgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:36:16 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1382064A;
        Fri, 28 Jun 2019 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561736175;
        bh=P0q2UFfbUHYwfmb/JPMOVIIGnfRXLzPGQwS42qAp73E=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=oB4/J5uQ6yewdmYk+br86w41GP1WQTpsf2PaBQOoAi77xF3vRmADerGce75ZFraW0
         Mv5T+Mv2+7JvafZ9aUZR4H0ItKvrAuRPK03eM35tvB7q6YygbSvsxzFeCJN10n6F9X
         aitDnPmM6nF16a/1eFVrKJlpIYQGcfVmmZIoMAno=
Date:   Fri, 28 Jun 2019 08:36:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: allocate blocks for pinned file
Message-ID: <20190628153614.GA27114@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190627170504.71700-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627170504.71700-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows fallocate to allocate physical blocks for pinned file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt | 25 +++++++++++++++++++++++++
 fs/f2fs/file.c                     |  7 ++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index bebd1be3ba49..496fa28b2492 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -804,3 +804,28 @@ WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
 WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
 WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
 WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+
+Fallocate(2) Policy
+-------------------
+
+The default policy follows the below posix rule.
+
+Allocating disk space
+    The default operation (i.e., mode is zero) of fallocate() allocates
+    the disk space within the range specified by offset and len.  The
+    file size (as reported by stat(2)) will be changed if offset+len is
+    greater than the file size.  Any subregion within the range specified
+    by offset and len that did not contain data before the call will be
+    initialized to zero.  This default behavior closely resembles the
+    behavior of the posix_fallocate(3) library function, and is intended
+    as a method of optimally implementing that function.
+
+However, once F2FS receives ioctl(fd, F2FS_IOC_SET_PIN_FILE) in prior to
+fallocate(fd, DEFAULT_MODE), it allocates on-disk blocks addressess having
+zero or random data, which is useful to the below scenario where:
+ 1. create(fd)
+ 2. ioctl(fd, F2FS_IOC_SET_PIN_FILE)
+ 3. fallocate(fd, 0, 0, size)
+ 4. address = fibmap(fd, offset)
+ 5. open(blkdev)
+ 6. write(blkdev, address)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e7c368db8185..cdfd4338682d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1528,7 +1528,12 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (off_end)
 		map.m_len++;
 
-	err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+	if (f2fs_is_pinned_file(inode))
+		map.m_seg_type = CURSEG_COLD_DATA;
+
+	err = f2fs_map_blocks(inode, &map, 1, (f2fs_is_pinned_file(inode) ?
+						F2FS_GET_BLOCK_PRE_DIO :
+						F2FS_GET_BLOCK_PRE_AIO));
 	if (err) {
 		pgoff_t last_off;
 
-- 
2.19.0.605.g01d371f741-goog

