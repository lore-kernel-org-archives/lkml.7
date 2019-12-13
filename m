Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA43C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C482073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="hxS+mB4B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sp4hVZFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfLMBlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:41:11 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:55299 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731604AbfLMBlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:41:11 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C58B02798;
        Thu, 12 Dec 2019 20:41:07 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 12 Dec 2019 20:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=9R1DF4M5Pmu5MeZeNHugx3+fZB4LUBd
        c0AIWbpwNu0g=; b=hxS+mB4BUTJX804lzDTqDP4nZjPhAIWQ+Xo4jn58vmx7fs/
        lrue5+5+lo+vSrGl8dIcmwtQL9IYY8iR0n2UHd+1pyCCOjfQ5V3oIgarQSlv5JNm
        rSrGQgOETDdnjf5fsK0Nl/+zv2HTvppkFMEmdC/B0e3UGhua2d8fdg06qTgJOtjc
        TzsHe9a0uRepyTJ/odkLf3vFy0XmyZLcSnwiP3kNbZFfjkU0pSEEwh7slw9XXpfq
        /TnsAPSoYUCvH8H1FtWWGEMpGnedNv8EsHW/hHtYpgs51jSukMrwnzqwvhuq5Pig
        sRy2WBzyrB2CE55DooY10eoijL8xrKUiAT5ToGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9R1DF4
        M5Pmu5MeZeNHugx3+fZB4LUBdc0AIWbpwNu0g=; b=Sp4hVZFfpci0lyVOFH7QzD
        blP1G7YkXIeHsMlzNyjlN2sAzjkZ6rD0mVNbHAbfOR5QxUO+YrWb55rAa7jG8hpl
        8lmmZX2B7m+tpAMYjYCIgupHVZ/TyENkjQyjkV+pCctw//hbsd/RsGsDDmppT2w2
        3/+XELmpVdnYx4WMuGpjLnZzmaNazStDB7MQMUwlJim9EgVb5rQ10k6xHe9wawwp
        qwwOZkxvO6zVuIyJUwq04LFpP2HBlwZXjb0ihDcMhnEzlU2FhiIFvxDIxvDmN3ua
        kztSvJgd7SRLydLIxHhVaBYm+H94T2jTcu9xGRDgXe5140/EhSdtasYIhousIxeQ
        ==
X-ME-Sender: <xms:MuzyXfBgkU4UiZiso_eGpnA8h-iHD0yt5WANprvLJDuKIg3AcZNffw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:MuzyXUsBCV5TOZ5prXltKNzixjwfeIhYBZnXV_xcOiA4SrvW8Pf8Fg>
    <xmx:MuzyXdRZVBkvMoO0LcDGiBqHhuX5cOdoEQx6H1B91EyQXRL4k_4wrA>
    <xmx:MuzyXbLwXwEV1EzZs8bKS6--C-jQo4vEs0yX2u3gyOsgZdwp6FrZYg>
    <xmx:M-zyXXc-DzCftJLfsxXjTCGWD2GwDI6WyiQCteKNjYScHwuMYgJiXg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 87175E00A2; Thu, 12 Dec 2019 20:41:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-680-g58d4e90-fmstable-20191213v1
Mime-Version: 1.0
Message-Id: <601efc97-714b-40af-b3a0-e4687c43be46@www.fastmail.com>
In-Reply-To: <bbe9045e-c5ca-541c-1ee9-0f5ef246a27b@linux.vnet.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-7-git-send-email-eajames@linux.ibm.com>
 <de395d95-15f4-4df3-873d-ce89ae008ed3@www.fastmail.com>
 <bffadb0a-aba7-d799-b2ef-a4adb3259c4b@linux.ibm.com>
 <f597202e-0d5a-4b76-ba0a-a6f0a857b289@www.fastmail.com>
 <bbe9045e-c5ca-541c-1ee9-0f5ef246a27b@linux.vnet.ibm.com>
Date:   Fri, 13 Dec 2019 12:12:38 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.vnet.ibm.com>,
        "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        linux-aspeed@lists.ozlabs.org, "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        mark.rutland@arm.com, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v2 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Dec 2019, at 05:46, Eddie James wrote:
> 
> On 12/11/19 10:52 PM, Andrew Jeffery wrote:
> >
> > On Thu, 12 Dec 2019, at 07:09, Eddie James wrote:
> >> On 12/10/19 9:47 PM, Andrew Jeffery wrote:
> >>> On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> >>>> +
> >>>> +	regmap_update_bits(sdmc, SDMC_REMAP, ctx->chip->sdmc_remap,
> >>>> +			   ctx->chip->sdmc_remap);
> >>> I disagree with doing this. As mentioned on the bindings it should be up to
> >>> the platform integrator to ensure that this is configured appropriately.
> >>
> >> Probably so, but then how does one actually configure that elsewhere? Do
> >> you mean add code to the edac driver (and add support for the ast2600)
> >> to read some dts properties to set it?
> > Right. That's where I was going. I don't expect you to do that as part of this
> > patch series, but if you could separate this code out into separate patches
> > (dealing with the sdmc property in the devicetree binding as well) we can at
> > least concentrate on getting the core XDMA driver in and work out how to
> > move forward with configuring the memory controller later.
> 
> 
> Yea... my concern is that then we end up with a driver upstream that 
> doesn't actually work. Same concern with the reset thing you mentioned 
> below.

How would it not work? It would just be up to the platform integrator to make
sure the stars align right? If they do then there should be no problem. Whacking
the memory controller here is done out of convenience.

We can still carry the separate patches adding this and the reset behaviour in
e.g. the openbmc kernel tree if necessary.

Andrew
