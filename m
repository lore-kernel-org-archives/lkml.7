Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E25C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3935620678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="EYJ8qXOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xs3rnUen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgAIF6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:58:01 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48037 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgAIF6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:58:01 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E833321F18;
        Thu,  9 Jan 2020 00:57:59 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 09 Jan 2020 00:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=EsMKsMKI6HhF0F0RtD4RD5a7b8gvE2C
        1Qv6MEtScRc0=; b=EYJ8qXOpV4/5J8MYiMmaa8eIayd6/H1HHxWVnf/tlbBRNto
        fm3Q4Fh9cgfTPSjK9rNLBrbApDVyxe12FJ6FoZMKKIfI/o35oYFzeLu6sT3doOGF
        rcFXwT1B87faUViSKpFIk5dp7w9b6b1ZbDQ4lcHqWbsPGsGFCNIi50of4Bw6cWKU
        ekZNyPTwr+pi3KXXZta4A2ce3LNLVAaV0OFbWJcyw2t1UHsHCXy3s2gDwynYWvRX
        khyCdm6jNGvzlO5JxDtVtSxAqmv3uvntP1ADUTyt4LTp4CGPiTFl2pqOWJz6EZGB
        mR5+2YEur68wjgp6AuSFr0OGMqhiZkdVDAWLygQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EsMKsM
        KI6HhF0F0RtD4RD5a7b8gvE2C1Qv6MEtScRc0=; b=Xs3rnUenGEIz7PHXDH/03Y
        bensMd8MOXuP70PFSP5rGOVCtoYjI+24kyTIhCofx5Aqx37f1gC8jDgU15/oRQUd
        LdgzprFRmP6YgEaSB6lLnuNbfNW3pO09P62Hu6WmhW9NKc/2G8ZMhDDh4NcyD/kc
        x/+D9ZQL1v3ELOxcigJB7vzlM8ZdqvIWhKBpyhdUa+QF/ftdqx4EOa1zwJm00Q42
        rnYIihXXh7Brqo2zg998zDTNBBSQRzqkqmKrzKUPyx0xfIhNmeVai8XZihgMrY0F
        ZPtGCB8EsSjwlYlgGNE3ykKDD1Hf0eQZ7hORs5R/cBp4zp/GOxtnCeIiucAwzsDw
        ==
X-ME-Sender: <xms:5sAWXqSUlHYgKeyBAM34X3wt_YQWCvCZVjGTSY5TXCy87amJcWywmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:5sAWXsGOqfvR6Phd36-p-3SnwtH8TSSKIX3Rmt3T9d1006Y7MkK_mw>
    <xmx:5sAWXqk3XoSaA_SeoBMr0RsoC56Drn_goMsUKLUjsyJUFe72GHz8ng>
    <xmx:5sAWXn0of7jeys2u1opLc6hpZ4gTFaloF-tefoSgxIkX7eh0ckpCpw>
    <xmx:58AWXpMqXvEOp__CoPwm3O8ewgPsyAqYxgS_SfH0SUTGJEdmdW4OHg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD6ACE00A2; Thu,  9 Jan 2020 00:57:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <cb602d43-7e00-4d7b-8f05-6b774d573901@www.fastmail.com>
In-Reply-To: <1577993276-2184-9-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-9-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 09 Jan 2020 16:29:57 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v4 08/12] soc: aspeed: xdma: Add reset ioctl
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> Users of the XDMA engine need a way to reset it if something goes wrong.
> Problems on the host side, or user error, such as incorrect host
> address, may result in the DMA operation never completing and no way to
> determine what went wrong. Therefore, add an ioctl to reset the engine
> so that users can recover in this situation.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
