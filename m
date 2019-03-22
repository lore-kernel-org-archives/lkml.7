Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A114C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E79E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256877;
	bh=jE4APAeJIJyncgkTaQhscriBgTMxSvuAgTpzX+fIu6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fk0WJykqVWAXg9sOAUphWFhum0JgGsDgl0nqXZwX5Z6AgjQ6UEje3ZyUmxoY8OqgI
	 0nlb7iRJ7JChXVuhZjif6pF9M29NWRCqx1EW/ufcaQSCN8KOlE7nCYeG8b+vOj+NUY
	 LV00A55ICORSN/GXCsWB0BWLlxrFCXtB41Zj3JJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbfCVMOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389920AbfCVMOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E1721929;
        Fri, 22 Mar 2019 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256872;
        bh=jE4APAeJIJyncgkTaQhscriBgTMxSvuAgTpzX+fIu6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19dlnWPXAtj2vYd4gUIJ56AkffKqW6CKWEy6ndjwNvuA3vZ2RNtq+CU/jAneHbu5k
         Fk6b965ZGw1Ta3PZCUUITRJyM9GlyP2Ai3jQ5wqm23wKBX4NQIp+KYNbz50nCgxrbq
         xnxqp2P5shluu8x2Ou+eXY98M+eDJTEto/3s5flg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 5.0 055/238] smb3: make default i/o size for smb3 mounts larger
Date:   Fri, 22 Mar 2019 12:14:34 +0100
Message-Id: <20190322111301.723612785@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit e8506d25f740fd058791cc12a6dfa9386ada6b96 upstream.

We negotiate rsize mounts (and it can be overridden by user) to
typically 4MB, so using larger default I/O sizes from userspace
(changing to 1MB default i/o size returned by stat) the
performance is much better (and not just for long latency
network connections) in most use cases for SMB3 than the default I/O
size (which ends up being 128K for cp and can be even smaller for cp).
This can be 4x slower or worse depending on network latency.

By changing inode->blocksize from 32K (which was perhaps ok
for very old SMB1/CIFS) to a larger value, 1MB (but still less than
max size negotiated with the server which is 4MB, in order to minimize
risk) it significantly increases performance for the
noncached case, and slightly increases it for the cached case.
This can be changed by the user on mount (specifying bsize=
values from 16K to 16MB) to tune better for performance
for applications that depend on blocksize.

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifs_fs_sb.h |    1 +
 fs/cifs/cifsfs.c     |    1 +
 fs/cifs/cifsglob.h   |    1 +
 fs/cifs/connect.c    |   26 ++++++++++++++++++++++++--
 fs/cifs/inode.c      |    2 +-
 5 files changed, 28 insertions(+), 3 deletions(-)

--- a/fs/cifs/cifs_fs_sb.h
+++ b/fs/cifs/cifs_fs_sb.h
@@ -58,6 +58,7 @@ struct cifs_sb_info {
 	spinlock_t tlink_tree_lock;
 	struct tcon_link *master_tlink;
 	struct nls_table *local_nls;
+	unsigned int bsize;
 	unsigned int rsize;
 	unsigned int wsize;
 	unsigned long actimeo; /* attribute cache timeout (jiffies) */
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -554,6 +554,7 @@ cifs_show_options(struct seq_file *s, st
 
 	seq_printf(s, ",rsize=%u", cifs_sb->rsize);
 	seq_printf(s, ",wsize=%u", cifs_sb->wsize);
+	seq_printf(s, ",bsize=%u", cifs_sb->bsize);
 	seq_printf(s, ",echo_interval=%lu",
 			tcon->ses->server->echo_interval / HZ);
 	if (tcon->snapshot_time)
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -559,6 +559,7 @@ struct smb_vol {
 	bool resilient:1; /* noresilient not required since not fored for CA */
 	bool domainauto:1;
 	bool rdma:1;
+	unsigned int bsize;
 	unsigned int rsize;
 	unsigned int wsize;
 	bool sockopt_tcp_nodelay:1;
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -102,7 +102,7 @@ enum {
 	Opt_backupuid, Opt_backupgid, Opt_uid,
 	Opt_cruid, Opt_gid, Opt_file_mode,
 	Opt_dirmode, Opt_port,
-	Opt_rsize, Opt_wsize, Opt_actimeo,
+	Opt_blocksize, Opt_rsize, Opt_wsize, Opt_actimeo,
 	Opt_echo_interval, Opt_max_credits,
 	Opt_snapshot,
 
@@ -204,6 +204,7 @@ static const match_table_t cifs_mount_op
 	{ Opt_dirmode, "dirmode=%s" },
 	{ Opt_dirmode, "dir_mode=%s" },
 	{ Opt_port, "port=%s" },
+	{ Opt_blocksize, "bsize=%s" },
 	{ Opt_rsize, "rsize=%s" },
 	{ Opt_wsize, "wsize=%s" },
 	{ Opt_actimeo, "actimeo=%s" },
@@ -1571,7 +1572,7 @@ cifs_parse_mount_options(const char *mou
 	vol->cred_uid = current_uid();
 	vol->linux_uid = current_uid();
 	vol->linux_gid = current_gid();
-
+	vol->bsize = 1024 * 1024; /* can improve cp performance significantly */
 	/*
 	 * default to SFM style remapping of seven reserved characters
 	 * unless user overrides it or we negotiate CIFS POSIX where
@@ -1944,6 +1945,26 @@ cifs_parse_mount_options(const char *mou
 			}
 			port = (unsigned short)option;
 			break;
+		case Opt_blocksize:
+			if (get_option_ul(args, &option)) {
+				cifs_dbg(VFS, "%s: Invalid blocksize value\n",
+					__func__);
+				goto cifs_parse_mount_err;
+			}
+			/*
+			 * inode blocksize realistically should never need to be
+			 * less than 16K or greater than 16M and default is 1MB.
+			 * Note that small inode block sizes (e.g. 64K) can lead
+			 * to very poor performance of common tools like cp and scp
+			 */
+			if ((option < CIFS_MAX_MSGSIZE) ||
+			   (option > (4 * SMB3_DEFAULT_IOSIZE))) {
+				cifs_dbg(VFS, "%s: Invalid blocksize\n",
+					__func__);
+				goto cifs_parse_mount_err;
+			}
+			vol->bsize = option;
+			break;
 		case Opt_rsize:
 			if (get_option_ul(args, &option)) {
 				cifs_dbg(VFS, "%s: Invalid rsize value\n",
@@ -3839,6 +3860,7 @@ int cifs_setup_cifs_sb(struct smb_vol *p
 	spin_lock_init(&cifs_sb->tlink_tree_lock);
 	cifs_sb->tlink_tree = RB_ROOT;
 
+	cifs_sb->bsize = pvolume_info->bsize;
 	/*
 	 * Temporarily set r/wsize for matching superblock. If we end up using
 	 * new sb then client will later negotiate it downward if needed.
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2080,7 +2080,7 @@ int cifs_getattr(const struct path *path
 		return rc;
 
 	generic_fillattr(inode, stat);
-	stat->blksize = CIFS_MAX_MSGSIZE;
+	stat->blksize = cifs_sb->bsize;
 	stat->ino = CIFS_I(inode)->uniqueid;
 
 	/* old CIFS Unix Extensions doesn't return create time */


