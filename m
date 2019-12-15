Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81747C2D0CD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 23:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E392467F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 23:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="VTbj5pMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gMw2MLwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfLOXdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 18:33:21 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35323 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbfLOXdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 18:33:21 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E2EF822348;
        Sun, 15 Dec 2019 18:33:19 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 15 Dec 2019 18:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=lzvbMSFkVBR+nAocAB/eyxxphB8B1S4
        O1CMOCvIRkYg=; b=VTbj5pMFSVZMVT7DLLhNqZee/qfUdpnNDdx36+SC/dzZoul
        i6gJqNcdAXdAD7yXYiMZxGQ90NOYdWI+2m1rqljGkGtNtXAvtxTlgw5wIbG9f9sq
        XbS47Q53S0MIvRphJfNoVpVBG6iaR5/MA1C5JPyK1+6Di/BBMxSBg7ObycblOvH7
        /cwaSIp0lw33SYMBhyU1gDM+xnBaSA/0+PM8uimxpV0uVnPPfBPDX3eTAwcTd7ig
        E8jRLPAVr/aEp+g/nUsfbkrc9ktVmU5I+gM2oarsRqus72w1YfZJ80xz8xWA5YiI
        EDoLx1IKzrCzEAWrQUFkM0pgrVQcTyT1w9ZfLog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lzvbMS
        FkVBR+nAocAB/eyxxphB8B1S4O1CMOCvIRkYg=; b=gMw2MLwRV8HiPZPynrJvdp
        QFfd/wzjfxOiBSkUWVsAOcI739DKAuCe3x3dqIgCHRIgc8Q9ZM/7UxOzsykIN6uB
        utST9rch5vnvj9BApLN7Ysy1AfSTh32mb25RBNeYwZFcm1lqZz6rLbzuJ48kHTnX
        18zw5NNymXzMLFJJQxtydvu5wdd4qL6gGEI8mAaaP9+Jh23qSHcrBWe49Nz80kdP
        5LHVdqwqr42uVnJquUplkZIzjIh95y43kvvoeRAGaiSqRitmSN5Ftf1/l1D/GGa1
        n4BSk91Kk8d1JPdkkzwJffc2WMBqTa1U3rlZswIwshnYB8ZcXToByiIGhEPPISvQ
        ==
X-ME-Sender: <xms:vsL2XeKfNhmf3dE2gzpbzSs86ap6GIT2CTE7EPK6YQnAElmTyqdjZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:vsL2XQFldtGw-XBJ4xn4Sr5zMs6iCzbRlpQm8X6rp4tuqn3GhBl4VA>
    <xmx:vsL2XQnx8qCojcex_yzhvksBdgoI8_Oc_QIClvjdvJZucVCPsybWXw>
    <xmx:vsL2Xe01UqS1qt5wLIomDWeSscJlJ1dcSYXP7sFVH6wmLv1McK_Svg>
    <xmx:v8L2XS1LxoMGXcASWDNuCFtSobL8cOMOIezDEfUBHtK3xKa7FlhVfA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE86EE00A2; Sun, 15 Dec 2019 18:33:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-680-g58d4e90-fmstable-20191213v1
Mime-Version: 1.0
Message-Id: <8017a61e-e579-41ea-816a-4a76a6dc41e9@www.fastmail.com>
In-Reply-To: <20191213135131.GA1822@cnn>
References: <20191213135131.GA1822@cnn>
Date:   Mon, 16 Dec 2019 10:05:02 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     "Sai Dasari" <sdasari@fb.com>, "Vijay Khemka" <vijaykhemka@fb.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, manikandan.e@hcl.com,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v5] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2019, at 00:21, Manikandan Elumalai wrote:
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platform based on AST2500 SoC.
> 
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
> 
> Signed-off-by : Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> Acked-by        : Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by  : Vijay Khemka <vkhemka@fb.com>

In the future, don't worry about aligning parts of the tag text. Single space is
the custom (and is less effort!)

Andrew
