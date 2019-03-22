Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51EA2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254263;
	bh=+FCC+5oticSxeie/FGSW78QIyJdUHcnxzmYbDY1qrT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jEjNR4yQzFDehhElgRa1hqK+dfCdvVbPn90mBNJRdV/YheoTEUMI2IfZ1/T0iVC6n
	 DGNKGfFul8Vh0FxycPyg/HahaWxSBDTwc8GR22qrbkGEiwsPd0vnOS17vvg5hgLMf4
	 XYMuQxVB2bcTqfBcJCFNUIh7iba6h2hYikbktGHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfCVLbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbfCVLbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276CD20449;
        Fri, 22 Mar 2019 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254258;
        bh=+FCC+5oticSxeie/FGSW78QIyJdUHcnxzmYbDY1qrT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaJPtnL4rFwr59PEeOe51o0IrGPEeqmL4gPiQ5ueJsHwOLE8ipBZCYozxic6+lLDX
         f3hMqCaEtiUFY5nrlg9DDAZoLA+80Rh6Yo6q0b54kbcBhOtB4+bw9mt2bXqr652BVa
         yl7PG+aQEhVAevC+QHAcqJytQZ2dQ6d7kcAOe5qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Eremin <dmitry.eremin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>
Subject: [PATCH 4.4 062/230] staging: lustre: fix buffer overflow of string buffer
Date:   Fri, 22 Mar 2019 12:13:20 +0100
Message-Id: <20190322111241.046874731@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Eremin <dmitry.eremin@intel.com>

commit 9563fe8a2de9db5eb087fe0e48ec335ee66f8f41 upstream.

Buffer overflow of string buffer due to non null terminated string.
Use strlcpy() when it's justifiable.
Use sizeof(var) instead of constants.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-4629
Reviewed-on: http://review.whamcloud.com/9389
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c |    9 +++++----
 drivers/staging/lustre/lnet/lnet/config.c           |   14 ++++++++------
 drivers/staging/lustre/lnet/selftest/conrpc.c       |    4 ++--
 drivers/staging/lustre/lnet/selftest/console.c      |    6 ++++--
 drivers/staging/lustre/lustre/include/lustre_disk.h |    1 +
 drivers/staging/lustre/lustre/libcfs/debug.c        |    6 +++---
 drivers/staging/lustre/lustre/libcfs/hash.c         |    3 +--
 drivers/staging/lustre/lustre/libcfs/workitem.c     |    4 ++--
 drivers/staging/lustre/lustre/llite/dir.c           |    2 +-
 drivers/staging/lustre/lustre/lov/lov_pool.c        |    3 +--
 drivers/staging/lustre/lustre/obdclass/obd_mount.c  |   10 +++++++---
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c      |    1 +
 drivers/staging/lustre/lustre/ptlrpc/sec_config.c   |    3 +--
 13 files changed, 37 insertions(+), 29 deletions(-)

--- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
+++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
@@ -2621,8 +2621,8 @@ ksocknal_enumerate_interfaces(ksock_net_
 
 		net->ksnn_interfaces[j].ksni_ipaddr = ip;
 		net->ksnn_interfaces[j].ksni_netmask = mask;
-		strncpy(&net->ksnn_interfaces[j].ksni_name[0],
-			names[i], IFNAMSIZ);
+		strlcpy(net->ksnn_interfaces[j].ksni_name,
+			names[i], sizeof(net->ksnn_interfaces[j].ksni_name));
 		j++;
 	}
 
@@ -2805,8 +2805,9 @@ ksocknal_startup(lnet_ni_t *ni)
 				goto fail_1;
 			}
 
-			strncpy(&net->ksnn_interfaces[i].ksni_name[0],
-				ni->ni_interfaces[i], IFNAMSIZ);
+			strlcpy(net->ksnn_interfaces[i].ksni_name,
+				ni->ni_interfaces[i],
+				sizeof(net->ksnn_interfaces[i].ksni_name));
 		}
 		net->ksnn_ninterfaces = i;
 	}
--- a/drivers/staging/lustre/lnet/lnet/config.c
+++ b/drivers/staging/lustre/lnet/lnet/config.c
@@ -650,8 +650,8 @@ lnet_parse_route(char *str, int *im_a_ro
 	INIT_LIST_HEAD(&nets);
 
 	/* save a copy of the string for error messages */
-	strncpy(cmd, str, sizeof(cmd) - 1);
-	cmd[sizeof(cmd) - 1] = 0;
+	strncpy(cmd, str, sizeof(cmd));
+	cmd[sizeof(cmd) - 1] = '\0';
 
 	sep = str;
 	for (;;) {
@@ -972,11 +972,13 @@ lnet_splitnets(char *source, struct list
 			return 0;
 
 		offset += (int)(sep - tb->ltb_text);
-		tb2 = lnet_new_text_buf(strlen(sep));
+		len = strlen(sep);
+		tb2 = lnet_new_text_buf(len);
 		if (tb2 == NULL)
 			return -ENOMEM;
 
-		strcpy(tb2->ltb_text, sep);
+		strncpy(tb2->ltb_text, sep, len);
+		tb2->ltb_text[len] = '\0';
 		list_add_tail(&tb2->ltb_list, nets);
 
 		tb = tb2;
@@ -1021,8 +1023,8 @@ lnet_match_networks(char **networksp, ch
 		tb = list_entry(raw_entries.next, struct lnet_text_buf_t,
 				    ltb_list);
 
-		strncpy(source, tb->ltb_text, sizeof(source)-1);
-		source[sizeof(source)-1] = 0;
+		strncpy(source, tb->ltb_text, sizeof(source));
+		source[sizeof(source)-1] = '\0';
 
 		/* replace ltb_text with the network(s) add on match */
 		rc = lnet_match_network_tokens(tb->ltb_text, ipaddrs, nip);
--- a/drivers/staging/lustre/lnet/selftest/conrpc.c
+++ b/drivers/staging/lustre/lnet/selftest/conrpc.c
@@ -612,8 +612,8 @@ lstcon_sesrpc_prep(lstcon_node_t *nd, in
 		msrq = &(*crpc)->crp_rpc->crpc_reqstmsg.msg_body.mksn_reqst;
 		msrq->mksn_sid     = console_session.ses_id;
 		msrq->mksn_force   = console_session.ses_force;
-		strncpy(msrq->mksn_name, console_session.ses_name,
-			strlen(console_session.ses_name));
+		strlcpy(msrq->mksn_name, console_session.ses_name,
+			sizeof(msrq->mksn_name));
 		break;
 
 	case LST_TRANS_SESEND:
--- a/drivers/staging/lustre/lnet/selftest/console.c
+++ b/drivers/staging/lustre/lnet/selftest/console.c
@@ -1739,7 +1739,8 @@ lstcon_session_new(char *name, int key,
 	console_session.ses_feats_updated = 0;
 	console_session.ses_timeout = (timeout <= 0) ?
 				      LST_CONSOLE_TIMEOUT : timeout;
-	strcpy(console_session.ses_name, name);
+	strlcpy(console_session.ses_name, name,
+		sizeof(console_session.ses_name));
 
 	rc = lstcon_batch_add(LST_DEFAULT_BATCH);
 	if (rc != 0)
@@ -1959,7 +1960,8 @@ lstcon_acceptor_handle(srpc_server_rpc_t
 	if (grp->grp_userland == 0)
 		grp->grp_userland = 1;
 
-	strcpy(jrep->join_session, console_session.ses_name);
+	strlcpy(jrep->join_session, console_session.ses_name,
+		sizeof(jrep->join_session));
 	jrep->join_timeout = console_session.ses_timeout;
 	jrep->join_status  = 0;
 
--- a/drivers/staging/lustre/lustre/include/lustre_disk.h
+++ b/drivers/staging/lustre/lustre/include/lustre_disk.h
@@ -68,6 +68,7 @@
    everything as string options */
 
 #define LMD_MAGIC    0xbdacbd03
+#define LMD_PARAMS_MAXLEN	4096
 
 /* gleaned from the mount command - no persistent info here */
 struct lustre_mount_data {
--- a/drivers/staging/lustre/lustre/libcfs/debug.c
+++ b/drivers/staging/lustre/lustre/libcfs/debug.c
@@ -512,9 +512,9 @@ int libcfs_debug_init(unsigned long bufs
 	}
 
 	if (libcfs_debug_file_path != NULL) {
-		strncpy(libcfs_debug_file_path_arr,
-			libcfs_debug_file_path, PATH_MAX-1);
-		libcfs_debug_file_path_arr[PATH_MAX - 1] = '\0';
+		strlcpy(libcfs_debug_file_path_arr,
+			libcfs_debug_file_path,
+			sizeof(libcfs_debug_file_path_arr));
 	}
 
 	/* If libcfs_debug_mb is set to an invalid value or uninitialized
--- a/drivers/staging/lustre/lustre/libcfs/hash.c
+++ b/drivers/staging/lustre/lustre/libcfs/hash.c
@@ -1062,8 +1062,7 @@ cfs_hash_create(char *name, unsigned cur
 	if (hs == NULL)
 		return NULL;
 
-	strncpy(hs->hs_name, name, len);
-	hs->hs_name[len - 1] = '\0';
+	strlcpy(hs->hs_name, name, len);
 	hs->hs_flags = flags;
 
 	atomic_set(&hs->hs_refcount, 1);
--- a/drivers/staging/lustre/lustre/libcfs/workitem.c
+++ b/drivers/staging/lustre/lustre/libcfs/workitem.c
@@ -360,8 +360,8 @@ cfs_wi_sched_create(char *name, struct c
 	if (sched == NULL)
 		return -ENOMEM;
 
-	strncpy(sched->ws_name, name, CFS_WS_NAME_LEN);
-	sched->ws_name[CFS_WS_NAME_LEN - 1] = '\0';
+	strlcpy(sched->ws_name, name, CFS_WS_NAME_LEN);
+
 	sched->ws_cptab = cptab;
 	sched->ws_cpt = cpt;
 
--- a/drivers/staging/lustre/lustre/llite/dir.c
+++ b/drivers/staging/lustre/lustre/llite/dir.c
@@ -641,7 +641,7 @@ static int ll_send_mgc_param(struct obd_
 	if (!msp)
 		return -ENOMEM;
 
-	strncpy(msp->mgs_param, string, MGS_PARAM_MAXLEN);
+	strlcpy(msp->mgs_param, string, sizeof(msp->mgs_param));
 	rc = obd_set_info_async(NULL, mgc, sizeof(KEY_SET_INFO), KEY_SET_INFO,
 				sizeof(struct mgs_send_param), msp, NULL);
 	if (rc)
--- a/drivers/staging/lustre/lustre/lov/lov_pool.c
+++ b/drivers/staging/lustre/lustre/lov/lov_pool.c
@@ -412,8 +412,7 @@ int lov_pool_new(struct obd_device *obd,
 	if (!new_pool)
 		return -ENOMEM;
 
-	strncpy(new_pool->pool_name, poolname, LOV_MAXPOOLNAME);
-	new_pool->pool_name[LOV_MAXPOOLNAME] = '\0';
+	strlcpy(new_pool->pool_name, poolname, sizeof(new_pool->pool_name));
 	new_pool->pool_lobd = obd;
 	/* ref count init to 1 because when created a pool is always used
 	 * up to deletion
--- a/drivers/staging/lustre/lustre/obdclass/obd_mount.c
+++ b/drivers/staging/lustre/lustre/obdclass/obd_mount.c
@@ -892,7 +892,7 @@ static int lmd_parse(char *options, stru
 	}
 	lmd->lmd_magic = LMD_MAGIC;
 
-	lmd->lmd_params = kzalloc(4096, GFP_NOFS);
+	lmd->lmd_params = kzalloc(LMD_PARAMS_MAXLEN, GFP_NOFS);
 	if (!lmd->lmd_params)
 		return -ENOMEM;
 	lmd->lmd_params[0] = '\0';
@@ -978,7 +978,7 @@ static int lmd_parse(char *options, stru
 				goto invalid;
 			clear++;
 		} else if (strncmp(s1, "param=", 6) == 0) {
-			int length;
+			size_t length, params_length;
 			char *tail = strchr(s1 + 6, ',');
 
 			if (tail == NULL)
@@ -986,8 +986,12 @@ static int lmd_parse(char *options, stru
 			else
 				length = tail - s1;
 			length -= 6;
+			params_length = strlen(lmd->lmd_params);
+			if (params_length + length + 1 >= LMD_PARAMS_MAXLEN)
+				return -E2BIG;
 			strncat(lmd->lmd_params, s1 + 6, length);
-			strcat(lmd->lmd_params, " ");
+			lmd->lmd_params[params_length + length] = '\0';
+			strlcat(lmd->lmd_params, " ", LMD_PARAMS_MAXLEN);
 			clear++;
 		} else if (strncmp(s1, "osd=", 4) == 0) {
 			rc = lmd_parse_string(&lmd->lmd_osd_type, s1 + 4);
--- a/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
@@ -422,6 +422,7 @@ static int ptlrpcd(void *arg)
 	complete(&pc->pc_starting);
 
 	/*
+
 	 * This mainloop strongly resembles ptlrpc_set_wait() except that our
 	 * set never completes.  ptlrpcd_check() calls ptlrpc_check_set() when
 	 * there are requests in the set. New requests come in on the set's
--- a/drivers/staging/lustre/lustre/ptlrpc/sec_config.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/sec_config.c
@@ -83,8 +83,7 @@ int sptlrpc_parse_flavor(const char *str
 		return 0;
 	}
 
-	strncpy(buf, str, sizeof(buf));
-	buf[sizeof(buf) - 1] = '\0';
+	strlcpy(buf, str, sizeof(buf));
 
 	bulk = strchr(buf, '-');
 	if (bulk)


