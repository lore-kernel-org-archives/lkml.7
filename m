Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C0C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA2A21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ItChtcYj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofOwDzQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfGDG7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:59:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40357 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbfGDG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:59:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F302621B34;
        Thu,  4 Jul 2019 02:59:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Jul 2019 02:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=G7SayW4S/aV3JUo1cLGnykNspda
        yDsjsUFvSmkGU34E=; b=ItChtcYjFQ8z/59e58hzqb+Y4S4LwWxLstgxcDOd7qA
        eydiMbxP7GfkHMFKt2HyfGu4y5IJeIg/U0efAUi+uP3CRRyYivYvkGoGIe4xRSC5
        8PBkM7VKCvRri52y4jN2rFaAeRU/fGsT85P31zaLqxgggZHhrqqpbbvS2VfN/QMr
        GdRuzk1Dusj9sNhVnqtHo5jSUg8pAHDEP7IqrkiOj9aBjMlnax3Qe0bB5eUqGYUB
        kpEfq4tM6Sx2DD6ISeT0gteW6jY2IPo1NcuzqgSr2noDvo9TxicAhR5ve4hPnAYn
        478PChhblcZbB0RvR/YYhQKAmN331uCDF+gXj0ew8fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G7SayW
        4S/aV3JUo1cLGnykNspdayDsjsUFvSmkGU34E=; b=ofOwDzQ5Th1gipKBkSq0ZU
        6bU3U3aP3OjJH8KynrgdStVZJa/xpOGgHJCCg+dsGet3wkASWykMBHj2Oki9dc+5
        7DFUEIYfgwz283RGyerxJXJ7Q1TcO1VIhIpeh7QkhbPo74fJvUdlgklSRlSS7K8S
        bo+hfqioTx8gjXQ0u16FhlgDSxTCSk4ssmIV89dxtdTFXBebsn/XMQySML8zcU/4
        CnbloIXiRkly2P/dHlpZSsXV2ZVVxPoXH9l4QrUhWceSt1LYXU+FW9D8A08cEPgY
        UWfyOtWL8PwWkMCvM7akBQDdnxgj1CzqL0UoK7xPCAdyRQuVGlf4yh3UlFfHS5kg
        ==
X-ME-Sender: <xms:56MdXcwIbrPJH6op_gsEorIp4RXoRzsh9f4eQSoTA08OQdDladUK8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrfedugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:56MdXSLkJS70dqcI3VafeSVXIyQeTQ2ijuXoUBXKuoTCiIinhl53oA>
    <xmx:56MdXXu0lds92EqDSQ7spxBruZbTQbOQ16QTqFumByBmZsc60rjhig>
    <xmx:56MdXUAy5dJWfsfwsgs0V0U5oOCUupfKDt1g09E5Ces9GxCD28OQcA>
    <xmx:6KMdXS_Uupu6CdNsVX48NAuitjnxYOXK7GEBv-Gt6yWbN5t9XRklQQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 848A2380084;
        Thu,  4 Jul 2019 02:59:51 -0400 (EDT)
Date:   Thu, 4 Jul 2019 08:59:49 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: linux-next: build failure after merge of the usb and usb-gadget
 trees
Message-ID: <20190704065949.GA32707@kroah.com>
References: <20190704163458.63ed69d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704163458.63ed69d2@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 04:34:58PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_output_dwc3_log_ctrl':
> trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'
> 
> Caused by commit
> 
>   3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")
> 
> I have used the usb tree from next-20190703 for today.
> 
> This also occurs in the usb-gadget tree so I have used the version of
> that from next-20190703 as well.

Odd, I thought I pulled the usb-gadget tree into mine.  Felipe, can you
take a look at this to see if I messed something up?

thanks,

greg k-h
