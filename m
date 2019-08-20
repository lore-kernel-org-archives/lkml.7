Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C269C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1222DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="uyIw8Zsf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCLLjV2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfHTNEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:04:31 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:48597 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:04:30 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7F2B72078;
        Tue, 20 Aug 2019 09:04:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Aug 2019 09:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=V
        m1CFRjugck3T4LV10KBGOIjut7rhdmdTJNUs23j25Y=; b=uyIw8ZsfWR5+kbJwD
        1XLvPyPtmFKTlNYxQgwvtj4MQgUBJBPF0mHKdhRYRGw++m3cJx0yfRSEQxt/cF5b
        qmdtaI+spMaidZxbFT2qmXdsBuHsYq93yNO3zOM73KQVtbIq4q9TM9/JYjmubXC5
        hGqgQ11n5kFeFZ2BctUuA0B4kM1+0lZ9CCgWHAx3r2PUGPPCa3SJXSfIRrLQiFJ0
        tC8pAARLMh2X1kSzkjq3lFwV9APNORvuTYgozIqx/qRBuoCYtarpj/T+pj02Qjq0
        18Pai+Cpx2e2Bj4gl9wZPt6xQ0zdykvEzzdoiqMPLDBkuxy6XAIUo2oGXLMrPbCj
        oZM0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Vm1CFRjugck3T4LV10KBGOIjut7rhdmdTJNUs23j2
        5Y=; b=XCLLjV2vFteWfosJVq6bWG8eVc5Nt3Oxi3IwRqI3q93n4qtLk0LOAFjb8
        FEo+kP8W0s92G1kVjp01yBLjIFANutwdhIOJ1QdeOafP3iFo9nk7vgemgsj5CRJ5
        RE/Nw63yyd83j6WYABkHxCCoASz6Z0ou39yjuqPpt4WlQ7yCJ/LssKJ/gTYsuYOB
        I8mFZoETt3pACpp1lFZRfhJp/SxiRCFRAWtE4rTFepz1QzARbQ5T+N0TloceZ/fn
        emUV0ko4MdoW/PNAZ+cyDWCF6BcHgNg+o/fju3dvPKEQuS3eG1asQ10dt1DxwsK8
        6EG+PvZRu6AgqFDovk5DKoaZ9j4Rg==
X-ME-Sender: <xms:3O9bXYj2uoRVqgsCR1c6WNlaSvqn_ZSbQM6kA6WBe3dMoemb5RR46A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeguddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhprghmkfhpqdhouhhtucdlhedttddmnecujfgurhepuffvfhfhkffffgggjggtgfes
    thejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvg
    hlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtddrudefhedrudegkedrudehuden
    ucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
    enucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:3O9bXVQdnlMAXlwCKGNpRsMX2FbwkgUeWCHt7qv9JQlQ3AbcidXMvQ>
    <xmx:3O9bXbHhxkvx79jOXqOUTReXe9UyhhRxbk0T4iuWv-hwBGid4NqqAQ>
    <xmx:3O9bXdknno5SerW0zMRffQzS7Fl0Ju3GAoBzCpD0x0NIME4bpO160g>
    <xmx:3e9bXcTk0XxrUmePsC8qEkFdgmcAlueXMGrddox6jSYpqU2VMAiXCiaFJLw>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 24416380075;
        Tue, 20 Aug 2019 09:04:27 -0400 (EDT)
Subject: Re: [PATCH v4 03/10] dt-bindings: mailbox: Add a sunxi message box
 binding
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh@kernel.org>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-4-samuel@sholland.org>
 <20190820071456.if5lyb4t3em77svl@flea>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8947f4d1-3bb4-11b8-b114-5016339514b8@sholland.org>
Date:   Tue, 20 Aug 2019 08:04:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190820071456.if5lyb4t3em77svl@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 2:14 AM, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Aug 19, 2019 at 10:23:04PM -0500, Samuel Holland wrote:
>> This mailbox hardware is present in Allwinner sun8i, sun9i, and sun50i
>> SoCs. Add a device tree binding for it.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  .../mailbox/allwinner,sunxi-msgbox.yaml       | 79 +++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
> 
> So we merged a bunch of schemas already, with the convention that the
> name was the first compatible to use that binding.
> 
> That would be allwinner,sun6i-a31-msgbox.yaml in that case

Okay, I'll rename the binding and driver (and Kconfig symbol?).

Thanks,
Samuel

