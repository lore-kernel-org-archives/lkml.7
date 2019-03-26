Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C1D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="XnoONczA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfCZQgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:36:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54247 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfCZQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:36:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so13353531wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLaniIsP9Pgj38i/cF6fQVJt/oSPNpbEsEWUOxjxDnY=;
        b=XnoONczAWvY0wIgCCptP6qnspanv/tQCI1Tl4k7lrM89EwlwCXQH77TeZoX8x8zr1r
         TOqs7VerEmPfukxOU92hqzIESXbsHPFEhlcZ+FWhw1lWA5zc6TLEtjEChSFQw0mOZxRW
         OwueOM/axyFYpzoR1bJXqd0j/eIOldVj2NWVcezjYm25taDDvONCZ+IX23NHzHhIXyZm
         aoBoggR482YHrYPlZp9S4H71JuP+gqaALptdvGbSLKLlewKAaFPOV5JnMObAWf+WGHut
         wmtSo3cN0jYcFNBE9078dj7LkbeySiZKtq6FSi/SLUPCQn1t7h/nvJSz4LbwGFXtoR1T
         +mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLaniIsP9Pgj38i/cF6fQVJt/oSPNpbEsEWUOxjxDnY=;
        b=dnQrKLYFpCv451zTfn3vcYQCDR9ge+7bLD7+Qdyl1X/t4XyocgMiNe4I79gOul96el
         lkHm8MTpFSs5NnHD6tiVSAPZrJ17AtTSR02BwPByoHXE8dNb3R4U8u20TjxmKz5NC1ae
         drbGU2A7WEox56QPCPfMEUysWvGDhZHseOC9ykOri3Fl6HyRiVRm6/++s7nqmZeamWgb
         DA8tars+2I+pbDziY0G2H7IC0N7Fhe22WpWGpmBTSvoFYLZVl6PPEnJbYaNkeu3Qkf4Y
         1gga7cFvfcQrRTlL2Ed9nLvDtZZo0BWSh39Mcv+qwjwQf3JMpPYeWIGnOWeMPjwr4PbD
         2Jzw==
X-Gm-Message-State: APjAAAXLylX4KCM85ER2mzQr05Mz/+aIyUdj5fFFcXqzVkEgTSeXYEWe
        9M4s5TCtWNYg4RhnMuC9d4srPg==
X-Google-Smtp-Source: APXvYqwJFcVMR0Q1Htaff5UXoS5w4Cl9jrdHlPXmdfBN118VmF9hnMem2LtWRW25NKaKHnUM7Z8KrA==
X-Received: by 2002:a7b:c34e:: with SMTP id l14mr10286385wmj.68.1553618201592;
        Tue, 26 Mar 2019 09:36:41 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id a17sm34884489wmg.40.2019.03.26.09.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 09:36:41 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:36:40 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190326163640.GD4958@nanopsycho.orion>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:09PM CET, mkubecek@suse.cz wrote:
>Basic genetlink and init infrastructure for the netlink interface, register
>genetlink family "ethtool". Introduce CONFIG_ETHTOOL_NETLINK Kconfig
>option. Add interface description into Documentation/networking.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---

[...]


>diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
>new file mode 100644
>index 000000000000..85dd6dac71a2
>--- /dev/null
>+++ b/net/ethtool/netlink.c
>@@ -0,0 +1,34 @@
>+// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>+
>+#include <linux/ethtool_netlink.h>
>+#include "netlink.h"
>+
>+/* genetlink setup */
>+
>+static const struct genl_ops ethtool_genl_ops[] = {

Please be consistent with prefixes. Either use "ethtool_" or "ethnl_"
for all functions and variables in this code.


>+};
>+
>+struct genl_family ethtool_genl_family = {
>+	.hdrsize	= 0,
>+	.name		= ETHTOOL_GENL_NAME,
>+	.version	= ETHTOOL_GENL_VERSION,
>+	.netnsok	= true,
>+	.parallel_ops	= true,
>+	.ops		= ethtool_genl_ops,
>+	.n_ops		= ARRAY_SIZE(ethtool_genl_ops),
>+};
>+
>+/* module setup */
>+
>+static int __init ethnl_init(void)
>+{
>+	int ret;
>+
>+	ret = genl_register_family(&ethtool_genl_family);
>+	if (WARN(ret < 0, "ethtool: genetlink family registration failed"))

Why do you need this warning? Please avoid it.


>+		return ret;
>+
>+	return 0;
>+}
>+
>+subsys_initcall(ethnl_init);
>diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
>new file mode 100644
>index 000000000000..63063b582ca2
>--- /dev/null
>+++ b/net/ethtool/netlink.h
>@@ -0,0 +1,12 @@
>+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>+
>+#ifndef _NET_ETHTOOL_NETLINK_H
>+#define _NET_ETHTOOL_NETLINK_H
>+
>+#include <linux/ethtool_netlink.h>
>+#include <linux/netdevice.h>
>+#include <net/genetlink.h>
>+
>+extern struct genl_family ethtool_genl_family;
>+
>+#endif /* _NET_ETHTOOL_NETLINK_H */
>-- 
>2.21.0
>
