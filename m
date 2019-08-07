Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403FFC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FF721871
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565213641;
	bh=kzoxY63N7Hd6uqZda5v9QRQddHcGV31C3bVcs7VizwY=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=Q49U7QkQUtBcyTkRU36QB/sFngCrrgLfj0bhOdQhgIyMEZiRyBke+S96QHr8ABtv4
	 tfdZiylVpy6ytJ5NEXN2WHBUpTiD7tj4gOEOaf3zKmJeguNExPUYEzBglCxqxYW/Iw
	 /lF8nrM2LlGDlIm1U/64LJ+UrdNRPycDn9MFPauo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfHGVeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbfHGVd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:33:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62002186A;
        Wed,  7 Aug 2019 21:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565213638;
        bh=kzoxY63N7Hd6uqZda5v9QRQddHcGV31C3bVcs7VizwY=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=uFbSIOdG3mvQJMvDmq3ZUn5YIwlsr/m0AvqTAbOwmuECS5DF+3KcKikDZUSpimxmh
         meynf8w2I0RfhubI1sW5afLlflgj9EHTD8DV09KNsduAOb4a4jF7SKYjRzz+ywf8p1
         MTjdjAmu1UYh6v6A/5AaKoX7a2ExUmRYI9mBBfx8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190701113606.4130-1-paul@crapouillou.net>
References: <20190701113606.4130-1-paul@crapouillou.net>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ingenic/jz4740: Fix "pll half" divider not read/written properly
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 14:33:57 -0700
Message-Id: <20190807213358.A62002186A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-07-01 04:36:06)
> The code was setting the bit 21 of the CPCCR register to use a divider
> of 2 for the "pll half" clock, and clearing the bit to use a divider
> of 1.
>=20
> This is the opposite of how this register field works: a cleared bit
> means that the /2 divider is used, and a set bit means that the divider
> is 1.
>=20
> Restore the correct behaviour using the newly introduced .div_table
> field.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next. Does this need a fixes tag?


