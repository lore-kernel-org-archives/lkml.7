Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71CDC19759
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 00:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40B82086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 00:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="OC/bJtu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VR3W6WNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfHEAcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 20:32:14 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46199 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbfHEAcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 20:32:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 911B6210AF;
        Sun,  4 Aug 2019 20:32:12 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 04 Aug 2019 20:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=Prb7tn3TJaxCnpwPPyi4xsZf7IapyER
        pEa2ECzebZJ8=; b=OC/bJtu6RxIN+aXu0LGViMDdm0L+VrwJ3Q9M2C+0PSyBSqM
        lvq1PeCyWvBlPu0hpZFVoCAnO4dAao9GQtYHommXGw51thzV2lZvNOuXY1LPkFjT
        hQt/2Lz6/x7t9zGe0oe80l5GasiLr6S6J0qF0KjePvv0pO2qvwY/kziSEhSzSeyr
        QDRqiqGITr3cIn8JtDIZHOaYNqsw9SCbvpuZ9yYq6piUfkdijrSItZhf45WPF/rA
        qkCWDYyUbcM7gFKS+laWsFAKPLD8vWYyYie7LPa3xPpZjrI9t9HGt65yGilZeXqm
        fQsWLM9Iwr80WsaJLclD8Bpyqhb+6DJbtU+FLXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Prb7tn
        3TJaxCnpwPPyi4xsZf7IapyERpEa2ECzebZJ8=; b=VR3W6WNB98Qi32CdFWRQ2z
        GL4+WEI1xXnXG+TZNDL0Zv8Pel4UGnvs4CSmGEjU+tQ71Wa3LpLjNdaM7h3U7sfM
        p8hvF1HP/AB5LMSwWyZfyo7aAiULkeXjw/CRYLXkllSIASlB4oc8fRTkQ65q4Zd8
        xB660kM38NCjQFMyTEjZ8HSxB+0SpuEp7wvnio2DnItxVBXX+K6X+YDofazAEjd6
        KyLMYkIgYeOHw7UHUvRjuuUwJQcKHuvQMVVwoPwbWFNwmQidbyOU0PqPwtoFUFDT
        gIDMGnGFwRjeGX4aO/09Ll71KOAGNGj88vKBZefQb32zxOWJ4yDAbQ7sTxESwzlg
        ==
X-ME-Sender: <xms:CnlHXR1l0V9THU39Aap7oiHt8szc2igbuZPkdhxMsB_kV48QIxL9gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddtiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:CnlHXUOAlGPqae4gC48F0Pt0yXZKToIbq-M1Bb9YA0UTYG5C8i7Ptg>
    <xmx:CnlHXeBB8JbU__uOJwzDKnXEOrk36kZ05q1-RetV8TWpqQwiUDOYug>
    <xmx:CnlHXTdAqWMW4DB9PQfLoKy3QyL3MHQDkxkZUV8dz2HbR2vmiUg6hA>
    <xmx:DHlHXaY6LySV9ubuK-ADN-my4zPeO3kv0jgPF40e0yMFfHbC5RU9lA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5A373E00A2; Sun,  4 Aug 2019 20:32:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-799-g925e343-fmstable-20190729v1
Mime-Version: 1.0
Message-Id: <593f30af-1065-4136-a420-3d0cf2a111f5@www.fastmail.com>
In-Reply-To: <20190802083736.26783-1-Ben_Pai@wistron.com>
References: <20190802083736.26783-1-Ben_Pai@wistron.com>
Date:   Mon, 05 Aug 2019 10:02:33 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ben Pai" <Ben_Pai@wistron.com>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     wangat@tw.ibm.com
Subject: Re: [PATCH v4 4/4] ARM: dts: aspeed: Add Mihawk BMC platform
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2019, at 18:07, Ben Pai wrote:
> The Mihawk BMC is an ASPEED ast2500 based BMC that is part of an
> OpenPower Power9 server.
> 
> Signed-off-by: Ben Pai <Ben_Pai@wistron.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
