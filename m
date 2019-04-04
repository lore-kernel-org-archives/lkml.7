Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90615C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5697A206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="BrNRdPV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4qeP4U9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDDCQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:16:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60255 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfDDCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:16:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5B7F521D23;
        Wed,  3 Apr 2019 22:16:37 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 03 Apr 2019 22:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=r0+ySxPxczosFjZW0tVjVY7YxeyyP96
        YtlNToKjzLcs=; b=BrNRdPV4PqYv1yfmwSvq43n5VWDUbmWRfVy+ZSwP2h52Ycu
        EqKrfovi388Ru4TyleBAZNEs5vjhcvpLDfuRUp7aguhaX8YGREtDVxWArVcuacJh
        R8ajAjrtnoGWRWo8m9rg39dP0noBKfJlmvjRTFV7tHPPgn6UVrBRQEbSzfqdj2Dq
        ScnSJ4CwXuuQGFtlT9MZMr45N7OA6yTLP33lGSzrNQkgo1ClTpeobSzeXlVd2RDQ
        /fNwShwfAtpApSqUYTDlFzZIl3BQ6Hs9dwa+7lNl0JGtBLN6sOzA+grVj7YTfsws
        0ypkPnVeL+qWmK0h61Elt9U0xODaKeWS87oPghA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=r0+ySx
        PxczosFjZW0tVjVY7YxeyyP96YtlNToKjzLcs=; b=4qeP4U9DD5PE5Ce1iwM3mm
        mdN/pTxpq/K1WnabHhpmVl2RcC2b7qUqt+F3oQHn6OMtXFbgp2filffevuD01ODH
        Q6/ZUafRyZlGiw0eps57lCpVOJw6rA1Szgy1RGkPTVA3P3woGQbzHa2fwN7vxnDU
        KCe550imW6CT77bcsYUXecy/ura6QdxcoleHY6LJGoyRdoGQsI61DODv9BId8jF1
        CVCU9lOhRBYixsT22GFc777fvpPkljmvqzM8F+JKfybEiv4n3BzjAPH0VuJsb8oa
        ih2oW7A9vZlsbTWCHrYq92VEjmTMhUQRI7q557jN3dd2WdGUvjyvgK6u0Q5lS2og
        ==
X-ME-Sender: <xms:A2mlXPxoKHZTzUoa4jrt2Dhea0wnbbFJCbhAZZGeb_v2WeBx4xMUZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehgeculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreej
    necuhfhrohhmpedftehnughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrd
    hiugdrrghuqeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:A2mlXAUxSRPZIiuEaovUWxS7ZvBkPei1SWVUEh1nx5I1TCr4Q-clyA>
    <xmx:A2mlXMRzcXGhPpkp6wa4d4UBSHYlMaCvib_tKVb6om8_8D9RVjYiQg>
    <xmx:A2mlXGlyrk6KnM_fPHfHBmdfOpN8uctgZr6O1iGcK20h4o4XeHEEdg>
    <xmx:BWmlXM_tgyUQ4B-lXdRGiviHoYFxsuBFMHkGmgmjyXRdLYbrixC4-g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 672C77C1B9; Wed,  3 Apr 2019 22:16:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <e6bfc462-da83-4c2e-9f33-24727e5afd00@www.fastmail.com>
In-Reply-To: <dd017f44-5d1d-d657-b159-c9dbaadd795f@linux.vnet.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <1554229504-5661-3-git-send-email-eajames@linux.ibm.com>
 <7effb2de-cc91-47af-88a2-a0075262e9c4@www.fastmail.com>
 <dd017f44-5d1d-d657-b159-c9dbaadd795f@linux.vnet.ibm.com>
Date:   Wed, 03 Apr 2019 22:16:34 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.vnet.ibm.com>,
        "Eddie James" <eajames@linux.ibm.com>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        "Joel Stanley" <joel@jms.id.au>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        linux-clk@vger.kernel.org, "Stephen Boyd" <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        "Rob Herring" <robh+dt@kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_2/5]_media:_platform:_Aspeed:_Make_reserved_memory_?=
 =?UTF-8?Q?optional?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Apr 2019, at 01:05, Eddie James wrote:
> 
> On 4/3/19 1:01 AM, Andrew Jeffery wrote:
> >
> > On Wed, 3 Apr 2019, at 04:55, Eddie James wrote:
> >> Reserved memory doesn't need to be required; system memory would work
> >> fine.
> > I had to do a bit of legwork to understand what you were doing here. My
> > understanding is that we allocate out of the default CMA region if the
> > memory-region property isn't specified. Is that what you're expecting?
> > Could be helpful to be a little less terse in the commit message.
> 
> 
> Correct.
> 
> 
> >
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   drivers/media/platform/aspeed-video.c | 6 +-----
> >>   1 file changed, 1 insertion(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/aspeed-video.c
> >> b/drivers/media/platform/aspeed-video.c
> >> index 55c55a6..8144fe3 100644
> >> --- a/drivers/media/platform/aspeed-video.c
> >> +++ b/drivers/media/platform/aspeed-video.c
> >> @@ -1608,11 +1608,7 @@ static int aspeed_video_init(struct aspeed_video
> >> *video)
> >>   		return PTR_ERR(video->vclk);
> >>   	}
> >>   
> >> -	rc = of_reserved_mem_device_init(dev);
> >> -	if (rc) {
> >> -		dev_err(dev, "Unable to reserve memory\n");
> >> -		return rc;
> >> -	}
> >> +	of_reserved_mem_device_init(dev);
> > You're ignoring *all* errors here with the expectation that the cause is the
> > missing memory-region property. However, other errors can propagate
> > out of of_reserved_mem_device_init() - e.g. ENOMEM. Rather than remove
> > error checking, I think you should explicitly test for ENODEV, which is what is
> > returned if the memory-region property is absent.
> 
> 
> But it doesn't matter if it fails for any reason, any DMA allocation 
> should fall back to default CMA memory. In the case of ENOMEM or other 
> errors, then the later calls to allocate DMA may fail and we can deal 
> with it then.

Fair enough then. I think it deserves a comment, but up to you.

Andrew
