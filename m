Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD28AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A8720857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="vH3GlHBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfCZKWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:22:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51148 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:22:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so12067943wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lRVZi2r3G7VUSF3IA05APgb6NuW2Y3SH/ohQpo5admk=;
        b=vH3GlHBq/V16PQuKuyAWiSwwPoAHZCGKlM7oper6rqeI+RUvvCqgXfKpK9TKG0mZ0r
         ozTPwnhbpB4H3kwLS3PoFcykkwfsBHVng+9O6VYW1JA8r2+o6alZFOPH7TVYlbAdxM6U
         JcBz44JWsBZRJyUfKdooNCLCXpRShHW6noRLihchcUUyJ+f4hOhSG2GnvJhEno48cbw5
         Q8cZjm0JUUhRsN+wWcbhKLPS0ql5N9YQ84gLSSHcI0K15+2987e/54p0IRMxJg+ILQWg
         wQBAnhBGOj3weYPIuD3dqH8Arg41LCowU7NVLTAMXLMT3NXjwfAggcrglpf4xc8TCEus
         wRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lRVZi2r3G7VUSF3IA05APgb6NuW2Y3SH/ohQpo5admk=;
        b=F632v0XEgYobyJAAMC6LjJM7NYmqPZR0OGP+12XYRToXEnPP+yH91QGvfnjEpgOs8p
         /fT++uQw50HOnCDp7POQv9att7q+ATwhzPO5WAqWRUnLMCoLVAOkmQxBPAxYKKmdUAub
         0Qjcc9fFXkFRgxEs4E1ynyA0E4/sRwF3ROlw6wDqhcBZB1qaWFYAH6/6NIonGrfVzRuF
         3ViOuWp55KOS+3/lflhDreS6bHDDc6+WcSmhAHqDkkjq9cyVv33ywcyO5H36kmo/dE0c
         2ymIUFc4NkO3XrbBg5o0SkMMPyha2c9GO6HOGqhaE1+3/ELGubPmJA+/v8KXEtVY/g92
         fuuA==
X-Gm-Message-State: APjAAAVtu2pb0ILj/fc5YWHFgaAkLovo26YpB5jxzHTiAh8HN+qUO1y8
        TnsZyJf3eZlJZX8F/JQcXoxmOfW1FdA=
X-Google-Smtp-Source: APXvYqyRDKTzAgCU5Fi92Ysk+tdSh8NrDXVt3cutUlgT97COwcMPT7jb8Q7P/Z6TSdNfIzUjfr59cg==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr9206191wmb.101.1553595734421;
        Tue, 26 Mar 2019 03:22:14 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id b3sm22047351wrx.57.2019.03.26.03.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:22:14 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:11:26 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 03/22] netlink: add strict version of
 nla_parse_nested()
Message-ID: <20190326101126.GC2230@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3a0ca34890256f86a4ca0c4f4582a0cff5af95ad.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0ca34890256f86a4ca0c4f4582a0cff5af95ad.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:03PM CET, mkubecek@suse.cz wrote:
>Similar to nla_parse_strict() and nlmsg_parse_strict(), add also
>nla_parse_nested_strict() as a version of nla_parse_nested() with strict
>policy checking.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Acked-by: Jiri Pirko <jiri@mellanox.com>

