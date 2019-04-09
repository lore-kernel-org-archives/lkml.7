Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9987C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E9020693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="fDlaBpuJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2tyfqA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDIBGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:06:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52761 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbfDIBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:05:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F0E7D23943;
        Mon,  8 Apr 2019 21:05:58 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 08 Apr 2019 21:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=oXeZYYbWObiGKwh5XzvLRHAJTEzchbU
        0DVqAoRpD2x4=; b=fDlaBpuJjZ5HbhgE3yoN3FKNPMEG77h3DRoO0sCL1joalhw
        J7EMrUtvwMsSOLLftoIhABgbKKlaygunWtYUmGV8DhxsxC8kcIYvszFTCNxH4V3c
        1Kl0twWIByKzzcQIbD9DHqN6vGIlGM2JlYv3urnT/C1gm7uT2J+kbzM9Gp7boAS4
        vhn60W8Jgec5P5uE17jmgcRn32BWI/38TY2Nn3rH37iJ+az/txtL3JzCVWXuf/bG
        q95mac9KcbyBj+Q4SNUC7c3jW3nlPRmwSYjwfh7or+5QruY49U71Av6GxUMV7kfA
        9m/zB9dZbuq37R3C9VJWtUCpla9tmPeDIzwYzRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oXeZYY
        bWObiGKwh5XzvLRHAJTEzchbU0DVqAoRpD2x4=; b=a2tyfqA816vAwIcy/TNN1N
        Yobgzkt2m27l7jhx85IJfFnEqX27sWz18VyUKy0Rqka7HcCwQuLyh+xKB1iZ26nh
        pAYjrVGH7C1qnw5CHnaCWQDZyOX/JihCO8G3V17RQP/FkYuKo7fNiPc2z6lGreMc
        1r0cJjsTAWaFmgmD19zrrv0Ml9UQAPt1QiHeLeE9iCjewu6rcEulR/ostGpsHzPr
        vJ8vJbpRC30EB/1pFx9ZtPHR7CCbWuE75ZMtuUglu3FtTrgKM0fChmsLuqB0GGRo
        ssAmcVUUi5EAnyV2sOuC/fWy1U90E7RPw6fjXW74tn+FPVzq1+adGCf0rRuNfToQ
        ==
X-ME-Sender: <xms:9e-rXG7-LGLPqiuC549DLVj8O_s01SsVJzzRq6m20I1LtfTb5WWQAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
    hinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfrrghrrghmpehmrghi
    lhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:9e-rXDE2yncpeOHCp5CEQtRHuvKSsti4OpLnM-MfPKyji-dvZlEieQ>
    <xmx:9e-rXJGwVqRwZGluVj6X94UpN8BnrA6U1ZLywCi4EWr-eHsPvxUC6A>
    <xmx:9e-rXHWprFB3wCin5x-UwUgYSGNvGPhwJG3rLLOO9kyQ6L-9Yx3ZMw>
    <xmx:9u-rXJfgERZhNhjUps0JQUCULFTP0-6VGZWN5fw4onZHsqQSDIDAyA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AA43E7C412; Mon,  8 Apr 2019 21:05:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <ac821164-92aa-468a-8ef7-5f6697b48716@www.fastmail.com>
In-Reply-To: <8eab4602-eb0e-a49d-3dab-c6454f4fdb47@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-4-git-send-email-linux@roeck-us.net>
 <2b039e4a-1f21-4297-a499-d8f764844693@www.fastmail.com>
 <8eab4602-eb0e-a49d-3dab-c6454f4fdb47@roeck-us.net>
Date:   Mon, 08 Apr 2019 21:05:57 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_03/22]_watchdog:_aspeed=5Fwdt:_Use_'dev'_instead_of?=
 =?UTF-8?Q?_dereferencing_it_repeatedly?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Apr 2019, at 10:33, Guenter Roeck wrote:
> Hi Andrew,
> 
> On 4/8/19 5:37 PM, Andrew Jeffery wrote:
> > 
> > 
> > On Tue, 9 Apr 2019, at 05:09, Guenter Roeck wrote:
> >> Introduce local variable 'struct device *dev' and use it instead of
> >> dereferencing it repeatedly.
> >>
> >> The conversion was done automatically with coccinelle using the
> >> following semantic patches. The semantic patches and the scripts
> >> used to generate this commit log are available at
> >> https://github.com/groeck/coccinelle-patches
> >>
> >> Cc: Joel Stanley <joel@jms.id.au>
> >> Cc: Andrew Jeffery <andrew@aj.id.au>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>   drivers/watchdog/aspeed_wdt.c | 21 +++++++++++----------
> >>   1 file changed, 11 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> >> index f09333fd54b4..34117745c65f 100644
> >> --- a/drivers/watchdog/aspeed_wdt.c
> >> +++ b/drivers/watchdog/aspeed_wdt.c
> >> @@ -187,6 +187,7 @@ static const struct watchdog_info aspeed_wdt_info = {
> >>   
> >>   static int aspeed_wdt_probe(struct platform_device *pdev)
> >>   {
> >> +	struct device *dev = &pdev->dev;
> >>   	const struct aspeed_wdt_config *config;
> >>   	const struct of_device_id *ofdid;
> >>   	struct aspeed_wdt *wdt;
> >> @@ -196,7 +197,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
> >>   	u32 status;
> >>   	int ret;
> >>   
> >> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> >> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> >>   	if (!wdt)
> >>   		return -ENOMEM;
> > 
> > Looks like it's missed this one somehow?
> > 
> > wdt->base = devm_ioremap_resource(&pdev->dev, res);
> > 
> > Otherwise,
> > 
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> > 
> 
> Assuming you mean the conversion to use devm_platform_ioremap_resource(),
> I had this already addressed with a single patch for all watchdog drivers.
> 
> https://patchwork.kernel.org/patch/10882207/
> 
> Sorry, I didn't Cc: you on that one - I limited the number of Cc:s to 
> avoid being
> tagged as spammer.

That's the piece I was missing.

Thanks!

Andrew
