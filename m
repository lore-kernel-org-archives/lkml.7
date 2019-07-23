Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB5C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C267521E70
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbfGWDnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:43:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbfGWDnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:43:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 599CC15310D30;
        Mon, 22 Jul 2019 20:43:51 -0700 (PDT)
Date:   Mon, 22 Jul 2019 20:43:48 -0700 (PDT)
Message-Id: <20190722.204348.1777955613668064779.davem@davemloft.net>
To:     hslester96@gmail.com
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: Merge cpu_to_le32s + memcpy to
 put_unaligned_le32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CANhBUQ0FMJATcjkb0RYyM8LhA92htq9mddLqcNB94FcxMBGsbg@mail.gmail.com>
References: <20190722074133.17777-1-hslester96@gmail.com>
        <20190722.182235.195933962601112626.davem@davemloft.net>
        <CANhBUQ0FMJATcjkb0RYyM8LhA92htq9mddLqcNB94FcxMBGsbg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jul 2019 20:43:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 23 Jul 2019 10:16:27 +0800

> David Miller <davem@davemloft.net> 于2019年7月23日周二 上午9:22写道：
>>
>> From: Chuhong Yuan <hslester96@gmail.com>
>> Date: Mon, 22 Jul 2019 15:41:34 +0800
>>
>> > Merge the combo uses of cpu_to_le32s and memcpy.
>> > Use put_unaligned_le32 instead.
>> > This simplifies the code.
>> >
>> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>>
>> Isn't the skb->data aligned to 4 bytes in these situations?
>>
>> If so, we should use the aligned variants.
>>
>> Thank you.
> 
> I have checked the five changed files.
> I find that they all have used get_unaligned_le32 for skb->data
> according to my previous applied patches and existing code.
> So I think the skb->data is unaligned in these situations.

Thank you for checking.

Patch applied to net-next.
