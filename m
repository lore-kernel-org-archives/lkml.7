Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A11ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831EF21D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UnY1yUEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfJKJ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:26:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33372 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfJKJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:26:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191011092605euoutp016d5ebfdd1fc4d6a294b3dae493afea85~MjYNjZsFf3004930049euoutp01q
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 09:26:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191011092605euoutp016d5ebfdd1fc4d6a294b3dae493afea85~MjYNjZsFf3004930049euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570785965;
        bh=l8hQnd/vXn3nilLKdtHCXyRoPm0qbS2aAe1CdP8UEWo=;
        h=To:Cc:From:Subject:Date:References:From;
        b=UnY1yUEOIGax06Q/c6cB4qFQg86WTV7xDGg0v+5xPJa1KFsWD39o798XGhIaqwO5k
         K4epAVNgdylbzQ4XLoXJGeTs8OxHuFrLsY34tRBY5VQzMDyx3Cg+keNWhA2nOwWm2i
         /SoIii3vbryARW5+70DxQ7QfSgKb5ezYhOQ6vHh0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191011092605eucas1p2e1b05ec62cfa1a7586c143b14fafb8cb~MjYNQOBH70254002540eucas1p2U;
        Fri, 11 Oct 2019 09:26:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F2.B0.04309.DAA40AD5; Fri, 11
        Oct 2019 10:26:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b~MjYM1UU4K1739217392eucas1p1Y;
        Fri, 11 Oct 2019 09:26:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191011092604eusmtrp1387a4e03f6c2008eb0a0c6d58a22cf98~MjYM0rgCX1047210472eusmtrp1w;
        Fri, 11 Oct 2019 09:26:04 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-d0-5da04aad12e9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.7F.04166.CAA40AD5; Fri, 11
        Oct 2019 10:26:04 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191011092604eusmtip2e55fbdc1d29c28849451e84a08a2c2a1~MjYMciyjS1392113921eusmtip2b;
        Fri, 11 Oct 2019 09:26:04 +0000 (GMT)
To:     linux-arm-kernel@lists.infradead.org
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
Message-ID: <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
Date:   Fri, 11 Oct 2019 11:26:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3e3V1Hk+tUPGhkDgp7qCkqN0orCRoSpNgfUYyc7TIlN2XX
        Z0FJiuYQFB+pY6lYPtOyWbpWmC5qlWIPydSiGkqaNQucliUrt6vlf59zvuf1hUNi4ia+L5mi
        zmA0anmqhBDiPY+XhoM6YxtkuyuXBPS35hJEGyZH+fSISU/Q/U1FOP3194yAbnlmxOmCdxEH
        BNKOug4kNbQXE9Luaxek84bNcfgJ4T4Fk5qSxWhCohOFyY1Nb4n0OX7O4vxrQR4awbXIjQQq
        HMr/POBpkZAUU60IrrY2I6cgpuwI9AsJnDCP4NP0OFrrsBnyMU5oQbBgMhFcYEPQY51xzfWi
        AqFSOylwChg1h6B0rIbnFAgqFLQ2LeFkTyoKfjV2ucaKqGioqBvFnIxTW+GzednF3pQM3v+0
        YFyNBzytnXItwCh/6LXpMY59YGKq3mUCqFIBlFY5CO7WQ3C9akjAsSfMWm6v8iYYrCjBuYZ8
        BNbhTgEXlCAYuViz6nQvPLS85GsRubJiO9w0hXDpg3Bl4AnPmQbKHcZsHtwR7lDeU41xaRFc
        KhRz1dtAZ7nxb+3Ai1cYx1KYrjbzylCAbp013TprunXWdP9vaEB4O/JhMlmVkmHD1Ex2MCtX
        sZlqZfDpNJUBrTzPoMNiNyLTcpIZUSSSbBTV+NfLxHx5FpurMiMgMYmXqFGnl4lFCnnuWUaT
        dkqTmcqwZuRH4hIf0bkNH0+KKaU8gznDMOmMZk3lkW6+eajcXJBQ0ee+0ObPt3cfv+UdPnS0
        JCmDXrwTh3/HEkvbhrGufijexbP/cCiiCvuMjxpjkpXdiYdNgbHt8/HZTUahdTxsqXfn4p64
        SLv1jeF55hZlrcnvg6MoAp0Piv+iuR8J3sfuKkYmsKoAbIFWRByR7s+hLt9zSGdjyo6GS3A2
        WR66A9Ow8r8EalHAOAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7prvBbEGmxaqW7xflkPo8Wmx9dY
        LS7vmsNmcWBpO4vFm98v2C2Wn9rBYtFyx9SB3WPNvDWMHptWdbJ5bF5S7/F5k1wAS5SeTVF+
        aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexqKlt9kK3rFW
        fPt8lb2B8TJLFyMnh4SAicTbTc3MILaQwFJGid13uCHiMhInpzWwQtjCEn+udbF1MXIB1bxm
        lHiycy4TSEJEQENiStdjdpAEs8A7RokH3fvZQRJsAoYSXW9BOjg5hAVsJX4t2sAIYvMK2ElM
        nncNbBuLgKrEy0N/gGwODlGBWIlNe80gSgQlTs58AnYcs4CZxLzND5khbHmJ7W/nQNniEree
        zGeawCgwC0nLLCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg1Gw79nPz
        DsZLG4MPMQpwMCrx8H5QnB8rxJpYVlyZe4hRgoNZSYR30aw5sUK8KYmVValF+fFFpTmpxYcY
        TYH+mcgsJZqcD4zovJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFIN
        jOU+25I/nV6+g4e3RPeua4Pdst9c/nzHZZp3rHU185d5YN23KtLlUr+3xT2lL1emWK3MvZxX
        +TTt+bI02YDkgnYRtaiH9n6tqZwdz89MWSm7uXOr86rM4ridqbqh4Xlcb16bb73KwaG+3OzP
        saSvYrM3X78ZNm9WqOctv3shXU+Nzyi9KYzOV2Ipzkg01GIuKk4EANNXmfewAgAA
X-CMS-MailID: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Recently I've got access to ARM Juno R1 board and did some tests with 
current mainline kernel on it. I'm a bit surprised that enabling 
CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling 
this Kconfig option, I get no single message from the kernel, although I 
have earlycon enabled.

I've did my test with default defconfig and current linux-next, 
v5.4-rc1, v5.3 and v4.19. In all cases the result is the same. I'm 
booting kernel using a precompiled uboot from Linaro release and TFTP 
download.

Is this a known issue? Other ARM64 boards I have access to (Samsung TM2e 
and RaspberryPi3) boots fine with the same kernel image.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

