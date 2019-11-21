Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AC9C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7558120692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ZH+/ClKx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PODPb8be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfKUWpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:45:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45925 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfKUWpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:45:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B147922C9D;
        Thu, 21 Nov 2019 17:45:14 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 21 Nov 2019 17:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=dtxfG1NstJO0gZ3w3rZPANJZr2PPUHV
        Erzd70gBGFhE=; b=ZH+/ClKxc2IJ3766JJ4Etfw/LlvWwEYV2j5Md6sQP2rKTvH
        jNSywaGPikAJfhCzCWAXTrrpF51K6rwiI1o/19qJtnMTTbhUVB3s9UPkmSv2DZUm
        iDcJLLv0/EzzlpxWpZnByRMgmoCBbpegEg2PpE3e8lUnyBEWSQ9Lz6uI5kmzZUT0
        0K3XOpbSFpCV/N3vmcfyQ7gUJ75LYZZFWOCLYWoh/WI9aeUfyu0tGkUbwCc9gFn9
        tYAKjxZFk+k7Q3t+UxwQT9jxpGsspEhWn8hvfrG3+pqaqn7BlWUuUpt1V69uuN/F
        YnN4qgF6SuQbpsPevyyjzbRpe976p++26NrlZRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dtxfG1
        NstJO0gZ3w3rZPANJZr2PPUHVErzd70gBGFhE=; b=PODPb8beQz48rVN07lqgzy
        9NWnIwrrJjbgryblubT/MmPPfRdM3/tAtubpoOCWgSRjXZUD0Sjw8aqOdzE9Ea7R
        FAwa4OQ/2AGwlfrxZayVEARSbTsI2+Fkii2Vn81FwAO3yfNfqpbBMQQ4Xw3qucU8
        YioZfsXrthuCtNI5DBpxQ4LSoutGYFFgeoMz46izfhD6dp90y4USobL/myr9gDeI
        4a6Dy27wL4Vh/gSVeuTQNNIdQ1Pv6edOSSxyikxnxpAB4ni6qFzUUOb1dpp+cfA2
        Lu2qnmQxogMkOCacEYUc52RZxwEbl0/iQ5snky5jidN4ORkeuhdHaVGmkWxtl+2A
        ==
X-ME-Sender: <xms:eRPXXdE-Mw2ufJuK4b8r3148Xf9W78K2QfoHjCqVI6Agd2PagqHYmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehfecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughrvgif
    ucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrghmpe
    hmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:eRPXXVmNawSsD6EQTugb0EdbWZyA9HYxNzSNxF3Lrm646vdt0QIgrQ>
    <xmx:eRPXXYmon-eNmASI3UnMS9iGijDbuWchEH5aKBOixD7V5pt2AKojKA>
    <xmx:eRPXXetTE6dJ57zza3usLFCGJ7ER_mOQK9M1lE5Hh06iAvEJPstByw>
    <xmx:ehPXXbM8L_WFmZyTskLctbFhZxFIv6RfVnX-p7nIePAvKL-CS_kk7Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BC162E00B1; Thu, 21 Nov 2019 17:45:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <0fce7468-bb35-4d47-8d5d-abc228e99085@www.fastmail.com>
In-Reply-To: <20191121074843.GA10607@cnn>
References: <20191118123707.GA5560@cnn>
 <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
 <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com> <20191121074843.GA10607@cnn>
Date:   Fri, 22 Nov 2019 09:16:39 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>,
        "Vijay Khemka" <vijaykhemka@fb.com>
Cc:     "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Nov 2019, at 18:18, Manikandan wrote:
> 
> Hi Andrew/Vijay,
> 
> Thanks for the review .
> 
> The following changes done in dts and tested in Facebook Yosemite V2 
> BMC platform,
>   1. LPC feature removed as not supported .
>   2. VUART feature removed as not supported.
>   3. Host UART feature removed as not in the current scope.
>   4. ADC pinctrl details added in dts.

Can you please re-send the patch as a v2 and inline to the mail rather than
as an attachment?

Cheers,

Andrew
