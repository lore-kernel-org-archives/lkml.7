Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01FEC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947FC20740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfL0WWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:22:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52984 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0WWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 17:22:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E596C154CAEAA;
        Fri, 27 Dec 2019 14:22:03 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:22:03 -0800 (PST)
Message-Id: <20191227.142203.849415745093767537.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     antoine.tenart@bootlin.com, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=whpoNwcb2fXH3e=pFjY1Tjb9rHLVjq_q-OzK3FMgvx2wA@mail.gmail.com>
References: <20191221.180914.601367701836089009.davem@davemloft.net>
        <CAHk-=whpoNwcb2fXH3e=pFjY1Tjb9rHLVjq_q-OzK3FMgvx2wA@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Dec 2019 14:22:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Dec 2019 14:13:03 -0800

> I didn't notice until now (bad me - I've actually been taking a few
> days off due to xmas), but this causes a new warning in some
> configurations.
> 
> In particular, it causes a warning about
> 
>    'of_mdiobus_child_is_phy' defined but noy used
> 
> because when CONFIG_OF_MDIO is disabled, the <linux/of_mdio.h> header now has
> 
>   static bool of_mdiobus_child_is_phy(struct device_node *child)
>   {
>          return false;
>   }
> 
> which is all kinds of stupid.
> 
> I'm assuming that dummy function should just be marked "inline", the
> way the other helper dummy functions are defined when OF_MDIO is not
> enabled.

Yeah I have this fixed in my tree, I'll push that to you soon.

Thanks.
