Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED417C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EE82089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfIIK3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:29:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:38452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730369AbfIIK3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:29:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 512DBAE86;
        Mon,  9 Sep 2019 10:28:36 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v2] ceph: allow object copies across different filesystems in the same cluster
Date:   Mon,  9 Sep 2019 11:28:34 +0100
Message-Id: <20190909102834.16246-1-lhenriques@suse.com>
In-Reply-To: <87k1ahojri.fsf@suse.com>
References: <87k1ahojri.fsf@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OSDs are able to perform object copies across different pools.  Thus,
there's no need to prevent copy_file_range from doing remote copies if the
source and destination superblocks are different.  Only return -EXDEV if
they have different fsid (the cluster ID).

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Hi,

Here's the patch changelog since initial submittion:

- Dropped have_fsid checks on client structs
- Use %pU to print the fsid instead of raw hex strings (%*ph)
- Fixed 'To:' field in email so that this time the patch hits vger

Cheers,
--
Luis

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 685a03cc4b77..4a624a1dd0bb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1904,6 +1904,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	struct ceph_inode_info *src_ci = ceph_inode(src_inode);
 	struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
 	struct ceph_cap_flush *prealloc_cf;
+	struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
 	struct ceph_object_locator src_oloc, dst_oloc;
 	struct ceph_object_id src_oid, dst_oid;
 	loff_t endoff = 0, size;
@@ -1915,8 +1916,17 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 
 	if (src_inode == dst_inode)
 		return -EINVAL;
-	if (src_inode->i_sb != dst_inode->i_sb)
-		return -EXDEV;
+	if (src_inode->i_sb != dst_inode->i_sb) {
+		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
+
+		if (ceph_fsid_compare(&src_fsc->client->fsid,
+				      &dst_fsc->client->fsid)) {
+			dout("Copying object across different clusters:");
+			dout("  src fsid: %pU dst fsid: %pU\n",
+			     &src_fsc->client->fsid, &dst_fsc->client->fsid);
+			return -EXDEV;
+		}
+	}
 	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
 		return -EROFS;
 
@@ -1928,7 +1938,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * efficient).
 	 */
 
-	if (ceph_test_mount_opt(ceph_inode_to_client(src_inode), NOCOPYFROM))
+	if (ceph_test_mount_opt(src_fsc, NOCOPYFROM))
 		return -EOPNOTSUPP;
 
 	if ((src_ci->i_layout.stripe_unit != dst_ci->i_layout.stripe_unit) ||
@@ -2044,7 +2054,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 				dst_ci->i_vino.ino, dst_objnum);
 		/* Do an object remote copy */
 		err = ceph_osdc_copy_from(
-			&ceph_inode_to_client(src_inode)->client->osdc,
+			&src_fsc->client->osdc,
 			src_ci->i_vino.snap, 0,
 			&src_oid, &src_oloc,
 			CEPH_OSD_OP_FLAG_FADVISE_SEQUENTIAL |
