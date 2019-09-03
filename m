Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE58C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8D120674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YpxITNYJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PwfKBbhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfICMpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:45:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55323 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfICMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:45:30 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BE72421F2E;
        Tue,  3 Sep 2019 08:45:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Sep 2019 08:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=MIZWO/r5WYB1ZmJJ7B8lddyJnVF
        yg+qUjv42zSxUqt0=; b=YpxITNYJslSW1rZgpIoPl5+IM9y17nEwlw4O7z2QmG7
        SFyWS6hscPNDH/RBVBpP6XAvURfgbip1bM/4DmR3slsgnPCeq/CSBndgNRbq+qcB
        MFVztMkcLRCkvswpbB6WT1MNMnOSGRsV7WweL+jBHtiQtavnxOendn+JBWZ6h+PL
        UuUecnKYOBA84l7Dmo2Wub1ssIulrupTd+xz7tkYySrVEhIPcaHe7lDkTiUglaO2
        mUJJyPlNU7JcetuWjtyQzQdmXtJ34qQUcf1LRKORpeou2kxu38zKS11NySdEDNaY
        vD9Mc/GlW+PPORuRS1pnlJ2QC2IlXuLOudnUTamQpsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MIZWO/
        r5WYB1ZmJJ7B8lddyJnVFyg+qUjv42zSxUqt0=; b=PwfKBbhs0K48qaOLrvdzE5
        pnSCoTF02Nc0tuXuMuJ6ECD9L09iHhA4JPiQPVLi8jqgbvgrmKk/vEf1AdrEzXNu
        ot8Ni4Sxr4OpitfZYZmyRdNvSevN9oMTuCmbJj5RF60ZpAXReDS1yyrzmE+zL0kN
        pwRo1I08so8k7txh1/6CtR6Xs+PEElDKwtKyiQjKIl0zQLivScXT+wfVeNbJ2C1+
        Kije2LAwXPQAje3EbbCd/5DieXpKfIXUQSHfVriQ5zqFy1tpEBlu0xI07eVCGvBX
        Cm86foaabB9v4kxUVqMkY/xRlltWPnU9AtAuyjIcYG2q9SW/zHDH6MnzN3Me7krA
        ==
X-ME-Sender: <xms:aWBuXaHJEL_wvL6RIxE8cXqRUzkXedDrT0uGhaRozG3QvRuZTL4FnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejfedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:aWBuXSZMSm--u0-7G9yA86f6dcfE7NJfGCPNQ4yE5XJffU2AjjtV4A>
    <xmx:aWBuXcLYSZk_gHQe9K5RghidwiXL3sGmgDa-3MfDUksGYkerumEvZQ>
    <xmx:aWBuXVyjZyzeTamMj24KaKLxWdMGDhEGMm_MC8kalXnuhv-Lhvv-VQ>
    <xmx:aWBuXW62BIDK1Rwyvv7DuNM25f7N7yHc2oPD15nHM1sv37HTVSLr1Q>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2908D60068;
        Tue,  3 Sep 2019 08:45:28 -0400 (EDT)
Date:   Tue, 3 Sep 2019 14:45:27 +0200
From:   Greg KH <greg@kroah.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Dan Williams <dcbw@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
Message-ID: <20190903124527.GB493@kroah.com>
References: <CAODwPW8gTZ_2WEc9n=WJ2PEmQk2anTQYfwQ-898+kOq6wsjnZw@mail.gmail.com>
 <Pine.LNX.4.44L0.1908301337150.1459-100000@iolanthe.rowland.org>
 <20190902164724.GA22619@kroah.com>
 <1567500374.2878.2.camel@suse.com>
 <20190903091953.GA12325@kroah.com>
 <1567505043.2878.4.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567505043.2878.4.camel@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:04:03PM +0200, Oliver Neukum wrote:
> Am Dienstag, den 03.09.2019, 11:19 +0200 schrieb Greg KH:
> > On Tue, Sep 03, 2019 at 10:46:14AM +0200, Oliver Neukum wrote:
> > > Am Montag, den 02.09.2019, 18:47 +0200 schrieb Greg KH:
> > > > 
> > > > This should work just fine today.  Add a new device id to the "new_id"
> > > > file and then tell the driver to bind.  That's pretty much the same as a
> > > > "force_bind", right?
> > > 
> > > That looks like a race condition by design to me.
> > 
> > How?
> 
> You have one of these files and potentially multiple devices
> to be bound. You need a locking scheme. As soon as the acts
> of specifying and binding are distinct.

What needs to be locked here?

totally confused,

greg k-h
