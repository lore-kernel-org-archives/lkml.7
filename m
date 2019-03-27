Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A00C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE502082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfC0WZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:25:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727848AbfC0WZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:25:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F3BAAD38;
        Wed, 27 Mar 2019 22:25:55 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id C9A87E1404; Wed, 27 Mar 2019 23:25:54 +0100 (CET)
Date:   Wed, 27 Mar 2019 23:25:54 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
Message-ID: <20190327222554.GV26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
 <20190327201411.GH14297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327201411.GH14297@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:14:11PM +0100, Jiri Pirko wrote:
> Mon, Mar 25, 2019 at 06:08:33PM CET, mkubecek@suse.cz wrote:
> >+
> >+Kernel response contents:
> >+
> >+    ETHA_INFO_DEV		(nested)	device identification
> >+    ETHA_INFO_DRVINFO		(nested)	driver information
> >+        ETHA_DRVINFO_DRIVER		(string)	driver name
> >+        ETHA_DRVINFO_FWVERSION		(string)	firmware version
> >+        ETHA_DRVINFO_BUSINFO		(string)	device bus address
> >+        ETHA_DRVINFO_EROM_VER		(string)	expansion ROM version
> 
> These are already very nicely supported in devlink. No need to duplicate
> here.

They are supported by devlink as an interface. But devlink itself is
only supported by few NIC drivers at the moment:

mike@unicorn:~/work/git/net-next> grep -r devlink_ops drivers/net/
drivers/net/ethernet/mellanox/mlx4/main.c:static const struct devlink_ops mlx4_devlink_ops = {
drivers/net/ethernet/mellanox/mlx4/main.c:      devlink = devlink_alloc(&mlx4_devlink_ops, sizeof(*priv));
drivers/net/ethernet/mellanox/mlxsw/core.c:static const struct devlink_ops mlxsw_devlink_ops = {
drivers/net/ethernet/mellanox/mlxsw/core.c:             devlink = devlink_alloc(&mlxsw_devlink_ops, alloc_size);
drivers/net/ethernet/mellanox/mlx5/core/main.c:static const struct devlink_ops mlx5_devlink_ops = {
drivers/net/ethernet/mellanox/mlx5/core/main.c: devlink = devlink_alloc(&mlx5_devlink_ops, sizeof(*dev));
drivers/net/ethernet/cavium/liquidio/lio_main.c:static const struct devlink_ops liquidio_devlink_ops = {
drivers/net/ethernet/cavium/liquidio/lio_main.c:        devlink = devlink_alloc(&liquidio_devlink_ops,
drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:static const struct devlink_ops bnxt_dl_ops = {
drivers/net/ethernet/netronome/nfp/nfp_main.c:  devlink = devlink_alloc(&nfp_devlink_ops, sizeof(*pf));
drivers/net/ethernet/netronome/nfp/nfp_main.h:extern const struct devlink_ops nfp_devlink_ops;
drivers/net/ethernet/netronome/nfp/nfp_devlink.c:const struct devlink_ops nfp_devlink_ops = {
drivers/net/netdevsim/devlink.c:static const struct devlink_ops nsim_devlink_ops = {
drivers/net/netdevsim/devlink.c:        devlink = devlink_alloc(&nsim_devlink_ops, 0);

That's 6 drivers from 4 vendors (if I don't count netdevsim). And I did
not check if all of them do actually provide the information shown
above. On the other hand:

mike@unicorn:~/work/git/net-next> egrep -r '\.get_drvinfo' drivers/net/ | wc -l
240

Some of these 240 lines assign the same handler but not enough to make
me optimistic about being able to implement "ethtool -i <dev>" using
devlink interface in near future (say few months or one year).

I'm all for implementing new features which are are related to physical
device (ASIC) rather than network interface only in devlink (at the
level of kernel-userspace interface). But for features already provided
by ethtool (userspace utility) I can't help seeing the state of devlink
support in NIC drivers as a serious blocker.

Michal
