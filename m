Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC441C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E82190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="IMcXpfcB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ESPCQrNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfIBF0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 01:26:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41201 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729299AbfIBF0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:26:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 059DF210AF;
        Mon,  2 Sep 2019 01:26:29 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 02 Sep 2019 01:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=SfesOFiKN1IfZZTahtZmg0P++GiClFR
        iJzFNrBgRNCw=; b=IMcXpfcBx+4mIhFADnDJHiKjLIz6NUxMbOOK3QHwW66TKF3
        bQ2KBIVCA7xnkPDZDw9RB9bzlUWT/NUmBQMamxExN4PxhRRn/1KRB1ogw7VzQ8bU
        FGtJnWb3tlikUfLuMo67teT2whLCa8LA827GX3M5llOQyhW+YTbrUsBmVeQlvSXv
        HOedDzKU1xSlgBQOoW8lvq7WTCBRoiCectrKnffi/JQ3G37QKyuQw7hWq4mKm8Tt
        m9cZZIQIoJYbqxhP+Qvj4i7KFXoeqTGTeg4ogRrgF1hZbVwf4kK478ryTqV31Z7J
        cHwZZrCSV+1o6XYsT0jYHfXUdQGZDqW4orVYA/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SfesOF
        iKN1IfZZTahtZmg0P++GiClFRiJzFNrBgRNCw=; b=ESPCQrNGWZa3NWUnEGIJum
        szo+Ykhaei18sNqyeJ/3SMCaCb7GfzRBTRnUctTgvScmfn3pzcDivrTLLtk79lXG
        MMh6Ph+lbW0j4c0A5ZH4bFtHYevohVl2WYt9v/ajQevBj0flX62VeN1GmXX+GlQu
        eRO+TvL/gCBSQZj5kJdIPkzON42BnYIL60uadEg53X8qCld6oOWoa0aW3ACT9RVT
        PYARH5YQ8G8T+WtzJKNdXTzZ0WNwojpJg3wN1FldLip2lnb8+6v7tlAEvJGqGW1F
        2HbH4r5GStVpO2L4cb2AH4w2K19W+I8aODt8i3RsPQgqbWPTwCLAz2DTjgnDIARQ
        ==
X-ME-Sender: <xms:BKhsXa3JC6op-0jITHMraScWLdeddq1uvR1E197VSMO9D7zMMgUV_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiledgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:BKhsXVHsJdGTzihUkDM-ilLiRsvCKpM2BC7T8kiv4to7bcCbnrJyXw>
    <xmx:BKhsXTg632nPnfwjd06QPazju0OdQwar-ylxSp4OXRFBZ4IiyWSVfQ>
    <xmx:BKhsXbZM53rJ4CXHUNv1YZf4xHKOIV_WrS42S3C8uCvFHRfi2ee8QA>
    <xmx:BahsXY_KYrJX_0AyZT3k_lph9CBrcD_nZYKufQYiRw4sHkeqHUjtJg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F1E03E00A3; Mon,  2 Sep 2019 01:26:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-154-gfa7592a-fmstable-20190829v1
Mime-Version: 1.0
Message-Id: <83570e25-b20a-4a17-85ea-15a9a53289bf@www.fastmail.com>
In-Reply-To: <CACPK8XfYgEUfaK6rtr+FdEq-Vau6d4wE2Rvfp6Q4G2-kjVLT0g@mail.gmail.com>
References: <20190902035842.2747-1-andrew@aj.id.au>
 <20190902035842.2747-2-andrew@aj.id.au>
 <CACPK8XfYgEUfaK6rtr+FdEq-Vau6d4wE2Rvfp6Q4G2-kjVLT0g@mail.gmail.com>
Date:   Mon, 02 Sep 2019 14:56:38 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>, "Arnd Bergmann" <arnd@arndb.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "OpenBMC Maillist" <openbmc@lists.ozlabs.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "kbuild test robot" <lkp@intel.com>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-of-aspeed: Fix link failure for SPARC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Sep 2019, at 13:42, Joel Stanley wrote:
> On Mon, 2 Sep 2019 at 03:58, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Resolves the following build error reported by the 0-day bot:
> >
> >     ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!
> >
> > SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Guard the
> > callsite to maintain build coverage for the rest of the driver.
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/mmc/host/sdhci-of-aspeed.c | 38 ++++++++++++++++++++----------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > index d5acb5afc50f..96ca494752c5 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -224,10 +224,30 @@ static struct platform_driver aspeed_sdhci_driver = {
> >         .remove         = aspeed_sdhci_remove,
> >  };
> >
> > -static int aspeed_sdc_probe(struct platform_device *pdev)
> > -
> > +static int aspeed_sdc_create_sdhcis(struct platform_device *pdev)
> >  {
> > +#if defined(CONFIG_OF_ADDRESS)
> 
> This is going to be untested code forever, as no one will be running
> on a chip with this hardware present but OF_ADDRESS disabled.
> 
> How about we make the driver depend on OF_ADDRESS instead?

Testing is split into two pieces here: compile-time and run-time.
Clearly the run-time behaviour is going to be broken on configurations
without CONFIG_OF_ADDRESS (SPARC as mentioned), but I don't think
that means we shouldn't allow it to be compiled in that case
(e.g. CONFIG_COMPILE_TEST performs a similar role).

With respect to compile-time it's possible to compile either path as
demonstrated by the build failure report.

Having said that there's no reason we  couldn't do what you suggest,
just it wasn't the existing solution pattern for the problem (there are
several other drivers that suffered the same bug that were fixed in the
style of this patch). Either way works, it's all somewhat academic.
Your suggestion is more obvious in terms of correctness, but this
patch is basically just code motion (the only addition is the `#if`/
`#endif` lines over what was already there if we disregard the
function declaration/invocation). I'll change it if there are further
complaints and a reason to do a v3.

Andrew
