Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F3BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803CD21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="QBaZ3L8c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDe6zVwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfB1ABo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:01:44 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54003 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728397AbfB1ABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:01:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 31A51234B6;
        Wed, 27 Feb 2019 19:01:43 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 27 Feb 2019 19:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:in-reply-to:references:date:from:to:cc:subject
        :content-type; s=fm2; bh=K+DegNbvLP307hARvy97U1jKD+OQzjbATh22FbK
        GTHM=; b=QBaZ3L8cTMkXJJxcasULGDNBhJnhGwYcBZeUV1XFuppwkfTMUw/vcvW
        O7bHqXXJaGZjY44uRVjX5huZQs1yWQpKuNKM43queMNN/wStcq1ZSB2RYC/QwZnY
        R+9ejGS5g0wFljwZ9vmpE3pX0hg5co+Gwh+Af87Hx3p2E+EzrbSWeoh0brn6zAUf
        Tz086GZMSalbwUB3Ia2PlHp4A6a76XgNNl3fWiWfy74HjgaTA85maEqAPYxNvu0o
        7kPlWH9PgWfq3VZspBfEgvsvh53WmLwJu36igsFNLrlYe3/NbXSYqVjnXCCckHjj
        /FARo7pSxgMVb8tuFi6d5G4hcdoRQLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:references:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=K+DegNbvLP307hARv
        y97U1jKD+OQzjbATh22FbKGTHM=; b=XDe6zVwzKgucRkF8ntO2cMV3TIYjG6uL0
        +5fxUJI+Z4nx4H8gbiXD0fSaHwQCvYduV1KuUflLh1ASe+Zxwf8Rz177Sp+y5uwT
        2SOV/8D/dxXDZ69I768dhXcM6zyiLttpgrnIuJ77UN47R2CCSSosygZdtWdiovvc
        FhX36+HE0z6sCo7etn/EUxWyPy7f3K6sNJzg39nirFBFf6hcQ4QcZpwDXDBufLfw
        xc4WcA7PeKWY34SqKXBZJqfFIn2C/HdOW432+s05iednAhywToZ84eZWJTRD2qxb
        ymAbXiPX+cRNlQ3Lm9/rU6tEwrtBLvvKRnnulYNbxox9S3yOGXr2Q==
X-ME-Sender: <xms:5iR3XNqp1wQILNIM2VeHdfpWOx8wnVMYs12SULAfklKaOgk_loqtDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvddvgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgurhgv
    ficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfu
    ihiivgeptd
X-ME-Proxy: <xmx:5iR3XKjinyXsJAYAVIpHle_ZsutBxh18s1Ob7hajmEX9473hxqba4g>
    <xmx:5iR3XNGNem-3bhuPgUUS6ilmgnMEwP4BjqmRa0SaVanyF61wbYMIOA>
    <xmx:5iR3XCnd5VduWrHcU6K1qQTjUPS9RSZi_pzUxPmlj0j_6GDWlQelpQ>
    <xmx:5yR3XPDHUa3Oggy9aA29dp59u2ODO9rPrN-cT-1uwN3yHaTl-xir3Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7BDD07C1EB; Wed, 27 Feb 2019 19:01:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.5-895-g0d23ba6-fmstable-20190213v1
X-Me-Personality: 52947553
Message-Id: <43124fcc-6560-4a30-8043-727c39e487ab@www.fastmail.com>
In-Reply-To: <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
References: <20190221222537.137331-1-venture@google.com>
 <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
Date:   Wed, 27 Feb 2019 19:01:41 -0500
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Florian Fainelli" <f.fainelli@gmail.com>,
        "Patrick Venture" <venture@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019, at 15:35, Florian Fainelli wrote:
> 
> 
> On 2/21/2019 2:25 PM, Patrick Venture wrote:
> > The ASPEED AST2400, and AST2500 in some configurations include a
> > PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> > in the BMC's memory space.  This feature is especially useful when using
> > this bridge to send large files to the BMC.
> > 
> > The host may use this to send down a firmware image by staging data at a
> > specific memory address, and in a coordinated effort with the BMC's
> > software stack and kernel, transmit the bytes.
> > 
> > This driver enables the BMC to unlock the PCI bridge on demand, and
> > configure it via ioctl to allow the host to write bytes to an agreed
> > upon location.  In the primary use-case, the region to use is known
> > apriori on the BMC, and the host requests this information.  Once this
> > request is received, the BMC's software stack will enable the bridge and
> > the region and then using some software flow control (possibly via IPMI
> > packets), copy the bytes down.  Once the process is complete, the BMC
> > will disable the bridge and unset any region involved.
> > 
> > The default behavior of this bridge when present is: enabled and all
> > regions marked read-write.  This driver will fix the regions to be
> > read-only and then disable the bridge entirely.
> 
> A complete drive by review, so I could be completely off here (most
> likely am), but have you considered using virtio and doing some sort of
> rudimentary features (regions here) negotiation over that interface?
> 
> If I get your description right in premise maybe emulating the AHB side
> on the BMC as a PCI end-point device driver, and using it as a seemingly
> regular PCI EP from the host side with BARs and stuff might make sense
> here and be less of a security hole than it currently looks like.

It's not immediately clear to me that this is a win; it seems like a lot of
complexity that only prevents the host from accidentally stomping on
areas of BMC RAM; a malicious host would just ignore this constraint
anyway as the hardware capability allows access anywhere in the BMC's
address space. Most of the accidental case is taken care of by Patrick's
strategy anyway, which is disabling the capability entirely when there's
no need for it to be active.

Andrew
