Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3187C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A215D21850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555544937;
	bh=Ngut8Zra1tNBDucFICW5oi5hzvpBUalr/ubinIxWQgw=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=GqUGh2j+Ib+jJ41Q4rjuZTRcHkGKoTFynq4DgjbTVOg8nr3yNppbzNGvrQIwBGaZ7
	 iWHrCPl44mkbukpjpd78l1tkOdqGcrevljW/xd3UTU7/T7cM2SuQ7kiZ56tiB9jzRl
	 5HvXMxO6A6IypwqxzHbyC1pX2zoqpsHp6ufKFvWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbfDQXs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfDQXs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:48:56 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F949217FA;
        Wed, 17 Apr 2019 23:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555544935;
        bh=Ngut8Zra1tNBDucFICW5oi5hzvpBUalr/ubinIxWQgw=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=zczi+fYXLOXozwL8Lz2ntNKi3YyDwxLeSc5GG4OXraXsCsDkKmTwtPVa3zisxLBex
         45/bytSwfCkszVcYUmwu3v0IR0vc/UTKH0FgCKPbSfXclD0ZUyYFzpxVsqJs9lFPNJ
         8f5ACK9o/5MEio2kbwVG0miJsbeOsMGE6Beq32Vg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190417112420.3034-1-paul@crapouillou.net>
References: <20190417112420.3034-1-paul@crapouillou.net>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ingenic/jz4725b: Fix parent of pixel clock
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Message-ID: <155554493444.15276.2577888773542833089@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 17 Apr 2019 16:48:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-04-17 04:24:20)
> The pixel clock is directly connected to the output of the PLL, and not
> to the /2 divider.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 226dfa4726eb ("clk: Add Ingenic jz4725b CGU driver")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Is this breaking something in 5.1-rc series? Or just found by
inspection? I'm trying to understand the priority of this patch.

