Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1871BC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79B5206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="MYi2/m18";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bM3KysDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfJJAv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:51:28 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43253 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731166AbfJJAv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:51:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CAB221FAD;
        Wed,  9 Oct 2019 20:51:27 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 09 Oct 2019 20:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=UBrk70WdLG+JMj8YlDV4YajtdEG1xvL
        hcNqIGJ2cU8M=; b=MYi2/m18XdE1IFiJ483sVOzoqKIuhhhEDG0ZJjF8vk8hT1K
        b3eMQqpoJeEGSOvYsq8ndGbjaTeZmJwJ6S5rolWplxp/l7IXjyOQbpeyBHGD17kn
        ps9cs7ABl+sz+pqgMNR10cl4w2eGuVaCD2Wi+AUxGlyfblfAFOizIlwrJtqwLHru
        r/h54Mjd4AfYQ2luKjUPMfE7GljihTw9opQnvgRXWck5nW7bD3U51zjRVur/SIMt
        Dcl9Ggd1PGb20DE201wgncIjv1VlDeKaKbzI4PU67ltqQf+nedcHp56r/QWzXFW3
        uJIzsrfJL4VtFokPiyTLBpwOIhW7gB1zbT3Vy3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UBrk70
        WdLG+JMj8YlDV4YajtdEG1xvLhcNqIGJ2cU8M=; b=bM3KysDsqBtVG/t5opV5qx
        Tku4sVJM6oQMimYpCGEZtegj+ccBY0/bqS3UAKZB5cI7cc9ygRfvuf2a7jPKdtF7
        eKDbutSMjDuPIXT/Mjt0IVcaoj2fnoo86YyZWPEFMdzZx3KCRJIiWf6bivKFFN0I
        wgQc9fz0tkv+fjOkkSNo5kq+LeTztKM4WHR4UeF7Ni9CxeMH/5O5RdLxhHt8Msik
        /CU1IM6Y0rdVlswupIp+DtlzCEyVqj/L3VAeVqaFIsEj0H0AREvV1hfi/1UiRlp4
        7HiWrhEBwzHDtGVG0DUtc+jP5yBOTzIMwqCKP2e667mXkAKSc0ZmGr24j0r45vuw
        ==
X-ME-Sender: <xms:ioCeXTfMK69pJcqR31UQBEg9o0azGJNd_7TiiDeOybGWAhpF7oeyhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedvgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:ioCeXQR9hntBcHDqRh5_K13d9TkiKroTP8DF9AFq4pX9oU9xNOrOng>
    <xmx:ioCeXU-y__TtOOsuh1-wa24vDLnyi3z2FdA0P90dx8ATi_VzWgnHpg>
    <xmx:ioCeXQHpF9k3An-OzTrTTg-0k1iTmoCX6-CMkOU9uMdDfALE2DFjQQ>
    <xmx:j4CeXTzSNEw__hM1x0fDSms-_4K20lFN8xyD0Dix1UptTfTj_5YhdA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F2D1E00A5; Wed,  9 Oct 2019 20:51:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-360-g7dda896-fmstable-20191004v2
Mime-Version: 1.0
Message-Id: <18ac98e1-82b6-4782-bdfb-56765653e6df@www.fastmail.com>
In-Reply-To: <CACPK8Xf-f-r4S02GoxYdBYOJi5NGYMCOr6XGVza4vEGAsqzR9w@mail.gmail.com>
References: <20191008113523.13601-1-andrew@aj.id.au>
 <20191008113523.13601-2-andrew@aj.id.au>
 <CACPK8Xf-f-r4S02GoxYdBYOJi5NGYMCOr6XGVza4vEGAsqzR9w@mail.gmail.com>
Date:   Thu, 10 Oct 2019 11:22:17 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>
Cc:     linux-clk@vger.kernel.org,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add AST2500 RMII RCLK definitions
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Oct 2019, at 23:07, Joel Stanley wrote:
> On Tue, 8 Oct 2019 at 11:34, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The AST2500 has an explicit gate for the RMII RCLK for each of the two
> > MACs.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  include/dt-bindings/clock/aspeed-clock.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> > index f43738607d77..64e245fb113f 100644
> > --- a/include/dt-bindings/clock/aspeed-clock.h
> > +++ b/include/dt-bindings/clock/aspeed-clock.h
> > @@ -39,6 +39,8 @@
> >  #define ASPEED_CLK_BCLK                        33
> >  #define ASPEED_CLK_MPLL                        34
> >  #define ASPEED_CLK_24M                 35
> > +#define ASPEED_CLK_GATE_MAC1RCLK       36
> > +#define ASPEED_CLK_GATE_MAC2RCLK       37
> 
> Calling these ASPEED_CLK_GATE breaks the pattern the rest of the
> driver has in using that name for the clocks that are registered as
> struct aspeed_clk_gate clocks.
> 
> Do you think we should drop the GATE_ to match the existing clocks?

I named them that way because the bits in question do just gate the
clocks, but I've renamed them to keep the pattern. Will send a v2.

Andrew
