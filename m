Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F352FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBC12186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ry4Z/mOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfCONx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:53:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:12148 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfCONx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552658035;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mGhX0S4lYxtmzOM+9QbzJSmKiAcSM/0RnhP9G+YJkUM=;
        b=ry4Z/mOiIqXS+SP2OVrHC6tFG9b6pw/pOpDbUovaaYmU25R3QMeuwDDMlAZYGP9I9s
        oz7Spc5ZqStFmUixZcpHrNwFqycnrliBi3v3YOdx0jtSrMgXa1TkZmkm8WZ31IXGx4DY
        Bt43pncXFs9Un3Qotgp9bKGEB1iReeBPi/KJz8eqxhl908dCgKRpfZw3gGCayOwlWv1c
        703/iFdo3zHmXtXxFKeFMRh0+m5hvrRlv4vKSmDPuCiVSYJBUymsSxa68yH75dgKziM7
        96Qb2NYjZcJqPZd1ceP9CLIWKt1/LAPTpD3ZUfvDVF9b03DnJ0DUJEPt6KEilI/2XLTv
        Hg7Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1onXMaVuOBdyp/nutbxfg"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.119]
        by smtp.strato.de (RZmta 44.16 AUTH)
        with ESMTPSA id R01498v2FDr95mA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 15 Mar 2019 14:53:09 +0100 (CET)
Subject: Re: [PATCH] net: can: Increase tx queue length
To:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Dave Taht <dave@taht.net>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andre Naujoks <nautsch2@gmail.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Martin Jerabek <ma.jer@post.cz>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Sojka <sojkam1@fel.cvut.cz>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
 <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
 <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
 <87zhq43v4m.fsf@toke.dk> <87sgvvnwqf.fsf@taht.net>
 <9adf2fbb-7b0b-6821-98fb-2ddcdf5c0edd@hartkopp.net>
 <DM5PR02MB2187A422962182382358B916DC440@DM5PR02MB2187.namprd02.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f29c891a-2e21-3b9f-83d8-7abd48031011@hartkopp.net>
Date:   Fri, 15 Mar 2019 14:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <DM5PR02MB2187A422962182382358B916DC440@DM5PR02MB2187.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kedar,

On 3/15/19 11:04 AM, Appana Durga Kedareswara Rao wrote:

>> Having about 10 elements in a CAN driver tx queue allows to work with
>> queueing disciplines
>> (http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf) and also to maintain a
>> nearly real-time behaviour with outgoing traffic.
>>
>> When the CAN interface is not able to cope with the (intened) outgoing traffic
>> load, the applications should get an instant feedback about it.
>>
>> There is a difference between running CAN applications in the real world and
>> doing performance tests, where it makes sense to increase the tx-queue-len to
>> e.g. 1000 and dump 1000 frames into the driver to check the hardware
>> performance.
> 
> Thanks, Oliver, Martin, Andre, Toke, Dave for your inputs...
> So to conclude this the default txqueuelen 10 is ideal for real-time CAN traffic,
> For Stress/Performance tests user manually need to increase the txqueuelen based on his requirements.
> 
> Please correct me if my understanding is wrong.

Yes, I would confirm that approach.

As Martin Jerabek pointed to a discussion with Michal Sojka here:

https://marc.info/?l=linux-can&m=155222580602047&w=2

You might also go for a more academic view based on the number of 
different CAN applications on the host.

@Martin: Would you like to propose a patch for can.txt (now can.rst)?

Regards,
Oliver

