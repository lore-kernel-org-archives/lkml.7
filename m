Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B82C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA8A207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfCYRJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:09:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:51466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730458AbfCYRJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:09:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70F1EB022;
        Mon, 25 Mar 2019 17:08:58 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1D11AE1404; Mon, 25 Mar 2019 18:08:58 +0100 (CET)
Message-Id: <2eb71652408bf0cd97194069f68d264cf8070693.1553532199.git.mkubecek@suse.cz>
In-Reply-To: <cover.1553532199.git.mkubecek@suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v5 21/22] ethtool: provide message level in
 GET_SETTINGS request
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 18:08:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about supported and enabled message levels to the
GET_SETTINGS reply when ETH_SETTINGS_IM_DEBUG flag is set in the
request.

Unlike in the ioctl interface, "message level" is called "message mask" as
it is in fact interpreted as a bit mask. It is put into a nested attribute
ETHA_SETTINGS_DEBUG to allow future extensions (e.g. an actual verbosity
level).

Send notification in the same format as reply when message level is
modified using the ioctl interface (ETHTOOL_SMSGLVL command).

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/networking/ethtool-netlink.txt |  9 ++++-
 include/linux/netdevice.h                    |  2 +
 include/uapi/linux/ethtool_netlink.h         | 13 ++++++-
 net/ethtool/ioctl.c                          |  3 ++
 net/ethtool/settings.c                       | 40 ++++++++++++++++++++
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
index 3568d35ad7ec..603acfbefe29 100644
--- a/Documentation/networking/ethtool-netlink.txt
+++ b/Documentation/networking/ethtool-netlink.txt
@@ -279,6 +279,7 @@ Info mask bits meaning:
     ETH_SETTINGS_IM_LINKMODES		link modes and related
     ETH_SETTINGS_IM_LINKSTATE		link state
     ETH_SETTINGS_IM_WOL			struct ethtool_wolinfo
+    ETH_SETTINGS_IM_DEBUG		debugging
 
 Response contents:
 
@@ -300,6 +301,8 @@ Response contents:
     ETHA_SETTINGS_WOL		(nested)	wake on LAN settings
         ETHA_WOL_MODES			(bitfield32)	wake on LAN modes
         ETHA_WOL_SOPASS			(binary)	SecureOn(tm) password
+    ETHA_SETTINGS_DEBUG		(nested)	debugging
+        ETHA_DEBUG_MSG_MASK		(bitfield32)	debug message mask
 
 Most of the attributes and their values have the same meaning as matching
 members of the corresponding ioctl structures. For ETHA_LINKMODES_OURS,
@@ -309,6 +312,10 @@ ETHA_LINKMODES_PEER in the reply is a bit list.
 For ETHA_WOL_MODES, selector reports wake on LAN modes supported by the
 device and value enabled modes.
 
+ETHA_DEBUG_MSG_MASK corresponds to message level (which is actually a bitfield)
+as reported by ETHTOOL_GMSGLVL. The selector reports all message types
+recognized by kernel and value types enabled for the device.
+
 GET_SETTINGS request is allowed for unprivileged user but ETHA_WOL_SOPASS
 is only provided by kernel in response to privileged (netns CAP_NET_ADMIN)
 requests.
@@ -371,7 +378,7 @@ ETHTOOL_GDRVINFO		ETHNL_CMD_GET_INFO
 ETHTOOL_GREGS			n/a
 ETHTOOL_GWOL			ETHNL_CMD_GET_SETTINGS
 ETHTOOL_SWOL			ETHNL_CMD_SET_SETTINGS
-ETHTOOL_GMSGLVL			n/a
+ETHTOOL_GMSGLVL			ETHNL_CMD_GET_SETTINGS
 ETHTOOL_SMSGLVL			n/a
 ETHTOOL_NWAY_RST		n/a
 ETHTOOL_GLINK			ETHNL_CMD_GET_SETTINGS
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bc761511edb4..23ebb37769c9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3859,6 +3859,8 @@ enum {
 	NETIF_MSG_PKTDATA	= 0x1000,
 	NETIF_MSG_HW		= 0x2000,
 	NETIF_MSG_WOL		= 0x4000,
+
+	NETIF_MSG_ALL		= 0x7fff,
 };
 
 #define netif_msg_drv(p)	((p)->msg_enable & NETIF_MSG_DRV)
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 532ad11ae87c..924f7059f944 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -198,6 +198,7 @@ enum {
 	ETHA_SETTINGS_LINK_MODES,		/* nest - ETHA_LINKMODES_* */
 	ETHA_SETTINGS_LINK_STATE,		/* nest - ETHA_LINKSTATE_* */
 	ETHA_SETTINGS_WOL,			/* nest - ETHA_WOL_* */
+	ETHA_SETTINGS_DEBUG,			/* nest - ETHA_DEBUG_* */
 
 	__ETHA_SETTINGS_CNT,
 	ETHA_SETTINGS_MAX = (__ETHA_SETTINGS_CNT - 1)
@@ -207,11 +208,13 @@ enum {
 #define ETH_SETTINGS_IM_LINKMODES		(1U << 1)
 #define ETH_SETTINGS_IM_LINKSTATE		(1U << 2)
 #define ETH_SETTINGS_IM_WOL			(1U << 3)
+#define ETH_SETTINGS_IM_DEBUG			(1U << 4)
 
 #define ETH_SETTINGS_IM_ALL (ETH_SETTINGS_IM_LINKINFO | \
 			     ETH_SETTINGS_IM_LINKMODES | \
 			     ETH_SETTINGS_IM_LINKSTATE | \
-			     ETH_SETTINGS_IM_WOL)
+			     ETH_SETTINGS_IM_WOL | \
+			     ETH_SETTINGS_IM_DEBUG)
 
 enum {
 	ETHA_LINKINFO_UNSPEC,
@@ -254,6 +257,14 @@ enum {
 	ETHA_WOL_MAX = (__ETHA_WOL_CNT - 1)
 };
 
+enum {
+	ETHA_DEBUG_UNSPEC,
+	ETHA_DEBUG_MSG_MASK,			/* bitfield32 */
+
+	__ETHA_DEBUG_CNT,
+	ETHA_DEBUG_MAX = (__ETHA_DEBUG_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index bba02a218eea..e94fcd947c87 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2464,6 +2464,9 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 	case ETHTOOL_SMSGLVL:
 		rc = ethtool_set_value_void(dev, useraddr,
 				       dev->ethtool_ops->set_msglevel);
+		if (rc >= 0)
+			ethtool_notify(dev, NULL, ETHNL_CMD_SET_SETTINGS,
+				       ETH_SETTINGS_IM_DEBUG, NULL);
 		break;
 	case ETHTOOL_GEEE:
 		rc = ethtool_get_eee(dev, useraddr);
diff --git a/net/ethtool/settings.c b/net/ethtool/settings.c
index ea5279dad826..53409dd8af34 100644
--- a/net/ethtool/settings.c
+++ b/net/ethtool/settings.c
@@ -14,6 +14,7 @@ struct settings_data {
 	struct ethtool_wolinfo		wolinfo;
 	struct ethtool_link_settings	*lsettings;
 	int				link;
+	u32				msglevel;
 	bool				lpm_empty;
 };
 
@@ -123,6 +124,7 @@ static const struct nla_policy get_settings_policy[ETHA_SETTINGS_MAX + 1] = {
 	[ETHA_SETTINGS_LINK_MODES]	= { .type = NLA_REJECT },
 	[ETHA_SETTINGS_LINK_STATE]	= { .type = NLA_REJECT },
 	[ETHA_SETTINGS_WOL]		= { .type = NLA_REJECT },
+	[ETHA_SETTINGS_DEBUG]		= { .type = NLA_REJECT },
 };
 
 static int parse_settings(struct common_req_info *req_info,
@@ -188,6 +190,7 @@ static int prepare_settings(struct common_req_info *req_info,
 	struct settings_data *data =
 		container_of(req_info, struct settings_data, reqinfo_base);
 	struct net_device *dev = data->repdata_base.dev;
+	const struct ethtool_ops *eops = dev->ethtool_ops;
 	u32 req_mask = req_info->req_mask;
 	int ret;
 
@@ -222,6 +225,12 @@ static int prepare_settings(struct common_req_info *req_info,
 		if (ret < 0)
 			req_mask &= ~ETH_SETTINGS_IM_WOL;
 	}
+	if (req_mask & ETH_SETTINGS_IM_DEBUG) {
+		if (eops->get_msglevel)
+			data->msglevel = eops->get_msglevel(dev);
+		else
+			req_mask &= ~ETH_SETTINGS_IM_DEBUG;
+	}
 	ethnl_after_ops(dev);
 
 	data->repdata_base.info_mask = req_mask;
@@ -283,6 +292,11 @@ static int wol_size(void)
 			      nla_total_size(SOPASS_MAX));
 }
 
+static int debug_size(void)
+{
+	return nla_total_size(nla_total_size(sizeof(struct nla_bitfield32)));
+}
+
 /* To keep things simple, reserve space for some attributes which may not
  * be added to the message (e.g. ETHA_SETTINGS_SOPASS); therefore the length
  * returned may be bigger than the actual length of the message sent
@@ -308,6 +322,8 @@ static int settings_size(const struct common_req_info *req_info)
 		len += link_state_size(data->link);
 	if (info_mask & ETH_SETTINGS_IM_WOL)
 		len += wol_size();
+	if (info_mask & ETH_SETTINGS_IM_DEBUG)
+		len += debug_size();
 
 	return len;
 }
@@ -424,6 +440,24 @@ static int fill_wolinfo(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int fill_debug(struct sk_buff *skb, u32 msglevel)
+{
+	struct nlattr *nest;
+
+	nest = ethnl_nest_start(skb, ETHA_SETTINGS_DEBUG);
+	if (!nest)
+		return -EMSGSIZE;
+	if (nla_put_bitfield32(skb, ETHA_DEBUG_MSG_MASK, msglevel,
+			       NETIF_MSG_ALL))
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
@@ -454,6 +488,11 @@ static int fill_settings(struct sk_buff *skb,
 		if (ret < 0)
 			return ret;
 	}
+	if (info_mask & ETH_SETTINGS_IM_DEBUG) {
+		ret = fill_debug(skb, data->msglevel);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
@@ -508,6 +547,7 @@ static const struct nla_policy set_settings_policy[ETHA_SETTINGS_MAX + 1] = {
 	[ETHA_SETTINGS_LINK_MODES]	= { .type = NLA_NESTED },
 	[ETHA_SETTINGS_LINK_STATE]	= { .type = NLA_REJECT },
 	[ETHA_SETTINGS_WOL]		= { .type = NLA_NESTED },
+	[ETHA_SETTINGS_DEBUG]		= { .type = NLA_REJECT },
 };
 
 static int ethnl_set_link_ksettings(struct genl_info *info,
-- 
2.21.0

