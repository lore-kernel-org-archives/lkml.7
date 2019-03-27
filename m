Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4361BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9C62087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="BXavTnUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfC0UMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:12:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37832 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfC0UMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:12:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so20111208wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Qtj+TKhffEuPFEN+GNxBncgzLuwne/LRQjWAl4/NcE=;
        b=BXavTnUfrLsRhCj68BI69GAV/RiMP1sLllN7T8knRuW5yWay6Y64iDg9IiI9PrjN3+
         mdHfuPnWT1OtOXdazjv1pxZuMtO/yhP/jd7YvduPbtVbC6H5/y0hSqvx7Pd/evbvQ67w
         E3C1+vO6qdIBEIgXPE6X9EsZBcQp9WYG68AbLOjiWHvM//qoOCG4svdhdDiVEPFCKRsC
         wSnAVK36TsCNjJhmawK8DHrdBFGE03VTQXit1OTxqiCVYD/xALfyYEtO7XMlTwR/OIjM
         Zw9pA1mnyXUz4H2odiiPZWUBUFZIDS1mo2y/jf2hoeatmQakizch7W234CVrmNY000D5
         +5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Qtj+TKhffEuPFEN+GNxBncgzLuwne/LRQjWAl4/NcE=;
        b=VXZCQb43aiCQkAVopdaJgikvKIDgQ6SD/CGE35z4l6BCDy6RQJkkJPQPDPKiLMS3NI
         ZhX4gH0vZuSIb9CeX+tG0vdSEYgtNNk0XBPJkvCHS85jPLd2cGd+HL5TapOqybx/pLdn
         +ZeUbX5wp5cpqC78nExy+cFZR6iqHYGcJDVhIqdS76dtNvce6GXTJ4jv8lO7bTeVlJ4r
         r45t+KsfwGLGE8KHCm0WRr6kBF8mio2l/kfKP4V8JY6PZgcrtUBTgNIX6bwqT0xsTPbN
         7NSjHhtKNsK8iejlkrL49bWi4feR8dbY16NlToQZ3yq63eE1mkZmV9FORGYIobZDrHiX
         TeeA==
X-Gm-Message-State: APjAAAXKn9oNBwLM/FMJX6Y8vWL7Xs67mSfruocA/8KixZ7nbbctUA7c
        Lg98WHbE6+cP4iyj8mKXW+Ow2w==
X-Google-Smtp-Source: APXvYqxlmrn4vCOCM63n0bYHkqdHPNQb6gpsY1ifkSBPQaaoJEJyOXcMw8pyvr3T9qt0hsicoCm+Xw==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr15836211wrs.121.1553717558870;
        Wed, 27 Mar 2019 13:12:38 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id z8sm23147795wrh.80.2019.03.27.13.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 13:12:38 -0700 (PDT)
Date:   Wed, 27 Mar 2019 21:12:37 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190327201237.GG14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:30PM CET, mkubecek@suse.cz wrote:
>Requests a contents of one or more string sets, i.e. indexed arrays of
>strings; this information is provided by ETHTOOL_GSSET_INFO and
>ETHTOOL_GSTRINGS commands of ioctl interface. There are three types of
>requests:
>
>  - no NLM_F_DUMP, no device: get "global" stringsets
>  - no NLM_F_DUMP, with device: get string sets related to the device
>  - NLM_F_DUMP, no device: get device related string sets for all devices
>
>It's possible to request all string sets of given type or only specific
>sets. With ETHA_STRSET_COUNTS flag, only set sizes (number of strings) are
>returned.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---
> Documentation/networking/ethtool-netlink.txt |  46 +-
> include/uapi/linux/ethtool.h                 |   2 +
> include/uapi/linux/ethtool_netlink.h         |  43 ++
> net/ethtool/Makefile                         |   2 +-
> net/ethtool/netlink.c                        |   8 +
> net/ethtool/netlink.h                        |   4 +
> net/ethtool/strset.c                         | 447 +++++++++++++++++++
> 7 files changed, 549 insertions(+), 3 deletions(-)
> create mode 100644 net/ethtool/strset.c

First of all, the code is hard to follow. For reasons I mentioned in
other replies (lack of prefixes, wrappers, etc).

More importantly, why do we need this? This concept of having strings in
kernel for various things and features and sending them to userspace is
weird. Certainly not common for Netlink interface. I believe these
strings should be avoided and all should be communicated to userspace
and back in form of well-defined Netlink attributes. We are introducing
new Netlink API, lets do it properly and don't bring baggage from past.
