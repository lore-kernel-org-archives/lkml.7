Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1360FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEE920836
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="RKn4e8WA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wSZXJb38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKYX6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 18:58:51 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57283 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfKYX6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 18:58:50 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B3FCE227E7;
        Mon, 25 Nov 2019 18:58:49 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 25 Nov 2019 18:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=uAocx9y1gw6K1vU7ec8ZFYtLT+FTX7p
        LzUEnRUhE+Io=; b=RKn4e8WAMvltzcv9zoc0Mif0i7TY5VxDeczY2asdJNmEBVR
        NfXK+oxI2PFiaRAm4o/RuUdGgxAgKtFJe6wzl7l3O1+91bxSzm1LBXc6TFpP5toi
        dDPuPzH4HaigtgxQc0ph0KAziWqIut9sv6JEKh+kvOsyB121b6Nk5misvzVGKmW7
        9qdFfmXBEQuDZnW2AiRXr6tEyBc5ND/sh2LQEuG+3ww9m+fqEHazQ/3YBEIKN/zl
        kK31GDiQCjJpsWnctu99luHGL0jA70kUeyuCOaepoyRbemD/bdeBedGPDu+YGXBe
        sePZePKPTQBW/6bvc8+mMbPxDXhEH6dg53P+fWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uAocx9
        y1gw6K1vU7ec8ZFYtLT+FTX7pLzUEnRUhE+Io=; b=wSZXJb380Dy2W1S4zNtBzC
        ObLNLJQIB74ltyoBq+/up8UO9rz7bWBcqJwh4+VdhYjhS+tyPdGJUVpKymb1A89o
        YLNhhRmjyZEDGNh3EXwfvZaponAoAKDVzOesylFYG4H1DfziW6jnLj6+efydhYrD
        nsEi2IFm7cVBxzo8icAwUM+JBL6PsVZGHQwhPqNOmF0AX+QhUjiEKh+jSWPesjKM
        Ch0Brfk2zGRThlMvdAPigtlYgBWAo3+AY/QcPPCJKp9TAC8hGm5XqeW1i05KhPo6
        1Pj/XlOGronmvsJU2/uw7XMX8o8q3g4PAPOQwNZgPxS3BM60Pa2adhdLTF7mTIYQ
        ==
X-ME-Sender: <xms:t2rcXTkhGZI12cC68mbQIVXNK2nj9XctAWgoGB4UDt8G-siDCXU16A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeivddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:t2rcXaFjlgvXFeexOQXfEi1rSV_qaEVJO0Yc5CA-pv_HJOBxju-Bmg>
    <xmx:t2rcXTGVwWv06sB0eUCEMok0ofGBBPJlICOnoElb5ZlML0v8TsW3pw>
    <xmx:t2rcXXMHBD8fYafTHBgYkF8J4U8MlC7mZFlUCPF1M8TH52zCKM2F7Q>
    <xmx:uWrcXXvAPMIaH3Ilw_D06RyPobF5pzdans1r9UqkrhJP4YxeizPYqA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E1E14E00A2; Mon, 25 Nov 2019 18:58:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <3232fa33-559f-4086-a605-7186d81ee3f7@www.fastmail.com>
In-Reply-To: <20191125130420.GA24018@cnn>
References: <20191125130420.GA24018@cnn>
Date:   Tue, 26 Nov 2019 10:30:15 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>
Cc:     "Joel Stanley" <joel@jms.id.au>,
        "Vijay Khemka" <vijaykhemka@fb.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v3] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Nov 2019, at 23:34, manikandan-e wrote:
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platorm based on AST2500 SoC.
> 
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
> 
> Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
