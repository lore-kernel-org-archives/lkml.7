Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E80C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60906218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbfJJKeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:34:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:52624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfJJKeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:34:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1557CB187;
        Thu, 10 Oct 2019 10:34:03 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 36408E378C; Thu, 10 Oct 2019 12:34:02 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v2] genetlink: do not parse attributes for families
 with zero maxattr
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20191010103402.36408E378C@unicorn.suse.cz>
Date:   Thu, 10 Oct 2019 12:34:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c10e6cf85e7d ("net: genetlink: push attrbuf allocation and parsing
to a separate function") moved attribute buffer allocation and attribute
parsing from genl_family_rcv_msg_doit() into a separate function
genl_family_rcv_msg_attrs_parse() which, unlike the previous code, calls
__nlmsg_parse() even if family->maxattr is 0 (i.e. the family does its own
parsing). The parser error is ignored and does not propagate out of
genl_family_rcv_msg_attrs_parse() but an error message ("Unknown attribute
type") is set in extack and if further processing generates no error or
warning, it stays there and is interpreted as a warning by userspace.

Dumpit requests are not affected as genl_family_rcv_msg_dumpit() bypasses
the call of genl_family_rcv_msg_doit() if family->maxattr is zero. Do the
same also in genl_family_rcv_msg_doit().

Fixes: c10e6cf85e7d ("net: genetlink: push attrbuf allocation and parsing to a separate function")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/netlink/genetlink.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index ecc2bd3e73e4..1f14e55ad3ad 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -639,21 +639,23 @@ static int genl_family_rcv_msg_doit(const struct genl_family *family,
 				    const struct genl_ops *ops,
 				    int hdrlen, struct net *net)
 {
-	struct nlattr **attrbuf;
+	struct nlattr **attrbuf = NULL;
 	struct genl_info info;
 	int err;
 
 	if (!ops->doit)
 		return -EOPNOTSUPP;
 
+	if (!family->maxattr)
+		goto no_attrs;
 	attrbuf = genl_family_rcv_msg_attrs_parse(family, nlh, extack,
 						  ops, hdrlen,
 						  GENL_DONT_VALIDATE_STRICT,
-						  family->maxattr &&
 						  family->parallel_ops);
 	if (IS_ERR(attrbuf))
 		return PTR_ERR(attrbuf);
 
+no_attrs:
 	info.snd_seq = nlh->nlmsg_seq;
 	info.snd_portid = NETLINK_CB(skb).portid;
 	info.nlhdr = nlh;
@@ -676,8 +678,7 @@ static int genl_family_rcv_msg_doit(const struct genl_family *family,
 		family->post_doit(ops, skb, &info);
 
 out:
-	genl_family_rcv_msg_attrs_free(family, attrbuf,
-				       family->maxattr && family->parallel_ops);
+	genl_family_rcv_msg_attrs_free(family, attrbuf, family->parallel_ops);
 
 	return err;
 }
-- 
2.23.0

