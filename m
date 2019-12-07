Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9DCC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B7824681
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLGT5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:57:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42814 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLGT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:57:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8A7A515421AED;
        Sat,  7 Dec 2019 11:57:54 -0800 (PST)
Date:   Sat, 07 Dec 2019 11:57:54 -0800 (PST)
Message-Id: <20191207.115754.627115468855491396.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, hkallweit1@gmail.com
Subject: Re: [PATCH v2] net: phy: dp83867: fix hfs boot in rgmii mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191206123432.25257-1-grygorii.strashko@ti.com>
References: <20191206123432.25257-1-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Dec 2019 11:57:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 6 Dec 2019 14:34:32 +0200

> The commit ef87f7da6b28 ("net: phy: dp83867: move dt parsing to probe")
> causes regression on TI dra71x-evm and dra72x-evm, where DP83867 PHY is
> used in "rgmii-id" mode - the networking stops working.
> Unfortunately, it's not enough to just move DT parsing code to .probe() as
> it depends on phydev->interface value, which is set to correct value abter
> the .probe() is completed and before calling .config_init(). So, RGMII
> configuration can't be loaded from DT.
> 
> To fix and issue
> - move RGMII validation code to .config_init()
> - parse RGMII parameters in dp83867_of_init(), but consider them as
> optional.
> 
> Fixes: ef87f7da6b28 ("net: phy: dp83867: move dt parsing to probe")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> v2:
>  - fixed comments in code

Applied.
