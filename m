Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52CDFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4EF20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjQk+up0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390889AbfJPTLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:11:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55554 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfJPTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:11:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so4081627wma.5;
        Wed, 16 Oct 2019 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CC/Oz8bKqaGFSofX6Ax5x3Ge+1uAz440v/0zTckEN3g=;
        b=PjQk+up0muRoEZm4raHETsvdsjk4FbkAun42jKLH+uLOAJAw+Bh2BQ3SbsPrDeefmI
         LTkSNcd/ZyX7K+q9vjMZoH251ChO6HT7+7XZirypTea2B1FSn1a9SV7MzNNyhRpTK8JT
         MdmWMvlfk7hnWp0Wrly9wHDzQ5sWFb8LTiQYEAcF3JgyE2knomthyb1xoo0p4so+XGRC
         thfaxRbLE+XQKXMtuz8gXlpoZuHt2Nb8VfHAJMNztIzGFHo6s8ggZpYPQ0RT2GVOaqX1
         ukRzQEi5uOjoQaHBbZ89GgTNG6zFY/chlde5A9cDWOH4006/iMZqQueEz7xYPJB4s4Pq
         kOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CC/Oz8bKqaGFSofX6Ax5x3Ge+1uAz440v/0zTckEN3g=;
        b=jKHCuCiOB/dbWi/3NvJMKWojWy9+F1/gISl3ZRLaxvrgRBrskXhBe1reIm8+Ktg2mO
         UfG6wjCT3MhSkklnn8Fz+67xZJIyHCCMD1zjVEe1DJ1e8L67CzXMWN5bxbrhW6pBBb6L
         aBe1kCsScjJ8lAlnUdW0dwBDZGzac1O4mM7zofzw+w+RZByfzZDnPQcbqR4M9KwAgxDt
         xrT4dOwMz45wBWjd/FjgAGUCzE5HXjG/zMSu79ZgxHa/N2PtNApXl9yaMHo1hIu/dnCV
         ZXVpV1gBqr5Mr/DQbwVL9yGkKd3cF14BOR9sq04qpZKLwyOVM3igYR0zVdMHmDO4Nh9v
         PcpA==
X-Gm-Message-State: APjAAAVQJR7LCXdlW2lxtUscDfh/2yn3ptuVbN/gezwWA3L8Z7QvUUle
        RNqUWO2JrZGGwUhJ/8dRyxSKqj4d
X-Google-Smtp-Source: APXvYqwaF/88nLS0U5WgEhPgecpK0qKCac/hZu7LHmhAbGjUxlhqT7dfA8sHHKd9H3fXqtnKA/KsJA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr4927172wmb.89.1571253081847;
        Wed, 16 Oct 2019 12:11:21 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:d1a1:ef77:d584:db28? (p200300EA8F266400D1A1EF77D584DB28.dip0.t-ipconnect.de. [2003:ea:8f26:6400:d1a1:ef77:d584:db28])
        by smtp.googlemail.com with ESMTPSA id u11sm3155473wmd.32.2019.10.16.12.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 12:11:20 -0700 (PDT)
Subject: Re: [PATCH net] net: phy: Fix "link partner" information disappear
 issue
To:     Yonglong Liu <liuyonglong@huawei.com>, davem@davemloft.net,
        andrew@lunn.ch
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, shiju.jose@huawei.com
References: <1571193039-36228-1-git-send-email-liuyonglong@huawei.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <df0878a8-3961-072d-5812-4bb7d249eab8@gmail.com>
Date:   Wed, 16 Oct 2019 21:11:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571193039-36228-1-git-send-email-liuyonglong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2019 04:30, Yonglong Liu wrote:
> Some drivers just call phy_ethtool_ksettings_set() to set the
> links, for those phy drivers that use genphy_read_status(), if
> autoneg is on, and the link is up, than execute "ethtool -s
> ethx autoneg on" will cause "link partner" information disappear.
> 
> The call trace is phy_ethtool_ksettings_set()->phy_start_aneg()
> ->linkmode_zero(phydev->lp_advertising)->genphy_read_status(),
> the link didn't change, so genphy_read_status() just return, and
> phydev->lp_advertising is zero now.
> 
> This patch moves the clear operation of lp_advertising from
> phy_start_aneg() to genphy_read_lpa()/genphy_c45_read_lpa(), and
> if autoneg on and autoneg not complete, just clear what the
> generic functions care about.
> 
> Fixes: 88d6272acaaa ("net: phy: avoid unneeded MDIO reads in genphy_read_status")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
