Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16DDC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E664218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="2Gl3DVSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfGCNo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:44:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39741 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:44:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so2878208wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lqjwb4PSRRpgur45S0Sj39llo2koNK5cJny1303AO4k=;
        b=2Gl3DVSUwdQHd8Q3VmCtrI4Qk3ly3TpMfWH+JoiElbBZyH3bTKl/I/hZnH4h2rAMgn
         Dro/izjGNqzGybKf0Na86V0xPu684GM4bQvNLuLiQ9nb/h8KQwmrSUk7AWYbLo8wn2sI
         RpsXaF8qXgwQdMQ0DxAREpJkFCdeNCiEevvniv1mb/jwTWsn1vz0H/3Xge75bEFot4Op
         hrp6FAAaT6xt1JFvGUMwUBoI/HPBuJKifIScUI3zJwMjmJ1nZQaMHDRNQ3FRw6o2ZRub
         scq9E0LAWVWxxB3vRNYpwU3o3lT6Zk7HKdJnU99vj5gPNh/NvrI4KdyCRA8HziSVzywD
         Wq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lqjwb4PSRRpgur45S0Sj39llo2koNK5cJny1303AO4k=;
        b=W2d1IZqHOAzIIZ1A5/wyrHU5rltCRkanEj39NwqPbZUtF5vGN1V2NFA+EkdOe+AHxF
         8rhRbx2D5Kz6E5bJ6sN2UJ7rmkWwMre5qzXFandpEWULv9z/X9lbkAsJEOowh03dXCCj
         mnEazXGSgoF9mkt7q0b/b3N+c5AE4LP+rEUuD4YtbxU4ZsBaW4ZZbhdLuolxRE/PPD5v
         UN9pvDG0i44iFgif40z7F6Am18cUEj9ChXwbYT7cqLyqqCUf4gkoPx4ccd5UCLs2dOwk
         j16RfuB/IL8A4RRv6Z/GTvuk2NFabyCJVoTRoUDct1SYDZqi5Huh2iQbX2zsfLoYv3BT
         101A==
X-Gm-Message-State: APjAAAXGjNJE860idK3YQCwgE/J6BlmTwwVKdllAS+2uSnW99fBvDr7v
        S3Lfi1zdeIio8ItQA/KPKbveQg==
X-Google-Smtp-Source: APXvYqwDx1CQACHzdJvabOorGtzHxc6vae/DyNdKL+DNE+ANBUk4KWYrClqDqFMzup8XvG+kANkUMg==
X-Received: by 2002:adf:fa4c:: with SMTP id y12mr28966912wrr.282.1562161493662;
        Wed, 03 Jul 2019 06:44:53 -0700 (PDT)
Received: from localhost (ip-213-220-235-213.net.upcbroadband.cz. [213.220.235.213])
        by smtp.gmail.com with ESMTPSA id p11sm2910322wrm.53.2019.07.03.06.44.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 06:44:53 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:44:52 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/15] ethtool: move string arrays into
 common file
Message-ID: <20190703134452.GZ2250@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <0647ac484dac2c655d0e4260d81e86405688ff5b.1562067622.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0647ac484dac2c655d0e4260d81e86405688ff5b.1562067622.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jul 02, 2019 at 01:50:19PM CEST, mkubecek@suse.cz wrote:
>Introduce file net/ethtool/common.c for code shared by ioctl and netlink
>ethtool interface. Move name tables of features, RSS hash functions,
>tunables and PHY tunables into this file.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---
> net/ethtool/Makefile |  2 +-
> net/ethtool/common.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
> net/ethtool/common.h | 17 +++++++++
> net/ethtool/ioctl.c  | 83 ++-----------------------------------------
> 4 files changed, 104 insertions(+), 82 deletions(-)
> create mode 100644 net/ethtool/common.c
> create mode 100644 net/ethtool/common.h
>
>diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
>index 482fdb9380fa..11782306593b 100644
>--- a/net/ethtool/Makefile
>+++ b/net/ethtool/Makefile
>@@ -1,6 +1,6 @@
> # SPDX-License-Identifier: GPL-2.0
> 
>-obj-y				+= ioctl.o
>+obj-y				+= ioctl.o common.o
> 
> obj-$(CONFIG_ETHTOOL_NETLINK)	+= ethtool_nl.o
> 
>diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>new file mode 100644
>index 000000000000..b0ce420e994e
>--- /dev/null
>+++ b/net/ethtool/common.c
>@@ -0,0 +1,84 @@
>+// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>+
>+#include "common.h"
>+
>+const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {

const char *netdev_features_strings[NETDEV_FEATURE_COUNT] = {
?

Same with the other arrays.

[...]
