Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5828C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9DC20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="do6mHBxe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7ze3g9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfCFAAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:00:19 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41939 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727621AbfCFAAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:00:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D17FA252A1;
        Tue,  5 Mar 2019 19:00:15 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 05 Mar 2019 19:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:in-reply-to:references:date:from:to:cc:subject
        :content-type; s=fm2; bh=mI22rVnWiiAIiyCDfZ8pwUtrqGYRJlqnVT+VlJp
        yivQ=; b=do6mHBxejZXsDBt3rqmW5OQiSq8PV395oYJ6tO0dJQal8TGmNd4a7b8
        LqO3bOzwtfvrTF98CCCV7fEYxiB2qq65uceKmWAxK5YlSBZrcuEiRIWGvTcq1CXg
        wW3CG3jZiBYVHnCcQ8dU/RdMXAn4nGtCMKyn2C4BUbKcsIow6j/r7nvqDC8bfMtR
        AY83Lv4xDnqLNGGGN7ElybbMCEd5+sk32/7SlAd/UktRY8VEIBT61gz6M2LpypJn
        KNvKWcfXFk/lx+JKxKDcLt63+g1R8kM+rgmuovDFOO5Hwlmk80hq7XLfI8k7/n14
        AXfmV+i3CkAauOdbuoDk9jipJ9qlTkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:references:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mI22rVnWiiAIiyCDf
        Z8pwUtrqGYRJlqnVT+VlJpyivQ=; b=k7ze3g9iNdKFVr24FZZSpdOhLxgiFt6cC
        dfTlbC7kQ1WpfSL/J7Qe6aasc7a4suN/buTupTRTv9HipCauoYe/2gqeOzWG1z49
        jaDixRxCpbNnVzmWW71nAjZePnM59Hd2bPOUGPTxSKHZPWCM0AUu27VZodEWab4x
        ZenlaVeHO7mWxNwFpTQJFz6g7HP+y3CQ1Myt6WDc9gWa11fnWfqCz/JWu2K4mEcd
        VeLCF3/LxSFKFVGFLE3asnrjVYqVn6RaJQZaN6s30tWSkAVGy9wzhhZWhWOhDQHO
        POf0Vi/NiE2OA4DyDLnaTINEvam58wVDgXSAZBqDOTeN2IfpjznEw==
X-ME-Sender: <xms:jg1_XEgjORv_ZdiIPWJ3pGpsLwMNIu_NuyDi38ioZdEdN7NIJOfHEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeggddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgurhgv
    ficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfu
    ihiivgeptd
X-ME-Proxy: <xmx:jg1_XI_Lk1z1sqE5ezYBrdTUJwau5-0VVNNYW3G6jO25pc5bVEiYnw>
    <xmx:jg1_XPJCNXslNk12xM-XJ44ufp1lYZZhACVLS6SUoaqX0f0dGkE7EQ>
    <xmx:jg1_XAqduhL_HcBR90tNnnTY1pPySURDiBT9ZU_AJP1PZQx4SEr3Dg>
    <xmx:jw1_XP_dkzKvXLo8PzUmTjoHwcR-_DQbKC0xGStcHksPc5X7Gu-k_g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8300B7C3AB; Tue,  5 Mar 2019 19:00:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.5-925-g644bf8c-fmstable-20190228v5
X-Me-Personality: 52947553
Message-Id: <e889a254-ec7e-49f5-bdb0-1d8d8a9063a6@www.fastmail.com>
In-Reply-To: <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
 <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
 <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
Date:   Tue, 05 Mar 2019 19:00:05 -0500
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Mark Rutland" <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "OpenBMC Maillist" <openbmc@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Mar 2019, at 08:15, Eddie James wrote:
> 
> On 3/5/19 2:01 AM, Arnd Bergmann wrote:
> > On Mon, Mar 4, 2019 at 10:37 PM Eddie James <eajames@linux.ibm.com> wrote:
> >> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
> >> between the SOC (acting as a BMC) and a host processor in a server.
> >>
> >> This commit adds a driver to control the XDMA engine and adds functions
> >> to initialize the hardware and memory and start DMA operations.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > Hi Eddie,
> >
> > Thanks for your submission! Overall this looks well-implemented, but
> > I fear we already have too many ways of doing the same thing at
> > the moment, and I would hope to avoid adding yet another user space
> > interface for a specific hardware that does this.
> >
> > Your interface appears to be a fairly low-level variant, just doing
> > single DMA transfers through ioctls, but configuring the PCIe
> > endpoint over sysfs.
> 
> Hi, thanks for the quick response!
> 
> There is actually no PCIe configuration done in this driver. The two 
> sysfs entries control the system control unit (SCU) on the AST2500 
> purely to enable and disable entire PCIe devices. It might be possible 
> to control those devices more finely with a PCI endpoint driver, but 
> there is no need to do so. The XDMA engine does that by itself to 
> perform DMA fairly automatically.

I had a series a while back to expose random bits from devices in sysfs. It got
shot down pretty well, but the main contention was over the devicetree
bindings.

I think we could revive it as a library-type thing that drivers can use to expose
bits like what you're describing without putting the grubby details in the
devicetree. The we would have a consistent approach to exposing otherwise
hard to describe functions (which is what a lot of a BMC turns out to be).

Andrew
