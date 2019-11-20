Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53AEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96565224D2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FNqN9ioq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ppDu1SJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfKTNc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:32:56 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42771 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727442AbfKTNc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:32:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F1B6D4DA;
        Wed, 20 Nov 2019 08:32:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 20 Nov 2019 08:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=n
        G1qI7q/zWCkIrCeM/rIvDmve2KkiC1w2QXe0U9BI50=; b=FNqN9ioqSBRcubf7n
        lS2HJ1gZfSpxcjwAM55efIt+ODEDXmHd+Aof3D3VmTNZx56cebnoHwnwyNofOEa1
        nRWOPEqzNmcy7e21GGrekFYfM0v46jlGzeRgjNRHSJ5/awg7NYL4rx17eM3ML6Fg
        CDeIztHDBIz6t8lbhEgeLPIV5gM/6c3ndxv1a27DGJjkf2tSxB4YB0cEOZqryxNd
        kz7GfRt+s/VcQ8ChLsIpHYbtO53pN9n4JL1Z20MDTuWGb/+fVhKtKtgs0cg3m/4g
        Um+lbu6OmnnWVBaohKs2GfgF5NafdfB9ISm3ZwQso74p14qf2re1cIbOWn5pu4vc
        CexPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=nG1qI7q/zWCkIrCeM/rIvDmve2KkiC1w2QXe0U9BI
        50=; b=ppDu1SJ8RhS6IVG734CpMBXZVIBgZsqABm0mbVPkPAgXUlAn9GETfuFHa
        vQjARsF2spyyNcX//DikOxiEN5eFb10zyFRTkjpGQCpCE8qc2sNOg9PVWgIIHo2I
        1Ep2qySmV9zirn1EhjSekipfMEX/G6QnsB54w8QfmrWcGIMor2SxiPuXQlfhCdWY
        BzXCvKO/BsZcw0FERIebC0LqahhCAhjbHEFrSlhDhJiBQiiBTz0kiY3Mm7T/sPY3
        4qGDG1ecUYCBO1oDZqFYfg2t3T7juafs/xDcyX14z/pI6hoglRQ6PLB49q3suuP0
        lcuU45sbhzQ+ci82iodIZhCAOCEiA==
X-ME-Sender: <xms:hkDVXbHl44XDamYubUp8PoHnidFzCNAOOo1d2Ug02kxmxWDNtYADmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtugfg
    jggfsehtqhertddtreejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorg
    hhrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgrphhpshhpohhtrdgt
    ohhmnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:hkDVXcCMMJZMK9W2yG0tJS-UQUP--vox2byeirKIEsHmFvSR6izcGQ>
    <xmx:hkDVXYN7cshqPyj9sV4ms0tadCQJu0MttEKy00n2Flk_1XCtoD9tWg>
    <xmx:hkDVXWgo82VMeIqHom5W66EvjjLmXTWdRNVCeewd7uqCjX4BE7uZtA>
    <xmx:hkDVXXyC3-PoqGHg5g7TQaL3EU07bYXnJt9fZ7oUiCQUv9_DPIxTYA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id E01D73060062;
        Wed, 20 Nov 2019 08:32:53 -0500 (EST)
Date:   Wed, 20 Nov 2019 14:32:52 +0100
From:   Greg KH <greg@kroah.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+d934a9036346e0215d8f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: bad host security descriptor; not enough data (4 vs 5 left)
Message-ID: <20191120133252.GC2892197@kroah.com>
References: <000000000000d9a391059713dc1f@google.com>
 <20191111160950.GA870254@kroah.com>
 <1574248737.14298.33.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1574248737.14298.33.camel@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:18:57PM +0100, Oliver Neukum wrote:
> Am Montag, den 11.11.2019, 17:09 +0100 schrieb Greg KH:
> > On Mon, Nov 11, 2019 at 07:34:08AM -0800, syzbot wrote:
> > > Hello,
> > >=20
> > > syzbot found the following crash on:
> > >=20
> > > HEAD commit:    3183c037 usb: gadget: add raw-gadget interface
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12525dc6e=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D79de80330=
003b5f7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd934a903634=
6e0215d8f
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14ac740=
6e00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13eea39ae=
00000
> > >=20
> > > IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> > > Reported-by: syzbot+d934a9036346e0215d8f@syzkaller.appspotmail.com
> > >=20
> > > usb 1-1: config 0 interface 0 altsetting 0 has 3 endpoint descriptors,
> > > different from the interface descriptor's value: 4
> > > usb 1-1: New USB device found, idVendor=3D13dc, idProduct=3D5611,
> > > bcdDevice=3D2f.15
> > > usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=
=3D0
> > > usb 1-1: config 0 descriptor??
> > > hwa-hc 1-1:0.0: Wire Adapter v106.52 newer than groked v1.0
> > > hwa-hc 1-1:0.0: FIXME: USB_MAXCHILDREN too low for WUSB adapter (194 =
ports)
> > > usb 1-1: BUG: bad host security descriptor; not enough data (4 vs 5 l=
eft)
> > > usb 1-1: supported encryption types: =EF=BF=BDS=03=D0=81=EF=BF=BD=EF=
=BF=BD=EF=BF=BD|c=03=D0=81=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDc=03=D0=81=EF=
=BF=BD=EF=BF=BD=EF=BF=BD
> > > usb 1-1: E: host doesn't support CCM-1 crypto
> > > hwa-hc 1-1:0.0: Wireless USB HWA host controller
> > > hwa-hc 1-1:0.0: new USB bus registered, assigned bus number 11
> >=20
> > wusb code, hah.  It's about to be deleted from the kernel because no one
> > uses it and there is no hardware out there.  I wouldn't spend a ton of
> > time fuzzing it.
> >=20
> > One more good reason to just delete it soon...
>=20
> Unfortunately that is not an option for the stable trees.

Well, we can just mark the thing as BROKEN.  I strongly doubt anyone is
using it as there is no hardware out there.

thanks,

greg k-h
