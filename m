Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90512087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfCYRIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:08:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:51364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730390AbfCYRIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:08:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BBAEB01C;
        Mon, 25 Mar 2019 17:08:49 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 0948EE1404; Mon, 25 Mar 2019 18:08:49 +0100 (CET)
Message-Id: <bf037dd3511328f6cb8a92884058ab5eac8c812a.1553532199.git.mkubecek@suse.cz>
In-Reply-To: <cover.1553532199.git.mkubecek@suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v5 18/22] ethtool: provide link state in GET_SETTINGS
 request
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 18:08:49 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about device link state (as provided by ETHTOOL_GLINK ioctl
command) into the GET_SETTINGS reply when ETH_SETTINGS_IM_LINKSTATE flag is
set in the request.

Note: we cannot use NLA_FLAG for link state as we need three states: off,
on and unknown. The attribute is also encapsulated in a nest to allow
future extensions.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/networking/ethtool-netlink.txt |  5 ++-
 include/uapi/linux/ethtool_netlink.h         | 13 ++++++-
 net/ethtool/common.c                         |  8 +++++
 net/ethtool/common.h                         |  1 +
 net/ethtool/ioctl.c                          |  8 ++---
 net/ethtool/settings.c                       | 37 ++++++++++++++++++++
 6 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
index e79ae9fe01be..ebd1a0404828 100644
--- a/Documentation/networking/ethtool-netlink.txt
+++ b/Documentation/networking/ethtool-netlink.txt
@@ -277,6 +277,7 @@ Info mask bits meaning:
 
     ETH_SETTINGS_IM_LINKINFO		link settings
     ETH_SETTINGS_IM_LINKMODES		link modes and related
+    ETH_SETTINGS_IM_LINKSTATE		link state
 
 Response contents:
 
@@ -293,6 +294,8 @@ Response contents:
         ETHA_LINKMODES_PEER		(bitset)	partner link modes
         ETHA_LINKMODES_SPEED		(u32)		link speed (Mb/s)
         ETHA_LINKMODES_DUPLEX		(u8)		duplex mode
+    ETHA_SETTINGS_LINK_STATE	(nested)	link state
+        ETHA_LINKSTATE_LINK		(u8)		link on/off/unknown
 
 Most of the attributes and their values have the same meaning as matching
 members of the corresponding ioctl structures. For ETHA_LINKMODES_OURS,
@@ -350,7 +353,7 @@ ETHTOOL_SWOL			n/a
 ETHTOOL_GMSGLVL			n/a
 ETHTOOL_SMSGLVL			n/a
 ETHTOOL_NWAY_RST		n/a
-ETHTOOL_GLINK			n/a
+ETHTOOL_GLINK			ETHNL_CMD_GET_SETTINGS
 ETHTOOL_GEEPROM			n/a
 ETHTOOL_SEEPROM			n/a
 ETHTOOL_GCOALESCE		n/a
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 895ba9cd8924..45c27c7291d0 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -196,6 +196,7 @@ enum {
 	ETHA_SETTINGS_COMPACT,			/* flag */
 	ETHA_SETTINGS_LINK_INFO,		/* nest - ETHA_LINKINFO_* */
 	ETHA_SETTINGS_LINK_MODES,		/* nest - ETHA_LINKMODES_* */
+	ETHA_SETTINGS_LINK_STATE,		/* nest - ETHA_LINKSTATE_* */
 
 	__ETHA_SETTINGS_CNT,
 	ETHA_SETTINGS_MAX = (__ETHA_SETTINGS_CNT - 1)
@@ -203,9 +204,11 @@ enum {
 
 #define ETH_SETTINGS_IM_LINKINFO		(1U << 0)
 #define ETH_SETTINGS_IM_LINKMODES		(1U << 1)
+#define ETH_SETTINGS_IM_LINKSTATE		(1U << 2)
 
 #define ETH_SETTINGS_IM_ALL (ETH_SETTINGS_IM_LINKINFO | \
-			     ETH_SETTINGS_IM_LINKMODES)
+			     ETH_SETTINGS_IM_LINKMODES | \
+			     ETH_SETTINGS_IM_LINKSTATE)
 
 enum {
 	ETHA_LINKINFO_UNSPEC,
@@ -231,6 +234,14 @@ enum {
 	ETHA_LINKMODES_MAX = (__ETHA_LINKMODES_CNT - 1)
 };
 
+enum {
+	ETHA_LINKSTATE_UNSPEC,
+	ETHA_LINKSTATE_LINK,			/* u8 */
+
+	__ETHA_LINKSTATE_CNT,
+	ETHA_LINKSTATE_MAX = (__ETHA_LINKSTATE_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index a91a4f00d275..dc907d8b6e43 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -205,3 +205,11 @@ convert_legacy_settings_to_link_ksettings(
 		= legacy_settings->eth_tp_mdix_ctrl;
 	return retval;
 }
+
+int __ethtool_get_link(struct net_device *dev)
+{
+	if (!dev->ethtool_ops->get_link)
+		return -EOPNOTSUPP;
+
+	return netif_running(dev) && dev->ethtool_ops->get_link(dev);
+}
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 7a3e0b10e69a..a5ddd7f5cfce 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -17,6 +17,7 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN];
 
 int __ethtool_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info);
 int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
+int __ethtool_get_link(struct net_device *dev);
 
 bool convert_legacy_settings_to_link_ksettings(
 	struct ethtool_link_ksettings *link_ksettings,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index be3e34ac8cc7..58669dafeaf9 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1318,12 +1318,12 @@ static int ethtool_nway_reset(struct net_device *dev)
 static int ethtool_get_link(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata = { .cmd = ETHTOOL_GLINK };
+	int link = __ethtool_get_link(dev);
 
-	if (!dev->ethtool_ops->get_link)
-		return -EOPNOTSUPP;
-
-	edata.data = netif_running(dev) && dev->ethtool_ops->get_link(dev);
+	if (link < 0)
+		return link;
 
+	edata.data = link;
 	if (copy_to_user(useraddr, &edata, sizeof(edata)))
 		return -EFAULT;
 	return 0;
diff --git a/net/ethtool/settings.c b/net/ethtool/settings.c
index 2e0f425029ef..7a2729f01f79 100644
--- a/net/ethtool/settings.c
+++ b/net/ethtool/settings.c
@@ -11,6 +11,7 @@ struct settings_data {
 	struct common_reply_data	repdata_base;
 	struct ethtool_link_ksettings	ksettings;
 	struct ethtool_link_settings	*lsettings;
+	int				link;
 	bool				lpm_empty;
 };
 
@@ -112,6 +113,7 @@ static const struct nla_policy get_settings_policy[ETHA_SETTINGS_MAX + 1] = {
 	[ETHA_SETTINGS_COMPACT]		= { .type = NLA_FLAG },
 	[ETHA_SETTINGS_LINK_INFO]	= { .type = NLA_REJECT },
 	[ETHA_SETTINGS_LINK_MODES]	= { .type = NLA_REJECT },
+	[ETHA_SETTINGS_LINK_STATE]	= { .type = NLA_REJECT },
 };
 
 static int parse_settings(struct common_req_info *req_info,
@@ -168,6 +170,7 @@ static int prepare_settings(struct common_req_info *req_info,
 
 	data->lsettings = &data->ksettings.base;
 	data->lpm_empty = true;
+	data->link = -EOPNOTSUPP;
 
 	ret = ethnl_before_ops(dev);
 	if (ret < 0)
@@ -189,6 +192,8 @@ static int prepare_settings(struct common_req_info *req_info,
 		ethnl_bitmap_to_u32(data->ksettings.link_modes.lp_advertising,
 				    __ETHTOOL_LINK_MODE_MASK_NWORDS);
 	}
+	if (req_mask & ETH_SETTINGS_IM_LINKSTATE)
+		data->link = __ethtool_get_link(dev);
 	ethnl_after_ops(dev);
 
 	data->repdata_base.info_mask = req_mask;
@@ -237,6 +242,13 @@ static int link_modes_size(const struct ethtool_link_ksettings *ksettings,
 	return nla_total_size(len);
 }
 
+static int link_state_size(int link)
+{
+	if (link < 0)
+		return nla_total_size(0);
+	return nla_total_size(nla_total_size(sizeof(u8)));
+}
+
 /* To keep things simple, reserve space for some attributes which may not
  * be added to the message (e.g. ETHA_SETTINGS_SOPASS); therefore the length
  * returned may be bigger than the actual length of the message sent
@@ -258,6 +270,8 @@ static int settings_size(const struct common_req_info *req_info)
 			return ret;
 		len += ret;
 	}
+	if (info_mask & ETH_SETTINGS_IM_LINKSTATE)
+		len += link_state_size(data->link);
 
 	return len;
 }
@@ -330,6 +344,23 @@ static int fill_link_modes(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int fill_link_state(struct sk_buff *skb, u8 link)
+{
+	struct nlattr *nest;
+
+	nest = ethnl_nest_start(skb, ETHA_SETTINGS_LINK_STATE);
+	if (!nest)
+		return -EMSGSIZE;
+	if (link >=0 && nla_put_u8(skb, ETHA_LINKSTATE_LINK, link))
+		goto err;
+	nla_nest_end(skb, nest);
+	return 0;
+
+err:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
 static int fill_settings(struct sk_buff *skb,
 			 const struct common_req_info *req_info)
 {
@@ -350,6 +381,11 @@ static int fill_settings(struct sk_buff *skb,
 		if (ret < 0)
 			return ret;
 	}
+	if (info_mask & ETH_SETTINGS_IM_LINKSTATE) {
+		ret = fill_link_state(skb, data->link);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
@@ -394,6 +430,7 @@ static const struct nla_policy set_settings_policy[ETHA_SETTINGS_MAX + 1] = {
 	[ETHA_SETTINGS_COMPACT]		= { .type = NLA_FLAG },
 	[ETHA_SETTINGS_LINK_INFO]	= { .type = NLA_NESTED },
 	[ETHA_SETTINGS_LINK_MODES]	= { .type = NLA_NESTED },
+	[ETHA_SETTINGS_LINK_STATE]	= { .type = NLA_REJECT },
 };
 
 static int ethnl_set_link_ksettings(struct genl_info *info,
-- 
2.21.0

