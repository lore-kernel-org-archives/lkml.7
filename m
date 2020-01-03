Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87141C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535E0227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBA3X6AA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgACSdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:33:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47562 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728353AbgACSdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578076397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k9B8DZHWqzTB+Kt3rFqrnVZ5tO/IU+S24gouCA4CSXo=;
        b=FBA3X6AAhdzPbUta/4PUXV67XLR86TwXDioVkGKoHWvC4gJvf3rcLMKfdd0p1x8FTCtWqH
        ThF72tEQkFAPM74KaK4dr1iZhcLc0Dwyo4PkVtJgaOJ2+3UEnE54/hZRhc3+/TiVG4s8q2
        rJyI9rs6Y+Sj8JgGDhGeGGjOSyDcKvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-ymZGaeSoOde_Db7plRlGWA-1; Fri, 03 Jan 2020 13:33:14 -0500
X-MC-Unique: ymZGaeSoOde_Db7plRlGWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E90F164A7F;
        Fri,  3 Jan 2020 18:33:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B09397BA32;
        Fri,  3 Jan 2020 18:33:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 446632202E9; Fri,  3 Jan 2020 13:33:07 -0500 (EST)
Date:   Fri, 3 Jan 2020 13:33:07 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20200103183307.GB13350@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org>
 <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com>
 <20200103141235.GA13350@redhat.com>
 <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
 <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 10:18:22AM -0800, Dan Williams wrote:
> On Fri, Jan 3, 2020 at 10:12 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jan 3, 2020 at 6:12 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> [..]
> > > Hi Dan,
> > >
> > > Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
> > > sure how to get ack from ext4 developers.
> >
> > Jan counts for ext4, I just missed this. Now merged.
> 
> Oh, this now collides with:
> 
>    30fa529e3b2e xfs: add a xfs_inode_buftarg helper
> 
> Care to rebase? I'll also circle back to your question about
> partitions on patch1.

Hi Dan,

Here is the updated patch.

Thanks
Vivek

Subject: dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()

As of now dax_writeback_mapping_range() takes "struct block_device" as a
parameter and dax_dev is searched from bdev name. This also involves taking
a fresh reference on dax_dev and putting that reference at the end of
function.

We are developing a new filesystem virtio-fs and using dax to access host
page cache directly. But there is no block device. IOW, we want to make
use of dax but want to get rid of this assumption that there is always
a block device associated with dax_dev.

So pass in "struct dax_device" as parameter instead of bdev.

ext2/ext4/xfs are current users and they already have a reference on
dax_device. So there is no need to take reference and drop reference to
dax_device on each call of this function.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c            |    8 +-------
 fs/ext2/inode.c     |    5 +++--
 fs/ext4/inode.c     |    2 +-
 fs/xfs/xfs_aops.c   |    2 +-
 include/linux/dax.h |    4 ++--
 5 files changed, 8 insertions(+), 13 deletions(-)

Index: rhvgoyal-linux-fuse/fs/dax.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/dax.c	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/fs/dax.c	2020-01-03 11:20:05.602186062 -0500
@@ -937,12 +937,11 @@ static int dax_writeback_one(struct xa_s
  * on persistent storage prior to completion of the operation.
  */
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct dax_device *dax_dev, struct writeback_control *wbc)
 {
 	XA_STATE(xas, &mapping->i_pages, wbc->range_start >> PAGE_SHIFT);
 	struct inode *inode = mapping->host;
 	pgoff_t end_index = wbc->range_end >> PAGE_SHIFT;
-	struct dax_device *dax_dev;
 	void *entry;
 	int ret = 0;
 	unsigned int scanned = 0;
@@ -953,10 +952,6 @@ int dax_writeback_mapping_range(struct a
 	if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
 		return 0;
 
-	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
-	if (!dax_dev)
-		return -EIO;
-
 	trace_dax_writeback_range(inode, xas.xa_index, end_index);
 
 	tag_pages_for_writeback(mapping, xas.xa_index, end_index);
@@ -977,7 +972,6 @@ int dax_writeback_mapping_range(struct a
 		xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
-	put_dax(dax_dev);
 	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
 	return ret;
 }
Index: rhvgoyal-linux-fuse/include/linux/dax.h
===================================================================
--- rhvgoyal-linux-fuse.orig/include/linux/dax.h	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/include/linux/dax.h	2020-01-03 11:20:05.603186062 -0500
@@ -141,7 +141,7 @@ static inline void fs_put_dax(struct dax
 
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc);
+		struct dax_device *dax_dev, struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 dax_entry_t dax_lock_page(struct page *page);
@@ -180,7 +180,7 @@ static inline struct page *dax_layout_bu
 }
 
 static inline int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct dax_device *dax_dev, struct writeback_control *wbc)
 {
 	return -EOPNOTSUPP;
 }
Index: rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/xfs/xfs_aops.c	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c	2020-01-03 11:20:05.605186062 -0500
@@ -587,7 +587,7 @@ xfs_dax_writepages(
 
 	xfs_iflags_clear(ip, XFS_ITRUNCATED);
 	return dax_writeback_mapping_range(mapping,
-			xfs_inode_buftarg(ip)->bt_bdev, wbc);
+			xfs_inode_buftarg(ip)->bt_daxdev, wbc);
 }
 
 STATIC sector_t
Index: rhvgoyal-linux-fuse/fs/ext4/inode.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/ext4/inode.c	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/fs/ext4/inode.c	2020-01-03 11:20:05.606186062 -0500
@@ -2866,7 +2866,7 @@ static int ext4_dax_writepages(struct ad
 	percpu_down_read(&sbi->s_journal_flag_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
-	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
+	ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
 	percpu_up_read(&sbi->s_journal_flag_rwsem);
Index: rhvgoyal-linux-fuse/fs/ext2/inode.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/ext2/inode.c	2020-01-03 11:19:59.151186062 -0500
+++ rhvgoyal-linux-fuse/fs/ext2/inode.c	2020-01-03 11:20:05.608186062 -0500
@@ -960,8 +960,9 @@ ext2_writepages(struct address_space *ma
 static int
 ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
-	return dax_writeback_mapping_range(mapping,
-			mapping->host->i_sb->s_bdev, wbc);
+	struct ext2_sb_info *sbi = EXT2_SB(mapping->host->i_sb);
+
+	return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 }
 
 const struct address_space_operations ext2_aops = {

