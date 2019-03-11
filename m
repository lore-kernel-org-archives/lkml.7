Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D65C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D693E214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfCKTnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:43:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:59611 "EHLO zero.eik.bme.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKTns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:43:48 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 15:43:46 EDT
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
        by localhost (Postfix) with SMTP id 94CB27456B3;
        Mon, 11 Mar 2019 20:33:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
        id 73F847456B2; Mon, 11 Mar 2019 20:33:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zero.eik.bme.hu (Postfix) with ESMTP id 734E17456A0;
        Mon, 11 Mar 2019 20:33:39 +0100 (CET)
Date:   Mon, 11 Mar 2019 20:33:39 +0100 (CET)
From:   BALATON Zoltan <balaton@eik.bme.hu>
To:     Pintu Agarwal <pintu.ping@gmail.com>
cc:     open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, qemu-devel@nongnu.org,
        =?EUC-KR?B?wPzB+L+1?= <jy0.jeon@gmail.com>
Subject: Re: [Qemu-devel] ssh session with qemu-arm using busybox
In-Reply-To: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903112027050.69539@zero.eik.bme.hu>
References: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Pintu Agarwal wrote:
> I am sure, many of you people would have explored already "how to use
> ssh over qemu" and found a easy method.
> So, if anybody have easy setup please share with me.
>
> I could see that after adding "ip=dhcp" I get the eth0 interface like this:
> / # ifconfig
> eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
>          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:2 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:1180 (1.1 KiB)  TX bytes:1180 (1.1 KiB)
>          Interrupt:22
>
> lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          UP LOOPBACK RUNNING  MTU:65536  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>
> But I could not ping it from ubuntu PC.

This should already be documented here:
https://wiki.qemu.org/Documentation/Networking

The default QEMU network is -net user slirp based networking that provides 
outbound connectivity from the virtual machine but no ping or inbound 
connections. I.e. you can ssh from your guest to your host (so you could 
use scp in your guest to copy files from your host) or use some other 
networking (such as tap) that allows the host to connect to guest (but 
then you'll need to arrange routing and dhcp if you want that on your 
host otherwise your guest will only see your host). Hope this helps.

Regards,
BALATON Zoltan
