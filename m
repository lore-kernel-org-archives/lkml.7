Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1162DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55362085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfCGRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:49:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52294 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfCGRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:49:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 98711147B05F8;
        Thu,  7 Mar 2019 09:49:52 -0800 (PST)
Date:   Thu, 07 Mar 2019 09:49:52 -0800 (PST)
Message-Id: <20190307.094952.931716686086981512.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com
Subject: Re: [PATCH] net: stmmac: Avoid sometimes uninitialized Clang
 warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307162101.29204-1-natechancellor@gmail.com>
References: <20190307162101.29204-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Mar 2019 09:49:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu,  7 Mar 2019 09:21:01 -0700

> @@ -565,7 +565,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>  	u32 ts_master_en = 0;
>  	u32 ts_event_en = 0;
>  	u32 value = 0;
> -	u32 sec_inc;
> +	u32 sec_inc = 0;
>  	bool xmac;

Please don't break the reverse christmas tree ordering here, thank you.
