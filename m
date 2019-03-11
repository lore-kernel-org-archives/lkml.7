Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DF72084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iTN3/uV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfCKQUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:20:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59074 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:20:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BGJVe5110686;
        Mon, 11 Mar 2019 16:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=n6Mc/pIyRxKJquEGA+zfhNGg7HTntORVqLlWN5uTjbs=;
 b=iTN3/uV8Hc63yfZl8VzmDjWMHivwVw4g7mgEK1z8e6/gfDA7iS2lDyq82qm13oOu3Kes
 VpHlAWwn+qJ2Q9RHRguJBnuLPb/8BsUqMi3DqGVzQ5+uaca0q8SdKf+ZGPUEPSW1tuYE
 +pj+Kl0TJfAOWzFVUeBAj6z7xdzuEaEl+Fi8Sh5gGgtiLYTmJB7+8IHthGsQFJ76KxxG
 VMLw+TB9+Rlyu9fkT1d5PrQZ+GsyBnrw2btmAu8v+/kfNq0a5uyPWXaRbpkFReX6eQ59
 eJT8fXw8d6fDDEIq/wWDI24DMTMTSaar5u+HV631P+oidDdQv0fVS9/uCt8qCaOC9GOP Mw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r430efyrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 16:19:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2BGJrYH029487
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 16:19:53 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2BGJr5D011004;
        Mon, 11 Mar 2019 16:19:53 GMT
Received: from localhost (/10.159.224.240)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 16:19:52 +0000
Date:   Mon, 11 Mar 2019 09:19:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-xfs@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 1/2] xfs: zero initialize highstale and lowstale in
 xfs_dir2_leaf_addname
Message-ID: <20190311161948.GC4359@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=890 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Smatch complains about the following:

fs/xfs/libxfs/xfs_dir2_leaf.c:848 xfs_dir2_leaf_addname() error:
uninitialized symbol 'lowstale'.

fs/xfs/libxfs/xfs_dir2_leaf.c:849 xfs_dir2_leaf_addname() error:
uninitialized symbol 'highstale'.

I don't think there's any incorrect behavior associated with the
uninitialized variable, but as the author of the previous zero-init
patch points out, it's best not to be passing around pointers to
uninitialized stack areas.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_dir2_leaf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_leaf.c b/fs/xfs/libxfs/xfs_dir2_leaf.c
index 9a3767818c50..2abf945e5844 100644
--- a/fs/xfs/libxfs/xfs_dir2_leaf.c
+++ b/fs/xfs/libxfs/xfs_dir2_leaf.c
@@ -574,7 +574,7 @@ xfs_dir2_leaf_addname(
 	xfs_dir2_data_unused_t	*dup;		/* data unused entry */
 	int			error;		/* error return value */
 	int			grown;		/* allocated new data block */
-	int			highstale;	/* index of next stale leaf */
+	int			highstale = 0;	/* index of next stale leaf */
 	int			i;		/* temporary, index */
 	int			index;		/* leaf table position */
 	struct xfs_buf		*lbp;		/* leaf's buffer */
@@ -583,7 +583,7 @@ xfs_dir2_leaf_addname(
 	xfs_dir2_leaf_entry_t	*lep;		/* leaf entry table pointer */
 	int			lfloglow;	/* low leaf logging index */
 	int			lfloghigh;	/* high leaf logging index */
-	int			lowstale;	/* index of prev stale leaf */
+	int			lowstale = 0;	/* index of prev stale leaf */
 	xfs_dir2_leaf_tail_t	*ltp;		/* leaf tail pointer */
 	int			needbytes;	/* leaf block bytes needed */
 	int			needlog;	/* need to log data header */
