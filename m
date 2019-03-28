Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A874C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9292173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="WyvvpFHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfC1JVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:21:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42850 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfC1JV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:21:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so18413792wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CVDuAFcbk05SpGpgeym11NZprLVHwvxD2Jm7bjwqObE=;
        b=WyvvpFHaAcI9JS94+RdreCHTk7KlZZGic+DSFx1ZWQKACMRwESb5GhfySnHxBm9REB
         +26cMfRX/IG35gvI2kW9Ooa1UiNqMQWpFvbXpg48WdqJ2GFBFtoUBVObu5UJAuUTSOko
         u4dXURQfsGkt9zB0tCoDABnvswwKWiSR/f+XtLoTfQrDCChRLnQSuigyW++AyIOALF8H
         LE36PjTtjhGlH8jWAnCxqvDM3Fdel0lxwUMZ17FZZhB1sdoIM5EeZv2wgiwn9MZwN7e2
         ngqy70o9G6x0Fip1PuDhzN7IVcTTpzKup0jrrGn4fcmQ95PZ+1lMsZOr9/hM9cxsKKJt
         Y8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CVDuAFcbk05SpGpgeym11NZprLVHwvxD2Jm7bjwqObE=;
        b=Cu68jTSH+oirw6MSmXX70yC7rqFXjDFw5aHVYG8+DfKeNolbLeLemcINUYqfhVxAoe
         UGsYVpzoWdK8x0pcotv8+bpKFP7uZTRtHKN11scN6GHxUT539CPECNJiBOUr6U7PM++c
         wPlPSXe5xv64Qfs7Z0HY+gu9LvBCiM/4b8z46EyCm9MUEvfLSI8Hi3cOiddbn/cXhuA7
         ebugsP70PObI4vUApOMt8XVPK1nVx0HcI8TSm45SVxjIA26cxhMh7hferdqGZt8tIdmU
         HD8+kcRg0yJztpp05dKZIC5uHOc5lUfHlIPsZScREM4xQVQRwtoXzeJrIaq6yJyDQA3i
         XpbQ==
X-Gm-Message-State: APjAAAUbVlIIKBN74z1PXAKmoIzSKgIANbArjlQjLxLkvRDknaji3LXM
        Rms6pmpHt0eUhx07alo2dS8Bqw==
X-Google-Smtp-Source: APXvYqy8nKgNdthsmpYuBz76577vB9XlOCJUZNDCWsbwFoqIEIagWO+D/PqcEpdr1Pl4pySqOVinnw==
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr26694397wrm.221.1553764888039;
        Thu, 28 Mar 2019 02:21:28 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id t17sm8664885wrr.26.2019.03.28.02.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 02:21:27 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:21:26 +0100
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
Message-ID: <20190328092126.GL14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
 <20190327201411.GH14297@nanopsycho>
 <20190327222554.GV26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327222554.GV26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 27, 2019 at 11:25:54PM CET, mkubecek@suse.cz wrote:
>On Wed, Mar 27, 2019 at 09:14:11PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:33PM CET, mkubecek@suse.cz wrote:
>> >+
>> >+Kernel response contents:
>> >+
>> >+    ETHA_INFO_DEV		(nested)	device identification
>> >+    ETHA_INFO_DRVINFO		(nested)	driver information
>> >+        ETHA_DRVINFO_DRIVER		(string)	driver name
>> >+        ETHA_DRVINFO_FWVERSION		(string)	firmware version
>> >+        ETHA_DRVINFO_BUSINFO		(string)	device bus address
>> >+        ETHA_DRVINFO_EROM_VER		(string)	expansion ROM version
>> 
>> These are already very nicely supported in devlink. No need to duplicate
>> here.
>
>They are supported by devlink as an interface. But devlink itself is
>only supported by few NIC drivers at the moment:
>
>mike@unicorn:~/work/git/net-next> grep -r devlink_ops drivers/net/
>drivers/net/ethernet/mellanox/mlx4/main.c:static const struct devlink_ops mlx4_devlink_ops = {
>drivers/net/ethernet/mellanox/mlx4/main.c:      devlink = devlink_alloc(&mlx4_devlink_ops, sizeof(*priv));
>drivers/net/ethernet/mellanox/mlxsw/core.c:static const struct devlink_ops mlxsw_devlink_ops = {
>drivers/net/ethernet/mellanox/mlxsw/core.c:             devlink = devlink_alloc(&mlxsw_devlink_ops, alloc_size);
>drivers/net/ethernet/mellanox/mlx5/core/main.c:static const struct devlink_ops mlx5_devlink_ops = {
>drivers/net/ethernet/mellanox/mlx5/core/main.c: devlink = devlink_alloc(&mlx5_devlink_ops, sizeof(*dev));
>drivers/net/ethernet/cavium/liquidio/lio_main.c:static const struct devlink_ops liquidio_devlink_ops = {
>drivers/net/ethernet/cavium/liquidio/lio_main.c:        devlink = devlink_alloc(&liquidio_devlink_ops,
>drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:static const struct devlink_ops bnxt_dl_ops = {
>drivers/net/ethernet/netronome/nfp/nfp_main.c:  devlink = devlink_alloc(&nfp_devlink_ops, sizeof(*pf));
>drivers/net/ethernet/netronome/nfp/nfp_main.h:extern const struct devlink_ops nfp_devlink_ops;
>drivers/net/ethernet/netronome/nfp/nfp_devlink.c:const struct devlink_ops nfp_devlink_ops = {
>drivers/net/netdevsim/devlink.c:static const struct devlink_ops nsim_devlink_ops = {
>drivers/net/netdevsim/devlink.c:        devlink = devlink_alloc(&nsim_devlink_ops, 0);
>
>That's 6 drivers from 4 vendors (if I don't count netdevsim). And I did
>not check if all of them do actually provide the information shown
>above. On the other hand:
>
>mike@unicorn:~/work/git/net-next> egrep -r '\.get_drvinfo' drivers/net/ | wc -l
>240
>
>Some of these 240 lines assign the same handler but not enough to make
>me optimistic about being able to implement "ethtool -i <dev>" using
>devlink interface in near future (say few months or one year).
>
>I'm all for implementing new features which are are related to physical
>device (ASIC) rather than network interface only in devlink (at the
>level of kernel-userspace interface). But for features already provided
>by ethtool (userspace utility) I can't help seeing the state of devlink
>support in NIC drivers as a serious blocker.

What I'm thinking about at for some time now would be en explicit
default devlink and devlink_port registration for every netdev for
drivers that does not support devlink themselves. I need to think about
it more, but it seems doable. Then we can hang appropriate things there
and make the ethtoolnl/devlink separation clear. I believe we need to do
it.


>
>Michal
