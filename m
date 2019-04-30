Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83B6C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ECF21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="UlrB1v2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vZ8aI4Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfD3INu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:13:50 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59451 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfD3INu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:13:50 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BDC5A551;
        Tue, 30 Apr 2019 04:13:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Apr 2019 04:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=cdFeCbmF2JOlSkSFgqVW8iAZ49D
        tq1g4z3meNqi1GVo=; b=UlrB1v2Q3cwjJ8IAYZejQxZWX1sbREPN2GcHRsifs0h
        LFvNTmfkLyA1KdNmQlv3rp7lXJ6X1EY/PWHZMOY08SyEn8F7PDxBQ/E/+YgSxDvm
        fJ53qbszRgEds7FLzeCJN3T4U78nN+3y1MHBkIRMZiD/9YN9r5xRvvNp7IDukPcs
        Ik3RevOjyRzNetQHE4nG3LabqQ8ctoCZzjl0lARPUk+ysOzu5vO6Fqp1FUNkFfVk
        DPUSA/TloU66UhNl1Sw43McKEOMB0pAInN8QvNjaGrbdEvv1IsoqCTkzDWkroa4i
        4IxBEpQqT++fK3fz6ar4DsNGex4VjPcieZA2qI0jS9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cdFeCb
        mF2JOlSkSFgqVW8iAZ49Dtq1g4z3meNqi1GVo=; b=vZ8aI4DwwcJ/dMT52JJz1E
        C3hnYGiEnQWCvQxRzRgKK3d2X8j/7ei+kTGhLvZiP8dXwS2Kmw2GBQDxgTbsjCHn
        JfzXBx/jJ1qKlkZYpY7LydG5G8UU+6i9UweqcinL+hGtA2UZPZseAC4LYPN4zqq8
        UqLJSjSv9ytAazdXoZjOkI2nGJaLa+icu0RXSRJwa9Ez7EjbFPAEsc+3a456Xwg4
        IlAeAMZNZurYyfnpTXufFw+c+Vg/+O+hnwc5HH2aeQF6qd55OxkQGmuiXWEPIQYZ
        iP2KHtGDAiuhlsExWJN20BBMklJo4eDQbGlssCDYqVI/7Y0DTZMyaursPeOTmYfA
        ==
X-ME-Sender: <xms:uwPIXKxzsm3xg9i_FKfh0E9gbxnTvTqiR6JgYSDqcOpd3M-3UQnYSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:uwPIXFRHf6kgV_Oqoy0QC7zbuMjFSyigoMf0hLg0cpqFc-FpbSwx_g>
    <xmx:uwPIXMe2Esg0a3UftFbBMkaBgEpznnuGlRc_Atn6XAPYfAzr0sfJJw>
    <xmx:uwPIXC6EMYCFcWDrdyWmtd2fs4mPLY7uSNp-o-T6YGa5tt5SfyiQPA>
    <xmx:vAPIXCfd96gSLzYED7Me7lT2a_1JMbfDeR5oOZcJlVgP5BYQanggfA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9E0EE44B6;
        Tue, 30 Apr 2019 04:13:46 -0400 (EDT)
Date:   Tue, 30 Apr 2019 10:13:44 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the pm tree
Message-ID: <20190430081344.GA8245@kroah.com>
References: <20190430174829.4f33e8b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430174829.4f33e8b0@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:48:29PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   Documentation/driver-api/index.rst
> 
> between commit:
> 
>   680e6ffa1510 ("Documentation: add Linux ACPI to Sphinx TOC tree")
> 
> from the pm tree and commit:
> 
>   09e7d4ed8991 ("docs: Add Generic Counter interface documentation")
> 
> from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/driver-api/index.rst
> index aa87075c7846,201247b7c1e8..000000000000
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@@ -56,7 -56,7 +56,8 @@@ available subsections can be seen below
>      slimbus
>      soundwire/index
>      fpga/index
>  +   acpi/index
> +    generic-counter

Looks good to me, thanks!

greg k-h
