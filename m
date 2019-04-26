Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031E420675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="XCDs3RTm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKWLABy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDZGZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:25:52 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48853 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfDZGZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:25:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B0461401;
        Fri, 26 Apr 2019 02:25:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 26 Apr 2019 02:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4esubMP0KWw/vET2G/lx8tto0C6
        sRoXB7wbClE3UN2Y=; b=XCDs3RTmpxTBrnbLgWy+9Uil4Fddg4bmzSIwssp7UnI
        ivIyfJNS2B0ZnbmtMpahvQARqJG0aN4FnbwMIlp/OcWe5tnbKEVaTsR5NWXMdSDC
        qBicmlMsx+Gl97re4zDtWJUg+d6yqUzC5b4w6DpgXlyvhSp7Hl4KfvexSPJPNUaX
        T2CnXo5XNhql9YgR4HHXYJ7+J09av0BW9r9OY85yk6e0TZqSVH2g+64r8WSuru+O
        FB+AlcB+vjeYjhSM2b2K4fgX5ra/zNZm4bP0QQmwoDBS9TILcWb9Aqh1G1yu32IH
        Rehx2/Cl/yL/SgcOeyJjeTWz3uVfAmBq+vscTg2hUPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4esubM
        P0KWw/vET2G/lx8tto0C6sRoXB7wbClE3UN2Y=; b=GKWLABy6Es4KtM+0JsVmqQ
        RxW0OmUphdJ5goKgr30hyb2vCcuaYEAbsw6pBSNcCzBDVOoYtdIyyK/AzwFslMfr
        ZjYqDVTJJdF9dsNKvgl1gol5yEuWlRy3/BdZkofd4daDMlOWRpOYPRIjJ6T6pIYm
        TCXGgFviC8rZAnzFZzl35rvQh2rx21jYwoKQglBbdbRaTV4xsrzmM3V9IwcPbM4q
        DmmtVqD7qwAYijHlaY5GFEySuXYes/5P8/aH9mb1xhD3X2hnxHUaWm6dabqysnLV
        rMx4SVB4uS0ic0f4mBFy6DIWy+IHalSeh7iPYj9oFq7mF2CASYaFB78+n9gjS9MQ
        ==
X-ME-Sender: <xms:baTCXL53-WCdJfUiB2yOsT2SxHdJ6SSgCSo8TG0j52WhG6Swe5zZRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheehgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeeivddrudelfedrhedtrd
    dvvdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:baTCXO34zrq5jBQuFWDOeYEwbVIVX9vNrpV6dmLz4GPInyCCXJ6gSQ>
    <xmx:baTCXKBoB2iT6JtiQrTgkc5fLSTkOGfdDqcOBqQq46_mg-sY2Dpv2w>
    <xmx:baTCXI03P8SrRisYmz9QrOOVgV4jxBgG0aPGSNDKyG72uR-wwGq44g>
    <xmx:bqTCXM1xJXGoplEvmJakJ8yJ0R_j8qJdxgjluzJGpiDyveoFbO6Jjw>
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25066E4173;
        Fri, 26 Apr 2019 02:25:49 -0400 (EDT)
Date:   Fri, 26 Apr 2019 08:25:48 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Patrick Venture <venture@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: linux-next: build warning after merge of the char-misc tree
Message-ID: <20190426062548.GB5920@kroah.com>
References: <20190426155653.2cdebc5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426155653.2cdebc5d@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 03:56:53PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the char-misc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/misc/aspeed-p2a-ctrl.c: In function 'aspeed_p2a_mmap':
> drivers/misc/aspeed-p2a-ctrl.c:110:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>   pgprot_t prot = vma->vm_page_prot;
>   ^~~~~~~~
> 
> Introduced by commit
> 
>   01c60dcea9f7 ("drivers/misc: Add Aspeed P2A control driver")

Patrick, I thought you fixed all of these already?  Can you send a patch
again?

Can you also make the driver so it can build with CONFIG_COMPILE_TEST
enabled so that others can find your problems earlier in the review
process?

thanks,

greg k-h
