Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12994C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44592087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfCYRIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:08:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729489AbfCYRIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:08:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7BF6AFBB;
        Mon, 25 Mar 2019 17:08:03 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 99CA5E1404; Mon, 25 Mar 2019 18:08:03 +0100 (CET)
Message-Id: <3a0ca34890256f86a4ca0c4f4582a0cff5af95ad.1553532199.git.mkubecek@suse.cz>
In-Reply-To: <cover.1553532199.git.mkubecek@suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v5 03/22] netlink: add strict version of
 nla_parse_nested()
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 18:08:03 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to nla_parse_strict() and nlmsg_parse_strict(), add also
nla_parse_nested_strict() as a version of nla_parse_nested() with strict
policy checking.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 include/net/netlink.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index bc0497076bec..723139637ba4 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -913,6 +913,15 @@ static inline int nla_parse_nested(struct nlattr *tb[], int maxtype,
 			 extack);
 }
 
+static inline int nla_parse_nested_strict(struct nlattr *tb[], int maxtype,
+					  const struct nlattr *nla,
+					  const struct nla_policy *policy,
+					  struct netlink_ext_ack *extack)
+{
+	return nla_parse_strict(tb, maxtype, nla_data(nla), nla_len(nla),
+				policy, extack);
+}
+
 /**
  * nla_put_u8 - Add a u8 netlink attribute to a socket buffer
  * @skb: socket buffer to add attribute to
-- 
2.21.0

