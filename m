Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F7AC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A9206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 16:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="lU/QjJsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfJLQdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 12:33:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36994 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfJLQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 12:33:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so15040802wro.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WK0aZtBfkjzF2vB8/5+pzziZzjABmbX2uXNAi/6qqVY=;
        b=lU/QjJsd0iMUxgEz3IhsP8HaMvgoGdR4I/B6oB9obychkcm1NXhuKGhvEAUnEXPXQK
         KVisFsqiRvr6/mNpVqZxlMkZJxxNPijRUFARXQlQIztCL7oEgpVVOPwW2GqsWaLRyLv7
         Yq1wBpnSSsmQ5JVxw7sE0Ya5BbVBxmNT+f70ZVTq5kHPEb8ky+dwAPutUHbRNiKaleXu
         2YpYP2Z7SfF9VABD19W/sDZQcSEceF7OPiZxAHrTkZbFc5DyzBzKIB8VNmv8d3DaSZIz
         wmii5ceGd719vgr7vM3DawcdFYCbeLLkcNAieHPrxO6U1+8CSW+79ioVlh5QXEgVbm8k
         Qpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WK0aZtBfkjzF2vB8/5+pzziZzjABmbX2uXNAi/6qqVY=;
        b=FGc6x3y+qZ6/2nXiO6eQUI8Bc6aEX7E99g57Cv84QAngE86p/2F2e+pkSyRHNd6Dv9
         Uag2D0gP7VXrUKUpJUvw9Ay3kiA+35zjKE7cvekS8S51ZFEUwwp2KpFpJVxmW2G0QnaZ
         ATEJYxtElLMXnqRD0Ai8zuxhiExRvpRuK2uJGnHGEF6gXrynseIl8AECi91v15VdAR4n
         wH+ZkBon+kBCAvxmVSnhovXFFVu66ThIoStqM2QzNdx4Y9DJVaOm4kz0ytJRQ9nqlZzI
         1IlN+Yijq3QuXnkSKyIEFCfb6dwIS96TOe6uwHJ5Cx8OIFBHi7Qj7nHkdRtWdzd6Op1+
         88Lw==
X-Gm-Message-State: APjAAAU3iXBaHAtYA+FmYS+YC+TSOKYODDEQRZpTumU1I6gH5abbT19C
        xhRpoC0+KEqhVkmdlklTSD2tdg==
X-Google-Smtp-Source: APXvYqx0gE9jjfI4wMYpx2TWxq6U428URJZdGf7D1iK2MfrVuLbFKwv4kZ5uQ3X6jHg3QLv4d4rKag==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr17622633wro.145.1570897990815;
        Sat, 12 Oct 2019 09:33:10 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id l18sm14362413wrc.18.2019.10.12.09.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 09:33:10 -0700 (PDT)
Date:   Sat, 12 Oct 2019 18:33:09 +0200
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
Subject: Re: [PATCH net-next v7 14/17] ethtool: set link settings with
 LINKINFO_SET request
Message-ID: <20191012163309.GA2219@nanopsycho>
References: <cover.1570654310.git.mkubecek@suse.cz>
 <aef31ba798d1cfa2ae92d333ad1547f4b528ffa8.1570654310.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef31ba798d1cfa2ae92d333ad1547f4b528ffa8.1570654310.git.mkubecek@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 09, 2019 at 10:59:43PM CEST, mkubecek@suse.cz wrote:

[...]

>+static const struct nla_policy linkinfo_hdr_policy[ETHTOOL_A_HEADER_MAX + 1] = {
>+	[ETHTOOL_A_HEADER_UNSPEC]		= { .type = NLA_REJECT },
>+	[ETHTOOL_A_HEADER_DEV_INDEX]		= { .type = NLA_U32 },
>+	[ETHTOOL_A_HEADER_DEV_NAME]		= { .type = NLA_NUL_STRING,
>+						    .len = IFNAMSIZ - 1 },

Please make ETHTOOL_A_HEADER_DEV_NAME accept alternative names as well.
Just s/IFNAMSIZ/ALTIFNAMSIZ should be enough.

>+	[ETHTOOL_A_HEADER_GFLAGS]		= { .type = NLA_U32 },
>+	[ETHTOOL_A_HEADER_RFLAGS]		= { .type = NLA_REJECT },
>+};

[...]
