Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FE12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553664001;
	bh=uJdSY8hsIdOJYfoSPCcn6YMze9S9BrkzJvGBrQQuoJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVOD9NNbc14U6oV13ZLm+ZuENLtHmtFeEdSEY3zwTgzLW5lyYy8Y8v7FUlvLksf78
	 8guCjjpd+FslBRpusCQVkk5Jb9i55v3y/6csZMNleOyjTS7w501M2a4+eLZ9fBbCYF
	 4GJTH8eQTxWJQwTRTdT8BUGHV2EvkDFDNBoHrjB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbfC0FT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43559 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733302AbfC0FT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A2723221CF;
        Wed, 27 Mar 2019 01:19:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=44sobiezBTw2ONsn3SEWIjTyZtpWfEVkRxYs8fv06mI=; b=KHz8VTpd
        Sfr5c44cfwYvhD0X24y4Tm10toxcbw36ItGWfnULv4j0E2FMv6Qum5WwSXXYwopL
        E3N7CnNyx9GdbggfhVqM2hibEKOWY62mNZpQulKKg25g+xHuWrFxj6E1EZ04SzgB
        1VZTBR5oD+/NMT+Zc3vWu0RVwroSFB4WDcWoSKWJAvXOLDlNr2u2Xcm2IIeiP+9S
        LBDYcHW3YRQAgJCYNeC5lpUi/4InE1J7xpvwEDdFLQU5LhsWh22/cd1UINSIOXI2
        fK33EZwzTS/wEL3XwUZp/q/9E0BMjQm8JMg/G69lm0bSaERZzwAWAZR/8u4C0Hax
        OH/+LL3kbWldFw==
X-ME-Sender: <xms:-webXEu4L8G716CXhMqFmOAPXnbPGTZ0QndZ9O04_8oCcWKNM78tIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffoh
    hmrghinhepthigthdrihhnthenucfkphepuddvgedrudeiledrudefledrudelvdenucfr
    rghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:-webXMPqNGgzUdLGkDlWf314KbtjaO4ABacTLAdPtakoPFyDHr84XQ>
    <xmx:-webXOr22XsvWgV0zYXMYbSG_dQx2iZZvP73nJ89kQPrQ04rO4ePlA>
    <xmx:-webXN-2pLc9Nbn9y0QMCtQ7TGGjQ945PVkbroOEd53YIAtxCrdvHw>
    <xmx:-webXCWLKv9p_XQ_4CjIeyqY2ZU12-CuKP-LP140QFhXpQW-h8GJtw>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30935E4210;
        Wed, 27 Mar 2019 01:19:50 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v3 22/24] fs: Copy documentation to struct declarations
Date:   Wed, 27 Mar 2019 16:17:15 +1100
Message-Id: <20190327051717.23225-23-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the documentation for structures declared in fs.h is located
in Documentation/filesystems/vfs.txt.  Having documentation far away
from the code increases the chance of docs getting stale.  This is
exactly the case with fs core data structure documentation.  Docs
currently reference 2.6 kernels.

The kernel has a mechanism for documenting structures in the
source/header files, we should use it.  This makes reading arguable
easier because documentation is right there with the source and also
prevent the docs from getting stale.

Copy documentation for filesystem data structures from vfs.txt and
locate it in docstrings with the struct declarations.
into fs.h

Where members are not documented, document with string:

	TODO: document this

To ease review do not touch vfs.txt, this file will be converted to rst
shortly.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/fs.h | 802 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 788 insertions(+), 14 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a8af48d3bd4f..f2baf7c7e537 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -341,55 +341,264 @@ typedef struct {
 typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 		unsigned long, unsigned long);
 
+/**
+ * struct address_space_operations - This describes how the VFS can manipulate
+ * mapping of a file to page cache in your filesystem.
+ */
 struct address_space_operations {
+	/**
+	 * @writepage: Called by the VM to write a dirty page to backing
+	 * store.  This may happen for data integrity reasons
+	 * (i.e. 'sync'), or to free up memory (flush).  The difference
+	 * can be seen in wbc->sync_mode.  The PG_Dirty flag has been
+	 * cleared and PageLocked is true.  writepage() should start
+	 * writeout, should set PG_Writeback, and should make sure the
+	 * page is unlocked, either synchronously or asynchronously when
+	 * the write operation completes.  If wbc->sync_mode is
+	 * WB_SYNC_NONE, writepage() doesn't have to try too hard if
+	 * there are problems, and may choose to write out other pages
+	 * from the mapping if that is easier (e.g. due to internal
+	 * dependencies).  If it chooses not to start writeout, it
+	 * should return AOP_WRITEPAGE_ACTIVATE so that the VM will not
+	 * keep calling writepage() on that page.  See
+	 * Documentation/filesystems/Locking for more details.
+	 */
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
+
+	/**
+	 * @readpage: Called by the VM to read a page from backing
+	 * store.  The page will be locked when readpage is called, and
+	 * should be unlocked and marked uptodate once the read
+	 * completes.  If readpage() discovers that it needs to unlock
+	 * the page for some reason, it can do so, and then return
+	 * AOP_TRUNCATED_PAGE.  In this case, the page will be
+	 * relocated, relocked and if that all succeeds, readpage() will
+	 * be called again.
+	 */
 	int (*readpage)(struct file *, struct page *);
 
-	/* Write back some dirty pages from this mapping. */
+	/**
+	 * @writepages: Write back some dirty pages from this mapping.
+	 * Called by the VM to write out pages associated with the
+	 * address_space object.  If wbc->sync_mode is WBC_SYNC_ALL,
+	 * then the writeback_control will specify a range of pages that
+	 * must be written out.  If it is WBC_SYNC_NONE, then a
+	 * nr_to_write is given and that many pages should be written if
+	 * possible.  If no writepages() is given, then
+	 * ampage_writepages() is used instead.  This will choose pages
+	 * from the address space that are tagged as DIRTY and will pass
+	 * them to writepage().
+	 */
 	int (*writepages)(struct address_space *, struct writeback_control *);
 
-	/* Set a page dirty.  Return true if this dirtied it */
+	/**
+	 * @set_page_dirty: Called by the VM to set a page dirty.  This
+	 * is particularly needed if an address space attaches private
+	 * data to a page, and that data needs to be updated when a page
+	 * is dirtied.  This is called, for example, when a memory
+	 * mapped page gets modified.  If defined, it should set the
+	 * PageDirty flag, and the PAGECACHE_TAG_DIRTY tag in the radix
+	 * tree.  Return true if this dirtied it
+	 */
 	int (*set_page_dirty)(struct page *page);
 
-	/*
-	 * Reads in the requested pages. Unlike ->readpage(), this is
-	 * PURELY used for read-ahead!.
+	/**
+	 * @readpages: Called by the VM to read pages associated with
+	 * the address_space object.  This is essentially just a vector
+	 * version of readpage().  Instead of just one page, several
+	 * pages are requested.  Unlike ->readpage(), readpages() is
+	 * only used for read-ahead, so read errors are ignored.  If
+	 * anything goes wrong, feel free to give up.
 	 */
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			 struct list_head *pages, unsigned nr_pages);
 
+	/**
+	 * @write_begin: Called by the generic buffered write code to
+	 * ask the filesystem to prepare to write len bytes at the given
+	 * offset in the file.  The address_space should check that the
+	 * write will be able to complete, by allocating space if
+	 * necessary and doing any other internal housekeeping.  If the
+	 * write will update parts of any basic-blocks on storage, then
+	 * those blocks should be pre-read (if they haven't been read
+	 * already) so that the updated blocks can be written out
+	 * properly.  The filesystem must return the locked pagecache
+	 * page for the specified offset, in ``*pagep``, for the caller
+	 * to write into.  It must be able to cope with short writes
+	 * (where the length passed to write_begin is greater than the
+	 * number of bytes copied into the page).  flags is a field for
+	 * AOP_FLAG_xxx flags, described in include/linux/fs.h.  A
+	 * ``void *`` may be returned in fsdata, which then gets passed
+	 * into write_end().  Returns 0 on success; < 0 on failure
+	 * (which is the error code), in which case write_end() is not
+	 * called.
+	 */
 	int (*write_begin)(struct file *, struct address_space *mapping,
 			   loff_t pos, unsigned len, unsigned flags,
 			   struct page **pagep, void **fsdata);
+
+	/**
+	 * @write_end: After a successful write_begin, and data copy,
+	 * write_end must be called.  len is the original len passed to
+	 * write_begin, and copied is the amount that was able to be
+	 * copied.  The filesystem must take care of unlocking the page
+	 * and releasing it refcount, and updating i_size.  Returns < 0
+	 * on failure, otherwise the number of bytes (<= 'copied') that
+	 * were able to be copied into pagecache.
+	 */
 	int (*write_end)(struct file *, struct address_space *mapping,
 			 loff_t pos, unsigned len, unsigned copied,
 			 struct page *page, void *fsdata);
 
-	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
+	/*
+	 * @bmap: Called by the VFS to map a logical block offset within
+	 * object to physical block number.  This method is used by the
+	 * FIBMAP ioctl and for working with swap-files.  To be able to
+	 * swap to a file, the file must have a stable mapping to a
+	 * block device.  The swap system does not go through the
+	 * filesystem but instead uses bmap to find out where the blocks
+	 * in the file are and uses those addresses directly.
+	 */
+/* private: Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
+
+/* public */
+	/**
+	 * @invalidatepage: If a page has PagePrivate set, then
+	 * invalidatepage will be called when part or all of the page is
+	 * to be removed from the address space.  This generally
+	 * corresponds to either a truncation, punch hole or a complete
+	 * invalidation of the address space (in the latter case
+	 * 'offset' will always be 0 and 'length' will be PAGE_SIZE).
+	 * Any private data associated with the page should be updated
+	 * to reflect this truncation.  If offset is 0 and length is
+	 * PAGE_SIZE, then the private data should be released, because
+	 * the page must be able to be completely discarded.  This may
+	 * be done by calling the ->releasepage function, but in this
+	 * case the release MUST succeed.
+	 */
 	void (*invalidatepage)(struct page *, unsigned int offset,
 			       unsigned int length);
+
+	/**
+	 * @releasepage: Releasepage is called on PagePrivate pages to
+	 * indicate that the page should be freed if possible.
+	 * ->releasepage should remove any private data from the page
+	 * and clear the PagePrivate flag.  If releasepage() fails for
+	 * some reason, it must indicate failure with a 0 return value.
+	 * releasepage() is used in two distinct though related cases.
+	 * The first is when the VM finds a clean page with no active
+	 * users and wants to make it a free page.  If ->releasepage
+	 * succeeds, the page will be removed from the address_space and
+	 * become free.  The second case is when a request has been made
+	 * to invalidate some or all pages in an address_space.  This
+	 * can happen through the fadvise(POSIX_FADV_DONTNEED) system
+	 * call or by the filesystem explicitly requesting it as nfs and
+	 * 9fs do (when they believe the cache may be out of date with
+	 * storage) by calling invalidate_inode_pages2().  If the
+	 * filesystem makes such a call, and needs to be certain that
+	 * all pages are invalidated, then its releasepage will need to
+	 * ensure this.  Possibly it can clear the PageUptodate bit if
+	 * it cannot free private data yet.
+	 */
 	int (*releasepage)(struct page *, gfp_t);
+
+	/**
+	 * @freepage: Freepage is called once the page is no longer
+	 * visible in the page cache in order to allow the cleanup of
+	 * any private data.  Since it may be called by the memory
+	 * reclaimer, it should not assume that the original
+	 * address_space mapping still exists, and it should not block.
+	 */
 	void (*freepage)(struct page *);
+
+	/**
+	 * @direct_IO: Called by the generic read/write routines to
+	 * perform direct_IO - that is IO requests which bypass the page
+	 * cache and transfer data directly between the storage and the
+	 * application's address space.
+	 */
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
-	/*
-	 * migrate the contents of a page to the specified target. If
-	 * migrate_mode is MIGRATE_ASYNC, it must not block.
+
+	/**
+	 * @migratepage: This is used to compact the physical memory
+	 * usage.  If the VM wants to relocate a page (maybe off a
+	 * memory card that is signalling imminent failure) it will pass
+	 * a new page and an old page to this function.  migratepage()
+	 * should transfer any private data across and update any
+	 * references that it has to the page.  If migrate_mode is
+	 * MIGRATE_ASYNC, it must not block.
 	 */
 	int (*migratepage)(struct address_space *mapping,
 			   struct page *newpage, struct page *page,
 			   enum migrate_mode mode);
+
+	/**
+	 * @isolate_page: Called by the VM when isolating a movable
+	 * non-lru page.  If page is successfully isolated, VM marks the
+	 * page as PG_isolated via __SetPageIsolated.
+	 */
 	bool (*isolate_page)(struct page *, isolate_mode_t);
+
+	/**
+	 * @putback_page: Called by the VM when isolated page's
+	 * migration fails.
+	 */
 	void (*putback_page)(struct page *);
+
+	/**
+	 * @launder_page: Called before freeing a page - it writes back
+	 * the dirty page.  To prevent redirtying the page, it is kept
+	 * locked during the whole operation.
+	 */
 	int (*launder_page)(struct page *);
+
+	/**
+	 * @is_partially_uptodate: Called by the VM when reading a file
+	 * through the pagecache when the underlying blocksize !=
+	 * pagesize.  If the required block is up to date then the read
+	 * can complete without needing the IO to bring the whole page
+	 * up to date.
+	 */
 	int (*is_partially_uptodate)(struct page *, unsigned long from,
 				     unsigned long count);
+
+	/**
+	 * @is_dirty_writeback: Called by the VM when attempting to
+	 * reclaim a page.  The VM uses dirty and writeback information
+	 * to determine if it needs to stall to allow flushers a chance
+	 * to complete some IO.  Ordinarily it can use PageDirty and
+	 * PageWriteback but some filesystems have more complex state
+	 * (unstable pages in NFS prevent reclaim) or do not set those
+	 * flags due to locking problems.  This callback allows a
+	 * filesystem to indicate to the VM if a page should be treated
+	 * as dirty or writeback for the purposes of stalling.
+	 */
 	void (*is_dirty_writeback)(struct page *, bool *dirty, bool *writeback);
+
+	/**
+	 * @error_remove_page: Normally set to generic_error_remove_page
+	 * if truncation is ok for this address space.  Used for memory
+	 * failure handling.  Setting this implies you deal with pages
+	 * going away under you, unless you have them locked or
+	 * reference counts increased.
+	 */
 	int (*error_remove_page)(struct address_space *, struct page *);
 
-	/* swapfile support */
+	/**
+	 * @swap_activate: Called when swapon is used on a file to
+	 * allocate space if necessary and pin the block lookup
+	 * information in memory.  A return value of zero indicates
+	 * success, in which case this file can be used to back
+	 * swapspace.
+	 */
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
 			     sector_t *span);
+
+	/**
+	 * @swap_deactivate: Called during swapoff on files where
+	 * swap_activate was successful.
+	 */
 	void (*swap_deactivate)(struct file *file);
 };
 
@@ -1784,83 +1993,444 @@ struct block_device_operations;
 
 struct iov_iter;
 
+/**
+ * struct file_operations - Describe how the VFS can manipulate an open
+ *                          file.
+ * @owner: Module owner.
+ * @mmap_supported_flags: TODO: document this
+ *
+ * Note that the file operations are implemented by the specific
+ * filesystem in which the inode resides.  When opening a device node
+ * (character or block special) most filesystems will call special
+ * support routines in the VFS which will locate the required device
+ * driver information.  These support routines replace the filesystem
+ * file operations with those for the device driver, and then proceed to
+ * call the new open() method for the file.  This is how opening a
+ * device file in the filesystem eventually ends up calling the device
+ * driver open() method.
+ *
+ * All methods are called without any locks being held, unless otherwise
+ * noted.
+ */
 struct file_operations {
 	struct module *owner;
+
+	/**
+	 * @llseek: Called when the VFS needs to move the file position
+	 * index.
+	 */
 	loff_t (*llseek)(struct file *, loff_t, int whence);
-	ssize_t (*read)(struct file *, char __user *buf, size_t bufsz,
+
+	/**
+	 * @read: Called by read(2) and related system calls.
+	 */
+	ssize_t (*read)(struct file *filp, char __user *buf, size_t bufsz,
 			loff_t *ppos);
-	ssize_t (*write)(struct file *, const char __user *buf, size_t bufsz,
-			 loff_t *ppos);
+
+	/**
+	 * @write: Called by write(2) and related system calls.
+	 */
+	ssize_t (*write)(struct file *filp, const char __user *buf,
+			 size_t bufsz, loff_t *ppos);
+
+	/**
+	 * @read_iter: Possibly asynchronous read with iov_iter as
+	 * destination.
+	 */
 	ssize_t (*read_iter)(struct kiocb *, struct iov_iter *);
+
+	/**
+	 * @write_iter: Possibly asynchronous write with iov_iter as
+	 * source.
+	 */
 	ssize_t (*write_iter)(struct kiocb *, struct iov_iter *);
+
+	/**
+	 * @iterate: Called when the VFS needs to read the directory
+	 * contents.
+	 */
 	int (*iterate)(struct file *, struct dir_context *);
+
+	/**
+	 * @iterate_shared: Called when the VFS needs to read the
+	 * directory contents when filesystem supports concurrent dir
+	 * iterators.
+	 */
 	int (*iterate_shared)(struct file *, struct dir_context *);
+
+	/**
+	 * @poll: Called by the VFS when a process wants to check if
+	 * there is activity on this file and (optionally) go to sleep
+	 * until there is activity.  Called by the select(2) and poll(2)
+	 * system calls.
+	 */
 	__poll_t (*poll)(struct file *, struct poll_table_struct *);
+
+	/**
+	 * @unlocked_ioctl: Called by the ioctl(2) system call.
+	 */
 	long (*unlocked_ioctl)(struct file *, unsigned int cmd, unsigned long arg);
+
+	/**
+	 * @compat_ioctl: Called by the ioctl(2) system call when 32 bit
+	 * system calls are used on 64 bit kernels.
+	 */
 	long (*compat_ioctl)(struct file *, unsigned int cmd, unsigned long arg);
+
+	/**
+	 * @mmap: Called by the mmap(2) system call.
+	 */
 	int (*mmap)(struct file *, struct vm_area_struct *);
+
 	unsigned long mmap_supported_flags;
+
+	/**
+	 * @open: Called by the VFS when an inode should be opened.
+	 * When the VFS opens a file, it creates a new "struct file".
+	 * It then calls the open method for the newly allocated file
+	 * structure.  You might think that the open method really
+	 * belongs in ``* struct inode_operations``, and you may be
+	 * right.  I think it's done the way it is because it makes
+	 * filesystems simpler to implement.  The open() method is a
+	 * good place to initialize the ``* private_data`` member in the
+	 * file structure if you want to point to a device structure.
+	 */
 	int (*open)(struct inode *, struct file *);
+
+	/**
+	 * @flush: Called by the close(2) system call to flush a file.
+	 */
 	int (*flush)(struct file *, fl_owner_t id);
+
+	/**
+	 * @release: Called when the last reference to an open file is
+	 * closed.
+	 */
 	int (*release)(struct inode *, struct file *);
+
+	/**
+	 * @fsync: Called by the fsync(2) system call.  (Also see
+	 * vfs.rst section "Handling errors during writeback".)
+	 */
 	int (*fsync)(struct file *, loff_t start, loff_t end, int datasync);
+
+	/**
+	 * @fasync: Called by the fcntl(2) system call when asynchronous
+	 * (non-blocking) mode is enabled for a file.
+	 */
 	int (*fasync)(int fd, struct file *, int flags);
+
+	/**
+	 * @lock: Called by the fcntl(2) system call for F_GETLK,
+	 * F_SETLK, and F_SETLKW commands.
+	 */
 	int (*lock)(struct file *, int cmd, struct file_lock *);
+
+	/**
+	 * @sendpage: TODO: document this
+	 */
 	ssize_t (*sendpage)(struct file *, struct page *, int, size_t, loff_t *, int);
+
+	/**
+	 * @get_unmapped_area: Called by the mmap(2) system call.
+	 */
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long addr,
 					   unsigned long len, unsigned long pgoff,
 					   unsigned long flags);
+
+	/**
+	 * @check_flags: Called by the fcntl(2) system call for F_SETFL
+	 * command.
+	 */
 	int (*check_flags)(int flags);
+
+	/**
+	 * @flock: Called by the flock(2) system call.
+	 */
 	int (*flock)(struct file *, int cmd, struct file_lock *);
+
+	/**
+	 * @splice_write: Called by the VFS to splice data from a pipe
+	 * to a file.  This method is used by the splice(2) system call
+	 */
 	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *,
 				size_t len, unsigned int flags);
+
+	/**
+	 * @splice_read: Called by the VFS to splice data from file to a
+	 * pipe.  This method is used by the splice(2) system call.
+	 */
 	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *,
 			       size_t len, unsigned int flags);
+
+	/**
+	 * @setlease: Called by the VFS to set or release a file lock
+	 * lease.  setlease implementations should call generic_setlease
+	 * to record or remove the lease in the inode after setting it.
+	 */
 	int (*setlease)(struct file *, long arg, struct file_lock **, void **priv);
+
+	/**
+	 * @fallocate: Called by the VFS to preallocate blocks or punch
+	 * a hole.
+	 */
 	long (*fallocate)(struct file *, int mode, loff_t offset, loff_t len);
+
+	/**
+	 * @show_fdinfo: TODO: document this
+	 */
 	void (*show_fdinfo)(struct seq_file *m, struct file *f);
+
 #ifndef CONFIG_MMU
+	/**
+	 * @mmap_capabilities: TODO: document this
+	 */
 	unsigned (*mmap_capabilities)(struct file *);
 #endif
+
+	/**
+	 * @copy_file_range: Called by the copy_file_range(2) system
+	 * call.
+	 */
 	ssize_t (*copy_file_range)(struct file *file_in, loff_t pos_in,
 				   struct file *file_out, loff_t pos_out,
 				   size_t len, unsigned int copy_flags);
+
+	/**
+	 * @remap_file_range: Called by the ioctl(2) system call for
+	 * FICLONERANGE and FICLONE and FIDEDUPERANGE commands to remap
+	 * file ranges.  An implementation should remap len bytes at
+	 * pos_in of the source file into the dest file at pos_out.
+	 * Implementations must handle callers passing in len == 0; this
+	 * means "remap to the end of the source file".  The return
+	 * value should the number of bytes remapped, or the usual
+	 * negative error code if errors occurred before any bytes were
+	 * remapped.  The remap_flags parameter accepts ``REMAP_FILE_*``
+	 * flags.  If REMAP_FILE_DEDUP is set then the implementation
+	 * must only remap if the requested file ranges have identical
+	 * contents.  If REMAP_CAN_SHORTEN is set, the caller is ok with
+	 * the implementation shortening the request length to satisfy
+	 * alignment or EOF requirements (or any other reason).
+	 */
 	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
+
+	/**
+	 * @fadvise: Possibly called by the fadvise64() system call.
+	 */
 	int (*fadvise)(struct file *, loff_t offset, loff_t len, int advice);
 } __randomize_layout;
 
+/**
+ * struct inode_operations - Describes how the VFS can manipulate an
+ * inode in your filesystem.
+ *
+ * All methods are called without any locks being held, unless otherwise
+ * noted.
+ */
 struct inode_operations {
+	/**
+	 * @lookup: Called when the VFS needs to look up an inode in a
+	 * parent directory.  The name to look for is found in the
+	 * dentry.  This method must call d_add() to insert the found
+	 * inode into the dentry.  The "i_count" field in the inode
+	 * structure should be incremented.  If the named inode does not
+	 * exist a NULL inode should be inserted into the dentry (this
+	 * is called a negative dentry).  Returning an error code from
+	 * this routine must only be done on a real error, otherwise
+	 * creating inodes with system calls like create(2), mknod(2),
+	 * mkdir(2) and so on will fail.  If you wish to overload the
+	 * dentry methods then you should initialise the "d_dop" field
+	 * in the dentry; this is a pointer to a &struct
+	 * dentry_operations.  This method is called with the directory
+	 * inode semaphore held.
+	 */
 	struct dentry * (*lookup)(struct inode *dir, struct dentry *dentry,
 				  unsigned int flags);
+
+	/**
+	 * @get_link: Called by the VFS to follow a symbolic link to the
+	 * inode it points to.  Only required if you want to support
+	 * symbolic links.  This method returns the symlink body to
+	 * traverse (and possibly resets the current position with
+	 * nd_jump_link()).  If the body won't go away until the inode
+	 * is gone, nothing else is needed; if it needs to be otherwise
+	 * pinned, arrange for its release by having get_link(..., ...,
+	 * done) do set_delayed_call(done, destructor, argument).  In
+	 * that case destructor(argument) will be called once VFS is
+	 * done with the body you've returned.  May be called in RCU
+	 * mode; that is indicated by %NULL dentry argument.  If request
+	 * can't be handled without leaving RCU mode, have it return
+	 * ERR_PTR(-ECHILD).
+	 */
 	const char * (*get_link)(struct dentry *, struct inode *, struct delayed_call *);
+
+	/**
+	 * @permission: Called by the VFS to check for access rights on
+	 * a POSIX-like filesystem.  May be called in rcu-walk mode
+	 * (mask & MAY_NOT_BLOCK).  If in rcu-walk mode, the filesystem
+	 * must check the permission without blocking or storing to the
+	 * inode.  If a situation is encountered that rcu-walk cannot
+	 * handle, return -ECHILD and it will be called again in
+	 * ref-walk mode.
+	 */
 	int (*permission)(struct inode *, int mask);
+	/**
+	 * @get_acl: Called when doing permission checks on an inode.
+	 */
 	struct posix_acl * (*get_acl)(struct inode *inode, int type);
 
+	/**
+	 * @readlink: This is now just an override for use by
+	 * readlink(2) for the cases when ->get_link uses nd_jump_link()
+	 * or object is not in fact a symlink.  Normally filesystems
+	 * should only implement ->get_link for symlinks and readlink(2)
+	 * will automatically use that.
+	 */
 	int (*readlink)(struct dentry *, char __user *buf, int bufsz);
 
+	/**
+	 * @create: Called by the open(2) and creat(2) system calls.
+	 * Only required if you want to support regular files.  The
+	 * dentry you get should not have an inode (i.e. it should be a
+	 * negative dentry).  Here you will probably call
+	 * d_instantiate() with the dentry and the newly created inode.
+	 */
 	int (*create)(struct inode *, struct dentry *, umode_t, bool);
+
+	/**
+	 * @link: Called by the link(2) system call.  Only required if
+	 * you want to support hard links.  You will probably need to
+	 * call d_instantiate() just as you would in the create()
+	 * method.
+	 */
 	int (*link)(struct dentry *, struct inode *, struct dentry *);
+
+	/**
+	 * @unlink: Called by the unlink(2) system call.  Only required
+	 * if you want to support deleting inodes.
+	 */
 	int (*unlink)(struct inode *, struct dentry *);
+
+	/**
+	 * @symlink: Called by the symlink(2) system call.  Only
+	 * required if you want to support symlinks.  You will probably
+	 * need to call d_instantiate() just as you would in the
+	 * create() method.
+	 */
 	int (*symlink)(struct inode *, struct dentry *, const char *symname);
+
+	/**
+	 * @mkdir: Called by the mkdir(2) system call.  Only required if
+	 * you want to support creating subdirectories.  You will
+	 * probably need to call d_instantiate() just as you would in
+	 * the create() method.
+	 */
 	int (*mkdir)(struct inode *, struct dentry *, umode_t);
+
+	/**
+	 * @rmdir: Called by the rmdir(2) system call.  Only required if
+	 * you want to support deleting subdirectories.
+	 */
 	int (*rmdir)(struct inode *, struct dentry *);
+
+	/**
+	 * @mknod: Called by the mknod(2) system call to create a device
+	 * (char, block) inode or a named pipe (FIFO) or socket.  Only
+	 * required if you want to support creating these types of
+	 * inodes.  You will probably need to call d_instantiate() just
+	 * as you would in the create() method.
+	 */
 	int (*mknod)(struct inode *, struct dentry *, umode_t, dev_t);
+
+	/**
+	 * @rename: Called by the rename(2) system call to rename the object to
+	 * have the parent and name given by the second inode and
+	 * dentry.  The filesystem must return -EINVAL for any
+	 * unsupported or unknown flags.  Currently the following flags
+	 * are implemented:
+	 *
+	 *  1. RENAME_NOREPLACE: this flag indicates that if the target
+	 *     of the rename exists the rename should fail with -EEXIST
+	 *     instead of replacing the target.  The VFS already checks
+	 *     for existence, so for local filesystems the
+	 *     RENAME_NOREPLACE implementation is equivalent to plain
+	 *     rename.
+	 *
+	 *  2. RENAME_EXCHANGE: exchange source and target.  Both must
+	 *     exist; this is checked by the VFS.  Unlike plain rename,
+	 *     source and target may be of different type.
+	 */
 	int (*rename)(struct inode *old_inode, struct dentry *old_dentry,
 		      struct inode *new_inode, struct dentry *new_dentry,
 		      unsigned int flags);
+
+	/**
+	 * @setattr: Called by the VFS to set attributes for a file.
+	 * This method is called by chmod(2) and related system calls.
+	 */
 	int (*setattr)(struct dentry *, struct iattr *);
+
+	/**
+	 * @getattr: Called by the VFS to get attributes of a file.
+	 * This method is called by stat(2) and related system calls.
+	 */
 	int (*getattr)(const struct path *, struct kstat *,
 		       u32 request_mask, unsigned int flags);
+
+	/**
+	 * @listxattr: Called by the VFS to list all extended attributes
+	 * for a given file.  This method is called by the listxattr(2)
+	 * system call.
+	 */
 	ssize_t (*listxattr)(struct dentry *, char *buf, size_t bufsz);
+
+	/**
+	 * @fiemap: Called by the VFS in order to support fiemap (see
+	 * Documentation/filesystems/fiemap.txt).
+	 */
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
 		      u64 len);
+
+	/**
+	 * @update_time: Called by the VFS to update a specific time or
+	 * the i_version of an inode.  If this is not defined the VFS
+	 * will update the inode itself and call
+	 * mark_inode_dirty_sync().
+	 */
 	int (*update_time)(struct inode *, struct timespec64 *, int flags);
+
+	/**
+	 * @atomic_open: Called on the last component of an open.  Using
+	 * this optional method the filesystem can look up, possibly
+	 * create and open the file in one atomic operation.  If it
+	 * wants to leave actual opening to the caller (e.g. if the file
+	 * turned out to be a symlink, device, or just something
+	 * filesystem won't do atomic open for), it may signal this by
+	 * returning finish_no_open(file, dentry).  This method is only
+	 * called if the last component is negative or needs lookup.
+	 * Cached positive dentries are still handled by f_op->open().
+	 * If the file was created, FMODE_CREATED flag should be set in
+	 * file->f_mode.  In case of O_EXCL the method must only succeed
+	 * if the file didn't exist and hence FMODE_CREATED shall always
+	 * be set on success.
+	 */
 	int (*atomic_open)(struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode);
+
+	/**
+	 * @tmpfile: Called in the end of O_TMPFILE open().  Optional,
+	 * equivalent to atomically creating, opening and unlinking a
+	 * file in given directory.
+	 */
 	int (*tmpfile)(struct inode *, struct dentry *, umode_t);
+
+	/**
+	 * @set_acl: Called by the VFS to set the access or default ACL
+	 * of an inode.
+	 */
 	int (*set_acl)(struct inode *, struct posix_acl *, int type);
 } ____cacheline_aligned;
 
@@ -1909,39 +2479,203 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
 
-
+/**
+ * struct super_operations - Describes how the VFS can manipulate the
+ * filesystem superblock.
+ *
+ * All methods are called without any locks being held, unless otherwise
+ * noted.  This means that most methods can block safely.  All methods
+ * are only called from a process context (i.e. not from an interrupt
+ * handler or bottom half).
+ *
+ * Whoever sets up the inode is responsible for filling in the "i_op"
+ * field.  This is a pointer to a &struct inode_operations which
+ * describes the methods that can be performed on individual inodes.
+ *
+ * All methods are called without any locks being held, unless otherwise
+ * noted.  This means that most methods can block safely.  All methods
+ * are only called from a process context (i.e. not from an interrupt
+ * handler or bottom half).
+ */
 struct super_operations {
+	/**
+	 * @alloc_inode: This method is called by alloc_inode() to
+	 * allocate memory for struct inode and initialize it.  If this
+	 * function is not defined, a simple 'struct inode' is
+	 * allocated.  Normally alloc_inode() will be used to allocate a
+	 * larger structure which contains a &struct inode embedded
+	 * within it.
+	 */
 	struct inode *(*alloc_inode)(struct super_block *sb);
+
+	/**
+	 * @destroy_inode: This method is called by destroy_inode() to release
+	 * resources allocated for struct inode.  It is only required if
+	 * ->alloc_inode was defined and simply undoes anything done by
+	 * ->alloc_inode.
+	 */
 	void (*destroy_inode)(struct inode *);
 
+	/**
+	 * @dirty_inode: This method is called by the VFS to mark an
+	 * inode dirty.
+	 */
 	void (*dirty_inode)(struct inode *, int flags);
+
+	/**
+	 * @write_inode: This method is called when the VFS needs to write an
+	 * inode to disc.  The second parameter indicates whether the write
+	 * should be synchronous or not, not all filesystems check this flag.
+	 */
 	int (*write_inode)(struct inode *, struct writeback_control *wbc);
+
+	/**
+	 * @drop_inode: Called when the last access to the inode is
+	 * dropped, with the inode->i_lock spinlock held.  This method
+	 * should be either %NULL (normal UNIX filesystem semantics) or
+	 * generic_delete_inode()(for filesystems that do not want to
+	 * cache inodes - causing delete_inode() to always be called
+	 * regardless of the value of ->i_nlink).  The
+	 * generic_delete_inode() behavior is equivalent to the old
+	 * practice of using force_delete() in the put_inode() case, but
+	 * does not have the races that the force_delete() approach had.
+	 */
 	int (*drop_inode)(struct inode *);
+
+	/**
+	 * @evict_inode: Hybrid of ->clear_inode() and ->delete_inode()
+	 * If present, does all fs work to be done when in-core inode
+	 * is about to be gone, for whatever reason.
+	 */
 	void (*evict_inode)(struct inode *);
+
+	/**
+	 * @put_super: Called when the VFS wishes to free the
+	 * superblock i.e. unmount).  This is called with the
+	 * superblock lock held.
+	 */
 	void (*put_super)(struct super_block *);
+
+	/**
+	 * @sync_fs: Called when VFS is writing out all dirty data
+	 * associated with a superblock.  The second parameter
+	 * indicates whether the method should wait until the write out
+	 * has been completed.  Optional.
+	 */
 	int (*sync_fs)(struct super_block *sb, int wait);
+
+	/**
+	 * @freeze_super: Called when the VFS is syncing the sb to make
+	 * sure the filesystem is consistent and calls the fs's
+	 * freeze_fs().
+	 */
 	int (*freeze_super)(struct super_block *);
+
+	/**
+	 * @freeze_fs: Called when VFS is locking a filesystem and
+	 * forcing it into a consistent state.  This method is
+	 * currently used by the Logical Volume Manager (LVM).
+	 */
 	int (*freeze_fs)(struct super_block *);
+
+	/**
+	 * @thaw_super: Called when the VFS is unlocking the filesystem
+	 * and marks it writeable again after freeze_super().
+	 */
 	int (*thaw_super)(struct super_block *);
+
+	/**
+	 * @unfreeze_fs: Called when VFS is unlocking a filesystem and
+	 * making it writable again.
+	 */
 	int (*unfreeze_fs)(struct super_block *);
+
+	/**
+	 * @statfs: Called when the VFS needs to get filesystem statistics.
+	 */
 	int (*statfs)(struct dentry *, struct kstatfs *);
+
+	/**
+	 * @remount_fs: Called when the filesystem is remounted.  This
+	 * is called with the kernel lock held.
+	 */
 	int (*remount_fs)(struct super_block *, int *flags, char *options);
+
+	/**
+	 * @umount_begin: Called when the VFS is unmounting a filesystem.
+	 */
 	void (*umount_begin)(struct super_block *);
 
+	/**
+	 * @show_options: Called by the VFS to show mount options for
+	 * /proc/<pid>/mounts (see vfs.rst "Mount Options" section).
+	 */
 	int (*show_options)(struct seq_file *, struct dentry *);
+
+	/**
+	 * @show_devname: Called by @show_options and @show_stats to
+	 * show the device name.
+	 */
 	int (*show_devname)(struct seq_file *, struct dentry *);
+
+	/**
+	 * @show_path: Called by @show_options to show the path. (FIXME which path?)
+	 */
 	int (*show_path)(struct seq_file *, struct dentry *);
+
+	/**
+	 * @show_stats: Called by the VFS to show mount stats in
+	 * /proc/<pid>mountstats.
+	 */
 	int (*show_stats)(struct seq_file *, struct dentry *);
+
 #ifdef CONFIG_QUOTA
+	/**
+	 * @quota_read: Called by the VFS to read from filesystem quota file.
+	 */
 	ssize_t (*quota_read)(struct super_block *sb, int type, char *data,
 			      size_t len, loff_t off);
+
+	/**
+	 * @quota_write: Called by the VFS to write to filesystem quota file.
+	 */
 	ssize_t (*quota_write)(struct super_block *sb, int type,
 			       const char *data, size_t len, loff_t off);
+
+	/**
+	 * @get_dquots: TODO: document this
+	 */
 	struct dquot **(*get_dquots)(struct inode *);
 #endif
+	/**
+	 * @bdev_try_to_free_page: TODO: document this
+	 */
 	int (*bdev_try_to_free_page)(struct super_block*, struct page*, gfp_t);
+
+	/**
+	 * @nr_cached_objects: Called by the sb cache shrinking
+	 * function for the filesystem to return the number of freeable
+	 * cached objects it contains.  Optional.
+	 */
 	long (*nr_cached_objects)(struct super_block *,
 				  struct shrink_control *);
+
+	/**
+	 * @free_cached_objects: Called by the sb cache shrinking
+	 * function for the filesystem to scan the number of objects
+	 * indicated to try to free them.  Optional, but any filesystem
+	 * implementing this method needs to also implement
+	 * ->nr_cached_objects for it to be called correctly.  We can't
+	 * do anything with any errors that the filesystem might have
+	 * encountered, hence the void return type.  This will never be
+	 * called if the VM is trying to reclaim under GFP_NOFS
+	 * conditions, hence this method does not need to handle that
+	 * situation itself.  Implementations must include conditional
+	 * reschedule calls inside any scanning loop that is done.
+	 * This allows the VFS to determine appropriate scan batch
+	 * sizes without having to worry about whether implementations
+	 * will cause holdoff problems due to large scan batch sizes.
+	 */
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
 };
@@ -2180,6 +2914,24 @@ static inline void file_accessed(struct file *file)
 int sync_inode(struct inode *inode, struct writeback_control *wbc);
 int sync_inode_metadata(struct inode *inode, int wait);
 
+/**
+ * struct file_system_type - Describes a filesystem.
+ * @name: Name of the filesystem type, such as "ext2", "iso9660",
+ *        "msdos" and so on.
+ * @fs_flags: Various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.).
+ * @parameters: TODO: document this.
+ * @owner: For internal VFS use; you should initialize this to
+ *         THIS_MODULE in most cases.
+ * @next: For internal VFS use; you should initialize this to %NULL.
+ * @fs_supers: TODO: document this.
+ * @s_lock_key: lockdep-specific
+ * @s_umount_key: lockdep-specific
+ * @s_vfs_rename_key: TODO: document this.
+ * @s_writers_key: TODO: document this.
+ * @i_lock_key: TODO: document this.
+ * @i_mutex_key: TODO: document this.
+ * @i_mutex_dir_key: TODO: document this.
+ */
 struct file_system_type {
 	const char *name;
 	int fs_flags;
@@ -2188,11 +2940,33 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+	/**
+	 * @init_fs_context: TODO: document this.
+	 */
 	int (*init_fs_context)(struct fs_context *);
+
 	const struct fs_parameter_description *parameters;
+	/**
+	 * @mount: The method to call when a new instance of this
+	 * filesystem should be mounted.  Please see vfs.rst
+	 * section file_system_type for further documentation.
+	 *
+	 * @fs_type: Describes the filesystem, partly initialized by
+	 * the specific filesystem code.
+	 * @flags: The mount flags.
+	 * @dev_name: The device name we are mounting.
+	 * @data: Arbitrary mount options, usually comes as an ASCII string
+	 * (see "Mount Options" section of Documentation/filesystems/vfs.rst).
+	 */
 	struct dentry *(*mount)(struct file_system_type *fs_type, int flags,
 				const char *dev_name, void *data);
+
+	/**
+	 * @kill_sb: The method to call when an instance of this filesystem
+	 *           should be shut down.
+	 */
 	void (*kill_sb)(struct super_block *);
+
 	struct module *owner;
 	struct file_system_type *next;
 	struct hlist_head fs_supers;
-- 
2.21.0

