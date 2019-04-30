Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A9DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A1721707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gccH8dea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PneItX3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfD3PfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:35:21 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50283 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfD3PfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:35:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 95C746CF;
        Tue, 30 Apr 2019 11:35:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 30 Apr 2019 11:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lUhLByuCWkwkjJrzNCYlklmu1AZ
        KvcruJii4RaKrLXk=; b=gccH8deaYaHtej3yNluzRWg7QUJlI659Biii8gdM+Sg
        f0eGGW2Rd5kzG4+YbDYY8ftNUijxzDlnf5apvL5v/E/87Cne/RJjdxMxkEwfmS4p
        eKncdIuxVsb7H9z7OU7rwYC+fDXywrM2eY5XsZT3IDj9SRocmzSLnj0k1r1HWux4
        EqBiwJxrInPuCPh9+nJs1VNUaq7mUJwR5OXsXm6LSDdkt896isJaOSfZmiaBRcxV
        hxujSTiwmxPO8lr/E7xZDY4C+WM2GiqColwtO8fhlLF3a31za8P3mFrKOyg3ukc+
        XXRhRR1yNhj/Ycs2e2cfjO5687Get0hwFlve7z/PIZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lUhLBy
        uCWkwkjJrzNCYlklmu1AZKvcruJii4RaKrLXk=; b=PneItX3IUUZH8xHqv/p6XL
        /ZPwYaqTGLgjrurBGpXc6j1xKRuheMqhdxqjNBLexHOTL5iPjU8vs+olxyozC8he
        MWGK7viX2tOvg3HU07J5CEk4/G9u5gFv/tnYtz2uE+xtaVrXNZ5VfggD7+PxnFVU
        ICWVvaCOOytD7ZHIgTzFECJTVjoWRT0deiug79dKsNn9COCQ6KUkc+fvtMgnFG6Z
        fiBi64e4cFQ1ShDk4ZYt5H2mqqz5ddcdWaRNyy0VbO23mMr7ertFkVM7T/2Y1/Mw
        lKq5zPoDSuEZnDfrSj53/lPUe3qF0SOoB3DwrU+mWrg78W1dJ0NrMQRmID2X++tw
        ==
X-ME-Sender: <xms:NmvIXI3eZ_jgXO2SVWsx285A9RC2sae2TKX1Tohku_JjYtcMRvV0dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieehgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrd
    gtohhmpdgrphhpshhpohhtrdgtohhmnecukfhppeekfedrkeeirdekledruddtjeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptd
X-ME-Proxy: <xmx:NmvIXEpsL08XzciNi3FXWkmc77WCF640MdIYZnD7PLLE-8II4HMjUg>
    <xmx:NmvIXHN-f8q_tsDEGX8YJ0xglms4P-0WPngqzpoqSwZNs7VPHkU-wQ>
    <xmx:NmvIXNphjoOPVKK94FfDy93jwJmv2NaM3FJsltqK7aAwRCPRAeIG3A>
    <xmx:N2vIXDvdxndjdJfCHRN-OXvXkmIgfXgbX-92dVYM2xMhCykIH0R9mA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A6B1103CF;
        Tue, 30 Apr 2019 11:35:18 -0400 (EDT)
Date:   Tue, 30 Apr 2019 17:35:16 +0200
From:   Greg KH <greg@kroah.com>
To:     syzbot <syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: Detected a wedged cx25840 chip; the device will not
 work.
Message-ID: <20190430153516.GA23459@kroah.com>
References: <00000000000048aa750587c052ef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000048aa750587c052ef@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 07:36:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=12df67c3200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> dashboard link: https://syzkaller.appspot.com/bug?extid=170a86bf206dd2c6217e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108a28f3200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145d8a2d200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com
> 
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> pvrusb2: Hardware description: Gotview USB 2.0 DVD 2
> pvrusb2: Invalid write control endpoint
> usb 1-1: USB disconnect, device number 2
> pvrusb2: Invalid write control endpoint
> pvrusb2: WARNING: Detected a wedged cx25840 chip; the device will not work.
> pvrusb2: WARNING: Try power cycling the pvrusb2 device.
> pvrusb2: WARNING: Disabling further access to the device to prevent other
> foul-ups.
> pvrusb2: Device being rendered inoperable
> cx25840 0-0044: Unable to detect h/w, assuming cx23887
> cx25840 0-0044: cx23887 A/V decoder found @ 0x88 (pvrusb2_a)
> pvrusb2: Attached sub-driver cx25840
> pvrusb2: Attempted to execute control transfer when device not ok
> pvrusb2: Attempted to execute control transfer when device not ok

As the driver said, power cycle your device, it crashed :)

Seriously, I think your script detection failed here, sorry.

greg k-h
