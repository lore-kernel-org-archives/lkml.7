Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7276B213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfCVFYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:24:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45712 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727577AbfCVFXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:17 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-00015w-Lg; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001oS-GN; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Vasily Averin" <vvs@virtuozzo.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.783254154@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 04/16] sunrpc: use-after-free in svc_process_common()
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit d4b09acf924b84bae77cad090a9d108e70b43643 upstream.

if node have NFSv41+ mounts inside several net namespaces
it can lead to use-after-free in svc_process_common()

svc_process_common()
        /* Setup reply header */
        rqstp->rq_xprt->xpt_ops->xpo_prep_reply_hdr(rqstp); <<< HERE

svc_process_common() can use incorrect rqstp->rq_xprt,
its caller function bc_svc_process() takes it from serv->sv_bc_xprt.
The problem is that serv is global structure but sv_bc_xprt
is assigned per-netnamespace.

According to Trond, the whole "let's set up rqstp->rq_xprt
for the back channel" is nothing but a giant hack in order
to work around the fact that svc_process_common() uses it
to find the xpt_ops, and perform a couple of (meaningless
for the back channel) tests of xpt_flags.

All we really need in svc_process_common() is to be able to run
rqstp->rq_xprt->xpt_ops->xpo_prep_reply_hdr()

Bruce J Fields points that this xpo_prep_reply_hdr() call
is an awfully roundabout way just to do "svc_putnl(resv, 0);"
in the tcp case.

This patch does not initialiuze rqstp->rq_xprt in bc_svc_process(),
now it calls svc_process_common() with rqstp->rq_xprt = NULL.

To adjust reply header svc_process_common() just check
rqstp->rq_prot and calls svc_tcp_prep_reply_hdr() for tcp case.

To handle rqstp->rq_xprt = NULL case in functions called from
svc_process_common() patch intruduces net namespace pointer
svc_rqst->rq_bc_net and adjust SVC_NET() definition.
Some other function was also adopted to properly handle described case.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Fixes: 23c20ecd4475 ("NFS: callback up - users counting cleanup")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
v2: - added lost extern svc_tcp_prep_reply_hdr()
    - context changes in svc_process_common()
    - dropped trace_svc_process() changes
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/sunrpc/svc.h |  5 ++++-
 net/sunrpc/svc.c           | 10 +++++++---
 net/sunrpc/svc_xprt.c      |  5 +++--
 net/sunrpc/svcsock.c       |  2 +-
 4 files changed, 15 insertions(+), 7 deletions(-)

--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -282,9 +282,12 @@ struct svc_rqst {
 						 * cache pages */
 	wait_queue_head_t	rq_wait;	/* synchronization */
 	struct task_struct	*rq_task;	/* service thread */
+	struct net		*rq_bc_net;	/* pointer to backchannel's
+						 * net namespace
+						 */
 };
 
-#define SVC_NET(svc_rqst)	(svc_rqst->rq_xprt->xpt_net)
+#define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
 
 /*
  * Rigorous type checking on sockaddr type conversions
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1063,6 +1063,8 @@ void svc_printk(struct svc_rqst *rqstp,
 static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...) {}
 #endif
 
+extern void svc_tcp_prep_reply_hdr(struct svc_rqst *);
+
 /*
  * Common routine for processing the RPC request.
  */
@@ -1092,7 +1094,8 @@ svc_process_common(struct svc_rqst *rqst
 	rqstp->rq_dropme = false;
 
 	/* Setup reply header */
-	rqstp->rq_xprt->xpt_ops->xpo_prep_reply_hdr(rqstp);
+	if (rqstp->rq_prot == IPPROTO_TCP)
+		svc_tcp_prep_reply_hdr(rqstp);
 
 	svc_putu32(resv, rqstp->rq_xid);
 
@@ -1139,7 +1142,8 @@ svc_process_common(struct svc_rqst *rqst
 	case SVC_DENIED:
 		goto err_bad_auth;
 	case SVC_CLOSE:
-		if (test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
+		if (rqstp->rq_xprt &&
+		    test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
 			svc_close_xprt(rqstp->rq_xprt);
 	case SVC_DROP:
 		goto dropit;
@@ -1354,10 +1358,10 @@ bc_svc_process(struct svc_serv *serv, st
 	struct kvec	*resv = &rqstp->rq_res.head[0];
 
 	/* Build the svc_rqst used by the common processing routine */
-	rqstp->rq_xprt = serv->sv_bc_xprt;
 	rqstp->rq_xid = req->rq_xid;
 	rqstp->rq_prot = req->rq_xprt->prot;
 	rqstp->rq_server = serv;
+	rqstp->rq_bc_net = req->rq_xprt->xprt_net;
 
 	rqstp->rq_addrlen = sizeof(req->rq_xprt->addr);
 	memcpy(&rqstp->rq_addr, &req->rq_xprt->addr, rqstp->rq_addrlen);
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -432,10 +432,11 @@ static struct svc_xprt *svc_xprt_dequeue
  */
 void svc_reserve(struct svc_rqst *rqstp, int space)
 {
+	struct svc_xprt *xprt = rqstp->rq_xprt;
+
 	space += rqstp->rq_res.head[0].iov_len;
 
-	if (space < rqstp->rq_reserved) {
-		struct svc_xprt *xprt = rqstp->rq_xprt;
+	if (xprt && space < rqstp->rq_reserved) {
 		atomic_sub((rqstp->rq_reserved - space), &xprt->xpt_reserved);
 		rqstp->rq_reserved = space;
 
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1195,7 +1195,7 @@ static int svc_tcp_sendto(struct svc_rqs
 /*
  * Setup response header. TCP has a 4B record length field.
  */
-static void svc_tcp_prep_reply_hdr(struct svc_rqst *rqstp)
+void svc_tcp_prep_reply_hdr(struct svc_rqst *rqstp)
 {
 	struct kvec *resv = &rqstp->rq_res.head[0];
 

