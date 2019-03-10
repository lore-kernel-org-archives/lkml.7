Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19B7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 05:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4E320657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 05:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfCJFQr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 00:16:47 -0500
Received: from mail.taht.net ([176.58.107.8]:59108 "EHLO mail.taht.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfCJFQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 00:16:47 -0500
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Mar 2019 00:16:45 EST
Received: from dancer.taht.net (c-73-162-29-198.hsd1.ca.comcast.net [73.162.29.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.taht.net (Postfix) with ESMTPSA id B68E121367;
        Sun, 10 Mar 2019 05:07:22 +0000 (UTC)
From:   Dave Taht <dave@taht.net>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Andre Naujoks <nautsch2@gmail.com>,
        "wg\@grandegger.com" <wg@grandegger.com>,
        "mkl\@pengutronix.de" <mkl@pengutronix.de>,
        "davem\@davemloft.net" <davem@davemloft.net>
Cc:     "linux-can\@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: can: Increase tx queue length
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
        <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
        <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
        <87zhq43v4m.fsf@toke.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Followup-To: dave.taht@gmail.com
Cancel-Lock: sha1:xzKOJHhSniuvrOl5sLJK50vgjUA=
Date:   Sat, 09 Mar 2019 21:07:20 -0800
In-Reply-To: <87zhq43v4m.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Sat, 09 Mar 2019 16:50:01 +0100")
Message-ID: <87sgvvnwqf.fsf@taht.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke Høiland-Jørgensen <toke@redhat.com> writes:

> Appana Durga Kedareswara Rao <appanad@xilinx.com> writes:
>
>> Hi Andre,
>>
>> <Snip> 
>>> 
>>> On 3/9/19 3:07 PM, Appana Durga Kedareswara rao wrote:
>>> > While stress testing the CAN interface on xilinx axi can in loopback
>>> > mode getting message "write: no buffer space available"
>>> > Increasing device tx queue length resolved the above mentioned issue.
>>> 
>>> No need to patch the kernel:
>>> 
>>> $ ip link set <dev-name> txqueuelen 500
>>> 
>>> does the same thing.
>>
>> Thanks for the review... 
>> Agree but it is not an out of box solution right?? 
>> Do you have any idea for socket can devices why the tx queue length is 10 whereas
>> for other network devices (ex: ethernet) it is 1000 ??
>
> Probably because you don't generally want a long queue adding latency on
> a CAN interface? The default 1000 is already way too much even for an
> Ethernet device in a lot of cases.
>
> If you get "out of buffer" errors it means your application is sending
> things faster than the receiver (or device) can handle them. If you
> solve this by increasing the queue length you are just papering over the
> underlying issue, and trading latency for fewer errors. This tradeoff
> *may* be appropriate for your particular application, but I can imagine
> it would not be appropriate as a default. Keeping the buffer size small
> allows errors to propagate up to the application, which can then back
> off, or do something smarter, as appropriate.
>
> I don't know anything about the actual discussions going on when the
> defaults were set, but I can imagine something along the lines of the
> above was probably a part of it :)
>
> -Toke

In a related discussion, loud and often difficult, over here on the can bus, 

https://github.com/systemd/systemd/issues/9194#issuecomment-469403685

we found that applying fq_codel as the default via sysctl qdisc a bad
idea for systems for at least one model of can device.

If you scroll back on the bug, a good description of what the can
subsystem expects from the qdisc is therein - it mandates an in-order
fifo qdisc or no queue at all. the CAN protocol expects each packet to
be transmitted successfully or rejected, and if so, passes the error up
to userspace and is supposed to stop for further input.

As this was the first serious bug ever reported against using fq_codel
as the default in 5+ years of systemd and 7 of openwrt deployment I've
been taking it very seriously. It's worse than just systemd - openwrt
patches out pfifo_fast entirely. pfifo_fast is the wrong qdisc - the
right choices are noqueue and possibly pfifo.

However, the vcan device exposes noqueue, and so far it has been only
the one device ( a 8Devices socketcan USB2CAN ) that did not do this in
their driver that was misbehaving.

Which was just corrected with a simple:

static int usb_8dev_probe(struct usb_interface *intf,
			 const struct usb_device_id *id)
{
     ...
     netdev->netdev_ops = &usb_8dev_netdev_ops;

     netdev->flags |= IFF_ECHO; /* we support local echo */
+    netdev->priv_flags |= IFF_NO_QUEUE;
     ...
}

and successfully tested on that bug report.

So at the moment, my thought is that all can devices should default to
noqueue, if they are not already. I think a pfifo_fast and a qlen of any
size is the wrong thing, but I still don't know enough about what other
can devices do or did to be certain.

