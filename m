Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29870C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2EF20673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TMhO5cgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfGCBhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:37:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34025 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfGCBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:37:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so572057qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=itC4RfMamo4nBUphW+p9hF/96GAi0A3uCODUBRvJI84=;
        b=TMhO5cgS+76xq5nHpxySpbIhABSRUywM4yxx2+y9FXTrvyuMrU3Cp2feNwPsOeRsKW
         DwKwJWsXiHOYGDICseJdVlYxguntHUvsU6MrtNgLZzUMElpHNBXa/6Jjn0/xtQMqMIB8
         Li6ad1O97GJAVS+d57FQzz6F3TMcNdl9iVk4T74Lx6hRRdmkPYI4UUEoAioE0m+84vvk
         DeVz4JERwD1PMdQMjQ3gICjK8PxsLEGU3AUM9Lg9AWg6DAaTXRItWMCoZYyHLuxDhIsD
         OpmqLVAEODV5QsCL8faaQnLfHa0ajB/20e6HjUrjqvxAQtCeJhPZL1UO8W1JyqkAll4C
         8i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=itC4RfMamo4nBUphW+p9hF/96GAi0A3uCODUBRvJI84=;
        b=qXPu8fl0As2APfWh3HCnFo1KcLgE8WE+WnVr1h0XBmWe59ieXPSeiDtrDcY6Yz4EyN
         I1DpnWgSwDXJc6W+gKelHa0mO5ggElEyNJ4FFhD8L3/RneYVsKXVXQDIv9NhHvyerpGq
         0S6pf2jiX0ZwHB1Po2xxyYo0YgNhBgHVGrEJNwZuI5LO9kwxNU69ol5zB9j9sDWdG39W
         DMAY6P+ZF6fbZPBfyXy2xJ7iQns5ndkxlPllSsBwOtNB5O11Sf8gtqU6xEtyqM+/DEa+
         RqW8V1x+5ksadZ9oKjqPEs9suXNYgPYdnFthhrFXiYvdi9thincBlE/eb+67Fy7506gI
         5Qpg==
X-Gm-Message-State: APjAAAXuF5xZWhO1dOGPv4T3CFUb/kabxI/ec1qXFlLI5Gg6ft+vhITW
        7YZX+hJc/5kpNvIiK8PSKwFlEQ==
X-Google-Smtp-Source: APXvYqyyl+pNFApWH9ul5KAlVhaGUV3rJBSAcAPkIU+AHaxs/CaVSypyCo85+p1EbI/jfLSIHXgbvA==
X-Received: by 2002:a37:f511:: with SMTP id l17mr25845461qkk.99.1562117850182;
        Tue, 02 Jul 2019 18:37:30 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n3sm280989qkk.54.2019.07.02.18.37.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 18:37:30 -0700 (PDT)
Date:   Tue, 2 Jul 2019 18:37:24 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 05/15] ethtool: helper functions for netlink
 interface
Message-ID: <20190702183724.423e3b1e@cakuba.netronome.com>
In-Reply-To: <44957b13e8edbced71aca893908d184eb9e57341.1562067622.git.mkubecek@suse.cz>
References: <cover.1562067622.git.mkubecek@suse.cz>
        <44957b13e8edbced71aca893908d184eb9e57341.1562067622.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Jul 2019 13:50:04 +0200 (CEST), Michal Kubecek wrote:
> Add common request/reply header definition and helpers to parse request
> header and fill reply header. Provide ethnl_update_* helpers to update
> structure members from request attributes (to be used for *_SET requests).
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 3c98b41f04e5..e13f29bbd625 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -1,8 +1,181 @@
>  // SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>  
> +#include <net/sock.h>
>  #include <linux/ethtool_netlink.h>
>  #include "netlink.h"
>  
> +static struct genl_family ethtool_genl_family;
> +
> +static const struct nla_policy dflt_header_policy[ETHTOOL_A_HEADER_MAX + 1] = {
> +	[ETHTOOL_A_HEADER_UNSPEC]	= { .type = NLA_REJECT },

I think we want strict checking on all new netlink interfaces, and
unfortunately that feature is opt-in.. so you need to add:

	.strict_start_type = ETHTOOL_A_HEADER_UNSPEC + 1

To the first attr.

> +	[ETHTOOL_A_HEADER_DEV_INDEX]	= { .type = NLA_U32 },
> +	[ETHTOOL_A_HEADER_DEV_NAME]	= { .type = NLA_NUL_STRING,
> +					    .len = IFNAMSIZ - 1 },
> +	[ETHTOOL_A_HEADER_INFOMASK]	= { .type = NLA_U32 },
> +	[ETHTOOL_A_HEADER_GFLAGS]	= { .type = NLA_U32 },
> +	[ETHTOOL_A_HEADER_RFLAGS]	= { .type = NLA_U32 },
> +};


