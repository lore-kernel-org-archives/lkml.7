Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2439C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8433D208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bv/Pbeuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfCHQNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:13:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33948 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCHQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:13:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28G9Qj4092684;
        Fri, 8 Mar 2019 16:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=hPCfQBMX170CXcGX6JASR8q0UVC740Re3OWUrvJyUpA=;
 b=Bv/PbeukB4gUyhKFX6gyHj3788yhwO5u5X00LSS2AVAiIz8aCGkIDD4pIOIXY8/jmB3Y
 AODSM2CJeTQ+ilrz0ricsc2V0pOX0fdPDc+jDoB7arllF3y1fLJ1vjqndyTqEGY++fRr
 vDYBPziWzEl+b/BeKv7LlFwWUgIPKDE1j3F0+npaKijfLfdh/YwuCqVFcscaxkJeuXq+
 8fRsUR5xYjD5d1lvgA/rSFyTlD/Ily5hCfFMkMYTgJZzV6MjKEGW5NRaF6NUmliqTsq8
 c+hNxJJkCo099N1TXn3ERebWh4fsXJhetKqLkLSrLaP7AWQaEC4Rwd5IDz8ElVixUn8k Tw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qyjfs10js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 16:13:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x28GDDF0013320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 16:13:13 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x28GDDor003528;
        Fri, 8 Mar 2019 16:13:13 GMT
Received: from localhost (/10.159.130.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 08:13:12 -0800
Date:   Fri, 8 Mar 2019 08:13:08 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-xfs@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH] xfs: clean up xfs_dir2_leafn_add
Message-ID: <20190308161308.GC4676@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9189 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=766 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Remove typedefs and consolidate local variable initialization.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_dir2_node.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
index de46f26c5292..16731d2d684b 100644
--- a/fs/xfs/libxfs/xfs_dir2_node.c
+++ b/fs/xfs/libxfs/xfs_dir2_node.c
@@ -426,26 +426,22 @@ xfs_dir2_leaf_to_node(
 static int					/* error */
 xfs_dir2_leafn_add(
 	struct xfs_buf		*bp,		/* leaf buffer */
-	xfs_da_args_t		*args,		/* operation arguments */
+	struct xfs_da_args	*args,		/* operation arguments */
 	int			index)		/* insertion pt for new entry */
 {
+	struct xfs_dir3_icleaf_hdr leafhdr;
+	struct xfs_inode	*dp = args->dp;
+	struct xfs_dir2_leaf	*leaf = bp->b_addr;
+	struct xfs_dir2_leaf_entry *lep;
+	struct xfs_dir2_leaf_entry *ents;
 	int			compact;	/* compacting stale leaves */
-	xfs_inode_t		*dp;		/* incore directory inode */
-	int			highstale;	/* next stale entry */
-	xfs_dir2_leaf_t		*leaf;		/* leaf structure */
-	xfs_dir2_leaf_entry_t	*lep;		/* leaf entry */
+	int			highstale = 0;	/* next stale entry */
 	int			lfloghigh;	/* high leaf entry logging */
 	int			lfloglow;	/* low leaf entry logging */
-	int			lowstale;	/* previous stale entry */
-	struct xfs_dir3_icleaf_hdr leafhdr;
-	struct xfs_dir2_leaf_entry *ents;
+	int			lowstale = 0;	/* previous stale entry */
 
 	trace_xfs_dir2_leafn_add(args, index);
 
-	dp = args->dp;
-	leaf = bp->b_addr;
-	highstale = 0;
-	lowstale = 0;
 	dp->d_ops->leaf_hdr_from_disk(&leafhdr, leaf);
 	ents = dp->d_ops->leaf_ents_p(leaf);
 
