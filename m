Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A3D206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="cWITM1We"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfCZQeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:34:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35211 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbfCZQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:34:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so15192374wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h1NUi2XfcH0m8w5YVpsaIacmYX1jejQOaM3T9xZYDiE=;
        b=cWITM1WeVf86ooKmPU9pv0jlX6l9pEWbCVS6sSor8Yi6y30I+4UBTSPjjD8zNhFdlh
         8ojN6wOGrb3HRuYehkr3sWQfmjw1+1e86cMb2n3QUqbi3FDneZiYrO6xBspf4Jl30WWq
         DaiCzvS/s0KNtaild99hfBROkkB2spJ7nBPHqjI74yZzXNuyDGva4JmNmmSk2Cl4kCSM
         +tJtU5h/c5AwQWFsRUAIpYAGJGDraqCwfqVo4BL8LhaU9gpsMQRM88+d6sJluzDZfH0g
         wj9hifQvaqbugTP+whqjOyR1j+Y83bOcMVdunB/mfG53brAThWPCydDJALPNft6eNWr0
         OznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h1NUi2XfcH0m8w5YVpsaIacmYX1jejQOaM3T9xZYDiE=;
        b=bOl9BrhwaXhqoe2xueXQODFG/iNh5tDsXDS2KTOey/77sl+RJibyWuyb7nt1KKQdvG
         fCLqJ8OqdS87ubQ3M0ViJqg5tmHSQ9Ynr9tGabY4P5qDUtsgKXozYTCFMaEdwxefD5B/
         SLWV3OrVT2vPpVFDUNWL8q2gf/kJ3EkZRPqsiqa0ImGeeYU8Cflx84Si3Xy59qLuXKTH
         VBROo13KnvpuxD43NcfJmpk1rgf8b+Q43Wb5G/smZX4JptNEBb4WfsU+zla85jyhG7QF
         D/WTUY3P9XJMaht0pWjv5rfdiNZQ8kriKUmCFn/B2sE4RKpzy5AuaHF4BID84w48UA00
         e4IA==
X-Gm-Message-State: APjAAAXnp5s//LMqgX0gSXLLOY13TI+POdURe/7/IsQXA2Rc0JCv7dcR
        Cspm8KnpGXQYLv5TRLRAHJc4mQ==
X-Google-Smtp-Source: APXvYqxg+e8eCI/ksTRJBm2jMC+j9qYUaYyIfFKHVWRB51A/9c+BXDOsKxBr1FmFib7BtEySS6GrPQ==
X-Received: by 2002:adf:afd7:: with SMTP id y23mr19600290wrd.254.1553618041216;
        Tue, 26 Mar 2019 09:34:01 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id i28sm36308781wrc.32.2019.03.26.09.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 09:34:00 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:34:00 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/22] ethtool: support for netlink
 notifications
Message-ID: <20190326163400.GC4958@nanopsycho.orion>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:18PM CET, mkubecek@suse.cz wrote:
>Add infrastructure for ethtool netlink notifications. There is only one
>multicast group "monitor" which is used to notify userspace about changes.
>Notifications are supposed to be broadcasted on every configuration change,
>whether it is done using the netlink interface or legacy ioctl one.
>
>To trigger an ethtool notification, both ethtool netlink and external code
>use ethtool_notify() helper. This helper requires RTNL to be held and may
>sleep.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---
> include/linux/ethtool_netlink.h      |  5 ++++
> include/linux/netdevice.h            | 12 +++++++++
> include/uapi/linux/ethtool_netlink.h |  2 ++
> net/ethtool/netlink.c                | 37 ++++++++++++++++++++++++++++
> net/ethtool/netlink.h                |  2 ++
> 5 files changed, 58 insertions(+)
>
>diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
>index 0412adb4f42f..2a15e64a16f3 100644
>--- a/include/linux/ethtool_netlink.h
>+++ b/include/linux/ethtool_netlink.h
>@@ -5,5 +5,10 @@
> 
> #include <uapi/linux/ethtool_netlink.h>
> #include <linux/ethtool.h>
>+#include <linux/netdevice.h>
>+
>+enum ethtool_multicast_groups {
>+	ETHNL_MCGRP_MONITOR,
>+};
> 
> #endif /* _LINUX_ETHTOOL_NETLINK_H_ */
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index 166fdc0a78b4..bc761511edb4 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -4353,6 +4353,18 @@ struct netdev_notifier_bonding_info {
> void netdev_bonding_info_change(struct net_device *dev,
> 				struct netdev_bonding_info *bonding_info);
> 
>+#if IS_ENABLED(CONFIG_ETHTOOL_NETLINK)
>+void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
>+		    unsigned int cmd, u32 req_mask, const void *data);
>+#else
>+static inline void ethtool_notify(struct net_device *dev,
>+				  struct netlink_ext_ack *extack,
>+				  unsigned int cmd, u32 req_mask,
>+				  const void *data)
>+{
>+}
>+#endif
>+
> static inline
> struct sk_buff *skb_gso_segment(struct sk_buff *skb, netdev_features_t features)
> {
>diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
>index de18e076ed69..91e4d117957b 100644
>--- a/include/uapi/linux/ethtool_netlink.h
>+++ b/include/uapi/linux/ethtool_netlink.h
>@@ -65,4 +65,6 @@ enum {
> #define ETHTOOL_GENL_NAME "ethtool"
> #define ETHTOOL_GENL_VERSION 1
> 
>+#define ETHTOOL_MCGRP_MONITOR_NAME "monitor"
>+
> #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_H_ */
>diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
>index cc6829ba4331..4a31765165ea 100644
>--- a/net/ethtool/netlink.c
>+++ b/net/ethtool/netlink.c
>@@ -4,6 +4,10 @@
> #include <linux/ethtool_netlink.h>
> #include "netlink.h"
> 
>+u32 ethnl_bcast_seq;
>+
>+static bool ethnl_ok __read_mostly;
>+
> static const struct nla_policy dev_policy[ETHA_DEV_MAX + 1] = {
> 	[ETHA_DEV_UNSPEC]	= { .type = NLA_REJECT },
> 	[ETHA_DEV_INDEX]	= { .type = NLA_U32 },
>@@ -147,11 +151,41 @@ struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
> 	return NULL;
> }
> 
>+/* notifications */
>+
>+typedef void (*ethnl_notify_handler_t)(struct net_device *dev,
>+				       struct netlink_ext_ack *extack,
>+				       unsigned int cmd, u32 req_mask,
>+				       const void *data);
>+
>+ethnl_notify_handler_t ethnl_notify_handlers[] = {
>+};
>+
>+void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
>+		    unsigned int cmd, u32 req_mask, const void *data)
>+{
>+	if (unlikely(!ethnl_ok))

Why do you need this?


>+		return;
>+	ASSERT_RTNL();
>+
>+	if (likely(cmd < ARRAY_SIZE(ethnl_notify_handlers) &&
>+		   ethnl_notify_handlers[cmd]))
>+		ethnl_notify_handlers[cmd](dev, extack, cmd, req_mask, data);
>+	else
>+		WARN_ONCE(1, "notification %u not implemented (dev=%s, req_mask=0x%x)\n",
>+			  cmd, netdev_name(dev), req_mask);
>+}
>+EXPORT_SYMBOL(ethtool_notify);

Please be consistent with prefixes. Rest of the code (most of it) has
prefix "ethnl".


>+
> /* genetlink setup */
> 
> static const struct genl_ops ethtool_genl_ops[] = {
> };
> 
>+static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
>+	[ETHNL_MCGRP_MONITOR] = { .name = ETHTOOL_MCGRP_MONITOR_NAME },
>+};
>+
> struct genl_family ethtool_genl_family = {
> 	.hdrsize	= 0,
> 	.name		= ETHTOOL_GENL_NAME,
>@@ -160,6 +194,8 @@ struct genl_family ethtool_genl_family = {
> 	.parallel_ops	= true,
> 	.ops		= ethtool_genl_ops,
> 	.n_ops		= ARRAY_SIZE(ethtool_genl_ops),
>+	.mcgrps		= ethtool_nl_mcgrps,
>+	.n_mcgrps	= ARRAY_SIZE(ethtool_nl_mcgrps),
> };
> 
> /* module setup */
>@@ -171,6 +207,7 @@ static int __init ethnl_init(void)
> 	ret = genl_register_family(&ethtool_genl_family);
> 	if (WARN(ret < 0, "ethtool: genetlink family registration failed"))
> 		return ret;
>+	ethnl_ok = true;
> 
> 	return 0;
> }
>diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
>index b8a6cd3dc3e3..5f2299548915 100644
>--- a/net/ethtool/netlink.h
>+++ b/net/ethtool/netlink.h
>@@ -11,6 +11,8 @@
> #define ETHNL_SET_ERRMSG(info, msg) \
> 	do { if (info) GENL_SET_ERR_MSG(info, msg); } while (0)
> 
>+extern u32 ethnl_bcast_seq;

Why do you need to have this in header? Second, it is not used by
anything. Please don't introduce variables that are not used. Introduce
them only in patch where you use it.


>+
> extern struct genl_family ethtool_genl_family;
> 
> struct net_device *ethnl_dev_get(struct genl_info *info, struct nlattr *nest);
>-- 
>2.21.0
>
