Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB061C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882BF2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIrJtXqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfC1G66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:58:58 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:46452 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1G65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:58:57 -0400
Received: by mail-lf1-f45.google.com with SMTP id r25so13155483lfn.13;
        Wed, 27 Mar 2019 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=bG9nur6wczXHYH79nzV+JTWbgH4BaqrOp760u6uBeeU=;
        b=UIrJtXqmUZtXrc/A5rksh6cvrQ0aerTQrJp8H+scTBVUkUPzQw+/CHdXR8P+QhKW5K
         EPk3Zqp/haV0QPtJ49BU8ZqXI2EOx1XUEvDjc4aJ9cWw1kbTddWdNOiOW16ko5MhBV3f
         M6zrLxFtHZV/qnK8MhOwxm4t7FRBLxhZVHY/7CVep3+SLi/964b94nwgMypKlWr81Eqa
         zaQMaQZM/Cjtng1AoRzadwTW3R/MNrthTHP/P9YhEsIypJuSs/CKvp9kKS9gNRlBo+pz
         fIgU1nSesTx33e+56yt/9oiWPNKpRuEQBWjUHR1fTiftWTwTdPknDWK63ct436AIDA80
         7g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bG9nur6wczXHYH79nzV+JTWbgH4BaqrOp760u6uBeeU=;
        b=uWSfWy9GJ6LLB4PVjaFrNk9iLadVZVTtN4WDfZjO+0PTKCqvGNUoaxHhtigM4C5a2h
         S4xPb+IsAevG4g7TQuPa5dztJ6Xx12okPUNk2gnteCYMWcqchBejllrS8mS+tZRmJ0EU
         U2skLyM/7hyDcZ6XUIU1IgM93R6mGg8b5qPI3w8SHEUdjCbTew1/dM3FDR81wg02SZvB
         xbw/WXAwgrAUIkvY4LTswIJUzKQPy369NGyfTqka6BytCe6UU9KcIUgWFIrqLpz4WBhT
         X7PATRY+kC3A61wE81QbzJGQN8KrokblNqBqa/Qbp8m0VO5ehD3/PMgrMwNYZT5CbL4C
         Ry+Q==
X-Gm-Message-State: APjAAAV5c46tEKVR4xr0dBkuXFCgn5w9BCXcUzhgPU3nYYQCqTWZbNV7
        Jnr1Qul9kERTswIOcrqbsOU=
X-Google-Smtp-Source: APXvYqwetZeNxPzGKjIIUbExfO0aurDL81vsiPY3bZKKtqUaaalM6OyMhQiPTzaP5rtEwp1SHVQ4Iw==
X-Received: by 2002:a19:ec17:: with SMTP id b23mr19909696lfa.76.1553756335258;
        Wed, 27 Mar 2019 23:58:55 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id l15sm1618241ljh.62.2019.03.27.23.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 23:58:54 -0700 (PDT)
Subject: Re: Issues with i.MX SPI DMA transfers
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <AM0PR04MB4211375B0647DE67D8C7406280590@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <ec3fdef9-8f74-1a5a-e34a-d66b9e28dc5d@gmail.com>
Date:   Thu, 28 Mar 2019 09:58:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211375B0647DE67D8C7406280590@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

I have update about these issues.

12 hours testing show very fast (some seconds) appearance of byte 
duplication at interface spi4 (alias for ecspi5), while interfaces spi0 
(alias for ecspi1) and spi1 (alias for ecspi2) work flawless (at least 
without any other OS load).

Looks like, ecspi5 has some different configuration in SPI or SDMA 
drivers or bug in SDMA script.

Any ideas?

Best wishes.

--

Igor Plyatov


