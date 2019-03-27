Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9369C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990F22087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="PPWumTec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfC0UOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:14:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35710 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfC0UOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:14:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so20153935wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FNBgucpkMNgGRsfVdEySULJb6WHUk4KUPjmP57c/Q+4=;
        b=PPWumTecNYnJXxhqHS2pVc/QT7vIoLPGfTPz3MNLqybZJUsU34kNknXHN2zyNXkjYW
         h+XIZr+uSinJwH6e30JapBnGwjq1QRaU4CRum/gUX452K3lo1R6/fBSRoYCXgp60Pyq3
         rdY2Qa6kp3IxfvjrCOGh3/DRrIFqnd60/R0G7liPSCdIZIDiR3a5rsXujrZ01AuYT92Y
         tB2bZCY5T5tr0xlr7t8GKW7yc+NpwQzwDNpHDLhaGGcZtlZjqDwwJ45yul/xMJI8/5o/
         QrCr1nNW7lq4EnGrb4CK4ytpSsxG0mJxz9Jwsuhlph1hX7pFvP7DcMVzU0V5QMTkUegB
         rw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FNBgucpkMNgGRsfVdEySULJb6WHUk4KUPjmP57c/Q+4=;
        b=cAPTe2vlj5xaXXEzhdw7eXxbqm5KBgYMkGIl6ppqdcarNrulD096bR5502giB41xpN
         peB+aoFSzFu2NQju3STZUrE2iWzyxdeCGB7+gVak8PgcmI06ImzV7Sg9qUyvNX9OrUoG
         zGJbXGLNNxBnjuaa6nIzpuCesXBGvNBwcqRm8FClSFqzHGuSwvHGQjBAW1imEqVZHd8c
         gGUUuu4F1f+KEpWQ5YKH2Hdkpf5pMOe2IPjoF9TMZRrodNu9IoHBEl16Em4qlPEN+SjJ
         dYa20uwR25ubbhhZNery5BsM4BtyYhtFZFT/IYixKSimf0VGrcMZZK482VlYoB0YJH5k
         5k3w==
X-Gm-Message-State: APjAAAUgwhMW92w/jxwDDwKFrTHbymS71+aofOTI+rkj3Bftl/e51B7M
        7BQSKEOPYaSF2sdBTDcRBf9MDg==
X-Google-Smtp-Source: APXvYqyRzKuRpal1qWRPuzjz8tSbWPMy09VXvZCScQrMLLNcqyiebc9vmwDqnra6/TE5WKASusKRBA==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr26067814wrm.322.1553717653074;
        Wed, 27 Mar 2019 13:14:13 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id 66sm6336011wmd.3.2019.03.27.13.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 13:14:12 -0700 (PDT)
Date:   Wed, 27 Mar 2019 21:14:11 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
Message-ID: <20190327201411.GH14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:33PM CET, mkubecek@suse.cz wrote:
>Implement GET_INFO request to get basic driver and device information as
>provided by ETHTOOL_GDRVINFO ioct command. The information is read only so
>that the corresponding SET_INFO message is only used in kernel replies.
>
>Move most of ethtool_get_drvinfo() int common.c so that the code can be
>shared by both ioctl and netlink interface.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---
> Documentation/networking/ethtool-netlink.txt |  43 ++++-
> include/uapi/linux/ethtool_netlink.h         |  30 ++++
> net/ethtool/Makefile                         |   2 +-
> net/ethtool/common.c                         |  52 ++++++
> net/ethtool/common.h                         |   2 +
> net/ethtool/info.c                           | 158 +++++++++++++++++++
> net/ethtool/ioctl.c                          |  50 +-----
> net/ethtool/netlink.c                        |   8 +
> net/ethtool/netlink.h                        |   1 +
> 9 files changed, 299 insertions(+), 47 deletions(-)
> create mode 100644 net/ethtool/info.c
>
>diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
>index 1508c16a236e..cffa508ca6c6 100644
>--- a/Documentation/networking/ethtool-netlink.txt
>+++ b/Documentation/networking/ethtool-netlink.txt
>@@ -129,6 +129,8 @@ List of message types
>     ETHNL_CMD_EVENT			notification only
>     ETHNL_CMD_GET_STRSET
>     ETHNL_CMD_SET_STRSET		response only
>+    ETHNL_CMD_GET_INFO
>+    ETHNL_CMD_SET_INFO			response only
> 
> All constants use ETHNL_CMD_ prefix, usually followed by "GET", "SET" or "ACT"
> to indicate the type.
>@@ -209,6 +211,45 @@ ETHA_STRSET_COUNTS tells kernel to only return string counts of the sets, not
> the actual strings.
> 
> 
>+GET_INFO
>+--------
>+
>+GET_INFO requests information provided by ioctl commands ETHTOOL_GDRVINFO,
>+ETHTOOL_GPERMADDR and ETHTOOL_GET_TS_INFO to provide basic device information.
>+Common pattern is that all information is read only so that SET_INFO message
>+exists but is only used by kernel for replies to GET_INFO requests. There is
>+also no corresponding notification.
>+
>+Request contents:
>+
>+    ETHA_INFO_DEV		(nested)	device identification
>+    ETHA_INFO_INFOMASK		(u32)		info mask
>+    ETHA_INFO_COMPACT		(flag)		request compact bitsets
>+
>+Info mask bits meaning:
>+
>+    ETH_INFO_IM_DRVINFO			driver info (GDRVINFO)
>+    ETH_INFO_IM_PERMADDR		permanent HW address (GPERMADDR)
>+    ETH_INFO_IM_TSINFO			timestamping info (GET_TS_INFO)
>+
>+Kernel response contents:
>+
>+    ETHA_INFO_DEV		(nested)	device identification
>+    ETHA_INFO_DRVINFO		(nested)	driver information
>+        ETHA_DRVINFO_DRIVER		(string)	driver name
>+        ETHA_DRVINFO_FWVERSION		(string)	firmware version
>+        ETHA_DRVINFO_BUSINFO		(string)	device bus address
>+        ETHA_DRVINFO_EROM_VER		(string)	expansion ROM version

These are already very nicely supported in devlink. No need to duplicate
here.
