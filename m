Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F92C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28DE206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGBCM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:12:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53946 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBCM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:12:28 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1B8E14DE8844;
        Mon,  1 Jul 2019 19:12:27 -0700 (PDT)
Date:   Mon, 01 Jul 2019 19:12:27 -0700 (PDT)
Message-Id: <20190701.191227.1363312826504012690.davem@davemloft.net>
To:     johannes@sipsolutions.net
Cc:     Jason@zx2c4.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: use 48 byte ctx instead of 6 signed longs for
 callback
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0092b0b405e02ac7401ceaad2ea650abc44559ea.camel@sipsolutions.net>
References: <20190628144022.31376-1-Jason@zx2c4.com>
        <0092b0b405e02ac7401ceaad2ea650abc44559ea.camel@sipsolutions.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jul 2019 19:12:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 28 Jun 2019 16:42:26 +0200

> On Fri, 2019-06-28 at 16:40 +0200, Jason A. Donenfeld wrote:
>> People are inclined to stuff random things into cb->args[n] because it
>> looks like an array of integers. Sometimes people even put u64s in there
>> with comments noting that a certain member takes up two slots. The
>> horror! Really this should mirror the usage of skb->cb, which are just
>> 48 opaque bytes suitable for casting a struct. Then people can create
>> their usual casting macros for accessing strongly typed members of a
>> struct.
>> 
>> As a plus, this also gives us the same amount of space on 32bit and 64bit.
>> 
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> Cc: Johannes Berg <johannes@sipsolutions.net>
> 
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Applied to net-next.
