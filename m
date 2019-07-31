Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8E3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40F9206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfGaW5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:57:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45114 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfGaW5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:57:08 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6017F1264EC7E;
        Wed, 31 Jul 2019 15:57:07 -0700 (PDT)
Date:   Wed, 31 Jul 2019 18:57:05 -0400 (EDT)
Message-Id: <20190731.185705.323737673654483593.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: phy_led_triggers: Fix a possible
 null-pointer dereference in phy_led_trigger_change_speed()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190730080813.15363-1-baijiaju1990@gmail.com>
References: <20190730080813.15363-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Jul 2019 15:57:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Tue, 30 Jul 2019 16:08:13 +0800

> In phy_led_trigger_change_speed(), there is an if statement on line 48
> to check whether phy->last_triggered is NULL: 
>     if (!phy->last_triggered)
> 
> When phy->last_triggered is NULL, it is used on line 52:
>     led_trigger_event(&phy->last_triggered->trigger, LED_OFF);
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, led_trigger_event(&phy->last_triggered->trigger,
> LED_OFF) is called when phy->last_triggered is not NULL.
> 
> This bug is found by a static analysis tool STCheck written by
> the OSLAB group in Tsinghua University.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thanks.
