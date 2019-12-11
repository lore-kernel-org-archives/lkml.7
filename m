Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1018FC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADCC2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ZgyUrBP/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nvtlJ7x+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfLKAab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:30:31 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40251 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfLKAaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:30:30 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4452222611;
        Tue, 10 Dec 2019 19:30:29 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 10 Dec 2019 19:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=rLVrKFn1e9XoYm6vW5UZkkz+J1OlgvA
        Bn/hbvdEf6xA=; b=ZgyUrBP/dSEnxvkY8KRknAovC8fWiLWxAPri0JddEv2wpbt
        8XkYPg5v8z5UXGDEisPsuEoguh3mRqAVQHXpbATiKvYx25KzbxCfIrGnwp+vCsDy
        gEZaIh707rLLt39hQzqkgQXTuikj9yuLv0PIDu71XYhcUZCJr+mv19PYl4pbbA0W
        zOrfA4k802Vw4UlRG4vWFViv5Db2wmRbTbecFUAtO0zwZh6ERsKImcwmISBslW85
        /UzAWLmiW+Sv7r7mX7AKXZXViKvEetc89firz44/ciq67vejDeNv7SknrXU0xbHZ
        3bciUhf0IenO5HEihvu+bHV5GUq3Go2THcDbMIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rLVrKF
        n1e9XoYm6vW5UZkkz+J1OlgvABn/hbvdEf6xA=; b=nvtlJ7x+wA/3kzg2Vj2QeI
        4ZdRaAYkzOJ8nFpvZTNBFjG+jumNaaEOGCysWN+TuheV50JcVW/pnbugHFaR/3FK
        LrWetfs88GNVS4RrJxiZ9N5SHZuwYeqJ6Yzkn5qd80nmjUuHwz1ZEPKFnN1fg+3s
        7NSWdMyGS2b4SGwfiaa1bQlUY7gICDxPlVxYfjEIvWSjqf1fZG8iLCbAx+8aIs2y
        83iqIVwJ3V56POQMCB5mWCkATs5SZNhwvZicRviaQxo+GjGFY3c5Qg2GY6LTpPGT
        v9X1fCOZLiYPG9BpU2JvGw1WvsDnLZnRcxahVBs8IO6ZCXdOl/USgxKElmqcSXjA
        ==
X-ME-Sender: <xms:pDjwXd6WSiamRPJa797sIeihJCfVdWmpfrTYEjpEVlNsFUn2ImAykQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:pDjwXRnnsIz2Z6fl4VVFFtDKTCw-QGxnmLZXw4WwIZWCtezQk_H5Qg>
    <xmx:pDjwXVznhDxidgYEiQfUhJs98QI_EhDN3Rfv92z2Au_LoZdRh77nzw>
    <xmx:pDjwXcD5Su1ORQaB7qjaBXd9Aj-R-8cquiYTuTCU3Wp_Ao01UlPZeQ>
    <xmx:pTjwXf3rmlvC0YvFlR76PhhH0DlvrPevgkwR3gQPH2T36otpJnsozg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4A7B7E00A2; Tue, 10 Dec 2019 19:30:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <40bf8eb4-2998-43fd-af61-c9063b09ced9@www.fastmail.com>
In-Reply-To: <1575566112-11658-3-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-3-git-send-email-eajames@linux.ibm.com>
Date:   Wed, 11 Dec 2019 11:02:08 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        linux-aspeed@lists.ozlabs.org, "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        mark.rutland@arm.com, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v2 02/12] irqchip: Add Aspeed SCU interrupt controller
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> The Aspeed SOCs provide some interrupts through the System Control
> Unit registers. Add an interrupt controller that provides these
> interrupts to the system.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
