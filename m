Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6534C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECCA20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfDBNpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:45:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43406 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731467AbfDBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:08 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002oo-LH; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004x5-O0; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dominique Martinet" <dominique.martinet@cea.fr>,
        syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        "Latchesar Ionkov" <lucho@ionkov.net>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.916471264@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 82/99] 9p/net: put a lower bound on msize
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dominique Martinet <dominique.martinet@cea.fr>

commit 574d356b7a02c7e1b01a1d9cba8a26b3c2888f45 upstream.

If the requested msize is too small (either from command line argument
or from the server version reply), we won't get any work done.
If it's *really* too small, nothing will work, and this got caught by
syzbot recently (on a new kmem_cache_create_usercopy() call)

Just set a minimum msize to 4k in both code paths, until someone
complains they have a use-case for a smaller msize.

We need to check in both mount option and server reply individually
because the msize for the first version request would be unchecked
with just a global check on clnt->msize.

Link: http://lkml.kernel.org/r/1541407968-31350-1-git-send-email-asmadeus@codewreck.org
Reported-by: syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/9p/client.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -155,6 +155,12 @@ static int parse_opts(char *opts, struct
 				ret = r;
 				continue;
 			}
+			if (option < 4096) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "msize should be at least 4k\n");
+				ret = -EINVAL;
+				continue;
+			}
 			clnt->msize = option;
 			break;
 		case Opt_trans:
@@ -980,10 +986,18 @@ static int p9_client_version(struct p9_c
 	else if (!strncmp(version, "9P2000", 6))
 		c->proto_version = p9_proto_legacy;
 	else {
+		p9_debug(P9_DEBUG_ERROR,
+			 "server returned an unknown version: %s\n", version);
 		err = -EREMOTEIO;
 		goto error;
 	}
 
+	if (msize < 4096) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "server returned a msize < 4096: %d\n", msize);
+		err = -EREMOTEIO;
+		goto error;
+	}
 	if (msize < c->msize)
 		c->msize = msize;
 
@@ -1048,6 +1062,13 @@ struct p9_client *p9_client_create(const
 	if (clnt->msize > clnt->trans_mod->maxsize)
 		clnt->msize = clnt->trans_mod->maxsize;
 
+	if (clnt->msize < 4096) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "Please specify a msize of at least 4k\n");
+		err = -EINVAL;
+		goto free_client;
+	}
+
 	err = p9_client_version(clnt);
 	if (err)
 		goto close_trans;

