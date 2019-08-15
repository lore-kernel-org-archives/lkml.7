Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5832BC32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222C02063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfHOCg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 22:36:57 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:35441 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbfHOCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 22:36:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2E38C83777EE;
        Thu, 15 Aug 2019 02:36:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plane66_590520a5a0e1f
X-Filterd-Recvd-Size: 18134
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Aug 2019 02:36:51 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Move comments after /* fallthrough */
Date:   Wed, 14 Aug 2019 19:36:49 -0700
Message-Id: <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code a bit easier for a script to appropriately convert
case statement blocks with /* fallthrough */ comments to a macro by
moving comments describing the next case block to the case statement.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/afs/cmservice.c | 10 +++-------
 fs/afs/fsclient.c  | 51 +++++++++++++++++----------------------------------
 fs/afs/vlclient.c  | 50 +++++++++++++++++++++++++-------------------------
 fs/afs/yfsclient.c | 51 +++++++++++++++++----------------------------------
 4 files changed, 62 insertions(+), 100 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index b86195e4dc6c..2270fe9325da 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -282,10 +282,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 	case 0:
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
-
-		/* extract the FID array and its count in two steps */
 		/* fall through */
-	case 1:
+	case 1:		/* extract the FID array and its count in two steps */
 		_debug("extract FID count");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -329,9 +327,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the callback array and its count in two steps */
 		/* fall through */
-	case 3:
+	case 3:		/* extract the callback array & count in two steps */
 		_debug("extract CB count");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -651,9 +648,8 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the FID array and its count in two steps */
 		/* Fall through */
-	case 1:
+	case 1:		/* extract the FID array and its count in two steps */
 		_debug("extract FID count");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 114f281f3687..d9dc1bdfa695 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -341,8 +341,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		}
 		/* Fall through */
 
-		/* extract the returned data length */
-	case 1:
+	case 1:		/* extract the returned data length */
 		_debug("extract data length");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -369,8 +368,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		ASSERTCMP(size, <=, PAGE_SIZE);
 		/* Fall through */
 
-		/* extract the returned data */
-	case 2:
+	case 2:		/* extract the returned data */
 		_debug("extract data %zu/%llu",
 		       iov_iter_count(&call->iter), req->remain);
 
@@ -411,8 +409,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		afs_extract_to_buf(call, (21 + 3 + 6) * 4);
 		/* Fall through */
 
-		/* extract the metadata */
-	case 4:
+	case 4:		/* extract the metadata */
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
@@ -1476,8 +1473,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_to_buf(call, 12 * 4);
 		/* Fall through */
 
-		/* extract the returned status record */
-	case 1:
+	case 1:		/* extract the returned status record */
 		_debug("extract status");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1489,8 +1485,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		/* Fall through */
 
-		/* extract the volume name length */
-	case 2:
+	case 2:		/* extract the volume name length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -1505,8 +1500,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the volume name */
-	case 3:
+	case 3:		/* extract the volume name */
 		_debug("extract volname");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1519,8 +1513,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the offline message length */
-	case 4:
+	case 4:		/* extract the offline message length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -1535,8 +1528,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the offline message */
-	case 5:
+	case 5:		/* extract the offline message */
 		_debug("extract offline");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1550,8 +1542,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the message of the day length */
-	case 6:
+	case 6:		/* extract the message of the day length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -1566,8 +1557,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the message of the day */
-	case 7:
+	case 7:		/* extract the message of the day */
 		_debug("extract motd");
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -1862,8 +1852,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* Extract the capabilities word count */
-	case 1:
+	case 1:		/* Extract the capabilities word count */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -1876,8 +1865,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* Extract capabilities words */
-	case 2:
+	case 2:		/* Extract capabilities words */
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
@@ -2034,8 +2022,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* Extract the file status count and array in two steps */
-	case 1:
+	case 1:		/* Extract the file status count & array in two steps */
 		_debug("extract status count");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -2074,8 +2061,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		/* Fall through */
 
-		/* Extract the callback count and array in two steps */
-	case 3:
+	case 3:		/* Extract the callback count & array in two steps */
 		_debug("extract CB count");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -2207,8 +2193,7 @@ static int afs_deliver_fs_fetch_acl(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the returned data length */
-	case 1:
+	case 1:		/* extract the returned data length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -2225,8 +2210,7 @@ static int afs_deliver_fs_fetch_acl(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the returned data */
-	case 2:
+	case 2:		/* extract the returned data */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -2235,8 +2219,7 @@ static int afs_deliver_fs_fetch_acl(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the metadata */
-	case 3:
+	case 3:		/* extract the metadata */
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index cfb0ac4bd039..c0b327ff0005 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -193,10 +193,10 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 				   sizeof(struct afs_uuid__xdr) + 3 * sizeof(__be32));
 		call->unmarshall++;
 
-		/* Extract the returned uuid, uniquifier, nentries and
-		 * blkaddrs size */
 		/* Fall through */
-	case 1:
+	case 1:		/* Extract the returned uuid, uniquifier, nentries and
+			 * blkaddrs size
+			 */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -220,8 +220,8 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		count = min(call->count, 4U);
 		afs_extract_to_buf(call, count * sizeof(__be32));
 
-		/* Fall through - and extract entries */
-	case 2:
+		/* Fall through */
+	case 2:		/* extract entries */
 		ret = afs_extract_data(call, call->count > 4);
 		if (ret < 0)
 			return ret;
@@ -323,8 +323,8 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* Fall through - and extract the capabilities word count */
-	case 1:
+		/* Fall through */
+	case 1:		/* extract the capabilities word count */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -336,8 +336,8 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		call->unmarshall++;
 		afs_extract_discard(call, count * sizeof(__be32));
 
-		/* Fall through - and extract capabilities words */
-	case 2:
+		/* Fall through */
+	case 2:		/*  extract capabilities words */
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
@@ -431,12 +431,12 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 	case 0:
 		afs_extract_to_buf(call, sizeof(uuid_t) + 3 * sizeof(__be32));
 		call->unmarshall = 1;
-
-		/* Extract the returned uuid, uniquifier, fsEndpoints count and
-		 * either the first fsEndpoint type or the volEndpoints
-		 * count if there are no fsEndpoints. */
 		/* Fall through */
-	case 1:
+	case 1:		/* Extract the returned uuid, uniquifier,
+			 * fsEndpoints count and either the first fsEndpoint
+			 * type or the volEndpoints count if there are no
+			 * fsEndpoints.
+			 */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -476,8 +476,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		afs_extract_to_buf(call, size);
 		call->unmarshall = 2;
 
-		/* Fall through - and extract fsEndpoints[] entries */
-	case 2:
+		/* Fall through */
+	case 2:		/* extract fsEndpoints[] entries */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -525,12 +525,12 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		afs_extract_to_buf(call, 1 * sizeof(__be32));
 		call->unmarshall = 3;
 
-		/* Extract the type of volEndpoints[0].  Normally we would
-		 * extract the type of the next endpoint when we extract the
-		 * data of the current one, but this is the first...
-		 */
 		/* Fall through */
-	case 3:
+	case 3:		/* Extract the type of volEndpoints[0].
+			 * Normally we would extract the type of the
+			 * next endpoint when we extract the data of
+			 * the current one, but this is the first...
+			 */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -556,8 +556,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		afs_extract_to_buf(call, size);
 		call->unmarshall = 4;
 
-		/* Fall through - and extract volEndpoints[] entries */
-	case 4:
+		/* Fall through */
+	case 4:		/* extract volEndpoints[] entries */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -592,8 +592,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		afs_extract_discard(call, 0);
 		call->unmarshall = 5;
 
-		/* Fall through - Done */
-	case 5:
+		/* Fall through */
+	case 5:		/* Done */
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 2575503170fc..77cf878e6a25 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -452,8 +452,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the returned data length */
-	case 1:
+	case 1:		/* extract the returned data length */
 		_debug("extract data length");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -480,8 +479,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		ASSERTCMP(size, <=, PAGE_SIZE);
 		/* Fall through */
 
-		/* extract the returned data */
-	case 2:
+	case 2:		/* extract the returned data */
 		_debug("extract data %zu/%llu",
 		       iov_iter_count(&call->iter), req->remain);
 
@@ -525,8 +523,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 				   sizeof(struct yfs_xdr_YFSVolSync));
 		/* Fall through */
 
-		/* extract the metadata */
-	case 4:
+	case 4:		/* extract the metadata */
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
@@ -1434,8 +1431,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSFetchVolumeStatus));
 		/* Fall through */
 
-		/* extract the returned status record */
-	case 1:
+	case 1:		/* extract the returned status record */
 		_debug("extract status");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1447,8 +1443,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		/* Fall through */
 
-		/* extract the volume name length */
-	case 2:
+	case 2:		/* extract the volume name length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -1463,8 +1458,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the volume name */
-	case 3:
+	case 3:		/* extract the volume name */
 		_debug("extract volname");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1477,8 +1471,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the offline message length */
-	case 4:
+	case 4:		/* extract the offline message length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -1493,8 +1486,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the offline message */
-	case 5:
+	case 5:		/* extract the offline message */
 		_debug("extract offline");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1508,8 +1500,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the message of the day length */
-	case 6:
+	case 6:		/* extract the message of the day length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -1524,8 +1515,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the message of the day */
-	case 7:
+	case 7:		/* extract the message of the day */
 		_debug("extract motd");
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -1817,8 +1807,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* Extract the file status count and array in two steps */
-	case 1:
+	case 1:		/* Extract the file status count & array in two steps */
 		_debug("extract status count");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1857,8 +1846,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		/* Fall through */
 
-		/* Extract the callback count and array in two steps */
-	case 3:
+	case 3:		/* Extract the callback count & array in two steps */
 		_debug("extract CB count");
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1990,8 +1978,7 @@ static int yfs_deliver_fs_fetch_opaque_acl(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* Extract the file ACL length */
-	case 1:
+	case 1:		/* Extract the file ACL length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -2012,8 +1999,7 @@ static int yfs_deliver_fs_fetch_opaque_acl(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* Extract the file ACL */
-	case 2:
+	case 2:		/* Extract the file ACL */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -2022,8 +2008,7 @@ static int yfs_deliver_fs_fetch_opaque_acl(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* Extract the volume ACL length */
-	case 3:
+	case 3:		/* Extract the volume ACL length */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -2044,8 +2029,7 @@ static int yfs_deliver_fs_fetch_opaque_acl(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* Extract the volume ACL */
-	case 4:
+	case 4:		/* Extract the volume ACL */
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
@@ -2057,8 +2041,7 @@ static int yfs_deliver_fs_fetch_opaque_acl(struct afs_call *call)
 		call->unmarshall++;
 		/* Fall through */
 
-		/* extract the metadata */
-	case 5:
+	case 5:		/* extract the metadata */
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
-- 
2.15.0

