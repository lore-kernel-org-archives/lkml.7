Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0FC04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6CA206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEBOPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:15:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbfEBOPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C0B0AD8C;
        Thu,  2 May 2019 14:15:11 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id CD0F5E00D0; Thu,  2 May 2019 16:15:10 +0200 (CEST)
Message-Id: <5368071b5e287d50cf3a93805746217a2f36ff69.1556806084.git.mkubecek@suse.cz>
In-Reply-To: <cover.1556806084.git.mkubecek@suse.cz>
References: <cover.1556806084.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v2 1/3] genetlink: do not validate dump requests if
 there is no policy
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org
Date:   Thu,  2 May 2019 16:15:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike do requests, dump genetlink requests now perform strict validation
by default even if the genetlink family does not set policy and maxtype
because it does validation and parsing on its own (e.g. because it wants to
allow different message format for different commands). While the null
policy will be ignored, maxtype (which would be zero) is still checked so
that any attribute will fail validation.

The solution is to only call __nla_validate() from genl_family_rcv_msg()
if family->maxtype is set.

Fixes: ef6243acb478 ("genetlink: optionally validate strictly/dumps")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
---
 net/netlink/genetlink.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 72668759cd2b..9814d6dbd2d6 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -537,21 +537,25 @@ static int genl_family_rcv_msg(const struct genl_family *family,
 			return -EOPNOTSUPP;
 
 		if (!(ops->validate & GENL_DONT_VALIDATE_DUMP)) {
-			unsigned int validate = NL_VALIDATE_STRICT;
 			int hdrlen = GENL_HDRLEN + family->hdrsize;
 
-			if (ops->validate & GENL_DONT_VALIDATE_DUMP_STRICT)
-				validate = NL_VALIDATE_LIBERAL;
-
 			if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
 				return -EINVAL;
 
-			rc = __nla_validate(nlmsg_attrdata(nlh, hdrlen),
-					    nlmsg_attrlen(nlh, hdrlen),
-					    family->maxattr, family->policy,
-					    validate, extack);
-			if (rc)
-				return rc;
+			if (family->maxattr) {
+				unsigned int validate = NL_VALIDATE_STRICT;
+
+				if (ops->validate &
+				    GENL_DONT_VALIDATE_DUMP_STRICT)
+					validate = NL_VALIDATE_LIBERAL;
+				rc = __nla_validate(nlmsg_attrdata(nlh, hdrlen),
+						    nlmsg_attrlen(nlh, hdrlen),
+						    family->maxattr,
+						    family->policy,
+						    validate, extack);
+				if (rc)
+					return rc;
+			}
 		}
 
 		if (!family->parallel_ops) {
-- 
2.21.0

