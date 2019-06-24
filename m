Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9413AC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692812089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="g3K+3sQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T24kO8Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfFXHhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:37:10 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46281 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbfFXHhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:37:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8F0133F8;
        Mon, 24 Jun 2019 03:37:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 Jun 2019 03:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=1+J5C2HWzRAWGr9qUi/dV7VOWB/
        lXXCZf4VWBdCbOxE=; b=g3K+3sQDn4c+WQ7BN/Yf4iqSFAz7JeF62Y4qIKWKKP8
        K/HCVktH3QNaiWY9FqoIk8EuPRvCRaSZZwJsVP4qY/xZWEIxtpA2BCG4EpXErQ+p
        g8vRbb4zqg3VxbsAuZ8KVOPDM/22O0sJJ1AMwhRkhWvFqgASksdnTqen1Ul0sM4F
        kTBPbPmd5vJ2IWV8HjR7qzoIyrvE7GvQsqkF5VvVDMFh76ZUaq9wOdFo6iHitq28
        uiEqGztL9PLua0hjB1Ysgu+SccZ+1/hSYwBYUJDZsZdoYGqtKmMYdR4ujqUPF3Nq
        cNCi3DSkhC5W7+IoRg/oorzQd+oCfKhZHSmh6EGJWyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1+J5C2
        HWzRAWGr9qUi/dV7VOWB/lXXCZf4VWBdCbOxE=; b=T24kO8Ynmc/MMjAOj4hhOj
        IDuIVgpVAXkT2XaGkzoeMbl17mHQN7MYMU1XNrFi9eMPzWpnohauDClfU0y6y2V4
        tw+uPDVsJBm1smL1gIcSAjyWvA4eJBABq7QJiorvLJWGcZ1ALgCMzlKy9suAWiql
        H9iQ2JkGA9Y9rR2lNkP5pjqRTnpjcJPdEohgwdVQVNRqTrZMTHuhxFvHxdVkFH73
        TGl2jA9wdNtOcJisHzSusaUp2q59FaSmNR7eLKTFOtQgi9IsNUR16GOM2uuKKx5W
        dODG4KQcEAqZIQc6mhIQw7APa5Wx3Kv87TxmaG+FdvmJMoDwIwUWZoenV/iyDwQg
        ==
X-ME-Sender: <xms:o30QXbleGP7Hx66krWKlv_allmqAP1f7ya7ChKI0SDKWFNLcoGfByA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppedujedvrddutdegrddvge
    ekrdeggeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:o30QXTGAK3c5LrdHsb-EQ8r4ss3kEO79j9kYTI51qescz8Rg3ozatw>
    <xmx:o30QXcqHiD9l23zn63Lmslgc-TxBSBEUDygWsXmwRfz-wFrRx775bQ>
    <xmx:o30QXX5WWCBWCyIOILJmborWroz4ycwM5Wz7AsmmwUnoYZHIc7JxXQ>
    <xmx:pH0QXZ0lKSu-QcedHo4lnr2K49mtL7tK0dCMxUE6UX7Agc7UeOxSbA>
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2AA83380083;
        Mon, 24 Jun 2019 03:37:05 -0400 (EDT)
Date:   Mon, 24 Jun 2019 15:34:43 +0800
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the pci tree
Message-ID: <20190624073443.GA13830@kroah.com>
References: <20190624171229.6415ca4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624171229.6415ca4f@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:29PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   Documentation/index.rst
> 
> between commit:
> 
>   c42eaffa1656 ("Documentation: add Linux PCI to Sphinx TOC tree")
> 
> from the pci tree and commit:
> 
>   ecefae6db042 ("docs: usb: rename files to .rst and add them to drivers-api")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

No patch "below", but I'm sure the fixup is fine :)

thanks,

greg k-h
