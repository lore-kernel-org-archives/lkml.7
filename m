Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D10C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41A3207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfCZAPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:15:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60256 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfCZAPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:15:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 36FF914B79D22;
        Mon, 25 Mar 2019 17:15:36 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:15:35 -0700 (PDT)
Message-Id: <20190325.171535.433266812521244784.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: fix a potential NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190323033942.21796-1-kjlu@umn.edu>
References: <20190323033942.21796-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Mar 2019 17:15:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 22 Mar 2019 22:39:42 -0500

> @@ -485,6 +485,8 @@ static int dwc_eth_dwmac_remove(struct platform_device *pdev)
>  	int err;
>  
>  	data = of_device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return -EINVAL;
>  
>  	err = stmmac_dvr_remove(&pdev->dev);
>  	if (err < 0)
> -- 
> 2.17.1
> 

Please show me the entry in dwc_eth_dwmac_driver that has a NULL of_match_table
field.

Otherwise I'm not applying this.
