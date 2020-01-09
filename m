Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88E7C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAEF20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="TUpA+YST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYgh4MG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgAIGAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:00:42 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54557 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgAIGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:00:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C1C9D21F18;
        Thu,  9 Jan 2020 01:00:40 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 09 Jan 2020 01:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Ynx/sG4Nu6QytMUoZxOmN9kX3FtDIxE
        I42xzek+Pfn0=; b=TUpA+YSTG1tGmezaZ9Ah0mNl6rxp8Ybki5q4KLihafGSdz0
        GuUuOlEF2247hWUPdze9hMGZUycaksL6VTUnk60pXHIg8sd1kjpGCZGEKRF7J26e
        mfvLZggOTBI9ZGZ6IFZRgapabYwzExHTREuyZcjX2CThxc++T/ojrlJ+rApjKuOx
        9v3kKerGLy18L5clOgZa6b4c7/GfBE3/K1Tz2Z62e7XlcTTx57tKjMoiOGv4WV6R
        dv2ed5WCpA9FI8UDmsr1JzUNEKRXM4PvOP0LO9CTpaitVjchwdglCcI5pP3jvv3O
        NqMyu5lx8UBU+fnx3vKuXe68Natiwn0CWPgYPwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ynx/sG
        4Nu6QytMUoZxOmN9kX3FtDIxEI42xzek+Pfn0=; b=pYgh4MG+6v0x/kOzN58ZwD
        0bVlCg+bvMKnJ7HSV3dTsd9CepSbqqD5giIeoZZBaMHx2Mv7SIlLoFgtfv7QRU3e
        HLQ3OGZgtuvSwfOfJheVMQAPDMBa3SHtG+2etnMBnwkufyrXUHUkTqNZsO5uOrvn
        lqhg3exfvjV6CfiAzG7CJYSpOiWB1LNlHzMxhTVmjxUgCFNupoMt0PxkOEuJ8HdC
        5cEK6tPNWZZaUbaeYEXO2Y+nIBjMaCiTgLPzvv/5WhO/aGea8epxvvbH6hNItUdI
        OfihBIct4QIZc2uDsakv2heOp9LBoP8A4JPTVnxuJt35cnHF4ZWoklN4zrWY3EaQ
        ==
X-ME-Sender: <xms:iMEWXie_pANBnkpVJ4G9iIWhVSn1ALKEyq2jE_ZuYKEhu8L-MVBvAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgepvd
X-ME-Proxy: <xmx:iMEWXk8EVHkyetfY_EsZL1wQLhQeBQjFOptSNMGyVAYBpqZGWhbCSg>
    <xmx:iMEWXo_Qww5xAHrrrDWUtFRccjch_zScy46gp45C_EOn9GUp_8ndbw>
    <xmx:iMEWXjrPfJjDS8JJfVAUBmuo6aJzHGu1cPnOfhZ-hZMxZIkhXMgESg>
    <xmx:iMEWXu4fJaFzyS2ddFpjcI0zT-HJL02VY4DSGpXxjYd0z_OfiycH_g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D45EE00A5; Thu,  9 Jan 2020 01:00:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <581ff3b5-c6c1-4e29-b87c-3bd961c4e659@www.fastmail.com>
In-Reply-To: <1577993276-2184-11-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-11-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 09 Jan 2020 16:32:40 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v4 10/12] ARM: dts: aspeed: ast2600: Add XDMA Engine
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
