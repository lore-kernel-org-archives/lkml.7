Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE40206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCKRjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:39:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39488 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:39:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6C35514C4E3DC;
        Mon, 11 Mar 2019 10:39:40 -0700 (PDT)
Date:   Mon, 11 Mar 2019 10:39:39 -0700 (PDT)
Message-Id: <20190311.103939.277829855981067209.davem@davemloft.net>
To:     eric.dumazet@gmail.com
Cc:     alexandre.belloni@bootlin.com, kjlu@umn.edu, pakki001@umn.edu,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ocelot_board: fix a NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <d61f3d5e-6f8c-5a44-447a-7fc96cb65037@gmail.com>
References: <20190311063632.21111-1-kjlu@umn.edu>
        <20190311102600.GB1637@piout.net>
        <d61f3d5e-6f8c-5a44-447a-7fc96cb65037@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 10:39:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 11 Mar 2019 07:14:58 -0700

> 
> 
> On 03/11/2019 03:26 AM, Alexandre Belloni wrote:
>> On 11/03/2019 01:36:32-0500, Kangjie Lu wrote:
>>> In case devm_kcalloc fails, the fix returns -ENOMEM to avoid
>>> NULL pointer dereference.
>>>
>>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> 
> 
> A proper error path is needed to avoid memory leaks.

This seems to be a major chronic problem with all of these patches.

Kangjie please put more care into the patches you are submitting.

You absolutely CANNOT just add a error check and return, you must
handle releasing resources and any other necessary cleanups.
