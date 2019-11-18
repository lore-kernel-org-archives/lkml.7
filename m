Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CB8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C601F20727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKRMJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:09:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:43636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbfKRMJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:09:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4F92B218;
        Mon, 18 Nov 2019 12:09:38 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH] osd: add new 'copy-from-notrunc' operation
Date:   Mon, 18 Nov 2019 12:09:34 +0000
Message-Id: <20191118120935.7013-2-lhenriques@suse.com>
In-Reply-To: <20191118120935.7013-1-lhenriques@suse.com>
References: <20191118120935.7013-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new 'copy-from-notrunc' is very similar to the 'copy-from' operation,
except that it receives 2 extra parameters: truncate_seq and
truncate_size.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 src/include/rados.h     |  1 +
 src/osd/OSD.cc          |  3 ++-
 src/osd/PrimaryLogPG.cc | 24 +++++++++++++++++++-----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/src/include/rados.h b/src/include/rados.h
index 44cbacffcad8..bba0168c5f07 100644
--- a/src/include/rados.h
+++ b/src/include/rados.h
@@ -297,6 +297,7 @@ extern const char *ceph_osd_state_name(int s);
 									    \
 	/* tiering */							    \
 	f(COPY_FROM,	__CEPH_OSD_OP(WR, DATA, 26),	"copy-from")	    \
+	f(COPY_FROM_NOTRUNC, __CEPH_OSD_OP(WR, DATA, 45), "copy-from-notrunc") \
 	/* was copy-get-classic */					\
 	f(UNDIRTY,	__CEPH_OSD_OP(WR, DATA, 28),	"undirty")	    \
 	f(ISDIRTY,	__CEPH_OSD_OP(RD, DATA, 29),	"isdirty")	    \
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 6b592ff85bfa..1d34bc683562 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -9919,7 +9919,8 @@ int OSD::init_op_flags(OpRequestRef& op)
             (iter->op.op != CEPH_OSD_OP_RMXATTR) &&
             (iter->op.op != CEPH_OSD_OP_STARTSYNC) &&
             (iter->op.op != CEPH_OSD_OP_COPY_GET) &&
-            (iter->op.op != CEPH_OSD_OP_COPY_FROM)) {
+            (iter->op.op != CEPH_OSD_OP_COPY_FROM) &&
+	    (iter->op.op != CEPH_OSD_OP_COPY_FROM_NOTRUNC)) {
           op->set_promote();
         }
       }
diff --git a/src/osd/PrimaryLogPG.cc b/src/osd/PrimaryLogPG.cc
index 2ef4ebf8b6cf..e4f884476fc0 100644
--- a/src/osd/PrimaryLogPG.cc
+++ b/src/osd/PrimaryLogPG.cc
@@ -282,9 +282,11 @@ public:
   PrimaryLogPG::CopyResults *results = nullptr;
   PrimaryLogPG::OpContext *ctx;
   OSDOp &osd_op;
+  uint32_t truncate_seq;
+  uint64_t truncate_size;
 
-  CopyFromCallback(PrimaryLogPG::OpContext *ctx, OSDOp &osd_op)
-    : ctx(ctx), osd_op(osd_op) {
+  CopyFromCallback(PrimaryLogPG::OpContext *ctx, OSDOp &osd_op, uint32_t seq, uint64_t size)
+    : ctx(ctx), osd_op(osd_op), truncate_seq(seq), truncate_size(size) {
   }
   ~CopyFromCallback() override {}
 
@@ -292,6 +294,10 @@ public:
     results = results_.get<1>();
     int r = results_.get<0>();
 
+    if (osd_op.op.op != CEPH_OSD_OP_COPY_FROM_NOTRUNC) {
+      truncate_seq = results->truncate_seq;
+      truncate_size = results->truncate_size;
+    }
     // for finish_copyfrom
     ctx->user_at_version = results->user_version;
 
@@ -5668,6 +5674,7 @@ int PrimaryLogPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
     case CEPH_OSD_OP_CACHE_TRY_FLUSH:
     case CEPH_OSD_OP_UNDIRTY:
     case CEPH_OSD_OP_COPY_FROM:  // we handle user_version update explicitly
+    case CEPH_OSD_OP_COPY_FROM_NOTRUNC:
     case CEPH_OSD_OP_CACHE_PIN:
     case CEPH_OSD_OP_CACHE_UNPIN:
     case CEPH_OSD_OP_SET_REDIRECT:
@@ -7664,17 +7671,24 @@ int PrimaryLogPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
       }
       break;
 
+    case CEPH_OSD_OP_COPY_FROM_NOTRUNC:
     case CEPH_OSD_OP_COPY_FROM:
       ++ctx->num_write;
       result = 0;
       {
 	object_t src_name;
 	object_locator_t src_oloc;
+	uint32_t truncate_seq = 0;
+	uint64_t truncate_size = 0;
 	snapid_t src_snapid = (uint64_t)op.copy_from.snapid;
 	version_t src_version = op.copy_from.src_version;
 	try {
 	  decode(src_name, bp);
 	  decode(src_oloc, bp);
+	  if (op.op == CEPH_OSD_OP_COPY_FROM_NOTRUNC) {
+	    decode(truncate_seq, bp);
+	    decode(truncate_size, bp);
+	  }
 	}
 	catch (buffer::error& e) {
 	  result = -EINVAL;
@@ -7714,7 +7728,7 @@ int PrimaryLogPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
 	    result = -EINVAL;
 	    break;
 	  }
-	  CopyFromCallback *cb = new CopyFromCallback(ctx, osd_op);
+	  CopyFromCallback *cb = new CopyFromCallback(ctx, osd_op, truncate_seq, truncate_size);
           ctx->op_finishers[ctx->current_osd_subop_num].reset(
             new CopyFromFinisher(cb));
 	  start_copy(cb, ctx->obc, src, src_oloc, src_version,
@@ -9546,8 +9560,8 @@ void PrimaryLogPG::finish_copyfrom(CopyFromCallback *cb)
     obs.oi.clear_omap_digest();
   }
 
-  obs.oi.truncate_seq = cb->results->truncate_seq;
-  obs.oi.truncate_size = cb->results->truncate_size;
+  obs.oi.truncate_seq = cb->truncate_seq;
+  obs.oi.truncate_size = cb->truncate_size;
 
   obs.oi.mtime = ceph::real_clock::to_timespec(cb->results->mtime);
   ctx->mtime = utime_t();
