Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA22C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614BC2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfEWQTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:19:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbfEWQTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:19:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 384947E9F9;
        Thu, 23 May 2019 16:19:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A93B5B689;
        Thu, 23 May 2019 16:19:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/23] NFS: Add fs_context support.
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:19:05 +0100
Message-ID: <155862834550.26654.17230477291010963688.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 23 May 2019 16:19:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add filesystem context support to NFS, parsing the options in advance and
attaching the information to struct nfs_fs_context.  The highlights are:

 (*) Merge nfs_mount_info and nfs_clone_mount into nfs_fs_context.  This
     structure represents NFS's superblock config.

 (*) Make use of the VFS's parsing support to split comma-separated lists.

 (*) Pin the NFS protocol module in the nfs_fs_context.

 (*) Attach supplementary error information to fs_context.  This has the
     downside that these strings must be static and can't be formatted.

 (*) Remove the auxiliary file_system_type structs since the information
     necessary can be conveyed in the nfs_fs_context struct instead.

 (*) Root mounts are made by duplicating the config for the requested mount
     so as to have the same parameters.  Submounts pick up their parameters
     from the parent superblock.

[AV -- retrans is u32, not string]

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/client.c         |   78 +--
 fs/nfs/fs_context.c     | 1330 ++++++++++++++++++++++++-----------------------
 fs/nfs/fscache.c        |    2 
 fs/nfs/getroot.c        |   73 +--
 fs/nfs/internal.h       |  104 +---
 fs/nfs/namespace.c      |  134 +++--
 fs/nfs/nfs3_fs.h        |    2 
 fs/nfs/nfs3client.c     |    5 
 fs/nfs/nfs3proc.c       |    2 
 fs/nfs/nfs4_fs.h        |    9 
 fs/nfs/nfs4client.c     |   60 +-
 fs/nfs/nfs4namespace.c  |  285 ++++++----
 fs/nfs/nfs4proc.c       |    2 
 fs/nfs/nfs4super.c      |  166 +++---
 fs/nfs/proc.c           |    2 
 fs/nfs/super.c          |  362 ++++---------
 include/linux/nfs_xdr.h |    8 
 17 files changed, 1293 insertions(+), 1331 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4534ecebe380..cb540edeb3e1 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -649,26 +649,26 @@ EXPORT_SYMBOL_GPL(nfs_init_client);
  * Create a version 2 or 3 client
  */
 static int nfs_init_server(struct nfs_server *server,
-			   const struct nfs_fs_context *cfg,
-			   struct nfs_subversion *nfs_mod)
+			   const struct fs_context *fc)
 {
+	const struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct rpc_timeout timeparms;
 	struct nfs_client_initdata cl_init = {
-		.hostname = cfg->nfs_server.hostname,
-		.addr = (const struct sockaddr *)&cfg->nfs_server.address,
-		.addrlen = cfg->nfs_server.addrlen,
-		.nfs_mod = nfs_mod,
-		.proto = cfg->nfs_server.protocol,
-		.net = cfg->net,
+		.hostname = ctx->nfs_server.hostname,
+		.addr = (const struct sockaddr *)&ctx->nfs_server.address,
+		.addrlen = ctx->nfs_server.addrlen,
+		.nfs_mod = ctx->nfs_mod,
+		.proto = ctx->nfs_server.protocol,
+		.net = fc->net_ns,
 		.timeparms = &timeparms,
 		.cred = server->cred,
 	};
 	struct nfs_client *clp;
 	int error;
 
-	nfs_init_timeout_values(&timeparms, cfg->nfs_server.protocol,
-				cfg->timeo, cfg->retrans);
-	if (cfg->flags & NFS_MOUNT_NORESVPORT)
+	nfs_init_timeout_values(&timeparms, ctx->nfs_server.protocol,
+				ctx->timeo, ctx->retrans);
+	if (ctx->flags & NFS_MOUNT_NORESVPORT)
 		set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
 	/* Allocate or find a client reference we can use */
@@ -679,46 +679,46 @@ static int nfs_init_server(struct nfs_server *server,
 	server->nfs_client = clp;
 
 	/* Initialise the client representation from the mount data */
-	server->flags = cfg->flags;
-	server->options = cfg->options;
+	server->flags = ctx->flags;
+	server->options = ctx->options;
 	server->caps |= NFS_CAP_HARDLINKS|NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
 		NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|NFS_CAP_OWNER_GROUP|
 		NFS_CAP_ATIME|NFS_CAP_CTIME|NFS_CAP_MTIME;
 
-	if (cfg->rsize)
-		server->rsize = nfs_block_size(cfg->rsize, NULL);
-	if (cfg->wsize)
-		server->wsize = nfs_block_size(cfg->wsize, NULL);
+	if (ctx->rsize)
+		server->rsize = nfs_block_size(ctx->rsize, NULL);
+	if (ctx->wsize)
+		server->wsize = nfs_block_size(ctx->wsize, NULL);
 
-	server->acregmin = cfg->acregmin * HZ;
-	server->acregmax = cfg->acregmax * HZ;
-	server->acdirmin = cfg->acdirmin * HZ;
-	server->acdirmax = cfg->acdirmax * HZ;
+	server->acregmin = ctx->acregmin * HZ;
+	server->acregmax = ctx->acregmax * HZ;
+	server->acdirmin = ctx->acdirmin * HZ;
+	server->acdirmax = ctx->acdirmax * HZ;
 
 	/* Start lockd here, before we might error out */
 	error = nfs_start_lockd(server);
 	if (error < 0)
 		goto error;
 
-	server->port = cfg->nfs_server.port;
-	server->auth_info = cfg->auth_info;
+	server->port = ctx->nfs_server.port;
+	server->auth_info = ctx->auth_info;
 
 	error = nfs_init_server_rpcclient(server, &timeparms,
-					  cfg->selected_flavor);
+					  ctx->selected_flavor);
 	if (error < 0)
 		goto error;
 
 	/* Preserve the values of mount_server-related mount options */
-	if (cfg->mount_server.addrlen) {
-		memcpy(&server->mountd_address, &cfg->mount_server.address,
-			cfg->mount_server.addrlen);
-		server->mountd_addrlen = cfg->mount_server.addrlen;
+	if (ctx->mount_server.addrlen) {
+		memcpy(&server->mountd_address, &ctx->mount_server.address,
+			ctx->mount_server.addrlen);
+		server->mountd_addrlen = ctx->mount_server.addrlen;
 	}
-	server->mountd_version = cfg->mount_server.version;
-	server->mountd_port = cfg->mount_server.port;
-	server->mountd_protocol = cfg->mount_server.protocol;
+	server->mountd_version = ctx->mount_server.version;
+	server->mountd_port = ctx->mount_server.port;
+	server->mountd_protocol = ctx->mount_server.protocol;
 
-	server->namelen  = cfg->namlen;
+	server->namelen  = ctx->namlen;
 	return 0;
 
 error:
@@ -940,10 +940,10 @@ EXPORT_SYMBOL_GPL(nfs_free_server);
  * Create a version 2 or 3 volume record
  * - keyed on server and FSID
  */
-struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs_create_server(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_server *server;
-	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 	struct nfs_fattr *fattr;
 	int error;
 
@@ -959,18 +959,18 @@ struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
 		goto error;
 
 	/* Get a client representation */
-	error = nfs_init_server(server, mount_info->ctx, nfs_mod);
+	error = nfs_init_server(server, fc);
 	if (error < 0)
 		goto error;
 
 	/* Probe the root fh to retrieve its FSID */
-	error = nfs_probe_fsinfo(server, mount_info->mntfh, fattr);
+	error = nfs_probe_fsinfo(server, ctx->mntfh, fattr);
 	if (error < 0)
 		goto error;
 	if (server->nfs_client->rpc_ops->version == 3) {
 		if (server->namelen == 0 || server->namelen > NFS3_MAXNAMLEN)
 			server->namelen = NFS3_MAXNAMLEN;
-		if (!(mount_info->ctx->flags & NFS_MOUNT_NORDIRPLUS))
+		if (!(ctx->flags & NFS_MOUNT_NORDIRPLUS))
 			server->caps |= NFS_CAP_READDIRPLUS;
 	} else {
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
@@ -978,8 +978,8 @@ struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
 	}
 
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
-		error = nfs_mod->rpc_ops->getattr(server, mount_info->mntfh,
-				fattr, NULL, NULL);
+		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
+						       fattr, NULL, NULL);
 		if (error < 0) {
 			dprintk("nfs_create_server: getattr error = %d\n", -error);
 			goto error;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 3afacdee37c8..d05271b91e38 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -15,7 +15,8 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
@@ -30,254 +31,215 @@
 #define NFS_DEFAULT_VERSION 2
 #endif
 
-enum {
-	/* Mount options that take no arguments */
-	Opt_soft, Opt_softerr, Opt_hard,
-	Opt_posix, Opt_noposix,
-	Opt_cto, Opt_nocto,
-	Opt_ac, Opt_noac,
-	Opt_lock, Opt_nolock,
-	Opt_udp, Opt_tcp, Opt_rdma,
-	Opt_acl, Opt_noacl,
-	Opt_rdirplus, Opt_nordirplus,
-	Opt_sharecache, Opt_nosharecache,
-	Opt_resvport, Opt_noresvport,
-	Opt_fscache, Opt_nofscache,
-	Opt_migration, Opt_nomigration,
-
-	/* Mount options that take integer arguments */
-	Opt_port,
-	Opt_rsize, Opt_wsize, Opt_bsize,
-	Opt_timeo, Opt_retrans,
-	Opt_acregmin, Opt_acregmax,
-	Opt_acdirmin, Opt_acdirmax,
+enum nfs_param {
+	Opt_ac,
+	Opt_acdirmax,
+	Opt_acdirmin,
+	Opt_acl,
+	Opt_acregmax,
+	Opt_acregmin,
 	Opt_actimeo,
-	Opt_namelen,
+	Opt_addr,
+	Opt_bg,
+	Opt_bsize,
+	Opt_clientaddr,
+	Opt_cto,
+	Opt_fg,
+	Opt_fscache,
+	Opt_hard,
+	Opt_intr,
+	Opt_local_lock,
+	Opt_lock,
+	Opt_lookupcache,
+	Opt_migration,
+	Opt_minorversion,
+	Opt_mountaddr,
+	Opt_mounthost,
 	Opt_mountport,
+	Opt_mountproto,
 	Opt_mountvers,
-	Opt_minorversion,
-
-	/* Mount options that take string arguments */
-	Opt_nfsvers,
-	Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
-	Opt_addr, Opt_mountaddr, Opt_clientaddr,
-	Opt_lookupcache,
-	Opt_fscache_uniq,
-	Opt_local_lock,
-
-	/* Special mount options */
-	Opt_userspace, Opt_deprecated, Opt_sloppy,
-
-	Opt_err
+	Opt_namelen,
+	Opt_port,
+	Opt_posix,
+	Opt_proto,
+	Opt_rdirplus,
+	Opt_rdma,
+	Opt_resvport,
+	Opt_retrans,
+	Opt_retry,
+	Opt_rsize,
+	Opt_sec,
+	Opt_sharecache,
+	Opt_sloppy,
+	Opt_soft,
+	Opt_softerr,
+	Opt_source,
+	Opt_tcp,
+	Opt_timeo,
+	Opt_udp,
+	Opt_v,
+	Opt_vers,
+	Opt_wsize,
 };
 
-static const match_table_t nfs_mount_option_tokens = {
-	{ Opt_userspace, "bg" },
-	{ Opt_userspace, "fg" },
-	{ Opt_userspace, "retry=%s" },
-
-	{ Opt_sloppy, "sloppy" },
-
-	{ Opt_soft, "soft" },
-	{ Opt_softerr, "softerr" },
-	{ Opt_hard, "hard" },
-	{ Opt_deprecated, "intr" },
-	{ Opt_deprecated, "nointr" },
-	{ Opt_posix, "posix" },
-	{ Opt_noposix, "noposix" },
-	{ Opt_cto, "cto" },
-	{ Opt_nocto, "nocto" },
-	{ Opt_ac, "ac" },
-	{ Opt_noac, "noac" },
-	{ Opt_lock, "lock" },
-	{ Opt_nolock, "nolock" },
-	{ Opt_udp, "udp" },
-	{ Opt_tcp, "tcp" },
-	{ Opt_rdma, "rdma" },
-	{ Opt_acl, "acl" },
-	{ Opt_noacl, "noacl" },
-	{ Opt_rdirplus, "rdirplus" },
-	{ Opt_nordirplus, "nordirplus" },
-	{ Opt_sharecache, "sharecache" },
-	{ Opt_nosharecache, "nosharecache" },
-	{ Opt_resvport, "resvport" },
-	{ Opt_noresvport, "noresvport" },
-	{ Opt_fscache, "fsc" },
-	{ Opt_nofscache, "nofsc" },
-	{ Opt_migration, "migration" },
-	{ Opt_nomigration, "nomigration" },
-
-	{ Opt_port, "port=%s" },
-	{ Opt_rsize, "rsize=%s" },
-	{ Opt_wsize, "wsize=%s" },
-	{ Opt_bsize, "bsize=%s" },
-	{ Opt_timeo, "timeo=%s" },
-	{ Opt_retrans, "retrans=%s" },
-	{ Opt_acregmin, "acregmin=%s" },
-	{ Opt_acregmax, "acregmax=%s" },
-	{ Opt_acdirmin, "acdirmin=%s" },
-	{ Opt_acdirmax, "acdirmax=%s" },
-	{ Opt_actimeo, "actimeo=%s" },
-	{ Opt_namelen, "namlen=%s" },
-	{ Opt_mountport, "mountport=%s" },
-	{ Opt_mountvers, "mountvers=%s" },
-	{ Opt_minorversion, "minorversion=%s" },
-
-	{ Opt_nfsvers, "nfsvers=%s" },
-	{ Opt_nfsvers, "vers=%s" },
-
-	{ Opt_sec, "sec=%s" },
-	{ Opt_proto, "proto=%s" },
-	{ Opt_mountproto, "mountproto=%s" },
-	{ Opt_addr, "addr=%s" },
-	{ Opt_clientaddr, "clientaddr=%s" },
-	{ Opt_mounthost, "mounthost=%s" },
-	{ Opt_mountaddr, "mountaddr=%s" },
-
-	{ Opt_lookupcache, "lookupcache=%s" },
-	{ Opt_fscache_uniq, "fsc=%s" },
-	{ Opt_local_lock, "local_lock=%s" },
-
-	/* The following needs to be listed after all other options */
-	{ Opt_nfsvers, "v%s" },
-
-	{ Opt_err, NULL }
+static const struct fs_parameter_spec nfs_param_specs[] = {
+	fsparam_flag_no("ac",		Opt_ac),
+	fsparam_u32   ("acdirmax",	Opt_acdirmax),
+	fsparam_u32   ("acdirmin",	Opt_acdirmin),
+	fsparam_flag_no("acl",		Opt_acl),
+	fsparam_u32   ("acregmax",	Opt_acregmax),
+	fsparam_u32   ("acregmin",	Opt_acregmin),
+	fsparam_u32   ("actimeo",	Opt_actimeo),
+	fsparam_string("addr",		Opt_addr),
+	fsparam_flag  ("bg",		Opt_bg),
+	fsparam_u32   ("bsize",		Opt_bsize),
+	fsparam_string("clientaddr",	Opt_clientaddr),
+	fsparam_flag_no("cto",		Opt_cto),
+	fsparam_flag  ("fg",		Opt_fg),
+	__fsparam(fs_param_is_string, "fsc",		Opt_fscache,
+		  fs_param_neg_with_no|fs_param_v_optional),
+	fsparam_flag  ("hard",		Opt_hard),
+	__fsparam(fs_param_is_flag, "intr",		Opt_intr,
+		  fs_param_neg_with_no|fs_param_deprecated),
+	fsparam_enum  ("local_lock",	Opt_local_lock),
+	fsparam_flag_no("lock",		Opt_lock),
+	fsparam_enum  ("lookupcache",	Opt_lookupcache),
+	fsparam_flag_no("migration",	Opt_migration),
+	fsparam_u32   ("minorversion",	Opt_minorversion),
+	fsparam_string("mountaddr",	Opt_mountaddr),
+	fsparam_string("mounthost",	Opt_mounthost),
+	fsparam_u32   ("mountport",	Opt_mountport),
+	fsparam_string("mountproto",	Opt_mountproto),
+	fsparam_u32   ("mountvers",	Opt_mountvers),
+	fsparam_u32   ("namlen",	Opt_namelen),
+	fsparam_string("nfsvers",	Opt_vers),
+	fsparam_u32   ("port",		Opt_port),
+	fsparam_flag_no("posix",	Opt_posix),
+	fsparam_string("proto",		Opt_proto),
+	fsparam_flag_no("rdirplus",	Opt_rdirplus),
+	fsparam_flag  ("rdma",		Opt_rdma),
+	fsparam_flag_no("resvport",	Opt_resvport),
+	fsparam_u32   ("retrans",	Opt_retrans),
+	fsparam_string("retry",		Opt_retry),
+	fsparam_u32   ("rsize",		Opt_rsize),
+	fsparam_string("sec",		Opt_sec),
+	fsparam_flag_no("sharecache",	Opt_sharecache),
+	fsparam_flag  ("sloppy",	Opt_sloppy),
+	fsparam_flag  ("soft",		Opt_soft),
+	fsparam_flag  ("softerr",	Opt_softerr),
+	fsparam_string("source",	Opt_source),
+	fsparam_flag  ("tcp",		Opt_tcp),
+	fsparam_u32   ("timeo",		Opt_timeo),
+	fsparam_flag  ("udp",		Opt_udp),
+	fsparam_flag  ("v2",		Opt_v),
+	fsparam_flag  ("v3",		Opt_v),
+	fsparam_flag  ("v4",		Opt_v),
+	fsparam_flag  ("v4.0",		Opt_v),
+	fsparam_flag  ("v4.1",		Opt_v),
+	fsparam_flag  ("v4.2",		Opt_v),
+	fsparam_string("vers",		Opt_vers),
+	fsparam_u32   ("wsize",		Opt_wsize),
+	{}
 };
 
 enum {
-	Opt_xprt_udp, Opt_xprt_udp6, Opt_xprt_tcp, Opt_xprt_tcp6, Opt_xprt_rdma,
-	Opt_xprt_rdma6,
-
-	Opt_xprt_err
-};
-
-static const match_table_t nfs_xprt_protocol_tokens = {
-	{ Opt_xprt_udp, "udp" },
-	{ Opt_xprt_udp6, "udp6" },
-	{ Opt_xprt_tcp, "tcp" },
-	{ Opt_xprt_tcp6, "tcp6" },
-	{ Opt_xprt_rdma, "rdma" },
-	{ Opt_xprt_rdma6, "rdma6" },
-
-	{ Opt_xprt_err, NULL }
+	Opt_local_lock_all,
+	Opt_local_lock_flock,
+	Opt_local_lock_none,
+	Opt_local_lock_posix,
 };
 
 enum {
-	Opt_sec_none, Opt_sec_sys,
-	Opt_sec_krb5, Opt_sec_krb5i, Opt_sec_krb5p,
-	Opt_sec_lkey, Opt_sec_lkeyi, Opt_sec_lkeyp,
-	Opt_sec_spkm, Opt_sec_spkmi, Opt_sec_spkmp,
-
-	Opt_sec_err
+	Opt_lookupcache_all,
+	Opt_lookupcache_none,
+	Opt_lookupcache_positive,
 };
 
-static const match_table_t nfs_secflavor_tokens = {
-	{ Opt_sec_none, "none" },
-	{ Opt_sec_none, "null" },
-	{ Opt_sec_sys, "sys" },
-
-	{ Opt_sec_krb5, "krb5" },
-	{ Opt_sec_krb5i, "krb5i" },
-	{ Opt_sec_krb5p, "krb5p" },
-
-	{ Opt_sec_lkey, "lkey" },
-	{ Opt_sec_lkeyi, "lkeyi" },
-	{ Opt_sec_lkeyp, "lkeyp" },
-
-	{ Opt_sec_spkm, "spkm3" },
-	{ Opt_sec_spkmi, "spkm3i" },
-	{ Opt_sec_spkmp, "spkm3p" },
+static const struct fs_parameter_enum nfs_param_enums[] = {
+	{ Opt_local_lock,	"all",		Opt_local_lock_all },
+	{ Opt_local_lock,	"flock",	Opt_local_lock_flock },
+	{ Opt_local_lock,	"none",		Opt_local_lock_none },
+	{ Opt_local_lock,	"posix",	Opt_local_lock_posix },
+	{ Opt_lookupcache,	"all",		Opt_lookupcache_all },
+	{ Opt_lookupcache,	"none",		Opt_lookupcache_none },
+	{ Opt_lookupcache,	"pos",		Opt_lookupcache_positive },
+	{ Opt_lookupcache,	"positive",	Opt_lookupcache_positive },
+	{}
+};
 
-	{ Opt_sec_err, NULL }
+static const struct fs_parameter_description nfs_fs_parameters = {
+	.name		= "nfs",
+	.specs		= nfs_param_specs,
+	.enums		= nfs_param_enums,
 };
 
 enum {
-	Opt_lookupcache_all, Opt_lookupcache_positive,
-	Opt_lookupcache_none,
-
-	Opt_lookupcache_err
+	Opt_vers_2,
+	Opt_vers_3,
+	Opt_vers_4,
+	Opt_vers_4_0,
+	Opt_vers_4_1,
+	Opt_vers_4_2,
 };
 
-static const match_table_t nfs_lookupcache_tokens = {
-	{ Opt_lookupcache_all, "all" },
-	{ Opt_lookupcache_positive, "pos" },
-	{ Opt_lookupcache_positive, "positive" },
-	{ Opt_lookupcache_none, "none" },
-
-	{ Opt_lookupcache_err, NULL }
+static const struct constant_table nfs_vers_tokens[] = {
+	{ "2",		Opt_vers_2 },
+	{ "3",		Opt_vers_3 },
+	{ "4",		Opt_vers_4 },
+	{ "4.0",	Opt_vers_4_0 },
+	{ "4.1",	Opt_vers_4_1 },
+	{ "4.2",	Opt_vers_4_2 },
 };
 
 enum {
-	Opt_local_lock_all, Opt_local_lock_flock, Opt_local_lock_posix,
-	Opt_local_lock_none,
-
-	Opt_local_lock_err
+	Opt_xprt_rdma,
+	Opt_xprt_rdma6,
+	Opt_xprt_tcp,
+	Opt_xprt_tcp6,
+	Opt_xprt_udp,
+	Opt_xprt_udp6,
+	nr__Opt_xprt
 };
 
-static const match_table_t nfs_local_lock_tokens = {
-	{ Opt_local_lock_all, "all" },
-	{ Opt_local_lock_flock, "flock" },
-	{ Opt_local_lock_posix, "posix" },
-	{ Opt_local_lock_none, "none" },
-
-	{ Opt_local_lock_err, NULL }
+static const struct constant_table nfs_xprt_protocol_tokens[nr__Opt_xprt] = {
+	{ "rdma",	Opt_xprt_rdma },
+	{ "rdma6",	Opt_xprt_rdma6 },
+	{ "tcp",	Opt_xprt_tcp },
+	{ "tcp6",	Opt_xprt_tcp6 },
+	{ "udp",	Opt_xprt_udp },
+	{ "udp6",	Opt_xprt_udp },
 };
 
 enum {
-	Opt_vers_2, Opt_vers_3, Opt_vers_4, Opt_vers_4_0,
-	Opt_vers_4_1, Opt_vers_4_2,
-
-	Opt_vers_err
+	Opt_sec_krb5,
+	Opt_sec_krb5i,
+	Opt_sec_krb5p,
+	Opt_sec_lkey,
+	Opt_sec_lkeyi,
+	Opt_sec_lkeyp,
+	Opt_sec_none,
+	Opt_sec_spkm,
+	Opt_sec_spkmi,
+	Opt_sec_spkmp,
+	Opt_sec_sys,
+	nr__Opt_sec
 };
 
-static const match_table_t nfs_vers_tokens = {
-	{ Opt_vers_2, "2" },
-	{ Opt_vers_3, "3" },
-	{ Opt_vers_4, "4" },
-	{ Opt_vers_4_0, "4.0" },
-	{ Opt_vers_4_1, "4.1" },
-	{ Opt_vers_4_2, "4.2" },
-
-	{ Opt_vers_err, NULL }
+static const struct constant_table nfs_secflavor_tokens[] = {
+	{ "krb5",	Opt_sec_krb5 },
+	{ "krb5i",	Opt_sec_krb5i },
+	{ "krb5p",	Opt_sec_krb5p },
+	{ "lkey",	Opt_sec_lkey },
+	{ "lkeyi",	Opt_sec_lkeyi },
+	{ "lkeyp",	Opt_sec_lkeyp },
+	{ "none",	Opt_sec_none },
+	{ "null",	Opt_sec_none },
+	{ "spkm3",	Opt_sec_spkm },
+	{ "spkm3i",	Opt_sec_spkmi },
+	{ "spkm3p",	Opt_sec_spkmp },
+	{ "sys",	Opt_sec_sys },
 };
 
-struct nfs_fs_context *nfs_alloc_parsed_mount_data(void)
-{
-	struct nfs_fs_context *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (ctx) {
-		ctx->timeo		= NFS_UNSPEC_TIMEO;
-		ctx->retrans		= NFS_UNSPEC_RETRANS;
-		ctx->acregmin		= NFS_DEF_ACREGMIN;
-		ctx->acregmax		= NFS_DEF_ACREGMAX;
-		ctx->acdirmin		= NFS_DEF_ACDIRMIN;
-		ctx->acdirmax		= NFS_DEF_ACDIRMAX;
-		ctx->mount_server.port	= NFS_UNSPEC_PORT;
-		ctx->nfs_server.port	= NFS_UNSPEC_PORT;
-		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
-		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
-		ctx->minorversion	= 0;
-		ctx->need_mount	= true;
-		ctx->net		= current->nsproxy->net_ns;
-		ctx->lsm_opts = NULL;
-	}
-	return ctx;
-}
-
-void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx)
-{
-	if (ctx) {
-		kfree(ctx->client_address);
-		kfree(ctx->mount_server.hostname);
-		kfree(ctx->nfs_server.export_path);
-		kfree(ctx->nfs_server.hostname);
-		kfree(ctx->fscache_uniq);
-		security_free_mnt_opts(&ctx->lsm_opts);
-		kfree(ctx);
-	}
-}
-
 /*
  * Sanity-check a server address provided by the mount command.
  *
@@ -342,7 +304,7 @@ static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
  * Add 'flavor' to 'auth_info' if not already present.
  * Returns true if 'flavor' ends up in the list, false otherwise
  */
-static int nfs_auth_info_add(struct nfs_fs_context *ctx,
+static int nfs_auth_info_add(struct fs_context *fc,
 			     struct nfs_auth_info *auth_info,
 			     rpc_authflavor_t flavor)
 {
@@ -355,10 +317,8 @@ static int nfs_auth_info_add(struct nfs_fs_context *ctx,
 			return 0;
 	}
 
-	if (auth_info->flavor_len + 1 >= max_flavor_len) {
-		dfprintk(MOUNT, "NFS: too many sec= flavors\n");
-		return -EINVAL;
-	}
+	if (auth_info->flavor_len + 1 >= max_flavor_len)
+		return nfs_invalf(fc, "NFS: too many sec= flavors");
 
 	auth_info->flavors[auth_info->flavor_len++] = flavor;
 	return 0;
@@ -367,17 +327,20 @@ static int nfs_auth_info_add(struct nfs_fs_context *ctx,
 /*
  * Parse the value of the 'sec=' option.
  */
-static int nfs_parse_security_flavors(struct nfs_fs_context *ctx, char *value)
+static int nfs_parse_security_flavors(struct fs_context *fc,
+				      struct fs_parameter *param)
 {
-	substring_t args[MAX_OPT_ARGS];
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	rpc_authflavor_t pseudoflavor;
-	char *p;
+	char *string = param->string, *p;
 	int ret;
 
-	dfprintk(MOUNT, "NFS: parsing sec=%s option\n", value);
+	dfprintk(MOUNT, "NFS: parsing %s=%s option\n", param->key, param->string);
 
-	while ((p = strsep(&value, ":")) != NULL) {
-		switch (match_token(p, nfs_secflavor_tokens, args)) {
+	while ((p = strsep(&string, ":")) != NULL) {
+		if (!*p)
+			continue;
+		switch (lookup_constant(nfs_secflavor_tokens, p, -1)) {
 		case Opt_sec_none:
 			pseudoflavor = RPC_AUTH_NULL;
 			break;
@@ -412,12 +375,10 @@ static int nfs_parse_security_flavors(struct nfs_fs_context *ctx, char *value)
 			pseudoflavor = RPC_AUTH_GSS_SPKMP;
 			break;
 		default:
-			dfprintk(MOUNT,
-				 "NFS: sec= option '%s' not recognized\n", p);
-			return -EINVAL;
+			return nfs_invalf(fc, "NFS: sec=%s option not recognized", p);
 		}
 
-		ret = nfs_auth_info_add(ctx, &ctx->auth_info, pseudoflavor);
+		ret = nfs_auth_info_add(fc, &ctx->auth_info, pseudoflavor);
 		if (ret < 0)
 			return ret;
 	}
@@ -425,12 +386,13 @@ static int nfs_parse_security_flavors(struct nfs_fs_context *ctx, char *value)
 	return 0;
 }
 
-static int nfs_parse_version_string(struct nfs_fs_context *ctx,
-				    char *string,
-				    substring_t *args)
+static int nfs_parse_version_string(struct fs_context *fc,
+				    const char *string)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+
 	ctx->flags &= ~NFS_MOUNT_VER3;
-	switch (match_token(string, nfs_vers_tokens, args)) {
+	switch (lookup_constant(nfs_vers_tokens, string, -1)) {
 	case Opt_vers_2:
 		ctx->version = 2;
 		break;
@@ -458,54 +420,37 @@ static int nfs_parse_version_string(struct nfs_fs_context *ctx,
 		ctx->minorversion = 2;
 		break;
 	default:
-		dfprintk(MOUNT, "NFS:   Unsupported NFS version\n");
-		return -EINVAL;
+		return nfs_invalf(fc, "NFS: Unsupported NFS version");
 	}
 	return 0;
 }
 
-static int nfs_get_option_str(substring_t args[], char **option)
-{
-	kfree(*option);
-	*option = match_strdup(args);
-	return !*option;
-}
-
-static int nfs_get_option_ui(struct nfs_fs_context *ctx,
-			     substring_t args[], unsigned int *option)
-{
-	match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
-	return kstrtouint(ctx->buf, 10, option);
-}
-
-static int nfs_get_option_ui_bound(struct nfs_fs_context *ctx,
-				   substring_t args[], unsigned int *option,
-				   unsigned int l_bound, unsigned u_bound)
-{
-	int ret;
-
-	match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
-	ret = kstrtouint(ctx->buf, 10, option);
-	if (ret < 0)
-		return ret;
-	if (*option < l_bound || *option > u_bound)
-		return -ERANGE;
-	return 0;
-}
-
 /*
- * Parse a single mount option in "key[=val]" form.
+ * Parse a single mount parameter.
  */
-static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
+static int nfs_fs_context_parse_param(struct fs_context *fc,
+				      struct fs_parameter *param)
 {
-	substring_t args[MAX_OPT_ARGS];
-	char *string;
-	int token, ret;
+	struct fs_parse_result result;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	unsigned short protofamily, mountfamily;
+	unsigned int len;
+	int ret, opt;
+
+	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", param->key);
 
-	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
+	opt = fs_parse(fc, &nfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return ctx->sloppy ? 1 : opt;
+
+	switch (opt) {
+	case Opt_source:
+		if (fc->source)
+			return nfs_invalf(fc, "NFS: Multiple sources not supported");
+		fc->source = param->string;
+		param->string = NULL;
+		break;
 
-	token = match_token(p, nfs_mount_option_tokens, args);
-	switch (token) {
 		/*
 		 * boolean options:  foo/nofoo
 		 */
@@ -521,30 +466,31 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		ctx->flags &= ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
 		break;
 	case Opt_posix:
-		ctx->flags |= NFS_MOUNT_POSIX;
-		break;
-	case Opt_noposix:
-		ctx->flags &= ~NFS_MOUNT_POSIX;
+		if (result.negated)
+			ctx->flags &= ~NFS_MOUNT_POSIX;
+		else
+			ctx->flags |= NFS_MOUNT_POSIX;
 		break;
 	case Opt_cto:
-		ctx->flags &= ~NFS_MOUNT_NOCTO;
-		break;
-	case Opt_nocto:
-		ctx->flags |= NFS_MOUNT_NOCTO;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NOCTO;
+		else
+			ctx->flags &= ~NFS_MOUNT_NOCTO;
 		break;
 	case Opt_ac:
-		ctx->flags &= ~NFS_MOUNT_NOAC;
-		break;
-	case Opt_noac:
-		ctx->flags |= NFS_MOUNT_NOAC;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NOAC;
+		else
+			ctx->flags &= ~NFS_MOUNT_NOAC;
 		break;
 	case Opt_lock:
-		ctx->flags &= ~NFS_MOUNT_NONLM;
-		ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
-		break;
-	case Opt_nolock:
-		ctx->flags |= NFS_MOUNT_NONLM;
-		ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+		if (result.negated) {
+			ctx->flags |= NFS_MOUNT_NONLM;
+			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+		} else {
+			ctx->flags &= ~NFS_MOUNT_NONLM;
+			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+		}
 		break;
 	case Opt_udp:
 		ctx->flags &= ~NFS_MOUNT_TCP;
@@ -557,244 +503,215 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 	case Opt_rdma:
 		ctx->flags |= NFS_MOUNT_TCP; /* for side protocols */
 		ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
-		xprt_load_transport(p);
+		xprt_load_transport(param->key);
 		break;
 	case Opt_acl:
-		ctx->flags &= ~NFS_MOUNT_NOACL;
-		break;
-	case Opt_noacl:
-		ctx->flags |= NFS_MOUNT_NOACL;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NOACL;
+		else
+			ctx->flags &= ~NFS_MOUNT_NOACL;
 		break;
 	case Opt_rdirplus:
-		ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
-		break;
-	case Opt_nordirplus:
-		ctx->flags |= NFS_MOUNT_NORDIRPLUS;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NORDIRPLUS;
+		else
+			ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
 		break;
 	case Opt_sharecache:
-		ctx->flags &= ~NFS_MOUNT_UNSHARED;
-		break;
-	case Opt_nosharecache:
-		ctx->flags |= NFS_MOUNT_UNSHARED;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_UNSHARED;
+		else
+			ctx->flags &= ~NFS_MOUNT_UNSHARED;
 		break;
 	case Opt_resvport:
-		ctx->flags &= ~NFS_MOUNT_NORESVPORT;
-		break;
-	case Opt_noresvport:
-		ctx->flags |= NFS_MOUNT_NORESVPORT;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NORESVPORT;
+		else
+			ctx->flags &= ~NFS_MOUNT_NORESVPORT;
 		break;
 	case Opt_fscache:
-		ctx->options |= NFS_OPTION_FSCACHE;
-		kfree(ctx->fscache_uniq);
-		ctx->fscache_uniq = NULL;
-		break;
-	case Opt_nofscache:
-		ctx->options &= ~NFS_OPTION_FSCACHE;
 		kfree(ctx->fscache_uniq);
-		ctx->fscache_uniq = NULL;
+		ctx->fscache_uniq = param->string;
+		param->string = NULL;
+		if (result.negated)
+			ctx->options &= ~NFS_OPTION_FSCACHE;
+		else
+			ctx->options |= NFS_OPTION_FSCACHE;
 		break;
 	case Opt_migration:
-		ctx->options |= NFS_OPTION_MIGRATION;
-		break;
-	case Opt_nomigration:
-		ctx->options &= ~NFS_OPTION_MIGRATION;
+		if (result.negated)
+			ctx->options &= ~NFS_OPTION_MIGRATION;
+		else
+			ctx->options |= NFS_OPTION_MIGRATION;
 		break;
 
 		/*
 		 * options that take numeric values
 		 */
 	case Opt_port:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->nfs_server.port,
-					    0, USHRT_MAX))
-			goto out_invalid_value;
+		if (result.uint_32 > USHRT_MAX)
+			goto out_of_bounds;
+		ctx->nfs_server.port = result.uint_32;
 		break;
 	case Opt_rsize:
-		if (nfs_get_option_ui(ctx, args, &ctx->rsize))
-			goto out_invalid_value;
+		ctx->rsize = result.uint_32;
 		break;
 	case Opt_wsize:
-		if (nfs_get_option_ui(ctx, args, &ctx->wsize))
-			goto out_invalid_value;
+		ctx->wsize = result.uint_32;
 		break;
 	case Opt_bsize:
-		if (nfs_get_option_ui(ctx, args, &ctx->bsize))
-			goto out_invalid_value;
+		ctx->bsize = result.uint_32;
 		break;
 	case Opt_timeo:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->timeo, 1, INT_MAX))
-			goto out_invalid_value;
+		if (result.uint_32 < 1 || result.uint_32 > INT_MAX)
+			goto out_of_bounds;
+		ctx->timeo = result.uint_32;
 		break;
 	case Opt_retrans:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->retrans, 0, INT_MAX))
-			goto out_invalid_value;
+		if (result.uint_32 > INT_MAX)
+			goto out_of_bounds;
+		ctx->retrans = result.uint_32;
 		break;
 	case Opt_acregmin:
-		if (nfs_get_option_ui(ctx, args, &ctx->acregmin))
-			goto out_invalid_value;
+		ctx->acregmin = result.uint_32;
 		break;
 	case Opt_acregmax:
-		if (nfs_get_option_ui(ctx, args, &ctx->acregmax))
-			goto out_invalid_value;
+		ctx->acregmax = result.uint_32;
 		break;
 	case Opt_acdirmin:
-		if (nfs_get_option_ui(ctx, args, &ctx->acdirmin))
-			goto out_invalid_value;
+		ctx->acdirmin = result.uint_32;
 		break;
 	case Opt_acdirmax:
-		if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
-			goto out_invalid_value;
+		ctx->acdirmax = result.uint_32;
 		break;
 	case Opt_actimeo:
-		if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
-			goto out_invalid_value;
-		ctx->acregmin = ctx->acregmax =
-			ctx->acdirmin = ctx->acdirmax;
+		ctx->acregmin = result.uint_32;
+		ctx->acregmax = result.uint_32;
+		ctx->acdirmin = result.uint_32;
+		ctx->acdirmax = result.uint_32;
 		break;
 	case Opt_namelen:
-		if (nfs_get_option_ui(ctx, args, &ctx->namlen))
-			goto out_invalid_value;
+		ctx->namlen = result.uint_32;
 		break;
 	case Opt_mountport:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.port,
-					    0, USHRT_MAX))
-			goto out_invalid_value;
+		if (result.uint_32 > USHRT_MAX)
+			goto out_of_bounds;
+		ctx->mount_server.port = result.uint_32;
 		break;
 	case Opt_mountvers:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.version,
-					    NFS_MNT_VERSION, NFS_MNT3_VERSION))
-			goto out_invalid_value;
+		if (result.uint_32 < NFS_MNT_VERSION ||
+		    result.uint_32 > NFS_MNT3_VERSION)
+			goto out_of_bounds;
+		ctx->mount_server.version = result.uint_32;
 		break;
 	case Opt_minorversion:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->minorversion,
-					    0, NFS4_MAX_MINOR_VERSION))
-			goto out_invalid_value;
+		if (result.uint_32 > NFS4_MAX_MINOR_VERSION)
+			goto out_of_bounds;
+		ctx->minorversion = result.uint_32;
 		break;
 
 		/*
 		 * options that take text values
 		 */
-	case Opt_nfsvers:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		ret = nfs_parse_version_string(ctx, string, args);
-		kfree(string);
+	case Opt_v:
+		ret = nfs_parse_version_string(fc, param->key + 1);
+		if (ret < 0)
+			return ret;
+		break;
+	case Opt_vers:
+		ret = nfs_parse_version_string(fc, param->string);
 		if (ret < 0)
 			return ret;
 		break;
 	case Opt_sec:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		ret = nfs_parse_security_flavors(ctx, string);
-		kfree(string);
+		ret = nfs_parse_security_flavors(fc, param);
 		if (ret < 0)
 			return ret;
 		break;
-	case Opt_proto:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		token = match_token(string, nfs_xprt_protocol_tokens, args);
 
-		ctx->protofamily = AF_INET;
-		switch (token) {
+	case Opt_proto:
+		protofamily = AF_INET;
+		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
 		case Opt_xprt_udp6:
-			ctx->protofamily = AF_INET6;
+			protofamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_udp:
 			ctx->flags &= ~NFS_MOUNT_TCP;
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 			break;
 		case Opt_xprt_tcp6:
-			ctx->protofamily = AF_INET6;
+			protofamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_tcp:
 			ctx->flags |= NFS_MOUNT_TCP;
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 			break;
 		case Opt_xprt_rdma6:
-			ctx->protofamily = AF_INET6;
+			protofamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_rdma:
 			/* vector side protocols to TCP */
 			ctx->flags |= NFS_MOUNT_TCP;
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
-			xprt_load_transport(string);
+			xprt_load_transport(param->string);
 			break;
 		default:
-			kfree(string);
-			dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
-			return -EINVAL;
+			return nfs_invalf(fc, "NFS: Unrecognized transport protocol");
 		}
-		kfree(string);
+
+		ctx->protofamily = protofamily;
 		break;
-	case Opt_mountproto:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		token = match_token(string, nfs_xprt_protocol_tokens, args);
-		kfree(string);
 
-		ctx->mountfamily = AF_INET;
-		switch (token) {
+	case Opt_mountproto:
+		mountfamily = AF_INET;
+		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
 		case Opt_xprt_udp6:
-			ctx->mountfamily = AF_INET6;
+			mountfamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_udp:
 			ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
 			break;
 		case Opt_xprt_tcp6:
-			ctx->mountfamily = AF_INET6;
+			mountfamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_tcp:
 			ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
 			break;
 		case Opt_xprt_rdma: /* not used for side protocols */
 		default:
-			dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
-			return -EINVAL;
+			return nfs_invalf(fc, "NFS: Unrecognized transport protocol");
 		}
+		ctx->mountfamily = mountfamily;
 		break;
+
 	case Opt_addr:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		ctx->nfs_server.addrlen =
-			rpc_pton(ctx->net, string, strlen(string),
-				 &ctx->nfs_server.address,
-				 sizeof(ctx->nfs_server._address));
-		kfree(string);
-		if (ctx->nfs_server.addrlen == 0)
+		len = rpc_pton(fc->net_ns, param->string, param->size,
+			       &ctx->nfs_server.address,
+			       sizeof(ctx->nfs_server._address));
+		if (len == 0)
 			goto out_invalid_address;
+		ctx->nfs_server.addrlen = len;
 		break;
 	case Opt_clientaddr:
-		if (nfs_get_option_str(args, &ctx->client_address))
-			goto out_nomem;
+		kfree(ctx->client_address);
+		ctx->client_address = param->string;
+		param->string = NULL;
 		break;
 	case Opt_mounthost:
-		if (nfs_get_option_str(args, &ctx->mount_server.hostname))
-			goto out_nomem;
+		kfree(ctx->mount_server.hostname);
+		ctx->mount_server.hostname = param->string;
+		param->string = NULL;
 		break;
 	case Opt_mountaddr:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		ctx->mount_server.addrlen =
-			rpc_pton(ctx->net, string, strlen(string),
-				 &ctx->mount_server.address,
-				 sizeof(ctx->mount_server._address));
-		kfree(string);
-		if (ctx->mount_server.addrlen == 0)
+		len = rpc_pton(fc->net_ns, param->string, param->size,
+			       &ctx->mount_server.address,
+			       sizeof(ctx->mount_server._address));
+		if (len == 0)
 			goto out_invalid_address;
+		ctx->mount_server.addrlen = len;
 		break;
 	case Opt_lookupcache:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		token = match_token(string, nfs_lookupcache_tokens, args);
-		kfree(string);
-		switch (token) {
+		switch (result.uint_32) {
 		case Opt_lookupcache_all:
 			ctx->flags &= ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
 			break;
@@ -806,22 +723,11 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
 			break;
 		default:
-			dfprintk(MOUNT, "NFS:   invalid lookupcache argument\n");
-			return -EINVAL;
+			goto out_invalid_value;
 		}
 		break;
-	case Opt_fscache_uniq:
-		if (nfs_get_option_str(args, &ctx->fscache_uniq))
-			goto out_nomem;
-		ctx->options |= NFS_OPTION_FSCACHE;
-		break;
 	case Opt_local_lock:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		token = match_token(string, nfs_local_lock_tokens, args);
-		kfree(string);
-		switch (token) {
+		switch (result.uint_32) {
 		case Opt_local_lock_all:
 			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
 				       NFS_MOUNT_LOCAL_FCNTL);
@@ -837,121 +743,32 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 					NFS_MOUNT_LOCAL_FCNTL);
 			break;
 		default:
-			dfprintk(MOUNT, "NFS:	invalid	local_lock argument\n");
-			return -EINVAL;
-		};
+			goto out_invalid_value;
+		}
 		break;
 
 		/*
 		 * Special options
 		 */
 	case Opt_sloppy:
-		ctx->sloppy = 1;
+		ctx->sloppy = true;
 		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
 		break;
-	case Opt_userspace:
-	case Opt_deprecated:
-		dfprintk(MOUNT, "NFS:   ignoring mount option '%s'\n", p);
-		break;
-
-	default:
-		dfprintk(MOUNT, "NFS:   unrecognized mount option '%s'\n", p);
-		return -EINVAL;
 	}
 
 	return 0;
 
-out_invalid_address:
-	printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
-	return -EINVAL;
 out_invalid_value:
-	printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
-	return -EINVAL;
-out_nomem:
-	printk(KERN_INFO "NFS: not enough memory to parse option\n");
-	return -ENOMEM;
-}
-
-/*
- * Error-check and convert a string of mount options from user space into
- * a data structure.  The whole mount string is processed; bad options are
- * skipped as they are encountered.  If there were no errors, return 1;
- * otherwise return 0 (zero).
- */
-int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
-{
-	char *p;
-	int rc, sloppy = 0, invalid_option = 0;
-
-	if (!raw) {
-		dfprintk(MOUNT, "NFS: mount options string was NULL.\n");
-		return 1;
-	}
-	dfprintk(MOUNT, "NFS: nfs mount opts='%s'\n", raw);
-
-	rc = security_sb_eat_lsm_opts(raw, &ctx->lsm_opts);
-	if (rc)
-		goto out_security_failure;
-
-	while ((p = strsep(&raw, ",")) != NULL) {
-		if (!*p)
-			continue;
-		if (nfs_fs_context_parse_option(ctx, p) < 0)
-			invalid_option = true;
-	}
-
-	if (!sloppy && invalid_option)
-		return 0;
-
-	if (ctx->minorversion && ctx->version != 4)
-		goto out_minorversion_mismatch;
-
-	if (ctx->options & NFS_OPTION_MIGRATION &&
-	    (ctx->version != 4 || ctx->minorversion != 0))
-		goto out_migration_misuse;
-
-	/*
-	 * verify that any proto=/mountproto= options match the address
-	 * families in the addr=/mountaddr= options.
-	 */
-	if (ctx->protofamily != AF_UNSPEC &&
-	    ctx->protofamily != ctx->nfs_server.address.sa_family)
-		goto out_proto_mismatch;
-
-	if (ctx->mountfamily != AF_UNSPEC) {
-		if (ctx->mount_server.addrlen) {
-			if (ctx->mountfamily != ctx->mount_server.address.sa_family)
-				goto out_mountproto_mismatch;
-		} else {
-			if (ctx->mountfamily != ctx->nfs_server.address.sa_family)
-				goto out_mountproto_mismatch;
-		}
-	}
-
-	return 1;
-
-out_minorversion_mismatch:
-	printk(KERN_INFO "NFS: mount option vers=%u does not support "
-			 "minorversion=%u\n", ctx->version, ctx->minorversion);
-	return 0;
-out_mountproto_mismatch:
-	printk(KERN_INFO "NFS: mount server address does not match mountproto= "
-			 "option\n");
-	return 0;
-out_proto_mismatch:
-	printk(KERN_INFO "NFS: server address does not match proto= option\n");
-	return 0;
-out_migration_misuse:
-	printk(KERN_INFO
-		"NFS: 'migration' not supported for this NFS version\n");
-	return -EINVAL;
-out_security_failure:
-	printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
-	return 0;
+	return nfs_invalf(fc, "NFS: Bad mount option value specified");
+out_invalid_address:
+	return nfs_invalf(fc, "NFS: Bad IP address specified");
+out_of_bounds:
+	nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
+	return -ERANGE;
 }
 
 /*
- * Split "dev_name" into "hostname:export_path".
+ * Split fc->source into "hostname:export_path".
  *
  * The leftmost colon demarks the split between the server's hostname
  * and the export path.  If the hostname starts with a left square
@@ -959,12 +776,13 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
  *
  * Note: caller frees hostname and export path, even on error.
  */
-static int nfs_parse_devname(struct nfs_fs_context *ctx,
-			     const char *dev_name,
-			     size_t maxnamlen, size_t maxpathlen)
+static int nfs_parse_source(struct fs_context *fc,
+			    size_t maxnamlen, size_t maxpathlen)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	const char *dev_name = fc->source;
 	size_t len;
-	char *end;
+	const char *end;
 
 	if (unlikely(!dev_name || !*dev_name)) {
 		dfprintk(MOUNT, "NFS: device name not specified\n");
@@ -980,7 +798,7 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx,
 		len = end - dev_name;
 		end++;
 	} else {
-		char *comma;
+		const char *comma;
 
 		end = strchr(dev_name, ':');
 		if (end == NULL)
@@ -988,8 +806,8 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx,
 		len = end - dev_name;
 
 		/* kill possible hostname list: not supported */
-		comma = strchr(dev_name, ',');
-		if (comma != NULL && comma < end)
+		comma = memchr(dev_name, ',', len);
+		if (comma)
 			len = comma - dev_name;
 	}
 
@@ -1011,19 +829,15 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx,
 	return 0;
 
 out_bad_devname:
-	dfprintk(MOUNT, "NFS: device name not in host:path format\n");
-	return -EINVAL;
-
+	return nfs_invalf(fc, "NFS: device name not in host:path format");
 out_nomem:
-	dfprintk(MOUNT, "NFS: not enough memory to parse device name\n");
+	nfs_errorf(fc, "NFS: not enough memory to parse device name");
 	return -ENOMEM;
-
 out_hostname:
-	dfprintk(MOUNT, "NFS: server hostname too long\n");
+	nfs_errorf(fc, "NFS: server hostname too long");
 	return -ENAMETOOLONG;
-
 out_path:
-	dfprintk(MOUNT, "NFS: export pathname too long\n");
+	nfs_errorf(fc, "NFS: export pathname too long");
 	return -ENAMETOOLONG;
 }
 
@@ -1043,12 +857,11 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx,
  * + breaking back: trying proto=udp after proto=tcp, v2 after v3,
  *   mountproto=tcp after mountproto=udp, and so on
  */
-static int nfs23_validate_mount_data(void *options,
-				     struct nfs_fs_context *ctx,
-				     struct nfs_fh *mntfh,
-				     const char *dev_name)
+static int nfs23_parse_monolithic(struct fs_context *fc,
+				  struct nfs_mount_data *data)
 {
-	struct nfs_mount_data *data = (struct nfs_mount_data *)options;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct nfs_fh *mntfh = ctx->mntfh;
 	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
 	int extra_flags = NFS_MOUNT_LEGACY_INTERFACE;
 
@@ -1120,6 +933,9 @@ static int nfs23_validate_mount_data(void *options,
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 		/* N.B. caller will free nfs_server.hostname in all cases */
 		ctx->nfs_server.hostname = kstrdup(data->hostname, GFP_KERNEL);
+		if (!ctx->nfs_server.hostname)
+			goto out_nomem;
+
 		ctx->namlen		= data->namlen;
 		ctx->bsize		= data->bsize;
 
@@ -1127,8 +943,6 @@ static int nfs23_validate_mount_data(void *options,
 			ctx->selected_flavor = data->pseudoflavor;
 		else
 			ctx->selected_flavor = RPC_AUTH_UNIX;
-		if (!ctx->nfs_server.hostname)
-			goto out_nomem;
 
 		if (!(data->flags & NFS_MOUNT_NONLM))
 			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK|
@@ -1136,6 +950,7 @@ static int nfs23_validate_mount_data(void *options,
 		else
 			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK|
 					NFS_MOUNT_LOCAL_FCNTL);
+
 		/*
 		 * The legacy version 6 binary mount data from userspace has a
 		 * field used only to transport selinux information into the
@@ -1146,12 +961,13 @@ static int nfs23_validate_mount_data(void *options,
 		 */
 		if (data->context[0]){
 #ifdef CONFIG_SECURITY_SELINUX
-			int rc;
+			int ret;
+
 			data->context[NFS_MAX_CONTEXT_LEN] = '\0';
-			rc = security_add_mnt_opt("context", data->context,
-					strlen(data->context), ctx->lsm_opts);
-			if (rc)
-				return rc;
+			ret = vfs_parse_fs_string(fc, "context",
+						  data->context, strlen(data->context));
+			if (ret < 0)
+				return ret;
 #else
 			return -EINVAL;
 #endif
@@ -1159,53 +975,47 @@ static int nfs23_validate_mount_data(void *options,
 
 		break;
 	default:
-		return NFS_TEXT_DATA;
+		goto generic;
 	}
 
+	ctx->skip_reconfig_option_check = true;
 	return 0;
 
+generic:
+	return generic_parse_monolithic(fc, data);
+
 out_no_data:
-	dfprintk(MOUNT, "NFS: mount program didn't pass any mount data\n");
-	return -EINVAL;
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		ctx->skip_reconfig_option_check = true;
+		return 0;
+	}
+	return nfs_invalf(fc, "NFS: mount program didn't pass any mount data");
 
 out_no_v3:
-	dfprintk(MOUNT, "NFS: nfs_mount_data version %d does not support v3\n",
-		 data->version);
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: nfs_mount_data version does not support v3");
 
 out_no_sec:
-	dfprintk(MOUNT, "NFS: nfs_mount_data version supports only AUTH_SYS\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: nfs_mount_data version supports only AUTH_SYS");
 
 out_nomem:
-	dfprintk(MOUNT, "NFS: not enough memory to handle mount options\n");
+	dfprintk(MOUNT, "NFS: not enough memory to handle mount options");
 	return -ENOMEM;
 
 out_no_address:
-	dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
 
 out_invalid_fh:
-	dfprintk(MOUNT, "NFS: invalid root filehandle\n");
-	return -EINVAL;
-}
-
-#if IS_ENABLED(CONFIG_NFS_V4)
-static void nfs4_validate_mount_flags(struct nfs_fs_context *ctx)
-{
-	ctx->flags &= ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
-			 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
+	return nfs_invalf(fc, "NFS: invalid root filehandle");
 }
 
 /*
  * Validate NFSv4 mount options
  */
-static int nfs4_validate_mount_data(void *options,
-				    struct nfs_fs_context *ctx,
-				    const char *dev_name)
+static int nfs4_parse_monolithic(struct fs_context *fc,
+				 struct nfs4_mount_data *data)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
-	struct nfs4_mount_data *data = (struct nfs4_mount_data *)options;
 	char *c;
 
 	if (data == NULL)
@@ -1255,7 +1065,7 @@ static int nfs4_validate_mount_data(void *options,
 		ctx->client_address = c;
 
 		/*
-		 * Translate to nfs_fs_context, which nfs4_fill_super
+		 * Translate to nfs_fs_context, which nfs_fill_super
 		 * can deal with.
 		 */
 
@@ -1275,101 +1085,325 @@ static int nfs4_validate_mount_data(void *options,
 
 		break;
 	default:
-		return NFS_TEXT_DATA;
+		goto generic;
 	}
 
+	ctx->skip_reconfig_option_check = true;
 	return 0;
 
+generic:
+	return generic_parse_monolithic(fc, data);
+
 out_no_data:
-	dfprintk(MOUNT, "NFS4: mount program didn't pass any mount data\n");
-	return -EINVAL;
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		ctx->skip_reconfig_option_check = true;
+		return 0;
+	}
+	return nfs_invalf(fc, "NFS4: mount program didn't pass any mount data");
 
 out_inval_auth:
-	dfprintk(MOUNT, "NFS4: Invalid number of RPC auth flavours %d\n",
-		 data->auth_flavourlen);
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS4: Invalid number of RPC auth flavours %d",
+		      data->auth_flavourlen);
 
 out_no_address:
-	dfprintk(MOUNT, "NFS4: mount program didn't pass remote address\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS4: mount program didn't pass remote address");
 
 out_invalid_transport_udp:
-	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFSv4: Unsupported transport protocol udp");
 }
 
-int nfs_validate_mount_data(struct file_system_type *fs_type,
-			    void *options,
-			    struct nfs_fs_context *ctx,
-			    struct nfs_fh *mntfh,
-			    const char *dev_name)
-{
-	if (fs_type == &nfs_fs_type)
-		return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
-	return nfs4_validate_mount_data(options, ctx, dev_name);
-}
-#else
-int nfs_validate_mount_data(struct file_system_type *fs_type,
-			    void *options,
-			    struct nfs_fs_context *ctx,
-			    struct nfs_fh *mntfh,
-			    const char *dev_name)
+/*
+ * Parse a monolithic block of data from sys_mount().
+ */
+static int nfs_fs_context_parse_monolithic(struct fs_context *fc,
+					   void *data)
 {
-	return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
-}
+	if (fc->fs_type == &nfs_fs_type)
+		return nfs23_parse_monolithic(fc, data);
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+	if (fc->fs_type == &nfs4_fs_type)
+		return nfs4_parse_monolithic(fc, data);
 #endif
 
-int nfs_validate_text_mount_data(void *options,
-				 struct nfs_fs_context *ctx,
-				 const char *dev_name)
+	return nfs_invalf(fc, "NFS: Unsupported monolithic data version");
+}
+
+/*
+ * Validate the preparsed information in the config.
+ */
+static int nfs_fs_context_validate(struct fs_context *fc)
 {
-	int port = 0;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct nfs_subversion *nfs_mod;
+	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
 	int max_namelen = PAGE_SIZE;
 	int max_pathlen = NFS_MAXPATHLEN;
-	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
+	int port = 0;
+	int ret;
 
-	if (nfs_parse_mount_options((char *)options, ctx) == 0)
-		return -EINVAL;
+	if (!fc->source)
+		goto out_no_device_name;
+
+	/* Check for sanity first. */
+	if (ctx->minorversion && ctx->version != 4)
+		goto out_minorversion_mismatch;
+
+	if (ctx->options & NFS_OPTION_MIGRATION &&
+	    (ctx->version != 4 || ctx->minorversion != 0))
+		goto out_migration_misuse;
+
+	/* Verify that any proto=/mountproto= options match the address
+	 * families in the addr=/mountaddr= options.
+	 */
+	if (ctx->protofamily != AF_UNSPEC &&
+	    ctx->protofamily != ctx->nfs_server.address.sa_family)
+		goto out_proto_mismatch;
+
+	if (ctx->mountfamily != AF_UNSPEC) {
+		if (ctx->mount_server.addrlen) {
+			if (ctx->mountfamily != ctx->mount_server.address.sa_family)
+				goto out_mountproto_mismatch;
+		} else {
+			if (ctx->mountfamily != ctx->nfs_server.address.sa_family)
+				goto out_mountproto_mismatch;
+		}
+	}
 
 	if (!nfs_verify_server_address(sap))
 		goto out_no_address;
 
 	if (ctx->version == 4) {
-#if IS_ENABLED(CONFIG_NFS_V4)
-		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
-			port = NFS_RDMA_PORT;
-		else
-			port = NFS_PORT;
-		max_namelen = NFS4_MAXNAMLEN;
-		max_pathlen = NFS4_MAXPATHLEN;
-		nfs_validate_transport_protocol(ctx);
-		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
-			goto out_invalid_transport_udp;
-		nfs4_validate_mount_flags(ctx);
-#else
-		goto out_v4_not_compiled;
-#endif /* CONFIG_NFS_V4 */
+		if (IS_ENABLED(CONFIG_NFS_V4)) {
+			if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
+				port = NFS_RDMA_PORT;
+			else
+				port = NFS_PORT;
+			max_namelen = NFS4_MAXNAMLEN;
+			max_pathlen = NFS4_MAXPATHLEN;
+			nfs_validate_transport_protocol(ctx);
+			if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
+				goto out_invalid_transport_udp;
+			ctx->flags &= ~(NFS_MOUNT_NONLM | NFS_MOUNT_NOACL |
+					NFS_MOUNT_VER3 | NFS_MOUNT_LOCAL_FLOCK |
+					NFS_MOUNT_LOCAL_FCNTL);
+		} else {
+			goto out_v4_not_compiled;
+		}
 	} else {
 		nfs_set_mount_transport_protocol(ctx);
 		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
 			port = NFS_RDMA_PORT;
 	}
- 
+
 	nfs_set_port(sap, &ctx->nfs_server.port, port);
 
-	return nfs_parse_devname(ctx, dev_name, max_namelen, max_pathlen);
+	ret = nfs_parse_source(fc, max_namelen, max_pathlen);
+	if (ret < 0)
+		return ret;
 
-#if !IS_ENABLED(CONFIG_NFS_V4)
+	/* Load the NFS protocol module if we haven't done so yet */
+	if (!ctx->nfs_mod) {
+		nfs_mod = get_nfs_version(ctx->version);
+		if (IS_ERR(nfs_mod)) {
+			ret = PTR_ERR(nfs_mod);
+			goto out_version_unavailable;
+		}
+		ctx->nfs_mod = nfs_mod;
+	}
+	return 0;
+
+out_no_device_name:
+	return nfs_invalf(fc, "NFS: Device name not specified");
 out_v4_not_compiled:
-	dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
+	nfs_errorf(fc, "NFS: NFSv4 is not compiled into kernel");
 	return -EPROTONOSUPPORT;
-#else
 out_invalid_transport_udp:
-	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
-	return -EINVAL;
-#endif /* !CONFIG_NFS_V4 */
-
+	return nfs_invalf(fc, "NFSv4: Unsupported transport protocol udp");
 out_no_address:
-	dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-	return -EINVAL;
+	return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
+out_mountproto_mismatch:
+	return nfs_invalf(fc, "NFS: Mount server address does not match mountproto= option");
+out_proto_mismatch:
+	return nfs_invalf(fc, "NFS: Server address does not match proto= option");
+out_minorversion_mismatch:
+	return nfs_invalf(fc, "NFS: Mount option vers=%u does not support minorversion=%u",
+			  ctx->version, ctx->minorversion);
+out_migration_misuse:
+	return nfs_invalf(fc, "NFS: 'Migration' not supported for this NFS version");
+out_version_unavailable:
+	nfs_errorf(fc, "NFS: Version unavailable");
+	return ret;
+}
+
+/*
+ * Create an NFS superblock by the appropriate method.
+ */
+static int nfs_get_tree(struct fs_context *fc)
+{
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	int err = nfs_fs_context_validate(fc);
+
+	if (err)
+		return err;
+	if (!ctx->internal)
+		return ctx->nfs_mod->rpc_ops->try_get_tree(fc);
+	else
+		return nfs_get_tree_common(fc);
+}
+
+/*
+ * Handle duplication of a configuration.  The caller copied *src into *sc, but
+ * it can't deal with resource pointers in the filesystem context, so we have
+ * to do that.  We need to clear pointers, copy data or get extra refs as
+ * appropriate.
+ */
+static int nfs_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	struct nfs_fs_context *src = nfs_fc2context(src_fc), *ctx;
+
+	ctx = kmemdup(src, sizeof(struct nfs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->mntfh = nfs_alloc_fhandle();
+	if (!ctx->mntfh) {
+		kfree(ctx);
+		return -ENOMEM;
+	}
+	nfs_copy_fh(ctx->mntfh, src->mntfh);
+
+	__module_get(ctx->nfs_mod->owner);
+	ctx->client_address		= NULL;
+	ctx->mount_server.hostname	= NULL;
+	ctx->nfs_server.export_path	= NULL;
+	ctx->nfs_server.hostname	= NULL;
+	ctx->fscache_uniq		= NULL;
+	fc->fs_private = ctx;
+	return 0;
 }
+
+static void nfs_fs_context_free(struct fs_context *fc)
+{
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+
+	if (ctx) {
+		if (ctx->server)
+			nfs_free_server(ctx->server);
+		if (ctx->nfs_mod)
+			put_nfs_version(ctx->nfs_mod);
+		kfree(ctx->client_address);
+		kfree(ctx->mount_server.hostname);
+		kfree(ctx->nfs_server.export_path);
+		kfree(ctx->nfs_server.hostname);
+		kfree(ctx->fscache_uniq);
+		nfs_free_fhandle(ctx->mntfh);
+		kfree(ctx);
+	}
+}
+
+static const struct fs_context_operations nfs_fs_context_ops = {
+	.free			= nfs_fs_context_free,
+	.dup			= nfs_fs_context_dup,
+	.parse_param		= nfs_fs_context_parse_param,
+	.parse_monolithic	= nfs_fs_context_parse_monolithic,
+	.get_tree		= nfs_get_tree,
+	.reconfigure		= nfs_reconfigure,
+};
+
+/*
+ * Prepare superblock configuration.  We use the namespaces attached to the
+ * context.  This may be the current process's namespaces, or it may be a
+ * container's namespaces.
+ */
+static int nfs_init_fs_context(struct fs_context *fc)
+{
+	struct nfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct nfs_fs_context), GFP_KERNEL);
+	if (unlikely(!ctx))
+		return -ENOMEM;
+
+	ctx->mntfh = nfs_alloc_fhandle();
+	if (unlikely(!ctx->mntfh)) {
+		kfree(ctx);
+		return -ENOMEM;
+	}
+
+	ctx->protofamily	= AF_UNSPEC;
+	ctx->mountfamily	= AF_UNSPEC;
+	ctx->mount_server.port	= NFS_UNSPEC_PORT;
+
+	if (fc->root) {
+		/* reconfigure, start with the current config */
+		struct nfs_server *nfss = fc->root->d_sb->s_fs_info;
+		struct net *net = nfss->nfs_client->cl_net;
+
+		ctx->flags		= nfss->flags;
+		ctx->rsize		= nfss->rsize;
+		ctx->wsize		= nfss->wsize;
+		ctx->retrans		= nfss->client->cl_timeout->to_retries;
+		ctx->selected_flavor	= nfss->client->cl_auth->au_flavor;
+		ctx->acregmin		= nfss->acregmin / HZ;
+		ctx->acregmax		= nfss->acregmax / HZ;
+		ctx->acdirmin		= nfss->acdirmin / HZ;
+		ctx->acdirmax		= nfss->acdirmax / HZ;
+		ctx->timeo		= 10U * nfss->client->cl_timeout->to_initval / HZ;
+		ctx->nfs_server.port	= nfss->port;
+		ctx->nfs_server.addrlen	= nfss->nfs_client->cl_addrlen;
+		ctx->version		= nfss->nfs_client->rpc_ops->version;
+		ctx->minorversion	= nfss->nfs_client->cl_minorversion;
+
+		memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
+			ctx->nfs_server.addrlen);
+
+		if (fc->net_ns != net) {
+			put_net(fc->net_ns);
+			fc->net_ns = get_net(net);
+		}
+
+		ctx->nfs_mod = nfss->nfs_client->cl_nfs_mod;
+		__module_get(ctx->nfs_mod->owner);
+	} else {
+		/* defaults */
+		ctx->timeo		= NFS_UNSPEC_TIMEO;
+		ctx->retrans		= NFS_UNSPEC_RETRANS;
+		ctx->acregmin		= NFS_DEF_ACREGMIN;
+		ctx->acregmax		= NFS_DEF_ACREGMAX;
+		ctx->acdirmin		= NFS_DEF_ACDIRMIN;
+		ctx->acdirmax		= NFS_DEF_ACDIRMAX;
+		ctx->nfs_server.port	= NFS_UNSPEC_PORT;
+		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
+		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
+		ctx->minorversion	= 0;
+		ctx->need_mount		= true;
+	}
+	fc->fs_private = ctx;
+	fc->ops = &nfs_fs_context_ops;
+	return 0;
+}
+
+struct file_system_type nfs_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "nfs",
+	.init_fs_context	= nfs_init_fs_context,
+	.parameters		= &nfs_fs_parameters,
+	.kill_sb		= nfs_kill_super,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+};
+MODULE_ALIAS_FS("nfs");
+EXPORT_SYMBOL_GPL(nfs_fs_type);
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+struct file_system_type nfs4_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "nfs4",
+	.init_fs_context	= nfs_init_fs_context,
+	.parameters		= &nfs_fs_parameters,
+	.kill_sb		= nfs_kill_super,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+};
+MODULE_ALIAS_FS("nfs4");
+MODULE_ALIAS("nfs4");
+EXPORT_SYMBOL_GPL(nfs4_fs_type);
+#endif /* CONFIG_NFS_V4 */
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 4dc887813c71..8806cacff6ec 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -128,7 +128,7 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 		return;
 
 	key->nfs_client = nfss->nfs_client;
-	key->key.super.s_flags = sb->s_flags & NFS_MS_MASK;
+	key->key.super.s_flags = sb->s_flags & NFS_SB_MASK;
 	key->key.nfs_server.flags = nfss->flags;
 	key->key.nfs_server.rsize = nfss->rsize;
 	key->key.nfs_server.wsize = nfss->wsize;
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 391dafaf9182..d973fe0669e9 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -68,66 +68,71 @@ static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *i
 /*
  * get an NFS2/NFS3 root dentry from the root filehandle
  */
-struct dentry *nfs_get_root(struct super_block *sb, struct nfs_fh *mntfh,
-			    const char *devname)
+int nfs_get_root(struct super_block *s, struct fs_context *fc)
 {
-	struct nfs_server *server = NFS_SB(sb);
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct nfs_server *server = NFS_SB(s);
 	struct nfs_fsinfo fsinfo;
-	struct dentry *ret;
+	struct dentry *root;
 	struct inode *inode;
-	void *name = kstrdup(devname, GFP_KERNEL);
-	int error;
+	char *name;
+	int error = -ENOMEM;
 
+	name = kstrdup(fc->source, GFP_KERNEL);
 	if (!name)
-		return ERR_PTR(-ENOMEM);
+		goto out;
 
 	/* get the actual root for this mount */
 	fsinfo.fattr = nfs_alloc_fattr();
-	if (fsinfo.fattr == NULL) {
-		kfree(name);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (fsinfo.fattr == NULL)
+		goto out_name;
 
-	error = server->nfs_client->rpc_ops->getroot(server, mntfh, &fsinfo);
+	error = server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsinfo);
 	if (error < 0) {
 		dprintk("nfs_get_root: getattr error = %d\n", -error);
-		ret = ERR_PTR(error);
-		goto out;
+		nfs_errorf(fc, "NFS: Couldn't getattr on root");
+		goto out_fattr;
 	}
 
-	inode = nfs_fhget(sb, mntfh, fsinfo.fattr, NULL);
+	inode = nfs_fhget(s, ctx->mntfh, fsinfo.fattr, NULL);
 	if (IS_ERR(inode)) {
 		dprintk("nfs_get_root: get root inode failed\n");
-		ret = ERR_CAST(inode);
-		goto out;
+		error = PTR_ERR(inode);
+		nfs_errorf(fc, "NFS: Couldn't get root inode");
+		goto out_fattr;
 	}
 
-	error = nfs_superblock_set_dummy_root(sb, inode);
-	if (error != 0) {
-		ret = ERR_PTR(error);
-		goto out;
-	}
+	error = nfs_superblock_set_dummy_root(s, inode);
+	if (error != 0)
+		goto out_fattr;
 
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
 	 * exists, we'll pick it up at this point and use it as the root
 	 */
-	ret = d_obtain_root(inode);
-	if (IS_ERR(ret)) {
+	root = d_obtain_root(inode);
+	if (IS_ERR(root)) {
 		dprintk("nfs_get_root: get root dentry failed\n");
-		goto out;
+		error = PTR_ERR(root);
+		nfs_errorf(fc, "NFS: Couldn't get root dentry");
+		goto out_fattr;
 	}
 
-	security_d_instantiate(ret, inode);
-	spin_lock(&ret->d_lock);
-	if (IS_ROOT(ret) && !ret->d_fsdata &&
-	    !(ret->d_flags & DCACHE_NFSFS_RENAMED)) {
-		ret->d_fsdata = name;
+	security_d_instantiate(root, inode);
+	spin_lock(&root->d_lock);
+	if (IS_ROOT(root) && !root->d_fsdata &&
+	    !(root->d_flags & DCACHE_NFSFS_RENAMED)) {
+		root->d_fsdata = name;
 		name = NULL;
 	}
-	spin_unlock(&ret->d_lock);
-out:
-	kfree(name);
+	spin_unlock(&root->d_lock);
+	fc->root = root;
+	error = 0;
+
+out_fattr:
 	nfs_free_fattr(fsinfo.fattr);
-	return ret;
+out_name:
+	kfree(name);
+out:
+	return error;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 481f370ab053..da088f5611f0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -4,18 +4,19 @@
  */
 
 #include "nfs4_fs.h"
-#include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/security.h>
 #include <linux/crc32.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
 #include <linux/wait_bit.h>
 
-#define NFS_MS_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
+#define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
 
 extern const struct export_operations nfs_export_ops;
 
 struct nfs_string;
+struct nfs_pageio_descriptor;
 
 /* Maximum number of readahead requests
  * FIXME: this should really be a sysctl so that users may tune it to suit
@@ -40,16 +41,6 @@ static inline int nfs_attr_use_mounted_on_fileid(struct nfs_fattr *fattr)
 	return 1;
 }
 
-struct nfs_clone_mount {
-	const struct super_block *sb;
-	const struct dentry *dentry;
-	char *hostname;
-	char *mnt_path;
-	struct sockaddr *addr;
-	size_t addrlen;
-	rpc_authflavor_t authflavor;
-};
-
 /*
  * Note: RFC 1813 doesn't limit the number of auth flavors that
  * a server can return, so make something up.
@@ -90,6 +81,10 @@ struct nfs_client_initdata {
  * In-kernel mount arguments
  */
 struct nfs_fs_context {
+	bool			internal;
+	bool			skip_reconfig_option_check;
+	bool			need_mount;
+	bool			sloppy;
 	unsigned int		flags;		/* NFS{,4}_MOUNT_* flags */
 	unsigned int		rsize, wsize;
 	unsigned int		timeo, retrans;
@@ -106,8 +101,6 @@ struct nfs_fs_context {
 	char			*fscache_uniq;
 	unsigned short		protofamily;
 	unsigned short		mountfamily;
-	bool			need_mount;
-	bool			sloppy;
 
 	struct {
 		union {
@@ -131,14 +124,31 @@ struct nfs_fs_context {
 		char			*export_path;
 		int			port;
 		unsigned short		protocol;
+		unsigned short		export_path_len;
 	} nfs_server;
 
-	void			*lsm_opts;
-	struct net		*net;
-
-	char			buf[32];	/* Parse buffer */
+	struct nfs_fh		*mntfh;
+	struct nfs_server	*server;
+	struct nfs_subversion	*nfs_mod;
+
+	/* Information for a cloned mount. */
+	struct nfs_clone_mount {
+		struct super_block	*sb;
+		struct dentry		*dentry;
+		struct nfs_fattr	*fattr;
+		unsigned int		inherited_bsize;
+	} clone_data;
 };
 
+#define nfs_errorf(fc, fmt, ...) errorf(fc, fmt, ## __VA_ARGS__)
+#define nfs_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
+#define nfs_warnf(fc, fmt, ...) warnf(fc, fmt, ## __VA_ARGS__)
+
+static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
+{
+	return fc->fs_private;
+}
+
 /* mount_clnt.c */
 struct nfs_mount_request {
 	struct sockaddr		*sap;
@@ -154,15 +164,6 @@ struct nfs_mount_request {
 	struct net		*net;
 };
 
-struct nfs_mount_info {
-	unsigned int inherited_bsize;
-	struct nfs_fs_context *ctx;
-	struct nfs_clone_mount *cloned;
-	struct nfs_server *server;
-	struct nfs_fh *mntfh;
-	struct nfs_subversion *nfs_mod;
-};
-
 extern int nfs_mount(struct nfs_mount_request *info);
 extern void nfs_umount(const struct nfs_mount_request *info);
 
@@ -188,10 +189,9 @@ extern struct nfs_client *nfs4_find_client_ident(struct net *, int);
 extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
-extern struct nfs_server *nfs_create_server(struct nfs_mount_info *);
-extern struct nfs_server *nfs4_create_server(struct nfs_mount_info *);
-extern struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *,
-						      struct nfs_fh *);
+extern struct nfs_server *nfs_create_server(struct fs_context *);
+extern struct nfs_server *nfs4_create_server(struct fs_context *);
+extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
 					struct sockaddr *sap, size_t salen,
 					struct net *net);
@@ -242,22 +242,8 @@ static inline void nfs_fs_proc_exit(void)
 extern const struct svc_version nfs4_callback_version1;
 extern const struct svc_version nfs4_callback_version4;
 
-struct nfs_pageio_descriptor;
-
-/* mount.c */
-#define NFS_TEXT_DATA		1
-
-extern struct nfs_fs_context *nfs_alloc_parsed_mount_data(void);
-extern void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx);
-extern int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx);
-extern int nfs_validate_mount_data(struct file_system_type *fs_type,
-				   void *options,
-				   struct nfs_fs_context *ctx,
-				   struct nfs_fh *mntfh,
-				   const char *dev_name);
-extern int nfs_validate_text_mount_data(void *options,
-					struct nfs_fs_context *ctx,
-					const char *dev_name);
+/* fs_context.c */
+extern struct file_system_type nfs_fs_type;
 
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
@@ -418,14 +404,9 @@ extern int nfs_wait_atomic_killable(atomic_t *p, unsigned int mode);
 
 /* super.c */
 extern const struct super_operations nfs_sops;
-extern struct file_system_type nfs_fs_type;
-extern struct file_system_type nfs_prepared_fs_type;
-#if IS_ENABLED(CONFIG_NFS_V4)
-extern struct file_system_type nfs4_referral_fs_type;
-#endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
-struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
-struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
+int nfs_try_get_tree(struct fs_context *);
+int nfs_get_tree_common(struct fs_context *);
 void nfs_kill_super(struct super_block *);
 
 extern struct rpc_stat nfs_rpcstat;
@@ -453,18 +434,13 @@ static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
 extern char *nfs_path(char **p, struct dentry *dentry,
 		      char *buffer, ssize_t buflen, unsigned flags);
 extern struct vfsmount *nfs_d_automount(struct path *path);
-struct vfsmount *nfs_submount(struct nfs_server *, struct dentry *,
-			      struct nfs_fh *, struct nfs_fattr *);
-struct vfsmount *nfs_do_submount(struct dentry *, struct nfs_fh *,
-				 struct nfs_fattr *, rpc_authflavor_t);
+int nfs_submount(struct fs_context *, struct nfs_server *);
+int nfs_do_submount(struct fs_context *);
 
 /* getroot.c */
-extern struct dentry *nfs_get_root(struct super_block *, struct nfs_fh *,
-				   const char *);
+extern int nfs_get_root(struct super_block *s, struct fs_context *fc);
 #if IS_ENABLED(CONFIG_NFS_V4)
-extern struct dentry *nfs4_get_root(struct super_block *, struct nfs_fh *,
-				    const char *);
-
+extern int nfs4_get_root(struct super_block *s, struct fs_context *cfg);
 extern int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh *mntfh, bool);
 #endif
 
@@ -483,7 +459,7 @@ int  nfs_show_options(struct seq_file *, struct dentry *);
 int  nfs_show_devname(struct seq_file *, struct dentry *);
 int  nfs_show_path(struct seq_file *, struct dentry *);
 int  nfs_show_stats(struct seq_file *, struct dentry *);
-int nfs_remount(struct super_block *sb, int *flags, char *raw_data);
+int  nfs_reconfigure(struct fs_context *);
 
 /* write.c */
 extern void nfs_pageio_init_write(struct nfs_pageio_descriptor *pgio,
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 1c4cb8914b20..66aba39e3f27 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -139,31 +139,62 @@ EXPORT_SYMBOL_GPL(nfs_path);
  */
 struct vfsmount *nfs_d_automount(struct path *path)
 {
-	struct vfsmount *mnt;
+	struct nfs_fs_context *ctx;
+	struct fs_context *fc;
+	struct vfsmount *mnt = ERR_PTR(-ENOMEM);
 	struct nfs_server *server = NFS_SERVER(d_inode(path->dentry));
-	struct nfs_fh *fh = NULL;
-	struct nfs_fattr *fattr = NULL;
+	struct nfs_client *client = server->nfs_client;
+	int ret;
 
 	if (IS_ROOT(path->dentry))
 		return ERR_PTR(-ESTALE);
 
-	mnt = ERR_PTR(-ENOMEM);
-	fh = nfs_alloc_fhandle();
-	fattr = nfs_alloc_fattr();
-	if (fh == NULL || fattr == NULL)
-		goto out;
+	/* Open a new filesystem context, transferring parameters from the
+	 * parent superblock, including the network namespace.
+	 */
+	fc = fs_context_for_submount(&nfs_fs_type, path->dentry);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
 
-	mnt = server->nfs_client->rpc_ops->submount(server, path->dentry, fh, fattr);
+	ctx = nfs_fc2context(fc);
+	ctx->clone_data.dentry	= path->dentry;
+	ctx->clone_data.sb	= path->dentry->d_sb;
+	ctx->clone_data.fattr	= nfs_alloc_fattr();
+	if (!ctx->clone_data.fattr)
+		goto out_fc;
+
+	if (fc->net_ns != client->cl_net) {
+		put_net(fc->net_ns);
+		fc->net_ns = get_net(client->cl_net);
+	}
+
+	/* for submounts we want the same server; referrals will reassign */
+	memcpy(&ctx->nfs_server.address, &client->cl_addr, client->cl_addrlen);
+	ctx->nfs_server.addrlen	= client->cl_addrlen;
+	ctx->nfs_server.port	= server->port;
+
+	ctx->version		= client->rpc_ops->version;
+	ctx->minorversion	= client->cl_minorversion;
+	ctx->nfs_mod		= client->cl_nfs_mod;
+	__module_get(ctx->nfs_mod->owner);
+
+	ret = client->rpc_ops->submount(fc, server);
+	if (ret < 0) {
+		mnt = ERR_PTR(ret);
+		goto out_fc;
+	}
+
+	up_write(&fc->root->d_sb->s_umount);
+	mnt = vfs_create_mount(fc);
 	if (IS_ERR(mnt))
-		goto out;
+		goto out_fc;
 
 	mntget(mnt); /* prevent immediate expiration */
 	mnt_set_expiry(mnt, &nfs_automount_list);
 	schedule_delayed_work(&nfs_automount_task, nfs_mountpoint_expiry_timeout);
 
-out:
-	nfs_free_fattr(fattr);
-	nfs_free_fhandle(fh);
+out_fc:
+	put_fs_context(fc);
 	return mnt;
 }
 
@@ -218,61 +249,62 @@ void nfs_release_automount_timer(void)
  * @authflavor: security flavor to use when performing the mount
  *
  */
-struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
-				 struct nfs_fattr *fattr, rpc_authflavor_t authflavor)
+int nfs_do_submount(struct fs_context *fc)
 {
-	struct super_block *sb = dentry->d_sb;
-	struct nfs_clone_mount mountdata = {
-		.sb = sb,
-		.dentry = dentry,
-		.authflavor = authflavor,
-	};
-	struct nfs_mount_info mount_info = {
-		.inherited_bsize = sb->s_blocksize_bits,
-		.cloned = &mountdata,
-		.mntfh = fh,
-		.nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod,
-	};
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct dentry *dentry = ctx->clone_data.dentry;
 	struct nfs_server *server;
-	struct vfsmount *mnt;
-	char *page = (char *) __get_free_page(GFP_USER);
-	char *devname;
+	char *buffer, *p;
+	int ret;
 
-	if (page == NULL)
-		return ERR_PTR(-ENOMEM);
+	/* create a new volume representation */
+	server = ctx->nfs_mod->rpc_ops->clone_server(NFS_SB(ctx->clone_data.sb),
+						     ctx->mntfh,
+						     ctx->clone_data.fattr,
+						     ctx->selected_flavor);
 
-	server = mount_info.nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
-							   fattr, authflavor);
 	if (IS_ERR(server))
-		return ERR_CAST(server);
+		return PTR_ERR(server);
 
-	mount_info.server = server;
+	ctx->server = server;
 
-	devname = nfs_devname(dentry, page, PAGE_SIZE);
-	if (IS_ERR(devname))
-		mnt = ERR_CAST(devname);
-	else
-		mnt = vfs_submount(dentry, &nfs_prepared_fs_type, devname, &mount_info);
+	buffer = kmalloc(4096, GFP_USER);
+	if (!buffer)
+		return -ENOMEM;
 
-	if (mount_info.server)
-		nfs_free_server(mount_info.server);
-	free_page((unsigned long)page);
-	return mnt;
+	ctx->internal		= true;
+	ctx->clone_data.inherited_bsize = ctx->clone_data.sb->s_blocksize_bits;
+
+	p = nfs_devname(dentry, buffer, 4096);
+	if (IS_ERR(p)) {
+		nfs_errorf(fc, "NFS: Couldn't determine submount pathname");
+		ret = PTR_ERR(p);
+	} else {
+		ret = vfs_parse_fs_string(fc, "source", p, buffer + 4096 - p);
+		if (!ret)
+			ret = vfs_get_tree(fc);
+	}
+	kfree(buffer);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nfs_do_submount);
 
-struct vfsmount *nfs_submount(struct nfs_server *server, struct dentry *dentry,
-			      struct nfs_fh *fh, struct nfs_fattr *fattr)
+int nfs_submount(struct fs_context *fc, struct nfs_server *server)
 {
-	int err;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct dentry *dentry = ctx->clone_data.dentry;
 	struct dentry *parent = dget_parent(dentry);
+	int err;
 
 	/* Look it up again to get its attributes */
-	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), &dentry->d_name, fh, fattr, NULL);
+	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), &dentry->d_name,
+						  ctx->mntfh, ctx->clone_data.fattr,
+						  NULL);
 	dput(parent);
 	if (err != 0)
-		return ERR_PTR(err);
+		return err;
 
-	return nfs_do_submount(dentry, fh, fattr, server->client->cl_auth->au_flavor);
+	ctx->selected_flavor = server->client->cl_auth->au_flavor;
+	return nfs_do_submount(fc);
 }
 EXPORT_SYMBOL_GPL(nfs_submount);
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index 09602dc1889f..1b950b66b3bb 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -27,7 +27,7 @@ static inline int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 #endif /* CONFIG_NFS_V3_ACL */
 
 /* nfs3client.c */
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *);
+struct nfs_server *nfs3_create_server(struct fs_context *);
 struct nfs_server *nfs3_clone_server(struct nfs_server *, struct nfs_fh *,
 				     struct nfs_fattr *, rpc_authflavor_t);
 
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 362c3549a217..73f6ee93479c 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -45,9 +45,10 @@ static inline void nfs_init_server_aclclient(struct nfs_server *server)
 }
 #endif
 
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs3_create_server(struct fs_context *fc)
 {
-	struct nfs_server *server = nfs_create_server(mount_info);
+	struct nfs_server *server = nfs_create_server(fc);
+
 	/* Create a client RPC handle for the NFS v3 ACL management interface */
 	if (!IS_ERR(server))
 		nfs_init_server_aclclient(server);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index a3ad2d46fd42..912a0b0c9bb9 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -963,7 +963,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.nlmclnt_ops	= &nlmclnt_fl_close_lock_ops,
 	.getroot	= nfs3_proc_get_root,
 	.submount	= nfs_submount,
-	.try_mount	= nfs_try_mount,
+	.try_get_tree	= nfs_try_get_tree,
 	.getattr	= nfs3_proc_getattr,
 	.setattr	= nfs3_proc_setattr,
 	.lookup		= nfs3_proc_lookup,
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 0bd8a5fc140b..e624a85d818c 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -268,14 +268,13 @@ extern const struct dentry_operations nfs4_dentry_operations;
 int nfs_atomic_open(struct inode *, struct dentry *, struct file *,
 		    unsigned, umode_t);
 
-/* super.c */
+/* fs_context.c */
 extern struct file_system_type nfs4_fs_type;
 
 /* nfs4namespace.c */
 struct rpc_clnt *nfs4_negotiate_security(struct rpc_clnt *, struct inode *,
 					 const struct qstr *);
-struct vfsmount *nfs4_submount(struct nfs_server *, struct dentry *,
-			       struct nfs_fh *, struct nfs_fattr *);
+int nfs4_submount(struct fs_context *, struct nfs_server *);
 int nfs4_replace_transport(struct nfs_server *server,
 				const struct nfs4_fs_locations *locations);
 
@@ -516,7 +515,6 @@ extern const nfs4_stateid invalid_stateid;
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
-struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *);
 extern bool nfs4_disable_idmapping;
 extern unsigned short max_session_slots;
 extern unsigned short max_session_cb_slots;
@@ -526,6 +524,9 @@ extern bool recover_lost_locks;
 #define NFS4_CLIENT_ID_UNIQ_LEN		(64)
 extern char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN];
 
+extern int nfs4_try_get_tree(struct fs_context *);
+extern int nfs4_get_referral_tree(struct fs_context *);
+
 /* nfs4sysctl.c */
 #ifdef CONFIG_SYSCTL
 int nfs4_register_sysctl(void);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index e05f754d1eb1..c34027cc8da9 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1042,9 +1042,9 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 /*
  * Create a version 4 volume record
  */
-static int nfs4_init_server(struct nfs_server *server,
-			    struct nfs_fs_context *ctx)
+static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct rpc_timeout timeparms;
 	int error;
 
@@ -1066,14 +1066,14 @@ static int nfs4_init_server(struct nfs_server *server,
 
 	/* Get a client record */
 	error = nfs4_set_client(server,
-			ctx->nfs_server.hostname,
-			(const struct sockaddr *)&ctx->nfs_server.address,
-			ctx->nfs_server.addrlen,
-			ctx->client_address,
-			ctx->nfs_server.protocol,
-			&timeparms,
-			ctx->minorversion,
-			ctx->net);
+				ctx->nfs_server.hostname,
+				&ctx->nfs_server.address,
+				ctx->nfs_server.addrlen,
+				ctx->client_address,
+				ctx->nfs_server.protocol,
+				&timeparms,
+				ctx->minorversion,
+				fc->net_ns);
 	if (error < 0)
 		return error;
 
@@ -1096,10 +1096,9 @@ static int nfs4_init_server(struct nfs_server *server,
  * Create a version 4 volume record
  * - keyed on server and FSID
  */
-/*struct nfs_server *nfs4_create_server(const struct nfs_fs_context *data,
-				      struct nfs_fh *mntfh)*/
-struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs4_create_server(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_server *server;
 	bool auth_probe;
 	int error;
@@ -1110,14 +1109,14 @@ struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 
 	server->cred = get_cred(current_cred());
 
-	auth_probe = mount_info->ctx->auth_info.flavor_len < 1;
+	auth_probe = ctx->auth_info.flavor_len < 1;
 
 	/* set up the general RPC client */
-	error = nfs4_init_server(server, mount_info->ctx);
+	error = nfs4_init_server(server, fc);
 	if (error < 0)
 		goto error;
 
-	error = nfs4_server_common_setup(server, mount_info->mntfh, auth_probe);
+	error = nfs4_server_common_setup(server, ctx->mntfh, auth_probe);
 	if (error < 0)
 		goto error;
 
@@ -1131,9 +1130,9 @@ struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 /*
  * Create an NFS4 referral server record
  */
-struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
-					       struct nfs_fh *mntfh)
+struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_client *parent_client;
 	struct nfs_server *server, *parent_server;
 	bool auth_probe;
@@ -1143,7 +1142,7 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	parent_server = NFS_SB(data->sb);
+	parent_server = NFS_SB(ctx->clone_data.sb);
 	parent_client = parent_server->nfs_client;
 
 	server->cred = get_cred(parent_server->cred);
@@ -1153,10 +1152,11 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 
 	/* Get a client representation */
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
-	rpc_set_port(data->addr, NFS_RDMA_PORT);
-	error = nfs4_set_client(server, data->hostname,
-				data->addr,
-				data->addrlen,
+	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
+	error = nfs4_set_client(server,
+				ctx->nfs_server.hostname,
+				&ctx->nfs_server.address,
+				ctx->nfs_server.addrlen,
 				parent_client->cl_ipaddr,
 				XPRT_TRANSPORT_RDMA,
 				parent_server->client->cl_timeout,
@@ -1166,10 +1166,11 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 		goto init_server;
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
 
-	rpc_set_port(data->addr, NFS_PORT);
-	error = nfs4_set_client(server, data->hostname,
-				data->addr,
-				data->addrlen,
+	rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
+	error = nfs4_set_client(server,
+				ctx->nfs_server.hostname,
+				&ctx->nfs_server.address,
+				ctx->nfs_server.addrlen,
 				parent_client->cl_ipaddr,
 				XPRT_TRANSPORT_TCP,
 				parent_server->client->cl_timeout,
@@ -1181,13 +1182,14 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
 init_server:
 #endif
-	error = nfs_init_server_rpcclient(server, parent_server->client->cl_timeout, data->authflavor);
+	error = nfs_init_server_rpcclient(server, parent_server->client->cl_timeout,
+					  ctx->selected_flavor);
 	if (error < 0)
 		goto error;
 
 	auth_probe = parent_server->auth_info.flavor_len < 1;
 
-	error = nfs4_server_common_setup(server, mntfh, auth_probe);
+	error = nfs4_server_common_setup(server, ctx->mntfh, auth_probe);
 	if (error < 0)
 		goto error;
 
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 2e460c33ae48..37999925040a 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -8,6 +8,7 @@
  * NFSv4 namespace
  */
 
+#include <linux/module.h>
 #include <linux/dcache.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
@@ -21,37 +22,64 @@
 #include <linux/inet.h>
 #include "internal.h"
 #include "nfs4_fs.h"
+#include "nfs.h"
 #include "dns_resolve.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
+/*
+ * Work out the length that an NFSv4 path would render to as a standard posix
+ * path, with a leading slash but no terminating slash.
+ */
+static ssize_t nfs4_pathname_len(const struct nfs4_pathname *pathname)
+{
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < pathname->ncomponents; i++) {
+		const struct nfs4_string *component = &pathname->components[i];
+
+		if (component->len > NAME_MAX)
+			goto too_long;
+		len += 1 + component->len; /* Adding "/foo" */
+		if (len > PATH_MAX)
+			goto too_long;
+	}
+	return len;
+
+too_long:
+	return -ENAMETOOLONG;
+}
+
 /*
  * Convert the NFSv4 pathname components into a standard posix path.
- *
- * Note that the resulting string will be placed at the end of the buffer
  */
-static inline char *nfs4_pathname_string(const struct nfs4_pathname *pathname,
-					 char *buffer, ssize_t buflen)
+static char *nfs4_pathname_string(const struct nfs4_pathname *pathname,
+				  unsigned short *_len)
 {
-	char *end = buffer + buflen;
-	int n;
+	ssize_t len;
+	char *buf, *p;
+	int i;
+
+	len = nfs4_pathname_len(pathname);
+	if (len < 0)
+		return ERR_PTR(len);
+	*_len = len;
 
-	*--end = '\0';
-	buflen--;
-
-	n = pathname->ncomponents;
-	while (--n >= 0) {
-		const struct nfs4_string *component = &pathname->components[n];
-		buflen -= component->len + 1;
-		if (buflen < 0)
-			goto Elong;
-		end -= component->len;
-		memcpy(end, component->data, component->len);
-		*--end = '/';
+	p = buf = kmalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < pathname->ncomponents; i++) {
+		const struct nfs4_string *component = &pathname->components[i];
+
+		*p++ = '/';
+		memcpy(p, component->data, component->len);
+		p += component->len;
 	}
-	return end;
-Elong:
-	return ERR_PTR(-ENAMETOOLONG);
+
+	*p = 0;
+	return buf;
 }
 
 /*
@@ -100,21 +128,25 @@ static char *nfs4_path(struct dentry *dentry, char *buffer, ssize_t buflen)
  */
 static int nfs4_validate_fspath(struct dentry *dentry,
 				const struct nfs4_fs_locations *locations,
-				char *page, char *page2)
+				struct nfs_fs_context *ctx)
 {
-	const char *path, *fs_path;
+	const char *path;
+	char *buf;
+	int n;
 
-	path = nfs4_path(dentry, page, PAGE_SIZE);
-	if (IS_ERR(path))
+	buf = kmalloc(4096, GFP_KERNEL);
+	path = nfs4_path(dentry, buf, 4096);
+	if (IS_ERR(path)) {
+		kfree(buf);
 		return PTR_ERR(path);
+	}
 
-	fs_path = nfs4_pathname_string(&locations->fs_path, page2, PAGE_SIZE);
-	if (IS_ERR(fs_path))
-		return PTR_ERR(fs_path);
-
-	if (strncmp(path, fs_path, strlen(fs_path)) != 0) {
+	n = strncmp(path, ctx->nfs_server.export_path,
+		    ctx->nfs_server.export_path_len);
+	kfree(buf);
+	if (n != 0) {
 		dprintk("%s: path %s does not begin with fsroot %s\n",
-			__func__, path, fs_path);
+			__func__, path, ctx->nfs_server.export_path);
 		return -ENOENT;
 	}
 
@@ -236,55 +268,70 @@ nfs4_negotiate_security(struct rpc_clnt *clnt, struct inode *inode,
 	return new;
 }
 
-static struct vfsmount *try_location(struct nfs_clone_mount *mountdata,
-				     char *page, char *page2,
-				     const struct nfs4_fs_location *location)
+static int try_location(struct fs_context *fc,
+			const struct nfs4_fs_location *location)
 {
-	const size_t addr_bufsize = sizeof(struct sockaddr_storage);
-	struct net *net = rpc_net_ns(NFS_SB(mountdata->sb)->client);
-	struct vfsmount *mnt = ERR_PTR(-ENOENT);
-	char *mnt_path;
-	unsigned int maxbuflen;
-	unsigned int s;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	unsigned int len, s;
+	char *source, *p;
+	int ret = -ENOENT;
+
+	/* Allocate a buffer big enough to hold any of the hostnames plus a
+	 * terminating char and also a buffer big enough to hold the hostname
+	 * plus a colon plus the path.
+	 */
+	len = 0;
+	for (s = 0; s < location->nservers; s++) {
+		const struct nfs4_string *buf = &location->servers[s];
+		if (buf->len > len)
+			len = buf->len;
+	}
 
-	mnt_path = nfs4_pathname_string(&location->rootpath, page2, PAGE_SIZE);
-	if (IS_ERR(mnt_path))
-		return ERR_CAST(mnt_path);
-	mountdata->mnt_path = mnt_path;
-	maxbuflen = mnt_path - 1 - page2;
+	kfree(ctx->nfs_server.hostname);
+	ctx->nfs_server.hostname = kmalloc(len + 1, GFP_KERNEL);
+	if (!ctx->nfs_server.hostname)
+		return -ENOMEM;
 
-	mountdata->addr = kmalloc(addr_bufsize, GFP_KERNEL);
-	if (mountdata->addr == NULL)
-		return ERR_PTR(-ENOMEM);
+	source = kmalloc(len + 1 + ctx->nfs_server.export_path_len + 1,
+			 GFP_KERNEL);
+	if (!source)
+		return -ENOMEM;
 
+	kfree(fc->source);
+	fc->source = source;
 	for (s = 0; s < location->nservers; s++) {
 		const struct nfs4_string *buf = &location->servers[s];
 
-		if (buf->len <= 0 || buf->len >= maxbuflen)
-			continue;
-
 		if (memchr(buf->data, IPV6_SCOPE_DELIMITER, buf->len))
 			continue;
 
-		mountdata->addrlen = nfs_parse_server_name(buf->data, buf->len,
-				mountdata->addr, addr_bufsize, net);
-		if (mountdata->addrlen == 0)
+		ctx->nfs_server.addrlen =
+			nfs_parse_server_name(buf->data, buf->len,
+					      &ctx->nfs_server.address,
+					      sizeof(ctx->nfs_server._address),
+					      fc->net_ns);
+		if (ctx->nfs_server.addrlen == 0)
 			continue;
 
-		memcpy(page2, buf->data, buf->len);
-		page2[buf->len] = '\0';
-		mountdata->hostname = page2;
+		rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
 
-		snprintf(page, PAGE_SIZE, "%s:%s",
-				mountdata->hostname,
-				mountdata->mnt_path);
+		memcpy(ctx->nfs_server.hostname, buf->data, buf->len);
+		ctx->nfs_server.hostname[buf->len] = '\0';
 
-		mnt = vfs_submount(mountdata->dentry, &nfs4_referral_fs_type, page, mountdata);
-		if (!IS_ERR(mnt))
-			break;
+		p = source;
+		memcpy(p, buf->data, buf->len);
+		p += buf->len;
+		*p++ = ':';
+		memcpy(p, ctx->nfs_server.export_path, ctx->nfs_server.export_path_len);
+		p += ctx->nfs_server.export_path_len;
+		*p = 0;
+
+		ret = nfs4_get_referral_tree(fc);
+		if (ret == 0)
+			return 0;
 	}
-	kfree(mountdata->addr);
-	return mnt;
+
+	return ret;
 }
 
 /**
@@ -293,38 +340,31 @@ static struct vfsmount *try_location(struct nfs_clone_mount *mountdata,
  * @locations: array of NFSv4 server location information
  *
  */
-static struct vfsmount *nfs_follow_referral(struct dentry *dentry,
-					    const struct nfs4_fs_locations *locations)
+static int nfs_follow_referral(struct fs_context *fc,
+			       const struct nfs4_fs_locations *locations)
 {
-	struct vfsmount *mnt = ERR_PTR(-ENOENT);
-	struct nfs_clone_mount mountdata = {
-		.sb = dentry->d_sb,
-		.dentry = dentry,
-		.authflavor = NFS_SB(dentry->d_sb)->client->cl_auth->au_flavor,
-	};
-	char *page = NULL, *page2 = NULL;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	char *export_path;
 	int loc, error;
 
 	if (locations == NULL || locations->nlocations <= 0)
-		goto out;
+		return -ENOENT;
 
-	dprintk("%s: referral at %pd2\n", __func__, dentry);
+	dprintk("%s: referral at %pd2\n", __func__, ctx->clone_data.dentry);
 
-	page = (char *) __get_free_page(GFP_USER);
-	if (!page)
-		goto out;
+	export_path = nfs4_pathname_string(&locations->fs_path,
+					   &ctx->nfs_server.export_path_len);
+	if (IS_ERR(export_path))
+		return PTR_ERR(export_path);
 
-	page2 = (char *) __get_free_page(GFP_USER);
-	if (!page2)
-		goto out;
+	ctx->nfs_server.export_path = export_path;
 
 	/* Ensure fs path is a prefix of current dentry path */
-	error = nfs4_validate_fspath(dentry, locations, page, page2);
-	if (error < 0) {
-		mnt = ERR_PTR(error);
-		goto out;
-	}
+	error = nfs4_validate_fspath(ctx->clone_data.dentry, locations, ctx);
+	if (error < 0)
+		return error;
 
+	error = -ENOENT;
 	for (loc = 0; loc < locations->nlocations; loc++) {
 		const struct nfs4_fs_location *location = &locations->locations[loc];
 
@@ -332,15 +372,12 @@ static struct vfsmount *nfs_follow_referral(struct dentry *dentry,
 		    location->rootpath.ncomponents == 0)
 			continue;
 
-		mnt = try_location(&mountdata, page, page2, location);
-		if (!IS_ERR(mnt))
-			break;
+		error = try_location(fc, location);
+		if (error == 0)
+			return 0;
 	}
 
-out:
-	free_page((unsigned long) page);
-	free_page((unsigned long) page2);
-	return mnt;
+	return error;
 }
 
 /*
@@ -348,71 +385,73 @@ static struct vfsmount *nfs_follow_referral(struct dentry *dentry,
  * @dentry - dentry of referral
  *
  */
-static struct vfsmount *nfs_do_refmount(struct rpc_clnt *client, struct dentry *dentry)
+static int nfs_do_refmount(struct fs_context *fc, struct rpc_clnt *client)
 {
-	struct vfsmount *mnt = ERR_PTR(-ENOMEM);
-	struct dentry *parent;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct dentry *dentry, *parent;
 	struct nfs4_fs_locations *fs_locations = NULL;
 	struct page *page;
-	int err;
+	int err = -ENOMEM;
 
 	/* BUG_ON(IS_ROOT(dentry)); */
 	page = alloc_page(GFP_KERNEL);
-	if (page == NULL)
-		return mnt;
+	if (!page)
+		return -ENOMEM;
 
 	fs_locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
-	if (fs_locations == NULL)
+	if (!fs_locations)
 		goto out_free;
 
 	/* Get locations */
-	mnt = ERR_PTR(-ENOENT);
-
+	dentry = ctx->clone_data.dentry;
 	parent = dget_parent(dentry);
 	dprintk("%s: getting locations for %pd2\n",
 		__func__, dentry);
 
 	err = nfs4_proc_fs_locations(client, d_inode(parent), &dentry->d_name, fs_locations, page);
 	dput(parent);
-	if (err != 0 ||
-	    fs_locations->nlocations <= 0 ||
+	if (err != 0)
+		goto out_free_2;
+
+	err = -ENOENT;
+	if (fs_locations->nlocations <= 0 ||
 	    fs_locations->fs_path.ncomponents <= 0)
-		goto out_free;
+		goto out_free_2;
 
-	mnt = nfs_follow_referral(dentry, fs_locations);
+	err = nfs_follow_referral(fc, fs_locations);
+out_free_2:
+	kfree(fs_locations);
 out_free:
 	__free_page(page);
-	kfree(fs_locations);
-	return mnt;
+	return err;
 }
 
-struct vfsmount *nfs4_submount(struct nfs_server *server, struct dentry *dentry,
-			       struct nfs_fh *fh, struct nfs_fattr *fattr)
+int nfs4_submount(struct fs_context *fc, struct nfs_server *server)
 {
-	rpc_authflavor_t flavor = server->client->cl_auth->au_flavor;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct dentry *dentry = ctx->clone_data.dentry;
 	struct dentry *parent = dget_parent(dentry);
 	struct inode *dir = d_inode(parent);
 	const struct qstr *name = &dentry->d_name;
 	struct rpc_clnt *client;
-	struct vfsmount *mnt;
+	int ret;
 
 	/* Look it up again to get its attributes and sec flavor */
-	client = nfs4_proc_lookup_mountpoint(dir, name, fh, fattr);
+	client = nfs4_proc_lookup_mountpoint(dir, name, ctx->mntfh,
+					     ctx->clone_data.fattr);
 	dput(parent);
 	if (IS_ERR(client))
-		return ERR_CAST(client);
+		return PTR_ERR(client);
 
-	if (fattr->valid & NFS_ATTR_FATTR_V4_REFERRAL) {
-		mnt = nfs_do_refmount(client, dentry);
-		goto out;
+	if (ctx->clone_data.fattr->valid & NFS_ATTR_FATTR_V4_REFERRAL) {
+		ret = nfs_do_refmount(fc, client);
+	} else {
+		ctx->selected_flavor = client->cl_auth->au_flavor;
+		ret = nfs_do_submount(fc);
 	}
 
-	if (client->cl_auth->au_flavor != flavor)
-		flavor = client->cl_auth->au_flavor;
-	mnt = nfs_do_submount(dentry, fh, fattr, flavor);
-out:
 	rpc_shutdown_client(client);
-	return mnt;
+	return ret;
 }
 
 /*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c29cbef6b53f..0ed47d58a894 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9846,7 +9846,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.file_ops	= &nfs4_file_operations,
 	.getroot	= nfs4_proc_get_root,
 	.submount	= nfs4_submount,
-	.try_mount	= nfs4_try_mount,
+	.try_get_tree	= nfs4_try_get_tree,
 	.getattr	= nfs4_proc_getattr,
 	.setattr	= nfs4_proc_setattr,
 	.lookup		= nfs4_proc_lookup,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 48a9f19904e0..0240429ec596 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -3,6 +3,7 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/nfs4_mount.h>
 #include <linux/nfs_fs.h>
 #include "delegation.h"
@@ -17,16 +18,6 @@
 
 static int nfs4_write_inode(struct inode *inode, struct writeback_control *wbc);
 static void nfs4_evict_inode(struct inode *inode);
-static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data);
-
-struct file_system_type nfs4_referral_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs4",
-	.mount		= nfs4_referral_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
 
 static const struct super_operations nfs4_sops = {
 	.alloc_inode	= nfs_alloc_inode,
@@ -40,16 +31,15 @@ static const struct super_operations nfs4_sops = {
 	.show_devname	= nfs_show_devname,
 	.show_path	= nfs_show_path,
 	.show_stats	= nfs_show_stats,
-	.remount_fs	= nfs_remount,
 };
 
 struct nfs_subversion nfs_v4 = {
-	.owner = THIS_MODULE,
-	.nfs_fs   = &nfs4_fs_type,
-	.rpc_vers = &nfs_version4,
-	.rpc_ops  = &nfs_v4_clientops,
-	.sops     = &nfs4_sops,
-	.xattr    = nfs4_xattr_handlers,
+	.owner		= THIS_MODULE,
+	.nfs_fs		= &nfs4_fs_type,
+	.rpc_vers	= &nfs_version4,
+	.rpc_ops	= &nfs_v4_clientops,
+	.sops		= &nfs4_sops,
+	.xattr		= nfs4_xattr_handlers,
 };
 
 static int nfs4_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -146,105 +136,125 @@ static void nfs_referral_loop_unprotect(void)
 	kfree(p);
 }
 
-static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
-				    struct nfs_mount_info *info,
-				    const char *hostname,
-				    const char *export_path)
+static int do_nfs4_mount(struct nfs_server *server,
+			 struct fs_context *fc,
+			 const char *hostname,
+			 const char *export_path)
 {
+	struct nfs_fs_context *root_ctx;
+	struct fs_context *root_fc;
 	struct vfsmount *root_mnt;
 	struct dentry *dentry;
-	char *root_devname;
-	int err;
 	size_t len;
+	int ret;
+
+	struct fs_parameter param = {
+		.key	= "source",
+		.type	= fs_value_is_string,
+		.dirfd	= -1,
+	};
 
 	if (IS_ERR(server))
-		return ERR_CAST(server);
+		return PTR_ERR(server);
 
-	len = strlen(hostname) + 5;
-	root_devname = kmalloc(len, GFP_KERNEL);
-	if (root_devname == NULL) {
+	root_fc = vfs_dup_fs_context(fc);
+	if (IS_ERR(root_fc)) {
 		nfs_free_server(server);
-		return ERR_PTR(-ENOMEM);
+		return PTR_ERR(root_fc);
+	}
+	kfree(root_fc->source);
+	root_fc->source = NULL;
+
+	root_ctx = nfs_fc2context(root_fc);
+	root_ctx->internal = true;
+	root_ctx->server = server;
+	/* We leave export_path unset as it's not used to find the root. */
+
+	len = strlen(hostname) + 5;
+	param.string = kmalloc(len, GFP_KERNEL);
+	if (param.string == NULL) {
+		put_fs_context(root_fc);
+		return -ENOMEM;
 	}
 
 	/* Does hostname needs to be enclosed in brackets? */
 	if (strchr(hostname, ':'))
-		snprintf(root_devname, len, "[%s]:/", hostname);
+		param.size = snprintf(param.string, len, "[%s]:/", hostname);
 	else
-		snprintf(root_devname, len, "%s:/", hostname);
-	info->server = server;
-	root_mnt = vfs_kern_mount(&nfs_prepared_fs_type, flags, root_devname, info);
-	if (info->server)
-		nfs_free_server(info->server);
-	info->server = NULL;
-	kfree(root_devname);
+		param.size = snprintf(param.string, len, "%s:/", hostname);
+	ret = vfs_parse_fs_param(root_fc, &param);
+	kfree(param.string);
+	if (ret < 0) {
+		put_fs_context(root_fc);
+		return ret;
+	}
+	root_mnt = fc_mount(root_fc);
+	put_fs_context(root_fc);
 
 	if (IS_ERR(root_mnt))
-		return ERR_CAST(root_mnt);
+		return PTR_ERR(root_mnt);
 
-	err = nfs_referral_loop_protect();
-	if (err) {
+	ret = nfs_referral_loop_protect();
+	if (ret) {
 		mntput(root_mnt);
-		return ERR_PTR(err);
+		return ret;
 	}
 
 	dentry = mount_subtree(root_mnt, export_path);
 	nfs_referral_loop_unprotect();
 
-	return dentry;
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	fc->root = dentry;
+	return 0;
 }
 
-struct dentry *nfs4_try_mount(int flags, const char *dev_name,
-			      struct nfs_mount_info *mount_info)
+int nfs4_try_get_tree(struct fs_context *fc)
 {
-	struct nfs_fs_context *ctx = mount_info->ctx;
-	struct dentry *res;
-
-	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	int err;
 
-	res = do_nfs4_mount(nfs4_create_server(mount_info),
-			    flags, mount_info,
-			    ctx->nfs_server.hostname,
-			    ctx->nfs_server.export_path);
+	dfprintk(MOUNT, "--> nfs4_try_get_tree()\n");
 
-	dfprintk(MOUNT, "<-- nfs4_try_mount() = %d%s\n",
-		 PTR_ERR_OR_ZERO(res),
-		 IS_ERR(res) ? " [error]" : "");
-	return res;
+	/* We create a mount for the server's root, walk to the requested
+	 * location and then create another mount for that.
+	 */
+	err= do_nfs4_mount(nfs4_create_server(fc),
+			   fc, ctx->nfs_server.hostname,
+			   ctx->nfs_server.export_path);
+	if (err) {
+		nfs_errorf(fc, "NFS4: Couldn't follow remote path");
+		dfprintk(MOUNT, "<-- nfs4_try_mount() = %d [error]\n", err);
+	} else {
+		dfprintk(MOUNT, "<-- nfs4_try_get_tree() = 0\n");
+	}
+	return err;
 }
 
 /*
  * Create an NFS4 server record on referral traversal
  */
-static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data)
+int nfs4_get_referral_tree(struct fs_context *fc)
 {
-	struct nfs_clone_mount *data = raw_data;
-	struct nfs_mount_info mount_info = {
-		.cloned = data,
-		.nfs_mod = &nfs_v4,
-	};
-	struct dentry *res;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	int err;
 
 	dprintk("--> nfs4_referral_mount()\n");
 
-	mount_info.mntfh = nfs_alloc_fhandle();
-	if (!mount_info.mntfh)
-		return ERR_PTR(-ENOMEM);
-
-	res = do_nfs4_mount(nfs4_create_referral_server(mount_info.cloned,
-							mount_info.mntfh),
-			    flags, &mount_info, data->hostname, data->mnt_path);
-
-	dprintk("<-- nfs4_referral_mount() = %d%s\n",
-		PTR_ERR_OR_ZERO(res),
-		IS_ERR(res) ? " [error]" : "");
-
-	nfs_free_fhandle(mount_info.mntfh);
-	return res;
+	/* create a new volume representation */
+	err = do_nfs4_mount(nfs4_create_referral_server(fc),
+			    fc, ctx->nfs_server.hostname,
+			    ctx->nfs_server.export_path);
+	if (err) {
+		nfs_errorf(fc, "NFS4: Couldn't follow remote path");
+		dfprintk(MOUNT, "<-- nfs4_referral_mount() = %d [error]\n", err);
+	} else {
+		dfprintk(MOUNT, "<-- nfs4_get_referral_tree() = 0\n");
+	}
+	return err;
 }
 
-
 static int __init init_nfs_v4(void)
 {
 	int err;
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 5552fa8b6e12..03b175fd94b9 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -707,7 +707,7 @@ const struct nfs_rpc_ops nfs_v2_clientops = {
 	.file_ops	= &nfs_file_operations,
 	.getroot	= nfs_proc_get_root,
 	.submount	= nfs_submount,
-	.try_mount	= nfs_try_mount,
+	.try_get_tree	= nfs_try_get_tree,
 	.getattr	= nfs_proc_getattr,
 	.setattr	= nfs_proc_setattr,
 	.lookup		= nfs_proc_lookup,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 5c8cf0e35141..c455ebeeadc9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -69,28 +69,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
-static struct dentry *nfs_prepared_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data);
-
-struct file_system_type nfs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs",
-	.mount		= nfs_fs_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-MODULE_ALIAS_FS("nfs");
-EXPORT_SYMBOL_GPL(nfs_fs_type);
-
-struct file_system_type nfs_prepared_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs",
-	.mount		= nfs_prepared_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-EXPORT_SYMBOL_GPL(nfs_prepared_fs_type);
-
 const struct super_operations nfs_sops = {
 	.alloc_inode	= nfs_alloc_inode,
 	.free_inode	= nfs_free_inode,
@@ -103,22 +81,10 @@ const struct super_operations nfs_sops = {
 	.show_devname	= nfs_show_devname,
 	.show_path	= nfs_show_path,
 	.show_stats	= nfs_show_stats,
-	.remount_fs	= nfs_remount,
 };
 EXPORT_SYMBOL_GPL(nfs_sops);
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-struct file_system_type nfs4_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs4",
-	.mount		= nfs_fs_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-MODULE_ALIAS_FS("nfs4");
-MODULE_ALIAS("nfs4");
-EXPORT_SYMBOL_GPL(nfs4_fs_type);
-
 static int __init register_nfs4_fs(void)
 {
 	return register_filesystem(&nfs4_fs_type);
@@ -714,11 +680,11 @@ bool nfs_auth_info_match(const struct nfs_auth_info *auth_info,
 EXPORT_SYMBOL_GPL(nfs_auth_info_match);
 
 /*
- * Ensure that a specified authtype in cfg->auth_info is supported by
- * the server. Returns 0 and sets cfg->selected_flavor if it's ok, and
+ * Ensure that a specified authtype in ctx->auth_info is supported by
+ * the server. Returns 0 and sets ctx->selected_flavor if it's ok, and
  * -EACCES if not.
  */
-static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
+static int nfs_verify_authflavors(struct nfs_fs_context *ctx,
 				  rpc_authflavor_t *server_authlist,
 				  unsigned int count)
 {
@@ -741,7 +707,7 @@ static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
 	for (i = 0; i < count; i++) {
 		flavor = server_authlist[i];
 
-		if (nfs_auth_info_match(&cfg->auth_info, flavor))
+		if (nfs_auth_info_match(&ctx->auth_info, flavor))
 			goto out;
 
 		if (flavor == RPC_AUTH_NULL)
@@ -749,7 +715,7 @@ static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
 	}
 
 	if (found_auth_null) {
-		flavor = cfg->auth_info.flavors[0];
+		flavor = ctx->auth_info.flavors[0];
 		goto out;
 	}
 
@@ -758,8 +724,8 @@ static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
 	return -EACCES;
 
 out:
-	cfg->selected_flavor = flavor;
-	dfprintk(MOUNT, "NFS: using auth flavor %u\n", cfg->selected_flavor);
+	ctx->selected_flavor = flavor;
+	dfprintk(MOUNT, "NFS: using auth flavor %u\n", ctx->selected_flavor);
 	return 0;
 }
 
@@ -767,50 +733,51 @@ static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
  * Use the remote server's MOUNT service to request the NFS file handle
  * corresponding to the provided path.
  */
-static int nfs_request_mount(struct nfs_fs_context *cfg,
+static int nfs_request_mount(struct fs_context *fc,
 			     struct nfs_fh *root_fh,
 			     rpc_authflavor_t *server_authlist,
 			     unsigned int *server_authlist_len)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_mount_request request = {
 		.sap		= (struct sockaddr *)
-						&cfg->mount_server.address,
-		.dirpath	= cfg->nfs_server.export_path,
-		.protocol	= cfg->mount_server.protocol,
+						&ctx->mount_server.address,
+		.dirpath	= ctx->nfs_server.export_path,
+		.protocol	= ctx->mount_server.protocol,
 		.fh		= root_fh,
-		.noresvport	= cfg->flags & NFS_MOUNT_NORESVPORT,
+		.noresvport	= ctx->flags & NFS_MOUNT_NORESVPORT,
 		.auth_flav_len	= server_authlist_len,
 		.auth_flavs	= server_authlist,
-		.net		= cfg->net,
+		.net		= fc->net_ns,
 	};
 	int status;
 
-	if (cfg->mount_server.version == 0) {
-		switch (cfg->version) {
+	if (ctx->mount_server.version == 0) {
+		switch (ctx->version) {
 			default:
-				cfg->mount_server.version = NFS_MNT3_VERSION;
+				ctx->mount_server.version = NFS_MNT3_VERSION;
 				break;
 			case 2:
-				cfg->mount_server.version = NFS_MNT_VERSION;
+				ctx->mount_server.version = NFS_MNT_VERSION;
 		}
 	}
-	request.version = cfg->mount_server.version;
+	request.version = ctx->mount_server.version;
 
-	if (cfg->mount_server.hostname)
-		request.hostname = cfg->mount_server.hostname;
+	if (ctx->mount_server.hostname)
+		request.hostname = ctx->mount_server.hostname;
 	else
-		request.hostname = cfg->nfs_server.hostname;
+		request.hostname = ctx->nfs_server.hostname;
 
 	/*
 	 * Construct the mount server's address.
 	 */
-	if (cfg->mount_server.address.sa_family == AF_UNSPEC) {
-		memcpy(request.sap, &cfg->nfs_server.address,
-		       cfg->nfs_server.addrlen);
-		cfg->mount_server.addrlen = cfg->nfs_server.addrlen;
+	if (ctx->mount_server.address.sa_family == AF_UNSPEC) {
+		memcpy(request.sap, &ctx->nfs_server.address,
+		       ctx->nfs_server.addrlen);
+		ctx->mount_server.addrlen = ctx->nfs_server.addrlen;
 	}
-	request.salen = cfg->mount_server.addrlen;
-	nfs_set_port(request.sap, &cfg->mount_server.port, 0);
+	request.salen = ctx->mount_server.addrlen;
+	nfs_set_port(request.sap, &ctx->mount_server.port, 0);
 
 	/*
 	 * Now ask the mount server to map our export path
@@ -826,20 +793,18 @@ static int nfs_request_mount(struct nfs_fs_context *cfg,
 	return 0;
 }
 
-static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_info)
+static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	int status;
 	unsigned int i;
 	bool tried_auth_unix = false;
 	bool auth_null_in_list = false;
 	struct nfs_server *server = ERR_PTR(-EACCES);
-	struct nfs_fs_context *ctx = mount_info->ctx;
 	rpc_authflavor_t authlist[NFS_MAX_SECFLAVORS];
 	unsigned int authlist_len = ARRAY_SIZE(authlist);
-	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 
-	status = nfs_request_mount(ctx, mount_info->mntfh, authlist,
-					&authlist_len);
+	status = nfs_request_mount(fc, ctx->mntfh, authlist, &authlist_len);
 	if (status)
 		return ERR_PTR(status);
 
@@ -853,7 +818,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 			 ctx->selected_flavor);
 		if (status)
 			return ERR_PTR(status);
-		return nfs_mod->rpc_ops->create_server(mount_info);
+		return ctx->nfs_mod->rpc_ops->create_server(fc);
 	}
 
 	/*
@@ -880,7 +845,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 		}
 		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 		ctx->selected_flavor = flavor;
-		server = nfs_mod->rpc_ops->create_server(mount_info);
+		server = ctx->nfs_mod->rpc_ops->create_server(fc);
 		if (!IS_ERR(server))
 			return server;
 	}
@@ -896,23 +861,22 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 	/* Last chance! Try AUTH_UNIX */
 	dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", RPC_AUTH_UNIX);
 	ctx->selected_flavor = RPC_AUTH_UNIX;
-	return nfs_mod->rpc_ops->create_server(mount_info);
+	return ctx->nfs_mod->rpc_ops->create_server(fc);
 }
 
-static struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mount_info *);
-
-struct dentry *nfs_try_mount(int flags, const char *dev_name,
-			     struct nfs_mount_info *mount_info)
+int nfs_try_get_tree(struct fs_context *fc)
 {
-	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
-	if (mount_info->ctx->need_mount)
-		mount_info->server = nfs_try_mount_request(mount_info);
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+
+	if (ctx->need_mount)
+		ctx->server = nfs_try_mount_request(fc);
 	else
-		mount_info->server = nfs_mod->rpc_ops->create_server(mount_info);
+		ctx->server = ctx->nfs_mod->rpc_ops->create_server(fc);
 
-	return nfs_fs_mount_common(flags, dev_name, mount_info);
+	return nfs_get_tree_common(fc);
 }
-EXPORT_SYMBOL_GPL(nfs_try_mount);
+EXPORT_SYMBOL_GPL(nfs_try_get_tree);
+
 
 #define NFS_REMOUNT_CMP_FLAGMASK ~(NFS_MOUNT_INTR \
 		| NFS_MOUNT_SECURE \
@@ -952,15 +916,11 @@ nfs_compare_remount_data(struct nfs_server *nfss,
 	return 0;
 }
 
-int
-nfs_remount(struct super_block *sb, int *flags, char *raw_data)
+int nfs_reconfigure(struct fs_context *fc)
 {
-	int error;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct super_block *sb = fc->root->d_sb;
 	struct nfs_server *nfss = sb->s_fs_info;
-	struct nfs_fs_context *ctx;
-	struct nfs_mount_data *options = (struct nfs_mount_data *)raw_data;
-	struct nfs4_mount_data *options4 = (struct nfs4_mount_data *)raw_data;
-	u32 nfsvers = nfss->nfs_client->rpc_ops->version;
 
 	sync_filesystem(sb);
 
@@ -970,64 +930,30 @@ nfs_remount(struct super_block *sb, int *flags, char *raw_data)
 	 * ones were explicitly specified. Fall back to legacy behavior and
 	 * just return success.
 	 */
-	if ((nfsvers == 4 && (!options4 || options4->version == 1)) ||
-	    (nfsvers <= 3 && (!options || (options->version >= 1 &&
-					   options->version <= 6))))
+	if (ctx->skip_reconfig_option_check)
 		return 0;
 
-	ctx = nfs_alloc_parsed_mount_data();
-	if (ctx == NULL)
-		return -ENOMEM;
-
-	/* fill out struct with values from existing mount */
-	ctx->flags = nfss->flags;
-	ctx->rsize = nfss->rsize;
-	ctx->wsize = nfss->wsize;
-	ctx->retrans = nfss->client->cl_timeout->to_retries;
-	ctx->selected_flavor = nfss->client->cl_auth->au_flavor;
-	ctx->acregmin = nfss->acregmin / HZ;
-	ctx->acregmax = nfss->acregmax / HZ;
-	ctx->acdirmin = nfss->acdirmin / HZ;
-	ctx->acdirmax = nfss->acdirmax / HZ;
-	ctx->timeo = 10U * nfss->client->cl_timeout->to_initval / HZ;
-	ctx->nfs_server.port = nfss->port;
-	ctx->nfs_server.addrlen = nfss->nfs_client->cl_addrlen;
-	ctx->version = nfsvers;
-	ctx->minorversion = nfss->nfs_client->cl_minorversion;
-	ctx->net = current->nsproxy->net_ns;
-	memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
-		ctx->nfs_server.addrlen);
-
-	/* overwrite those values with any that were specified */
-	error = -EINVAL;
-	if (!nfs_parse_mount_options((char *)options, ctx))
-		goto out;
-
 	/*
 	 * noac is a special case. It implies -o sync, but that's not
-	 * necessarily reflected in the mtab options. do_remount_sb
+	 * necessarily reflected in the mtab options. reconfigure_super
 	 * will clear SB_SYNCHRONOUS if -o sync wasn't specified in the
 	 * remount options, so we have to explicitly reset it.
 	 */
-	if (ctx->flags & NFS_MOUNT_NOAC)
-		*flags |= SB_SYNCHRONOUS;
+	if (ctx->flags & NFS_MOUNT_NOAC) {
+		fc->sb_flags |= SB_SYNCHRONOUS;
+		fc->sb_flags_mask |= SB_SYNCHRONOUS;
+	}
 
 	/* compare new mount options with old ones */
-	error = nfs_compare_remount_data(nfss, ctx);
-	if (!error)
-		error = security_sb_remount(sb, ctx->lsm_opts);
-out:
-	nfs_free_parsed_mount_data(ctx);
-	return error;
+	return nfs_compare_remount_data(nfss, ctx);
 }
-EXPORT_SYMBOL_GPL(nfs_remount);
+EXPORT_SYMBOL_GPL(nfs_reconfigure);
 
 /*
  * Finish setting up an NFS superblock
  */
-static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
+static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 {
-	struct nfs_fs_context *ctx = mount_info->ctx;
 	struct nfs_server *server = NFS_SB(sb);
 
 	sb->s_blocksize_bits = 0;
@@ -1059,13 +985,14 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_
 	nfs_super_set_maxbytes(sb, server->maxfilesize);
 }
 
-static int nfs_compare_mount_options(const struct super_block *s, const struct nfs_server *b, int flags)
+static int nfs_compare_mount_options(const struct super_block *s, const struct nfs_server *b,
+				     const struct fs_context *fc)
 {
 	const struct nfs_server *a = s->s_fs_info;
 	const struct rpc_clnt *clnt_a = a->client;
 	const struct rpc_clnt *clnt_b = b->client;
 
-	if ((s->s_flags & NFS_MS_MASK) != (flags & NFS_MS_MASK))
+	if ((s->s_flags & NFS_SB_MASK) != (fc->sb_flags & NFS_SB_MASK))
 		goto Ebusy;
 	if (a->nfs_client != b->nfs_client)
 		goto Ebusy;
@@ -1090,19 +1017,11 @@ static int nfs_compare_mount_options(const struct super_block *s, const struct n
 	return 0;
 }
 
-struct nfs_sb_mountdata {
-	struct nfs_server *server;
-	int mntflags;
-};
-
-static int nfs_set_super(struct super_block *s, void *data)
+static int nfs_set_super(struct super_block *s, struct fs_context *fc)
 {
-	struct nfs_sb_mountdata *sb_mntdata = data;
-	struct nfs_server *server = sb_mntdata->server;
+	struct nfs_server *server = fc->s_fs_info;
 	int ret;
 
-	s->s_flags = sb_mntdata->mntflags;
-	s->s_fs_info = server;
 	s->s_d_op = server->nfs_client->rpc_ops->dentry_ops;
 	ret = set_anon_super(s, server);
 	if (ret == 0)
@@ -1167,11 +1086,9 @@ static int nfs_compare_userns(const struct nfs_server *old,
 	return 1;
 }
 
-static int nfs_compare_super(struct super_block *sb, void *data)
+static int nfs_compare_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct nfs_sb_mountdata *sb_mntdata = data;
-	struct nfs_server *server = sb_mntdata->server, *old = NFS_SB(sb);
-	int mntflags = sb_mntdata->mntflags;
+	struct nfs_server *server = fc->s_fs_info, *old = NFS_SB(sb);
 
 	if (!nfs_compare_super_address(old, server))
 		return 0;
@@ -1182,13 +1099,12 @@ static int nfs_compare_super(struct super_block *sb, void *data)
 		return 0;
 	if (!nfs_compare_userns(old, server))
 		return 0;
-	return nfs_compare_mount_options(sb, server, mntflags);
+	return nfs_compare_mount_options(sb, server, fc);
 }
 
 #ifdef CONFIG_NFS_FSCACHE
 static void nfs_get_cache_cookie(struct super_block *sb,
-				 struct nfs_fs_context *ctx,
-				 struct nfs_clone_mount *cloned)
+				 struct nfs_fs_context *ctx)
 {
 	struct nfs_server *nfss = NFS_SB(sb);
 	char *uniq = NULL;
@@ -1197,68 +1113,70 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 	nfss->fscache_key = NULL;
 	nfss->fscache = NULL;
 
-	if (ctx) {
+	if (!ctx)
+		return;
+
+	if (ctx->clone_data.sb) {
+		struct nfs_server *mnt_s = NFS_SB(ctx->clone_data.sb);
+		if (!(mnt_s->options & NFS_OPTION_FSCACHE))
+			return;
+		if (mnt_s->fscache_key) {
+			uniq = mnt_s->fscache_key->key.uniquifier;
+			ulen = mnt_s->fscache_key->key.uniq_len;
+		}
+	} else {
 		if (!(ctx->options & NFS_OPTION_FSCACHE))
 			return;
 		if (ctx->fscache_uniq) {
 			uniq = ctx->fscache_uniq;
 			ulen = strlen(ctx->fscache_uniq);
 		}
-	} else if (cloned) {
-		struct nfs_server *mnt_s = NFS_SB(cloned->sb);
-		if (!(mnt_s->options & NFS_OPTION_FSCACHE))
-			return;
-		if (mnt_s->fscache_key) {
-			uniq = mnt_s->fscache_key->key.uniquifier;
-			ulen = mnt_s->fscache_key->key.uniq_len;
-		};
-	} else
 		return;
+	}
 
 	nfs_fscache_get_super_cookie(sb, uniq, ulen);
 }
 #else
 static void nfs_get_cache_cookie(struct super_block *sb,
-				 struct nfs_fs_context *parsed,
-				 struct nfs_clone_mount *cloned)
+				 struct nfs_fs_context *ctx)
 {
 }
 #endif
 
-static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
-				   struct nfs_mount_info *mount_info)
+int nfs_get_tree_common(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct super_block *s;
-	struct dentry *mntroot = ERR_PTR(-ENOMEM);
-	int (*compare_super)(struct super_block *, void *) = nfs_compare_super;
-	struct nfs_server *server = mount_info->server;
+	int (*compare_super)(struct super_block *, struct fs_context *) = nfs_compare_super;
+	struct nfs_server *server = ctx->server;
 	unsigned long kflags = 0, kflags_out = 0;
-	struct nfs_sb_mountdata sb_mntdata = {
-		.mntflags = flags,
-		.server = server,
-	};
 	int error;
 
-	mount_info->server = NULL;
+	ctx->server = NULL;
 	if (IS_ERR(server))
-		return ERR_CAST(server);
+		return PTR_ERR(server);
 
 	if (server->flags & NFS_MOUNT_UNSHARED)
 		compare_super = NULL;
 
 	/* -o noac implies -o sync */
 	if (server->flags & NFS_MOUNT_NOAC)
-		sb_mntdata.mntflags |= SB_SYNCHRONOUS;
+		fc->sb_flags |= SB_SYNCHRONOUS;
 
-	if (mount_info->cloned != NULL && mount_info->cloned->sb != NULL)
-		if (mount_info->cloned->sb->s_flags & SB_SYNCHRONOUS)
-			sb_mntdata.mntflags |= SB_SYNCHRONOUS;
+	if (ctx->clone_data.sb)
+		if (ctx->clone_data.sb->s_flags & SB_SYNCHRONOUS)
+			fc->sb_flags |= SB_SYNCHRONOUS;
+
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
+		fc->lsm_flags |= SECURITY_LSM_NATIVE_LABELS;
 
 	/* Get a superblock - note that we may end up sharing one that already exists */
-	s = sget(mount_info->nfs_mod->nfs_fs, compare_super, nfs_set_super,
-		 flags, &sb_mntdata);
+	fc->s_fs_info = server;
+	s = sget_fc(fc, compare_super, nfs_set_super);
+	fc->s_fs_info = NULL;
 	if (IS_ERR(s)) {
-		mntroot = ERR_CAST(s);
+		error = PTR_ERR(s);
+		nfs_errorf(fc, "NFS: Couldn't get superblock");
 		goto out_err_nosb;
 	}
 
@@ -1268,44 +1186,41 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	} else {
 		error = super_setup_bdi_name(s, "%u:%u", MAJOR(server->s_dev),
 					     MINOR(server->s_dev));
-		if (error) {
-			mntroot = ERR_PTR(error);
+		if (error)
 			goto error_splat_super;
-		}
 		s->s_bdi->ra_pages = server->rpages * NFS_MAX_READAHEAD;
 		server->super = s;
 	}
 
 	if (!s->s_root) {
-		unsigned bsize = mount_info->inherited_bsize;
+		unsigned bsize = ctx->clone_data.inherited_bsize;
 		/* initial superblock/root creation */
-		nfs_fill_super(s, mount_info);
+		nfs_fill_super(s, ctx);
 		if (bsize) {
 			s->s_blocksize_bits = bsize;
 			s->s_blocksize = 1U << bsize;
 		}
-		nfs_get_cache_cookie(s, mount_info->ctx, mount_info->cloned);
-		if (!(server->flags & NFS_MOUNT_UNSHARED))
-			s->s_iflags |= SB_I_MULTIROOT;
+		nfs_get_cache_cookie(s, ctx);
 	}
 
-	mntroot = nfs_get_root(s, mount_info->mntfh, dev_name);
-	if (IS_ERR(mntroot))
+	error = nfs_get_root(s, fc);
+	if (error < 0) {
+		nfs_errorf(fc, "NFS: Couldn't get root dentry");
 		goto error_splat_super;
-
+	}
 
 	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
 		kflags |= SECURITY_LSM_NATIVE_LABELS;
-	if (mount_info->cloned) {
-		if (d_inode(mntroot)->i_fop != &nfs_dir_operations) {
+	if (ctx->clone_data.sb) {
+		if (d_inode(fc->root)->i_fop != &nfs_dir_operations) {
 			error = -ESTALE;
 			goto error_splat_root;
 		}
 		/* clone any lsm security options from the parent to the new sb */
-		error = security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kflags,
+		error = security_sb_clone_mnt_opts(ctx->clone_data.sb, s, kflags,
 				&kflags_out);
 	} else {
-		error = security_sb_set_mnt_opts(s, mount_info->ctx->lsm_opts,
+		error = security_sb_set_mnt_opts(s, fc->security,
 							kflags, &kflags_out);
 	}
 	if (error)
@@ -1313,67 +1228,25 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
 		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
 		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
-	if (error)
-		goto error_splat_root;
 
 	s->s_flags |= SB_ACTIVE;
+	error = 0;
 
 out:
-	return mntroot;
+	return error;
 
 out_err_nosb:
 	nfs_free_server(server);
 	goto out;
 
 error_splat_root:
-	dput(mntroot);
-	mntroot = ERR_PTR(error);
+	dput(fc->root);
+	fc->root = NULL;
 error_splat_super:
 	deactivate_locked_super(s);
 	goto out;
 }
 
-struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data)
-{
-	struct nfs_mount_info mount_info = {
-	};
-	struct dentry *mntroot = ERR_PTR(-ENOMEM);
-	struct nfs_subversion *nfs_mod;
-	int error;
-
-	mount_info.ctx = nfs_alloc_parsed_mount_data();
-	mount_info.mntfh = nfs_alloc_fhandle();
-	if (mount_info.ctx == NULL || mount_info.mntfh == NULL)
-		goto out;
-
-	/* Validate the mount data */
-	error = nfs_validate_mount_data(fs_type, raw_data, mount_info.ctx, mount_info.mntfh, dev_name);
-	if (error == NFS_TEXT_DATA)
-		error = nfs_validate_text_mount_data(raw_data, 
-						     mount_info.ctx, dev_name);
-	if (error < 0) {
-		mntroot = ERR_PTR(error);
-		goto out;
-	}
-
-	nfs_mod = get_nfs_version(mount_info.ctx->version);
-	if (IS_ERR(nfs_mod)) {
-		mntroot = ERR_CAST(nfs_mod);
-		goto out;
-	}
-	mount_info.nfs_mod = nfs_mod;
-
-	mntroot = nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info);
-
-	put_nfs_version(nfs_mod);
-out:
-	nfs_free_parsed_mount_data(mount_info.ctx);
-	nfs_free_fhandle(mount_info.mntfh);
-	return mntroot;
-}
-EXPORT_SYMBOL_GPL(nfs_fs_mount);
-
 /*
  * Destroy an NFS2/3 superblock
  */
@@ -1391,17 +1264,6 @@ void nfs_kill_super(struct super_block *s)
 }
 EXPORT_SYMBOL_GPL(nfs_kill_super);
 
-/*
- * Internal use only: mount_info is already set up by caller.
- * Used for mountpoint crossings and for nfs4 root.
- */
-static struct dentry *
-nfs_prepared_mount(struct file_system_type *fs_type, int flags,
-		   const char *dev_name, void *raw_data)
-{
-	return nfs_fs_mount_common(flags, dev_name, raw_data);
-}
-
 #if IS_ENABLED(CONFIG_NFS_V4)
 
 /*
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 82bdb91da2ae..ed9f215d03ea 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1622,6 +1622,7 @@ struct nfs_subversion;
 struct nfs_mount_info;
 struct nfs_client_initdata;
 struct nfs_pageio_descriptor;
+struct fs_context;
 
 /*
  * RPC procedure vector for NFSv2/NFSv3 demuxing
@@ -1636,9 +1637,8 @@ struct nfs_rpc_ops {
 
 	int	(*getroot) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fsinfo *);
-	struct vfsmount *(*submount) (struct nfs_server *, struct dentry *,
-				      struct nfs_fh *, struct nfs_fattr *);
-	struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *);
+	int	(*submount) (struct fs_context *, struct nfs_server *);
+	int	(*try_get_tree) (struct fs_context *);
 	int	(*getattr) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fattr *, struct nfs4_label *,
 			    struct inode *);
@@ -1705,7 +1705,7 @@ struct nfs_rpc_ops {
 	struct nfs_client *(*init_client) (struct nfs_client *,
 				const struct nfs_client_initdata *);
 	void	(*free_client) (struct nfs_client *);
-	struct nfs_server *(*create_server)(struct nfs_mount_info *);
+	struct nfs_server *(*create_server)(struct fs_context *);
 	struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *,
 					   struct nfs_fattr *, rpc_authflavor_t);
 };

