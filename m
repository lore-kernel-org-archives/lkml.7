Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F97C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACBE2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfLITze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:55:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:43400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfLITzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:55:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4966AAF84;
        Mon,  9 Dec 2019 19:55:30 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id F0642E0321; Mon,  9 Dec 2019 20:55:29 +0100 (CET)
Message-Id: <4ed84a09e72ce1521ef7552f0a528ae0be343b4a.1575920565.git.mkubecek@suse.cz>
In-Reply-To: <cover.1575920565.git.mkubecek@suse.cz>
References: <cover.1575920565.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next 2/5] netlink: rename nl80211_validate_nested() to
 nla_validate_nested()
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Date:   Mon,  9 Dec 2019 20:55:29 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function nl80211_validate_nested() is not specific to nl80211, it's
a counterpart to nla_validate_nested_deprecated() with strict validation.
For consistency with other validation and parse functions, rename it to
nla_validate_nested().

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
---
 include/net/netlink.h  | 8 ++++----
 net/wireless/nl80211.c | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index b140c8f1be22..56c365dc6dc7 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1735,7 +1735,7 @@ static inline void nla_nest_cancel(struct sk_buff *skb, struct nlattr *start)
 }
 
 /**
- * nla_validate_nested - Validate a stream of nested attributes
+ * __nla_validate_nested - Validate a stream of nested attributes
  * @start: container attribute
  * @maxtype: maximum attribute type to be expected
  * @policy: validation policy
@@ -1758,9 +1758,9 @@ static inline int __nla_validate_nested(const struct nlattr *start, int maxtype,
 }
 
 static inline int
-nl80211_validate_nested(const struct nlattr *start, int maxtype,
-			const struct nla_policy *policy,
-			struct netlink_ext_ack *extack)
+nla_validate_nested(const struct nlattr *start, int maxtype,
+		    const struct nla_policy *policy,
+		    struct netlink_ext_ack *extack)
 {
 	return __nla_validate_nested(start, maxtype, policy,
 				     NL_VALIDATE_STRICT, extack);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index da5262b2298b..fa3526592c51 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12900,8 +12900,7 @@ static int nl80211_vendor_check_policy(const struct wiphy_vendor_command *vcmd,
 		return -EINVAL;
 	}
 
-	return nl80211_validate_nested(attr, vcmd->maxattr, vcmd->policy,
-				       extack);
+	return nla_validate_nested(attr, vcmd->maxattr, vcmd->policy, extack);
 }
 
 static int nl80211_vendor_cmd(struct sk_buff *skb, struct genl_info *info)
-- 
2.24.0

