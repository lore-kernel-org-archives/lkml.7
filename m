Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3A1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C9420869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556316180;
	bh=zWgbe3sH6AyKzLwdPq0MEOIdtManQi4jsdsZX/XFkqc=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=FLi4LjEEIcjKPFVyezosTv6TgN8eA6O4ebRvHSEj4kKntrS0YC1mk/XThhVOLJdp7
	 UCXDsJb3w+7TQIE1zDyL+fqT9ys1fpi0IWfhUpcqWloxH2NVvjpVkKnvi89z3Lo9ix
	 K4ArJeRp86tS3Sk3O9Adkoprham/dMtTaERReEzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDZWDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfDZWC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:02:59 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19DD206C1;
        Fri, 26 Apr 2019 22:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556316178;
        bh=zWgbe3sH6AyKzLwdPq0MEOIdtManQi4jsdsZX/XFkqc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=vWw9Kj9nQbmiJQbeUp1u16WmTL9GHxkUuzkCTvUjCHiBS9w8svynFpefU45yCW/IG
         25vGSoYdiAlib1FVE3pkr1UA8lggyp1L2sY4jPjLZydccCo7McTP60aRskMUJmNoVP
         zQmwcxTa56udTlmER5V9u/ovcJYkAKsaY/WVsk8I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190426210651.GX14604@piout.net>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-8-alexandre.belloni@bootlin.com> <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com> <20190425203139.GO14604@piout.net> <155622589096.15276.8583738150370510787@swboyd.mtv.corp.google.com> <20190425211009.GP14604@piout.net> <155622724107.15276.12946928869888731656@swboyd.mtv.corp.google.com> <20190426210651.GX14604@piout.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 7/7] clk: at91: add sam9x60 pmc driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <155631617779.168659.28330983552532693@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 26 Apr 2019 15:02:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-04-26 14:06:51)
> On 25/04/2019 14:20:41-0700, Stephen Boyd wrote:
> >=20
> > Hmm I was just confused it seems. If you don't have two devices probing
> > the same DT node with this compatible string then I think it can just be
> > CLK_OF_DECLARE(). I was thinking that you were running into some sort of
> > issue where the other driver using this same compatible couldn't probe.
> >=20
>=20
> I tried separating it into two initializations and do as much as
> possible in the platform driver but because the TCB clocks are
> peripheral clocks that depend on most of the other ones, I didn't find
> it convenient. This can safely be changed to CLK_OF_DECLARE. I can send
> v4 if you want. This should probably be changed for the other drivers
> too.

I've fixed it locally, just haven't pushed it out. If you have other
drivers that should be using CLK_OF_DECLARE then feel free to send a
patch for it.

