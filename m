Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A8C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B21C2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LqFr7arS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5xnqsv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgAIGAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:00:22 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52067 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727980AbgAIGAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:00:20 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8197D21FC5;
        Thu,  9 Jan 2020 01:00:19 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 09 Jan 2020 01:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Ynx/sG4Nu6QytMUoZxOmN9kX3FtDIxE
        I42xzek+Pfn0=; b=LqFr7arSoDu5Ff5sghPBU8wQvXcaFr+xPZ8DpIwUC1EwRKh
        csyaUzs3fDGb3CqlhOYeb3dD4qpYnM+aAPvo9UZVqydctoF0GgmPjEgfMGJVBlC/
        R2kvibCgVnGtmScJnesyC8ihQZvSSCgd+q7fwyYuGaa6ZH7yjTyWVYwMSCLcdpU2
        sSSlht3cSzY9U6+c6+TRjo/jNHJXmRPoFHdcbK7GIjyRurNQEHhkNghUlT4g+Sz/
        enLpYrcJVlJzhfs9PIZy7bEmVrHd48dgBfg4nyH/7P76LQGhEgEnWdBnSniAtvRm
        lV4A2FfWru2grAym/fBTEWddIORwEuKpty3uJMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ynx/sG
        4Nu6QytMUoZxOmN9kX3FtDIxEI42xzek+Pfn0=; b=L5xnqsv9k6wEYvD96af8mZ
        KJ6gFX39DOvLO1F/3u6rqQKuTIye6YWiHVGdV8tyyBK1hvJaUEojlJwuQ7vjVhXw
        fHsQigQfCqdJ+vt29npPSKye7wPGOlR809lqqmvnzd/2cGZHfe1mED5upc7aiBb2
        g0pcUGK/7i6jUuOIIR0Tl1Deyj958oSJ9bLiE4zf1xXihIDWxSWacldznmSf3MHN
        DmG9q6Obkc48+poA+uRiMUcarSHT+bTOLkZHHw7JEP1N+/1Ud9O9UMvLmzqD0pyl
        u7Y7b24/Jwo2gy1zF9QL1s2/RHMA10vO3SUGEdhAqmBLdkeyIidUZhpVpX90sxxA
        ==
X-ME-Sender: <xms:csEWXl4d5InvpzdQqvXJe6xxBm_jiD-aAgV_cuJb1Z76h4c1PdSh9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgepud
X-ME-Proxy: <xmx:csEWXkVHGvGyPnB8f2vYMtyktgufMFoU8rP3jShm1QhLxOjpSoFaoQ>
    <xmx:csEWXn2OivLIWMoIQ_cp0xp1NOs-z-Z1wuWmuH5x40H3Qiy6rownVA>
    <xmx:csEWXrPtnZxpy46ybLx4XhRrMthe6gvkPzdj7VBgNt5HqzQPn3SpMQ>
    <xmx:c8EWXo3B7ifWwjIPH21fvIxwgdd0QTec8UJN5ciOpqVBnwxfwI4Vow>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5C3BAE00A1; Thu,  9 Jan 2020 01:00:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <d1e6ea02-0b16-4dc6-8abb-1bbf30bd6548@www.fastmail.com>
In-Reply-To: <1577993276-2184-10-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-10-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 09 Jan 2020 16:32:17 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v4 09/12] ARM: dts: aspeed: ast2500: Add XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> Add a node for the XDMA engine with all the necessary information.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
