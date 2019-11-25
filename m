Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A144DC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7620B2067D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="YO5yHAIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TR0N2AZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfKXX7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:59:48 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60315 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbfKXX7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:59:48 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F0F2922967;
        Sun, 24 Nov 2019 18:59:46 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 24 Nov 2019 18:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=x+tDdMWKBIFb/MGGtC1anmSIzBdbBpV
        lggF2pFtQW5Q=; b=YO5yHAIbA2MZKbPGtU+/WaAHDDljYyrdv7zIHyeHuzlGXOa
        mCEO6rh9wRCeTmYRzlh6wj5pH8n33JECFLFjRBtctKPsT7cEOkrDlEFP+uAxuRug
        TD0K2IuOE9mtyfojqTgisq/kHbQrARf/rm2bwkZPugY1EUSf3Iwa3hBhI9iBuPm0
        /0u1tjyOl2y0wvUTnOvNlb1Lz1yvwup+zvCbhUIjN2gAVpFU1YKccbgJfi2HqlfW
        zZrDXy952PUpXKR+a7v7U3V3jwdGS+VFTEh7LK+P/gvRme6JvWtdRie1OUSDavlZ
        DPOYognNxMz7cWOt3SlPu3OOpXBLwFM/7wMiS4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=x+tDdM
        WKBIFb/MGGtC1anmSIzBdbBpVlggF2pFtQW5Q=; b=TR0N2AZkZIm/ia6TA/b5oc
        udFh5CVzCe7O4Eer9P/F7X/FSUjgDBf4SuiqVxGQptf3dlNNyOzZEyCg8CNju3Ky
        T9X4+hyCQIfLKkZLeQxlG8YtSA3jLoyShGvqV4HX2dtnfqok6HdVzmoqWvnsEQCo
        jC/PHx7/8RFl6Kpi9UxkbrxWHnzdm7GjcoI0CVralB3iSEJgpVaouGqvYFSjAL8h
        XjtaG+tlboCATeGDNaD/p2dPlvwM57afOVFYbhpY9B882QFwC1W7BEmOSLRw9evl
        aeZYZQwC1eFe6U5OlACvLVZkkarehfmH6t2WxfdPRoIVxYA/vcr8ifMCkrn14FNQ
        ==
X-ME-Sender: <xms:chnbXVG8PYTrbBW_SGYWSck1Cai7Ca4ZCHgVxEGtNATOXDxA161I4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgepud
X-ME-Proxy: <xmx:chnbXR9FgZj_rMxcX_jng8LRSunQmOxJSVB2FFa5qT7Sik6HA0Nacg>
    <xmx:chnbXehWE_4XX00eIm7NFAYfkrOv9czjls7jpoPVtj76YdlkYOtn8A>
    <xmx:chnbXVleV2z1RRFyys8JGkayeg3gzEttnS9PKhSUKeCE5zHiEX2yQA>
    <xmx:chnbXVTa241nWOIGbSkcOofyHnWPMpwiHigLyW5gqjdzcGFmJ7td9w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C6CC6E00A2; Sun, 24 Nov 2019 18:59:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <e4d49ccb-8b83-4c85-9be1-48d77c0000e2@www.fastmail.com>
In-Reply-To: <a600a526-2f11-4a37-b4f3-8f53c533db02@www.fastmail.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-7-git-send-email-eajames@linux.ibm.com>
 <a600a526-2f11-4a37-b4f3-8f53c533db02@www.fastmail.com>
Date:   Mon, 25 Nov 2019 10:31:13 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, "Joel Stanley" <joel@jms.id.au>,
        maz@kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        tglx@linutronix.de, "Rob Herring" <robh+dt@kernel.org>,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static int aspeed_xdma_remove(struct platform_device *pdev)
> > +{
> > +	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
> > +
> > +	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
> > +		      XDMA_CMDQ_SIZE);
> 
> You've used devm_gen_pool_create(), so no need to explicitly free it.

Sorry, disregard that, brain-fart.

Andrew
