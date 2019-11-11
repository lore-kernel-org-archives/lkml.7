Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9602FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632BD21E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Zjhq+j97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrxBxMF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKQJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:09:55 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:52663 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbfKKQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:09:55 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BCFC3441;
        Mon, 11 Nov 2019 11:09:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 11 Nov 2019 11:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=o
        eyjArZgJ+1Z8cibJW3qRiB63aJn/zAHRvlgC7SdXqY=; b=Zjhq+j97kXg1XZLZ4
        cP/2Ybs7wiLplr+MQdOywg6JReeMcq3Qv2/ho29x0Ees/sE8O2qxiCntExo7qXdU
        QLbouwpnlNY6F5PgrjCBmudhWUYFxD6Jlp87IO7dZpdMOwWgbhDgt68J3UAByqJv
        rklCTtJjRu2V/LmCHltfuKqpZ4i/XHZ/68oxywBBJmV8053h8nUz+1uBjx5jAlq+
        q3tM1UBskH4QrV8F1QDp8tLx054SuO8wCPs5uC6u/wSWWMkWMuSHZvv//ntDsd75
        B4NcVomDekgRWXiR8incT9vNtzTJNp1NzPXgxonNfDZMWCoUls3qAhNWlgQRo949
        a19iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=oeyjArZgJ+1Z8cibJW3qRiB63aJn/zAHRvlgC7SdX
        qY=; b=rrxBxMF+yfq+XRzctJjhXnSAX7gViLnPfUqN8S48yJMHSjnT+8wocrOzD
        pN297cFDRXouiSz8rc+kRh/7Rp8ROZD73TBoc5fVK2OCsPjsqoluspoFrG5MXjCn
        rOusezSRYoV9S95kpioSbqEE6MEqjRQh/kkBYv9yXfoVtJeVIo70suVnURBUTzbT
        w5WA/p2Ci0FVauEuEvHRNRy8h+iATqRjquu8HzlfyMQ67l005i0X+15hn7CTO4jN
        V4WCyK1KZVDpDUjQH9gBPi5Ef5lMGx3T5mOW9xpgrQNisPYYQp3+LiZFL2tfnyMc
        6QppLWLHS7sKY7aaLTZGWAq8hnaJg==
X-ME-Sender: <xms:0YfJXSFzbP6X5ca6cnWGmy0diMTIYZNUbW6K0hX7kEpThfms-QQmEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtqhertddtreejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepghhithhhuh
    gsrdgtohhmpdgrphhpshhpohhtrdgtohhmnecukfhppeekfedrkeeirdekledruddtjeen
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:0YfJXcrFkq4RB7KzbemiaKh9MDhQ8-wVlcIU0wG9VWs3hnw3xLwidQ>
    <xmx:0YfJXYhyr7RQp8Ub6OJo8mn_PY4MjG2pNEkUtg1LIZG0oMfXx-Xd5A>
    <xmx:0YfJXToUwrCzWr0gsb4t2e4LzrDgHi1QeNdRa2BV_7RDZBw1s8iA9Q>
    <xmx:0YfJXfy-llGru0LVWNepI5ExzRCapeRpjaqQez7-nrURT7qTLIHKig>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A04C38005B;
        Mon, 11 Nov 2019 11:09:52 -0500 (EST)
Date:   Mon, 11 Nov 2019 17:09:50 +0100
From:   Greg KH <greg@kroah.com>
To:     syzbot <syzbot+d934a9036346e0215d8f@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: bad host security descriptor; not enough data (4 vs 5 left)
Message-ID: <20191111160950.GA870254@kroah.com>
References: <000000000000d9a391059713dc1f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <000000000000d9a391059713dc1f@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 07:34:08AM -0800, syzbot wrote:
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    3183c037 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12525dc6e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D79de80330003b=
5f7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd934a9036346e02=
15d8f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14ac7406e00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13eea39ae00000
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d934a9036346e0215d8f@syzkaller.appspotmail.com
>=20
> usb 1-1: config 0 interface 0 altsetting 0 has 3 endpoint descriptors,
> different from the interface descriptor's value: 4
> usb 1-1: New USB device found, idVendor=3D13dc, idProduct=3D5611,
> bcdDevice=3D2f.15
> usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
> usb 1-1: config 0 descriptor??
> hwa-hc 1-1:0.0: Wire Adapter v106.52 newer than groked v1.0
> hwa-hc 1-1:0.0: FIXME: USB_MAXCHILDREN too low for WUSB adapter (194 port=
s)
> usb 1-1: BUG: bad host security descriptor; not enough data (4 vs 5 left)
> usb 1-1: supported encryption types: =EF=BF=BDS=03=D0=81=EF=BF=BD=EF=BF=
=BD=EF=BF=BD|c=03=D0=81=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDc=03=D0=81=EF=BF=
=BD=EF=BF=BD=EF=BF=BD
> usb 1-1: E: host doesn't support CCM-1 crypto
> hwa-hc 1-1:0.0: Wireless USB HWA host controller
> hwa-hc 1-1:0.0: new USB bus registered, assigned bus number 11

wusb code, hah.  It's about to be deleted from the kernel because no one
uses it and there is no hardware out there.  I wouldn't spend a ton of
time fuzzing it.

One more good reason to just delete it soon...

thanks,

greg k-h
