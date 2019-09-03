Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE1AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189E822D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lsQzpqdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uqN08YPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfICJT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:19:58 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52225 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbfICJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:19:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 538BB22128;
        Tue,  3 Sep 2019 05:19:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Sep 2019 05:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=z2lVEw1JSBkzTGutlvzaxeAhxEw
        JaiOIlS/JJN0dpKg=; b=lsQzpqdAVeNrHPs6hMk5PlYQiNtwVTsruYFTburpR37
        q5oNhvcf1SnQkCabmh76ZhRr7FdGOCMvZDttwpMOXiAUxc6eoAnfQ8Hyl+ljx19S
        AQIHaZH2vV/teQPUUd/uZBuxkoBqDShKdkqqsQiScuUOcSKuHpQAJ7lExBbGDD6e
        VvdCNqtJmmFv1hG2563Xi/vRbsprA6Rr9Mhz63eWStrcHEeTalJ7WKc/rN4V6vK+
        c6Drl7z4fx1FvDpr3wjPEontvdIgZzyGPf8V4H50FSXPpEb1LooSvdf+UlJfYRLU
        ugcFduESTpMJXD3Ol5l18GP2y79zEZWGImWCzlKj4nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=z2lVEw
        1JSBkzTGutlvzaxeAhxEwJaiOIlS/JJN0dpKg=; b=uqN08YPj2wGNbCz6j3w8w7
        SPNz0nPZoUf+rzv/RwXGDIbkotY4P8hKqI+UuGu2Klps9fVY1yAG36c4HHFgOdH5
        nQDoz9zltKwEwjmoBfa51Gb0n353YA1vY+wEpRoBlkR5YJZyfc0ugiMiu9obT7GM
        ENrJfPfTSFyOsYdASqwe/yjlxmZcoZaNzioEpi4QKvE+i0I+ztuN66TttVxkBOOP
        XHQ32JJiK8in3fPOyKL/qxFklN5P+UKdGFDnkQO2H60bLbzvodJtXSK+EV9vXlNQ
        yPCIKfWqt9HLStsjC30qrcS4PptiWCB12PIv0VqytzjHNb3teE0Y5uRIBGI7tMyA
        ==
X-ME-Sender: <xms:OzBuXS7KelHOV6s07gWBJLgEU1CGD0i5MZa-3yIh_MSZKkV-wr_yqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejvddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuffhomhgrihhnpehlfihnrdhnvg
    htnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:OzBuXWR-itCUfIXRrxKUidqjY7FTdGPBp1bQhVeSh_ZEbG56C-upMg>
    <xmx:OzBuXXlIfCGvRWy9-66UGpoY0M3tF-SILrxS8yO4xJEG77VPF2wSqQ>
    <xmx:OzBuXaS1-sPBcPyzDNmZhEskXp4A88BcJp5b7YK4o2BisuKYMcGSoQ>
    <xmx:PDBuXQWTYX9BnbntqHeuKR2NBkWkfzWsjmcfk9tBOMgcjMJSvBlsdQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 13D35D6005F;
        Tue,  3 Sep 2019 05:19:54 -0400 (EDT)
Date:   Tue, 3 Sep 2019 11:19:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Julius Werner <jwerner@chromium.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Dan Williams <dcbw@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
Message-ID: <20190903091953.GA12325@kroah.com>
References: <CAODwPW8gTZ_2WEc9n=WJ2PEmQk2anTQYfwQ-898+kOq6wsjnZw@mail.gmail.com>
 <Pine.LNX.4.44L0.1908301337150.1459-100000@iolanthe.rowland.org>
 <20190902164724.GA22619@kroah.com>
 <1567500374.2878.2.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567500374.2878.2.camel@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:46:14AM +0200, Oliver Neukum wrote:
> Am Montag, den 02.09.2019, 18:47 +0200 schrieb Greg KH:
> > 
> > This should work just fine today.  Add a new device id to the "new_id"
> > file and then tell the driver to bind.  That's pretty much the same as a
> > "force_bind", right?
> 
> That looks like a race condition by design to me.

How?

Anyway, this should all "just work" somehow, there's an old lwn.net
article I wrote about this over a decade ago when it was added.  A
number of subsystems use this all the time (vfio?) and I haven't heard
any issues with it in a long time.

thanks,

greg k-h
