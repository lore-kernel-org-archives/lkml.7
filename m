Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCFC49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EFC2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="S7XaQk1A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQ44Lh8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbfIJJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:19:43 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35095 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729349AbfIJJTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:19:43 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 26B686AB;
        Tue, 10 Sep 2019 05:19:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Sep 2019 05:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=FuIKM8ji5B1GYyi/ac3f7h+lnXh
        WE4Zc17vPAo4OuDE=; b=S7XaQk1Aasr0fDsjjCRfDjCxHvKWyaz59W8fXxPe4Z0
        7AbWAVFg/s4pmP+V/IYEoE0q3NHcPItLzB8JAJ8HCILSxDSrt9ztUmc9vL0Kl5fY
        qL6tiqHoE7uAoc7RfT/mDkjrs1/k386sF1nxZId6LuQY3DiEe8aKQfTLHnRsdYSh
        d9xsJ0g2YDWDDZuh26ug1Ux46Wa4rMOvjcCeI1gWeQZM87XG2VRBNR3vrFHC8uCZ
        F1vy5PlKR2lToqSGW+zSgz4UXq7tA8uhGDcqNq4gu3ZswhUgxFUk6rF+lkzBIJLF
        eJqwdDWSeenuIEZJpWdfWx9d2ndB/z3vZ1bMTwzNapA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FuIKM8
        ji5B1GYyi/ac3f7h+lnXhWE4Zc17vPAo4OuDE=; b=nQ44Lh8B8VV3oF+7DQAict
        C2weNhFVMnVhwdjoZwH19O4PJnL7UyYVoo5KDFfoSAGmkTom/T+z1xcOy6YPAvxG
        2KviBJv3sQJYtQglrHjBdvTBcy/HvEEXSFRM4m3PXmedSZARI1rceGo+VPknyXWQ
        OFxragE2YJejUDewlJIEob0yEOePdZXG7onR5TFYqseguBevxNFhs+FDaSZh6Ctf
        +PNZm1aaRyyEUhFNzGVejGaf4GR7WgARHETr+AAWqQnL+nNE0lJGzGtBLwimG3BT
        7jrY4kDmmrxISSM4pyfwMfkhYxxdCsBFedkJ/JYrdoNMTRrMu9OJx0mCuJ7LeJjw
        ==
X-ME-Sender: <xms:rWp3XR2Sncnr9Z2A3oEXAi1JrDr3_1D3VsMhVpu81S_3Z3fdKNi6og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudekkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppedvudefrdeftddrkedrud
    dutdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:rWp3XTLrDag1PYAjBtXuppdchF_KcmVRDlrwdXZss7IgG3w2cr3HfQ>
    <xmx:rWp3XZ-f2BbcX2J3DlVlIcpisu8j0th-o0lE82WG_RaPehyGBML0pQ>
    <xmx:rWp3XREKoQ54y3aazGM_idIIaJkUdi-Cr7sPe7Z_AX6GMJeGASbg9w>
    <xmx:rWp3XVk6zz9k07uO4bNh8vNt5xHkOTLltHoGjSvus0yOxBOHWvn2Aw>
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8160B80059;
        Tue, 10 Sep 2019 05:19:40 -0400 (EDT)
Date:   Tue, 10 Sep 2019 10:19:38 +0100
From:   Greg KH <greg@kroah.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH AUTOSEL 5.2 06/12] configfs_register_group() shouldn't be
 (and isn't) called in rmdirable parts
Message-ID: <20190910091938.GA5542@kroah.com>
References: <20190909154052.30941-1-sashal@kernel.org>
 <20190909154052.30941-6-sashal@kernel.org>
 <20190910060135.GA30753@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910060135.GA30753@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 08:01:35AM +0200, Christoph Hellwig wrote:
> Please stop selectively backporting parts of random series.  We'll
> need to the full series from Al in -stable instead.

Yeah, I'll pick this whole series up soon.  Sasha, can you drop this
from your queues please?

thanks,

greg k-h
