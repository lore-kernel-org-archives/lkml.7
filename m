Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F587C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E82075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="vO+WHnDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfK3WyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:54:12 -0500
Received: from rfvt.org.uk ([37.187.119.221]:49374 "EHLO rfvt.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfK3WyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:54:11 -0500
Received: from wylie.me.uk (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by rfvt.org.uk (Postfix) with ESMTPS id 074BD80260;
        Sat, 30 Nov 2019 22:54:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
        s=mydkim005; t=1575154449;
        bh=sCORn2MAw0TG+WBgIwwZWALjHRYvQWJaKn2hxmwLojU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=vO+WHnDz+j6Oog/JSlgcz93NUFWToy9N2FtsN3fmP/2xIbIN5LQRdaNQvnwnRl+jm
         BmrKbuqiLUvPdEc53/v5rLSuzRPmFhLP7YePb58BpQPiNlUJrRgQufmPJaBF4UmCH3
         TWnOJrLdwjm1kPYu1BKE06LtyyIOB1KPJDkMxwdms/xPPU/M2/Uqkv4+lnnE0lI57e
         1jfEWOpcixDYoWaZzoODt0MXtkJ7wDh0mBTEkALCN+9PgNqT3L27b63WwQRyEuGg3K
         bZuUMoxtkHOI0Jfsna63beJI5KlW26OgWdRq6jswJPYAxSPCNHtFmNoK/uD6hDCCOG
         CZGqB86xKeSwA==
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24034.62224.766635.808185@wylie.me.uk>
Date:   Sat, 30 Nov 2019 22:54:08 +0000
From:   "Alan J. Wylie" <alan@wylie.me.uk>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: 5.4 Regression in r8169 with jumbo frames - packet loss/delays
In-Reply-To: <75146b50-9518-8588-81fa-f2811faf6cca@gmail.com>
References: <24034.56114.248207.524177@wylie.me.uk>
        <75146b50-9518-8588-81fa-f2811faf6cca@gmail.com>
X-Mailer: VM 8.2.0b under 26.3 (x86_64-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 22:37 on Sat 30-Nov-2019 Heiner Kallweit (hkallweit1@gmail.com) wrote:

> Thanks for the report. A jumbo fix for one chip version may have
> revealed an issue with another chip version. Could you please try
> the following?

I'll do that in the morning.

> I checked the vendor driver r8168 and there's no special sequence
> to configure jumbo mode.
> 
> What would be interesting:
> Do you set the (jumbo) MTU before bringing the device up?

In the meantime here's some info: I use systemd/networkd, I'd suspect
that it does the MTU in the link, before the network.

$ for f in /etc/systemd/network/*; do echo "========== $f =========="; cat $f; done
========== /etc/systemd/network/01br0.netdev ==========
[NetDev]
Name=br0
Kind=bridge
MACAddress=90:2b:34:9d:ed:6f
========== /etc/systemd/network/02enp3s0.link ==========
[Match]
Driver=r8169

[Link]
MTUBytes=6000
========== /etc/systemd/network/02enp3s0.network ==========
[Match]
Name=enp3s0

[Network]
Bridge=br0

[Link]
MTUBytes=6000
========== /etc/systemd/network/03br0.network ==========
[Match]
Name=br0

[Link]
MTUBytes=6000

[Network]
DNS=192.168.21.1
Address=192.168.21.2/24
Gateway=192.168.21.1

Also, here's a grep of the syslog, I'm not sure how much to trust the
ordering though:

Nov 30 20:02:10 frodo kernel: Linux version 5.4.0-rc1-00312-g4ebcb113edcc (alan@frodo) (gcc version 9.2.0 (Gentoo Hardened 9.2.0-r2 p3)) #4 SMP PREEMPT Sat Nov 30 19:59:34 GMT 2019
Nov 30 20:02:10 frodo systemd-networkd[819]: br0: netdev ready
Nov 30 20:02:10 frodo systemd-networkd[819]: Enumeration completed
Nov 30 20:02:10 frodo systemd-networkd[819]: br0: rtnl: received neighbor message with invalid family, ignoring.
Nov 30 20:02:10 frodo systemd-networkd[819]: br0: IPv6 successfully enabled
Nov 30 20:02:10 frodo systemd-networkd[819]: br0: Gained carrier
Nov 30 20:02:10 frodo systemd-networkd[819]: br0: Lost carrier
Nov 30 20:02:10 frodo systemd-networkd[819]: br0: Gained IPv6LL
Nov 30 20:02:10 frodo systemd-networkd[819]: enp3s0: Gained carrier
Nov 30 20:02:10 frodo systemd-networkd[819]: enp3s0: Configured
Nov 30 20:02:10 frodo systemd-networkd[819]: br0: Gained carrier
Nov 30 20:02:10 frodo ntpd[1029]: 2019-11-30T20:02:10 ntpd[1029]: IO: Listen normally on 3 br0 192.168.21.2:123
Nov 30 20:02:10 frodo ntpd[1029]: 2019-11-30T20:02:10 ntpd[1029]: IO: Listen normally on 5 br0 [fe80::922b:34ff:fe9d:ed6f%3]:123
Nov 30 20:02:10 frodo ntpd[1029]: IO: Listen normally on 3 br0 192.168.21.2:123
Nov 30 20:02:10 frodo ntpd[1029]: IO: Listen normally on 5 br0 [fe80::922b:34ff:fe9d:ed6f%3]:123
Nov 30 20:02:10 frodo kernel: device: 'eth0': device_add
Nov 30 20:02:10 frodo kernel: PM: Adding info for No Bus:eth0
Nov 30 20:02:10 frodo kernel: r8169 0000:03:00.0 eth0: RTL8168evl/8111evl, 90:2b:34:9d:ed:6f, XID 2c9, IRQ 30
Nov 30 20:02:10 frodo kernel: r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
Nov 30 20:02:10 frodo kernel: r8169 0000:03:00.0 enp3s0: renamed from eth0
Nov 30 20:02:10 frodo kernel: net eth0: renaming to enp3s0
Nov 30 20:02:10 frodo kernel: device: 'br0': device_add
Nov 30 20:02:10 frodo kernel: PM: Adding info for No Bus:br0
Nov 30 20:02:10 frodo kernel: br0: port 1(enp3s0) entered blocking state
Nov 30 20:02:10 frodo kernel: br0: port 1(enp3s0) entered disabled state
Nov 30 20:02:10 frodo kernel: device enp3s0 entered promiscuous mode
Nov 30 20:02:10 frodo kernel: br0: port 1(enp3s0) entered blocking state
Nov 30 20:02:10 frodo kernel: br0: port 1(enp3s0) entered forwarding state
Nov 30 20:02:10 frodo kernel: r8169 0000:03:00.0 enp3s0: Link is Down
Nov 30 20:02:10 frodo kernel: IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
Nov 30 20:02:10 frodo kernel: br0: port 1(enp3s0) entered disabled state
Nov 30 20:02:10 frodo kernel: r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control rx/tx
Nov 30 20:02:10 frodo kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp3s0: link becomes ready
Nov 30 20:02:10 frodo kernel: br0: port 1(enp3s0) entered blocking state
Nov 30 20:02:10 frodo kernel: br0: port 1(enp3s0) entered forwarding state
Nov 30 20:02:14 frodo systemd-networkd[819]: br0: Configured

-- 
Alan J. Wylie                                          https://www.wylie.me.uk/

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience
