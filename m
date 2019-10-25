Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956D8CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746492070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfJYSG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:06:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46594 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731320AbfJYSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:05:41 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iO3xv-0008OI-KG; Fri, 25 Oct 2019 19:05:35 +0100
Received: from ben by deadeye with local (Exim 4.92.2)
        (envelope-from <ben@decadent.org.uk>)
        id 1iO3xv-0001i2-0q; Fri, 25 Oct 2019 19:05:35 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jeremy Sowden" <jeremy@azazel.net>,
        syzbot+4f0529365f7f2208d9f0@syzkaller.appspotmail.com,
        "Steffen Klassert" <steffen.klassert@secunet.com>
Date:   Fri, 25 Oct 2019 19:03:08 +0100
Message-ID: <lsq.1572026582.240053415@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 07/47] af_key: fix leaks in key_pol_get_resp and dump_sp.
In-Reply-To: <lsq.1572026581.992411028@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.76-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Sowden <jeremy@azazel.net>

commit 7c80eb1c7e2b8420477fbc998971d62a648035d9 upstream.

In both functions, if pfkey_xfrm_policy2msg failed we leaked the newly
allocated sk_buff.  Free it on error.

Fixes: 55569ce256ce ("Fix conversion between IPSEC_MODE_xxx and XFRM_MODE_xxx.")
Reported-by: syzbot+4f0529365f7f2208d9f0@syzkaller.appspotmail.com
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/key/af_key.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2437,8 +2437,10 @@ static int key_pol_get_resp(struct sock
 		goto out;
 	}
 	err = pfkey_xfrm_policy2msg(out_skb, xp, dir);
-	if (err < 0)
+	if (err < 0) {
+		kfree_skb(out_skb);
 		goto out;
+	}
 
 	out_hdr = (struct sadb_msg *) out_skb->data;
 	out_hdr->sadb_msg_version = hdr->sadb_msg_version;
@@ -2689,8 +2691,10 @@ static int dump_sp(struct xfrm_policy *x
 		return PTR_ERR(out_skb);
 
 	err = pfkey_xfrm_policy2msg(out_skb, xp, dir);
-	if (err < 0)
+	if (err < 0) {
+		kfree_skb(out_skb);
 		return err;
+	}
 
 	out_hdr = (struct sadb_msg *) out_skb->data;
 	out_hdr->sadb_msg_version = pfk->dump.msg_version;

