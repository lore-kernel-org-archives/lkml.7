Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9423BC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D727218BB
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="I/Limrpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGDIJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:09:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36775 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGDIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:09:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so5583133wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ikIOKBV36H/Xx1iuFIPI2qkuopRb0oqwGFKJA2jzmY4=;
        b=I/LimrpioiWUl+TQIxDzRUuF3Atd37fYhfeZDCXfS3Ifza1QV3qL8hlvjJ/vGuk8Yz
         2UY8Fd26nxylwrUL52R1hDOuoT0hPmJYMLXXLavrZAeWDIyuIFJvxMRrerEhw+ecH9HY
         6MX+olxNieSfywey7Cw8GkZ3JOaYzvSXAaT6SLHt6pbdfOIIU7vG86ffZJCUM+L2Jtkr
         QbJ42HuXTdTckIw4vuToyYxZ0rY6jmRgzM6dVveKzM3OZA42KZ3Zx+aLz9ZAg2L/O816
         HODt2JTXwQzDhEQpB7Rkl/r7tN3LUYg/l3R/D/jLTQ98VrZIHEYzqT3bt20m8h/aC+SQ
         hOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ikIOKBV36H/Xx1iuFIPI2qkuopRb0oqwGFKJA2jzmY4=;
        b=THWjLmVOixQ4EBvYZM0QXkYOLlAgpG8q3yFsrQzNyXrAR5tilYMq7rvHfSbfRtUDpP
         aeyi8K3EbqyC6h1ixdpa/dHK/OhQiI2Vxu6CojclXpRFvR5zg5w8sWASDeYJxWncJY8J
         tj+3GMqJuB7RHEZ/ktXNTdF0umO0VJskx4tfRADDNEMepo43KFOIwGyd/OCs3E4dTJer
         WUInCMrTUsHyk/3Fpdhlz10qBRKT12nLjfufKJUFJxhEwoN7kLwjZb3AdlMAOcYKKZo6
         zmK2fckRstk4s2Kib1XdovhzioNAK1EktXBlILo5VUf8hIdwxq2RkulOK3qJjN70iFcI
         vp3g==
X-Gm-Message-State: APjAAAU/c3aGAZfYVo4mhIV89sS02m23+3DeR78+gdtqTGf9uCeuj7HS
        M9ga5huTvvZJT49szCp/Jf+0+g==
X-Google-Smtp-Source: APXvYqxtJJPyG4RX207axr0ToNgMTD3BFhUKT7pEJfs8Zwuc3CesCIlqz0qlHQjj96AAD8AbNBdIGw==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr21751875wru.275.1562227795632;
        Thu, 04 Jul 2019 01:09:55 -0700 (PDT)
Received: from localhost (ip-213-220-235-213.net.upcbroadband.cz. [213.220.235.213])
        by smtp.gmail.com with ESMTPSA id a2sm5896823wmj.9.2019.07.04.01.09.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 01:09:55 -0700 (PDT)
Date:   Thu, 4 Jul 2019 10:09:54 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/15] ethtool: move string arrays into
 common file
Message-ID: <20190704080954.GH2250@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <0647ac484dac2c655d0e4260d81e86405688ff5b.1562067622.git.mkubecek@suse.cz>
 <20190703134452.GZ2250@nanopsycho>
 <20190703143722.GN20101@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703143722.GN20101@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 03, 2019 at 04:37:22PM CEST, mkubecek@suse.cz wrote:
>On Wed, Jul 03, 2019 at 03:44:52PM +0200, Jiri Pirko wrote:
>> Tue, Jul 02, 2019 at 01:50:19PM CEST, mkubecek@suse.cz wrote:
>> >Introduce file net/ethtool/common.c for code shared by ioctl and netlink
>> >ethtool interface. Move name tables of features, RSS hash functions,
>> >tunables and PHY tunables into this file.
>> >
>> >Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>> >---
>> > net/ethtool/Makefile |  2 +-
>> > net/ethtool/common.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
>> > net/ethtool/common.h | 17 +++++++++
>> > net/ethtool/ioctl.c  | 83 ++-----------------------------------------
>> > 4 files changed, 104 insertions(+), 82 deletions(-)
>> > create mode 100644 net/ethtool/common.c
>> > create mode 100644 net/ethtool/common.h
>> >
>> >diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
>> >index 482fdb9380fa..11782306593b 100644
>> >--- a/net/ethtool/Makefile
>> >+++ b/net/ethtool/Makefile
>> >@@ -1,6 +1,6 @@
>> > # SPDX-License-Identifier: GPL-2.0
>> > 
>> >-obj-y				+= ioctl.o
>> >+obj-y				+= ioctl.o common.o
>> > 
>> > obj-$(CONFIG_ETHTOOL_NETLINK)	+= ethtool_nl.o
>> > 
>> >diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>> >new file mode 100644
>> >index 000000000000..b0ce420e994e
>> >--- /dev/null
>> >+++ b/net/ethtool/common.c
>> >@@ -0,0 +1,84 @@
>> >+// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> >+
>> >+#include "common.h"
>> >+
>> >+const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
>> 
>> const char *netdev_features_strings[NETDEV_FEATURE_COUNT] = {
>> ?
>> 
>> Same with the other arrays.
>
>These are not new tables, this patch only moves existing tables from
>ioctl.c (originally net/core/ethtool.c) into common.c so that they can
>be used by both ioctl and netlink code.
>
>This fixed size string array format is used by ETHTOOL_GSTRINGS ioctl
>command. So if we switch these into simple const char *table[], we can
>get rid of some complexity in strset.c and bitset.c (the "simple" vs.
>"legacy" string set mess) but we would have to convert them into the
>fixed size string array in ioctl ETHTOOL_GSTRINGS handler. And then we
>would also have to convert (or rather "index") string sets retrieved
>from NIC driver (e.g. private flags, stats, tests) - which also means an
>extra kmalloc() (or rather kmalloc_array()).
>
>It an option I'm certainly open to if we agree on it but it's not for
>free.

Got it. I don't think we need to do this now. But it would be certainly
nice to fix this later on.

>
>Michal
