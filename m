Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB264C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935642075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfCUNk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:40:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728299AbfCUNkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:40:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63186AF67;
        Thu, 21 Mar 2019 13:40:24 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 14E0DE00BF; Thu, 21 Mar 2019 14:40:24 +0100 (CET)
Message-Id: <2f5584ba0a74bb84e96a3ae1cc3a92ee7a6f79c1.1553170807.git.mkubecek@suse.cz>
In-Reply-To: <cover.1553170807.git.mkubecek@suse.cz>
References: <cover.1553170807.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v4 02/22] netlink: introduce nla_put_bitfield32()
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Mar 2019 14:40:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other data types, this helper puts NLA_BITFIELD32 attribute into
a netlink message. It takes separate value and selector arguments, if there
is a struct nla_bitfield32 already, one can use nla_put().

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 include/net/netlink.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 23f27b0b3cef..bc0497076bec 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1211,6 +1211,21 @@ static inline int nla_put_in6_addr(struct sk_buff *skb, int attrtype,
 	return nla_put(skb, attrtype, sizeof(*addr), addr);
 }
 
+/**
+ * nla_put_bitfield32 - Add a bitfield32 value/selector attribute to
+ * a socket buffer
+ * @skb: socket buffer to add attribute to
+ * @value: 32-bit value bitmap
+ * @selector: 32-bit selector bitmap
+ */
+static inline int nla_put_bitfield32(struct sk_buff *skb, int attrtype,
+				     u32 value, u32 selector)
+{
+	struct nla_bitfield32 tmp = { .value = value, .selector = selector };
+
+	return nla_put(skb, attrtype, sizeof(tmp), &tmp);
+}
+
 /**
  * nla_get_u32 - return payload of u32 attribute
  * @nla: u32 netlink attribute
-- 
2.21.0

