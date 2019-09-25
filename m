Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB61C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53C221D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tWFEpt1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438401AbfIYPAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:00:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfIYPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:00:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so7307467wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yrL9qSy/3grZaifloxyMrl1qoRWf0gLjQ/fLitAs1Sg=;
        b=tWFEpt1lBq/s0U7lRRMcg92G7ibk3Zphd/xQ6319ivkDGRcwuA2VsUEEhRXg6p3Rmo
         UFFLhSxCcBbU50mqQ0W8FKmttRbATzcWCmWzUlzCYmIZf7A17ZZWEAdjUO3Mltty3bJV
         gPuGpquxOoSIhqEJg9Oa8QbSXdbCW277ihBHN4xSJurJgqArzSADU2YFcSm5U73benaB
         CseZ5S9N3BtBYiecF3XIxDjZ2ZSvHqLN7yJQQZNDkFJWfr8qH7co/SD6q7xm1QQdVXbE
         URk33RcMwYrT1AJwrVuvrmUKTijJubzDzzZcglUtnKOBSJhwpSL4ci9KcKrbyZ3YSve1
         djtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yrL9qSy/3grZaifloxyMrl1qoRWf0gLjQ/fLitAs1Sg=;
        b=llsnKyx1ExcpIpnR40RCmLQX28VMHwrCg38JwvrcOJmaO4VVxk2jXqest772FIZnJq
         9MbR+XuNDJm2MQJUlhtOd8H5da0gB/qKGIPyPebXZ/FFo1Z93bsV8VervGHHcDtycV7E
         pdEDfkmVVF7DDe5MfXTeU7E2ZjX2xVS6ZSVrkVTsVNRxFbzSEzpul+DSngNRw6u2bDwy
         us+JheFQPiNBNGsjS1wC0fk5xcjW1IE7Ysfgdh0lekT3Fb2S0vmERouWwpL5adYEFBIQ
         h5/SKc4zCYBSnW41FaYMhcUBtzJEBeAseH8mDL46Yj/ve25nmKF0OCFQmljVwDLKKSmE
         YMzA==
X-Gm-Message-State: APjAAAXFzHs2U94hmKk+2sHpyms49c5oZtcMP30I2wNwjpE/Y/oiDHKR
        rmdDU2V6ZLrTkhFjRxo2v4c1qzZMSN+0Qk3+
X-Google-Smtp-Source: APXvYqzY26KY3DPvEXCysVewS/BT+v0bJdfTqB6QhZQoHrrjhoEyJyWKY2tBc0+lQU6tMfc61ziGzQ==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr10224298wrr.334.1569423620189;
        Wed, 25 Sep 2019 08:00:20 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:87a6])
        by smtp.gmail.com with ESMTPSA id o9sm9880475wrh.46.2019.09.25.08.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 08:00:19 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32\@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: stmmac: Fix ASSERT_RTNL() warning on suspend/resume
In-Reply-To: <BN8PR12MB3266A4C33D234165A0F2A978D38F0@BN8PR12MB3266.namprd12.prod.outlook.com>
References: <1568714556-25024-1-git-send-email-lollivier@baylibre.com> <BN8PR12MB3266A4C33D234165A0F2A978D38F0@BN8PR12MB3266.namprd12.prod.outlook.com>
Date:   Wed, 25 Sep 2019 17:00:13 +0200
Message-ID: <86ftkkzaiq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17 Sep 2019 at 10:12, Jose Abreu <Jose.Abreu@synopsys.com> wrote:

> From: Loys Ollivier <lollivier@baylibre.com>
> Date: Sep/17/2019, 11:02:36 (UTC+00:00)
>
>> rtnl_lock needs to be taken before calling phylink_start/stop to lock the
>> network stack.
>> Fix ASSERT_RTNL() warnings by protecting such calls with lock/unlock.
>> 
>> Fixes: 74371272f97f ("net: stmmac: Convert to phylink and remove phylib logic")
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>
> I already sent a fix for this. Please see in -net:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/driv
> ers/net/ethernet/stmicro/stmmac?id=19e13cb27b998ff49f07e399b5871bfe5ba7e3
> f0

Ah good catch :)

>
> ---
> Thanks,
> Jose Miguel Abreu
