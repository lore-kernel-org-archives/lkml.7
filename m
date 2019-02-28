Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F08C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96E520C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfB1TrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:47:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37780 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfB1TrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:47:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C14E14BF64D0;
        Thu, 28 Feb 2019 11:47:08 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:47:07 -0800 (PST)
Message-Id: <20190228.114707.11382969767373748.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     f.suligoi@asem.it, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: e1000e: add MAC address kernel cmd line
 parameter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190228192958.GA24085@lunn.ch>
References: <20190228163729.GB17912@lunn.ch>
        <6a7a37813e71420b929c769dd1e77664@asem.it>
        <20190228192958.GA24085@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Feb 2019 11:47:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Feb 2019 20:29:58 +0100

> On Thu, Feb 28, 2019 at 05:13:27PM +0000, Flavio Suligoi wrote:
>> > > Hi Andrew,
>> > >
>> > > we produce a lot of boards and we have to change the MAC address,
>> > > from u-boot, for every board.  So I must save in the u-boot
>> > > environment (SPI NOR flash) the MAC address for every board.
>> > 
>> > Hi Flavio
>> > 
>> > u-boot should be able to write the MAC address in the correct part of
>> > device tree. Boards have been doing this a long time.
>> > 
>> > Module parameters are considered bad. You should only do it if you
>> > have no other option. Here you do have another options, so it is going
>> > to be a hard sell getting David to access your patch.
>> > 
>> > You will have more success by adding a call to
>> > eth_platform_get_mac_address() to the e1000e driver.
>> 
>> You have right, and thanks for your suggestions, 
>> but with a kernel parameter I can use the same method
>> for any board where the NVM is missed, independently of any architecture
>> (with or without the device tree presence - ARM or x86 or others).
> 
> Hi Flavio
> 
> Well, lets wait for David to say what he thinks about the module
> parameter.

I already rejected this, no way... Drivers that already have the
unacceptable module parameter are no an argument for spreading this
mistake further.
