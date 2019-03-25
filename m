Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B19207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfCYRH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:07:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:50798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729414AbfCYRH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:07:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE0B6AFB8;
        Mon, 25 Mar 2019 17:07:57 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 8CB01E1404; Mon, 25 Mar 2019 18:07:57 +0100 (CET)
Message-Id: <16ffb1fbfa8f54de587ac52f4ff95e5034c590b4.1553532199.git.mkubecek@suse.cz>
In-Reply-To: <cover.1553532199.git.mkubecek@suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v5 01/22] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 18:07:57 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permanent hardware address of a network device was traditionally provided
via ethtool ioctl interface but as Jiri Pirko pointed out in a review of
ethtool netlink interface, rtnetlink is much more suitable for it so let's
add it to the RTM_NEWLINK message.

As permanent address is not modifiable, reject userspace requests
containing IFLA_PERM_ADDRESS attribute.

Note: we already provide permanent hardware address for bond slaves;
unfortunately we cannot drop that attribute for backward compatibility
reasons.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 include/uapi/linux/if_link.h | 1 +
 net/core/rtnetlink.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 5b225ff63b48..351ef746b8b0 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -167,6 +167,7 @@ enum {
 	IFLA_NEW_IFINDEX,
 	IFLA_MIN_MTU,
 	IFLA_MAX_MTU,
+	IFLA_PERM_ADDRESS,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a51cab95ba64..a72e8f4d777b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1026,6 +1026,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4)  /* IFLA_CARRIER_DOWN_COUNT */
 	       + nla_total_size(4)  /* IFLA_MIN_MTU */
 	       + nla_total_size(4)  /* IFLA_MAX_MTU */
+	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
 	       + 0;
 }
 
@@ -1683,6 +1684,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	    nla_put_s32(skb, IFLA_NEW_IFINDEX, new_ifindex) < 0)
 		goto nla_put_failure;
 
+	if (nla_put(skb, IFLA_PERM_ADDRESS, dev->addr_len, dev->perm_addr))
+		goto nla_put_failure;
 
 	rcu_read_lock();
 	if (rtnl_fill_link_af(skb, dev, ext_filter_mask))
@@ -1742,6 +1745,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_CARRIER_DOWN_COUNT] = { .type = NLA_U32 },
 	[IFLA_MIN_MTU]		= { .type = NLA_U32 },
 	[IFLA_MAX_MTU]		= { .type = NLA_U32 },
+	[IFLA_PERM_ADDRESS]	= { .type = NLA_REJECT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.21.0

