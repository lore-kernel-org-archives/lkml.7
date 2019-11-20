Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2135C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 03:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7CD2240E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 03:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKTDSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:18:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49180 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKTDSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 22:18:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4FDA2146D5FD8;
        Tue, 19 Nov 2019 19:18:04 -0800 (PST)
Date:   Tue, 19 Nov 2019 19:18:03 -0800 (PST)
Message-Id: <20191119.191803.1036643221927656820.davem@davemloft.net>
To:     geert@linux-m68k.org
Cc:     f.fainelli@gmail.com, geert+renesas@glider.be,
        yuehaibing@huawei.com, andrew@lunn.ch, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdio_bus: Fix init if CONFIG_RESET_CONTROLLER=n
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAMuHMdW+Lkj1VRbS-1Qw8YsbPYueFrM770eBRv=e_sTg8vbiVg@mail.gmail.com>
References: <20191119112524.24841-1-geert+renesas@glider.be>
        <1afede33-897b-8718-d977-351357dffe4f@gmail.com>
        <CAMuHMdW+Lkj1VRbS-1Qw8YsbPYueFrM770eBRv=e_sTg8vbiVg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Nov 2019 19:18:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Nov 2019 19:55:53 +0100

> Hi Florian,
> 
> On Tue, Nov 19, 2019 at 7:05 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 11/19/19 3:25 AM, Geert Uytterhoeven wrote:
>> > Commit 1d4639567d970de0 ("mdio_bus: Fix PTR_ERR applied after
>> > initialization to constant") accidentally changed a check from -ENOTSUPP
>> > to -ENOSYS, causing failures if reset controller support is not enabled.
>> > E.g. on r7s72100/rskrza1:
>> >
>> >     sh-eth e8203000.ethernet: MDIO init failed: -524
>> >     sh-eth: probe of e8203000.ethernet failed with error -524
>> >
>> > Fixes: 1d4639567d970de0 ("mdio_bus: Fix PTR_ERR applied after initialization to constant")
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> This has been fixed in the "net" tree with:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=075e238d12c21c8bde700d21fb48be7a3aa80194
> 
> Ah, hadn't seen that one.
> 
> However, that one (a) keeps the unneeded check for -ENOSYS, and (b)
> carries a wrong Fixes tag.

Linus took Geert's fix so I reverted the one in 'net' and cherry picked
Geert's fix from Linus's tree.

Just FYI...
