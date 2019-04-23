Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E295C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6705820835
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfDWR0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:26:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39730 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbfDWR0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:26:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E9878133E8184;
        Tue, 23 Apr 2019 10:26:11 -0700 (PDT)
Date:   Tue, 23 Apr 2019 10:26:08 -0700 (PDT)
Message-Id: <20190423.102608.343500084156113302.davem@davemloft.net>
To:     mw@semihalf.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, antoine.tenart@bootlin.com,
        jaz@semihalf.com, gregory.clement@bootlin.com, nadavh@marvell.com,
        thomas.petazzoni@bootlin.com, linux@armlinux.org.uk,
        tn@semihalf.com, stefanc@marvell.com
Subject: Re: [net: PATCH] net: mvpp2: disable link IRQ waiting for IDLE
 frames
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAPv3WKcDgY_LY_u8mY47ZZqT2iVL9fp5n3Le0UVWsyO4QDYP-A@mail.gmail.com>
References: <20190228093627.vtfglsl2djenohlm@shell.armlinux.org.uk>
        <CAPv3WKdj+EKr2VR+NcBHQrS9xoxHoMzZOri65G61CH6xLL8jFw@mail.gmail.com>
        <CAPv3WKcDgY_LY_u8mY47ZZqT2iVL9fp5n3Le0UVWsyO4QDYP-A@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Apr 2019 10:26:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Tue, 23 Apr 2019 18:08:00 +0200

> Hi David, Rusell,
> 
> czw., 28 lut 2019 o 14:58 Marcin Wojtas <mw@semihalf.com> napisa©©(a):
>>
>> Hi Russell,
>>
>> czw., 28 lut 2019 o 10:36 Russell King - ARM Linux admin
>> <linux@armlinux.org.uk> napisa©©(a):
>> >
>> > On Wed, Feb 27, 2019 at 06:47:32PM +0100, Marcin Wojtas wrote:
>> > > Current version of the driver was configuring XLG MAC
>> > > in a way to wait 3 IDLE frames before allowing for the
>> > > link-up interrupt to be triggered. This resulted in an
>> > > issue, preventing to detect the link change during RX
>> > > traffic on the interface. Fix that.
>> >
>> > What about noise sensitivity?  Does this now mean that on boards such as
>> > Macchiatobin Single Shot or Clearfog GT9k where the serdes is connected
>> > directly to a SFP cage, that noise on the serdes lines triggers a link
>> > indication?
>> >
>>
>> Afaik waiting for idle frames is not required by any standard. In fact
>> this feature of the XLG MAC caused a risk that after dropping the link
>> during data transfer it would never go up again until remote peer
>> stops it.
>>
>> I tested it on 3 different boards with SerDes directly connected to
>> the SFP cage and I'm also not aware of any reporte about
>> noise-triggered false link interrupts in XLG MAC (proprietary Marvell
>> mvpp2x driver did not use waiting 3 idle frames feature). I'd rather
>> assume the MAC is not vulnerable to it, and only properly established
>> link can trigger an event.
>>
> 
> This patch seems to get forgotten - any objections to merge it?

If there is agreement, please repost it.

Thank you.
