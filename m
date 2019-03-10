Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A1DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA76206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EKpXfdFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCJRdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:33:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:29665 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfCJRdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552239227;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=atU7qKMidc+wz+05Sy33uEZ4util51c0rRQU+2ktajs=;
        b=EKpXfdFSg9s21OTZLy2CuBe7Vgh/D75Ajll9Kl1ltcTFkCUKlvCPyb3Jv9Hbg321iT
        +FSCxsozXn02PLnSHmiuAfl0e4DAPtD5dL9Q5/ug2ANa7OMIMpL/0OjwOhrmshn1pa4c
        naRWeMwu8PqhsGvEPTGzpD+aw0IxaaDUkM0earWhNl7J+/ei7E50EAZ3dQOHl6tQc0PS
        /qnY7Wh+KbZ2N2kTVIQKqCQLDIAgNGS8KhSFQL4fkqigWzI3cSIvlnrpMn8HXy1yIHbU
        LBiG+or78uOfK7J3q2cN+Qxb063GqoUc09VTli+xmTin2aCZssUEaUKAVGugDUwiso0B
        PA2Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1onXMaVuOBdyp/nutbxfg"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.119]
        by smtp.strato.de (RZmta 44.13 AUTH)
        with ESMTPSA id e06351v2AHUjm1i
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 10 Mar 2019 18:30:45 +0100 (CET)
Subject: Re: [PATCH] net: can: Increase tx queue length
To:     Dave Taht <dave@taht.net>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Andre Naujoks <nautsch2@gmail.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
 <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
 <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
 <87zhq43v4m.fsf@toke.dk> <87sgvvnwqf.fsf@taht.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <9adf2fbb-7b0b-6821-98fb-2ddcdf5c0edd@hartkopp.net>
Date:   Sun, 10 Mar 2019 18:30:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87sgvvnwqf.fsf@taht.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 3/10/19 6:07 AM, Dave Taht wrote:
> Toke Høiland-Jørgensen <toke@redhat.com> writes:
> 
>> Appana Durga Kedareswara Rao <appanad@xilinx.com> writes:
>>
>>> Hi Andre,
>>>
>>> <Snip>
>>>>
>>>> On 3/9/19 3:07 PM, Appana Durga Kedareswara rao wrote:
>>>>> While stress testing the CAN interface on xilinx axi can in loopback
>>>>> mode getting message "write: no buffer space available"
>>>>> Increasing device tx queue length resolved the above mentioned issue.
>>>>
>>>> No need to patch the kernel:
>>>>
>>>> $ ip link set <dev-name> txqueuelen 500
>>>>
>>>> does the same thing.
>>>
>>> Thanks for the review...
>>> Agree but it is not an out of box solution right??
>>> Do you have any idea for socket can devices why the tx queue length is 10 whereas
>>> for other network devices (ex: ethernet) it is 1000 ??
>>
>> Probably because you don't generally want a long queue adding latency on
>> a CAN interface? The default 1000 is already way too much even for an
>> Ethernet device in a lot of cases.
>>
>> If you get "out of buffer" errors it means your application is sending
>> things faster than the receiver (or device) can handle them. If you
>> solve this by increasing the queue length you are just papering over the
>> underlying issue, and trading latency for fewer errors. This tradeoff
>> *may* be appropriate for your particular application, but I can imagine
>> it would not be appropriate as a default. Keeping the buffer size small
>> allows errors to propagate up to the application, which can then back
>> off, or do something smarter, as appropriate.
>>
>> I don't know anything about the actual discussions going on when the
>> defaults were set, but I can imagine something along the lines of the
>> above was probably a part of it :)
>>
>> -Toke
> 
> In a related discussion, loud and often difficult, over here on the can bus,
> 
> https://github.com/systemd/systemd/issues/9194#issuecomment-469403685
> 
> we found that applying fq_codel as the default via sysctl qdisc a bad
> idea for systems for at least one model of can device.
> 
> If you scroll back on the bug, a good description of what the can
> subsystem expects from the qdisc is therein - it mandates an in-order
> fifo qdisc or no queue at all. the CAN protocol expects each packet to
> be transmitted successfully or rejected, and if so, passes the error up
> to userspace and is supposed to stop for further input.
> 
> As this was the first serious bug ever reported against using fq_codel
> as the default in 5+ years of systemd and 7 of openwrt deployment I've
> been taking it very seriously. It's worse than just systemd - openwrt
> patches out pfifo_fast entirely. pfifo_fast is the wrong qdisc - the
> right choices are noqueue and possibly pfifo.
> 
> However, the vcan device exposes noqueue, and so far it has been only
> the one device ( a 8Devices socketcan USB2CAN ) that did not do this in
> their driver that was misbehaving.
> 
> Which was just corrected with a simple:
> 
> static int usb_8dev_probe(struct usb_interface *intf,
> 			 const struct usb_device_id *id)
> {
>       ...
>       netdev->netdev_ops = &usb_8dev_netdev_ops;
> 
>       netdev->flags |= IFF_ECHO; /* we support local echo */
> +    netdev->priv_flags |= IFF_NO_QUEUE;
>       ...
> }
> 
> and successfully tested on that bug report.
> 
> So at the moment, my thought is that all can devices should default to
> noqueue, if they are not already. I think a pfifo_fast and a qlen of any
> size is the wrong thing, but I still don't know enough about what other
> can devices do or did to be certain.
> 

Having about 10 elements in a CAN driver tx queue allows to work with 
queueing disciplines 
(http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf) and also to 
maintain a nearly real-time behaviour with outgoing traffic.

When the CAN interface is not able to cope with the (intened) outgoing 
traffic load, the applications should get an instant feedback about it.

There is a difference between running CAN applications in the real world 
and doing performance tests, where it makes sense to increase the 
tx-queue-len to e.g. 1000 and dump 1000 frames into the driver to check 
the hardware performance.

Best regards,
Oliver
