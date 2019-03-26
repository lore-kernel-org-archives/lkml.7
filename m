Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA34C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFB92070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="tZjLOUd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfCZMtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:49:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZMtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:49:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id t124so12725555wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=54g1O2J+gZvw5uCHZaRG3RwISYfT5s0rXJ51ZvlU0PQ=;
        b=tZjLOUd4iLnx46GUhhcMDGghgTpeJwMLRMrRO1qI4x+sd2gyyWxYeHN6UHWPBamGuY
         A1yznvkkUjdTBJMyDE/5KqyuImuSmNsL/9hEPNWT0OGvUXABc+YCpVxw3IJFfDTbzZor
         YHR6BFMn7CAb3o3xMhQz/fvosm1xoOSQOeFSzQzduhlyOQoleW2XuGnUHUh6l92whnWh
         icbrVOJCxk2S8e30XIwq50LATw9oKZKrEzXgwW1GOcOQEkSH+fJdBUlM9Jq72yG6tPjJ
         ay75N818yM796x25LpF7khw5FxdIy80ta1JmjDr1K1htHUeyYnxeAbBL9WhhH85v1akE
         HQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54g1O2J+gZvw5uCHZaRG3RwISYfT5s0rXJ51ZvlU0PQ=;
        b=UKXQYmoaHoVEeegPnWGTy4siaUCGLM0/hHK7iZYDeTtZExl3HRDu1vQD791WbH7COC
         cqL4Prjcwbo3JFe7l1uGK8OdFeOC2e4F3b6tP+FTrEjZePWMlwutcmitY6nfTc9bnVNH
         g6+iYcN1eX+mEbW9ACHLHxLnj2zlyNjjHGlU2evMNeOWynOyDE5VblDSvosk53yL61ar
         d59n2m1YX0LFivvg46oDzIWoeS0GzDL2PmRTwcTP762yudzQHHFAPCDcekSejm1EyZli
         RNFmsUgBTaVo/Dc05PHg0aXVhiQ/oiuxQ/0LkWdFKsvyVFS3IIcdQOd+6FGazWLpuwcV
         x8BA==
X-Gm-Message-State: APjAAAXsQrsGY2cQV1W5gXGDI8RMrUJH/Hx0EGwaT+nwDcMxs8LEZziy
        xAsClaJvID2/76nw3BbVQcMUGQ==
X-Google-Smtp-Source: APXvYqzoovWnyRKchTp0ZmiJCxgwwzkAw47GIyPyJP8Uh/EAsyLRgZOAoVHuj9cZYz59CMn5v3GMeQ==
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr15157727wmi.144.1553604543390;
        Tue, 26 Mar 2019 05:49:03 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id x5sm19695036wru.12.2019.03.26.05.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 05:49:02 -0700 (PDT)
Date:   Tue, 26 Mar 2019 13:38:15 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/22] ethtool: helper functions for netlink
 interface
Message-ID: <20190326123815.GG2230@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <043188fe4776b9420a11116af5e6bad8925b9ee7.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043188fe4776b9420a11116af5e6bad8925b9ee7.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:12PM CET, mkubecek@suse.cz wrote:
>Various helpers used by ethtool netlink code.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---
> include/uapi/linux/ethtool_netlink.h |  11 ++
> net/ethtool/netlink.c                | 144 +++++++++++++++++++++++++++
> net/ethtool/netlink.h                | 144 +++++++++++++++++++++++++++
> 3 files changed, 299 insertions(+)
>
>diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
>index 6aa267451542..59240a2cda56 100644
>--- a/include/uapi/linux/ethtool_netlink.h
>+++ b/include/uapi/linux/ethtool_netlink.h
>@@ -18,6 +18,17 @@ enum {
> 	ETHNL_CMD_MAX = (__ETHNL_CMD_CNT - 1)
> };
> 
>+/* device specification */
>+
>+enum {
>+	ETHA_DEV_UNSPEC,

ETHNL/ETHA looks odd.
I would prefer prefix "ETHTOOL_* for everything in uapi:
ETHTOOL_CMD_* for commands.
ETHTOOL_ATTR_* for attributes.

Looks much nicer.


>+	ETHA_DEV_INDEX,				/* u32 */
>+	ETHA_DEV_NAME,				/* string */
>+
>+	__ETHA_DEV_CNT,
>+	ETHA_DEV_MAX = (__ETHA_DEV_CNT - 1)
>+};
>+
> /* generic netlink info */
> #define ETHTOOL_GENL_NAME "ethtool"
> #define ETHTOOL_GENL_VERSION 1
>diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
>index 85dd6dac71a2..cc6829ba4331 100644
>--- a/net/ethtool/netlink.c
>+++ b/net/ethtool/netlink.c
>@@ -1,8 +1,152 @@
> // SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> 
>+#include <net/sock.h>
> #include <linux/ethtool_netlink.h>
> #include "netlink.h"
> 
>+static const struct nla_policy dev_policy[ETHA_DEV_MAX + 1] = {

ethnl_dev_policy. Please maintain the namespace if possible.
"dev_policy" looks way too generic if anyone sees it in the code.


>+	[ETHA_DEV_UNSPEC]	= { .type = NLA_REJECT },
>+	[ETHA_DEV_INDEX]	= { .type = NLA_U32 },
>+	[ETHA_DEV_NAME]		= { .type = NLA_NUL_STRING,
>+				    .len = IFNAMSIZ - 1 },
>+};
>+
>+/**
>+ * ethnl_dev_get() - get device identified by nested attribute
>+ * @info: genetlink info (also used for extack error reporting)
>+ * @nest: nest attribute with device identification
>+ *
>+ * Finds the network device identified by ETHA_DEV_INDEX (ifindex) or
>+ * ETHA_DEV_NAME (name) attributes in a nested attribute @nest. If both
>+ * are supplied, they must identify the same device. If successful, takes
>+ * a reference to the device which is to be released by caller.
>+ *
>+ * Return: pointer to the device if successful, ERR_PTR(err) on error
>+ */
>+struct net_device *ethnl_dev_get(struct genl_info *info, struct nlattr *nest)

I wonder, why you have this in nested attr? Aren't ifindex/ifname always
used as a handle for commands/notifications? Would be just in toplevel
(see devlink/nl80211)


>+{
>+	struct net *net = genl_info_net(info);
>+	struct nlattr *tb[ETHA_DEV_MAX + 1];
>+	struct net_device *dev;
>+	int ret;
>+
>+	if (!nest) {
>+		ETHNL_SET_ERRMSG(info,
>+				 "mandatory device identification missing");

No need to wrap.


>+		return ERR_PTR(-EINVAL);
>+	}
>+	ret = nla_parse_nested_strict(tb, ETHA_DEV_MAX, nest, dev_policy,
>+				      info->extack);
>+	if (ret < 0)

"if (ret)" is enough. "Returns 0 on success or a negative error code."


>+		return ERR_PTR(ret);
>+
>+	if (tb[ETHA_DEV_INDEX]) {
>+		dev = dev_get_by_index(net, nla_get_u32(tb[ETHA_DEV_INDEX]));
>+		if (!dev)
>+			return ERR_PTR(-ENODEV);
>+		/* if both ifindex and ifname are passed, they must match */
>+		if (tb[ETHA_DEV_NAME]) {
>+			const char *nl_name = nla_data(tb[ETHA_DEV_NAME]);
>+
>+			if (strncmp(dev->name, nl_name, IFNAMSIZ)) {
>+				dev_put(dev);
>+				ETHNL_SET_ERRMSG(info,
>+						 "ifindex and ifname do not match");

No need to wrap.


>+				return ERR_PTR(-ENODEV);
>+			}
>+		}
>+		return dev;
>+	} else if (tb[ETHA_DEV_NAME]) {
>+		dev = dev_get_by_name(net, nla_data(tb[ETHA_DEV_NAME]));
>+		if (!dev)
>+			return ERR_PTR(-ENODEV);
>+	} else {
>+		ETHNL_SET_ERRMSG(info, "either ifindex or ifname required");
>+		return ERR_PTR(-EINVAL);
>+	}
>+
>+	if (!netif_device_present(dev)) {
>+		dev_put(dev);
>+		ETHNL_SET_ERRMSG(info, "device not present");
>+		return ERR_PTR(-ENODEV);
>+	}
>+	return dev;
>+}
>+
>+/**
>+ * ethnl_fill_dev() - Put device identification nest into a message
>+ * @msg:      skb with the message
>+ * @dev:      network device to describe
>+ * @attrtype: attribute type to use for the nest
>+ *
>+ * Create a nested attribute with attributes describing given network device.
>+ * Clean up on error.
>+ *
>+ * Return: 0 on success, error value (-EMSGSIZE only) on error
>+ */
>+int ethnl_fill_dev(struct sk_buff *msg, struct net_device *dev, u16 attrtype)
>+{
>+	struct nlattr *nest;
>+	int ret = -EMSGSIZE;
>+
>+	nest = ethnl_nest_start(msg, attrtype);
>+	if (!nest)
>+		return -EMSGSIZE;
>+
>+	if (nla_put_u32(msg, ETHA_DEV_INDEX, (u32)dev->ifindex))
>+		goto err;
>+	if (nla_put_string(msg, ETHA_DEV_NAME, dev->name))
>+		goto err;
>+
>+	nla_nest_end(msg, nest);
>+	return 0;
>+err:
Usually this label is called "nla_put_failure". Same for the rest.
"err" could be confused with error return variable.

have "ret = -EMSGSIZE" here. Easier to follow the error path.

>+	nla_nest_cancel(msg, nest);
>+	return ret;
>+}
>+
>+/**
>+ * ethnl_reply_init() - Create skb for a reply and fill device identification
>+ * @payload: payload length (without netlink and genetlink header)
>+ * @dev:     device the reply is about (may be null)
>+ * @cmd:     ETHNL_CMD_* command for reply
>+ * @info:    genetlink info of the received packet we respond to
>+ * @ehdrp:   place to store payload pointer returned by genlmsg_new()
>+ *
>+ * Return: pointer to allocated skb on success, NULL on error
>+ */
>+struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
>+				 u16 dev_attrtype, struct genl_info *info,
>+				 void **ehdrp)
>+{
>+	struct sk_buff *rskb;

Could be just "skb", or "msg". You have "msg" in ethnl_fill_dev().
Please have it consistent.


>+	void *ehdr;
>+
>+	rskb = genlmsg_new(payload, GFP_KERNEL);
>+	if (!rskb) {
>+		ETHNL_SET_ERRMSG(info,
>+				 "failed to allocate reply message");

No need to wrap.


>+		return NULL;
>+	}
>+
>+	ehdr = genlmsg_put_reply(rskb, info, &ethtool_genl_family, 0, cmd);
>+	if (!ehdr)
>+		goto err;
>+	if (ehdrp)
>+		*ehdrp = ehdr;
>+	if (dev) {
>+		int ret = ethnl_fill_dev(rskb, dev, dev_attrtype);
>+
>+		if (ret < 0)

"if (ret)" is enough.


>+			goto err;
>+	}
>+
>+	return rskb;
>+err:
>+	nlmsg_free(rskb);
>+	return NULL;
>+}
>+
> /* genetlink setup */
> 
> static const struct genl_ops ethtool_genl_ops[] = {
>diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
>index 63063b582ca2..db90d95410b1 100644
>--- a/net/ethtool/netlink.h
>+++ b/net/ethtool/netlink.h
>@@ -6,7 +6,151 @@
> #include <linux/ethtool_netlink.h>
> #include <linux/netdevice.h>
> #include <net/genetlink.h>
>+#include <net/sock.h>
>+
>+#define ETHNL_SET_ERRMSG(info, msg) \
>+	do { if (info) GENL_SET_ERR_MSG(info, msg); } while (0)

Why do you need this macro? Can info be null?
In general, macros like this should be avoided.


> 
> extern struct genl_family ethtool_genl_family;
> 
>+struct net_device *ethnl_dev_get(struct genl_info *info, struct nlattr *nest);
>+int ethnl_fill_dev(struct sk_buff *msg, struct net_device *dev, u16 attrtype);
>+
>+struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
>+				 u16 dev_attrtype, struct genl_info *info,
>+				 void **ehdrp);
>+
>+static inline int ethnl_str_size(const char *s)
>+{
>+	return nla_total_size(strlen(s) + 1);

This looks like more generic helper, not tight to ethtool.


>+}
>+
>+static inline int ethnl_str_ifne_size(const char *s)

Eh? "ifne"? What is this good for?


>+{
>+	return s[0] ? ethnl_str_size(s) : 0;
>+}
>+
>+static inline int ethnl_put_str_ifne(struct sk_buff *skb, int attrtype,
>+				     const char *s)
>+{
>+	if (!s[0])
>+		return 0;
>+	return nla_put_string(skb, attrtype, s);

I don't like helpers like this. Do the check in the caller and put or
not put the string there. It's a single if.


>+}
>+
>+static inline struct nlattr *ethnl_nest_start(struct sk_buff *skb,
>+					      int attrtype)
>+{
>+	return nla_nest_start(skb, attrtype | NLA_F_NESTED);

Please use nla_nest_start directly and avoid helpers like this.


>+}
>+
>+static inline int ethnlmsg_parse(const struct nlmsghdr *nlh,
>+				 struct nlattr *tb[], int maxtype,
>+				 const struct nla_policy *policy,
>+				 struct genl_info *info)
>+{
>+	return nlmsg_parse_strict(nlh, GENL_HDRLEN, tb, maxtype, policy,
>+				  info ? info->extack : NULL);

Same thing, please use nlmsg_parse_strict directly.


>+}
>+
>+/* ethnl_update_* return true if the value is changed */
>+static inline bool ethnl_update_u32(u32 *dst, struct nlattr *attr)
>+{
>+	u32 val;
>+
>+	if (!attr)
>+		return false;
>+	val = nla_get_u32(attr);
>+	if (*dst == val)
>+		return false;
>+
>+	*dst = val;
>+	return true;
>+}
>+
>+static inline bool ethnl_update_u8(u8 *dst, struct nlattr *attr)
>+{
>+	u8 val;
>+
>+	if (!attr)
>+		return false;
>+	val = nla_get_u8(attr);
>+	if (*dst == val)
>+		return false;
>+
>+	*dst = val;
>+	return true;
>+}
>+
>+/* update u32 value used as bool from NLA_U8 */
>+static inline bool ethnl_update_bool32(u32 *dst, struct nlattr *attr)
>+{
>+	u8 val;
>+
>+	if (!attr)
>+		return false;
>+	val = !!nla_get_u8(attr);
>+	if (!!*dst == val)
>+		return false;
>+
>+	*dst = val;
>+	return true;
>+}
>+
>+static inline bool ethnl_update_binary(u8 *dst, unsigned int len,
>+				       struct nlattr *attr)
>+{
>+	if (!attr)
>+		return false;
>+	if (nla_len(attr) < len)
>+		len = nla_len(attr);
>+	if (!memcmp(dst, nla_data(attr), len))
>+		return false;
>+
>+	memcpy(dst, nla_data(attr), len);
>+	return true;
>+}
>+
>+static inline bool ethnl_update_bitfield32(u32 *dst, struct nlattr *attr)
>+{
>+	struct nla_bitfield32 change;
>+	u32 newval;
>+
>+	if (!attr)
>+		return false;
>+	change = nla_get_bitfield32(attr);
>+	newval = (*dst & ~change.selector) | (change.value & change.selector);
>+	if (*dst == newval)
>+		return false;
>+
>+	*dst = newval;
>+	return true;
>+}

I don't understand puspose of these "update" helper functions. Try to
avoid them. In general, please try to avoid wrappers around netlink api.



>+
>+static inline void warn_partial_info(struct genl_info *info)
>+{
>+	ETHNL_SET_ERRMSG(info, "not all requested data could be retrieved");
>+}
>+
>+/* Check user privileges explicitly to allow finer access control based on
>+ * context of the request or hiding part of the information from unprivileged
>+ * users
>+ */
>+static inline bool ethnl_is_privileged(struct sk_buff *skb)
>+{
>+	struct net *net = sock_net(skb->sk);
>+
>+	return netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN);

Same here.


>+}
>+
>+/* total size of ETHA_*_DEV nested attribute; this is an upper estimate so that
>+ * we do not need to hold RTNL longer than necessary to prevent rename between
>+ * estimating the size and composing the message
>+ */
>+static inline unsigned int dev_ident_size(void)

You are missing "ethnl_" prefix.


>+{
>+	return nla_total_size(nla_total_size(sizeof(u32)) +
>+			      nla_total_size(IFNAMSIZ));
>+}
>+
> #endif /* _NET_ETHTOOL_NETLINK_H */
>-- 
>2.21.0
>
