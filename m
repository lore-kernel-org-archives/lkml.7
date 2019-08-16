Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8767DC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA172171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565976044;
	bh=dNOS0LnqCohDGlt5COYLN7CpHwjC+0zqmb4wtlqBFvI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=sjt6KAGzH3eEkAzt+/B7DXj2Gky0N2KfXsIysBPw4qgxCaf6Aubp7BWLZ3A8T2nzY
	 fOanaWF8DztW6SBnn2f6tWPwUk4GaJszjZEawoPM6pvOCDIt4W1Yd7jYJm/Qt0ycO1
	 TsVni4BNQG2FVcUiv6TwD6XOKGlx9ZKXBgB1SbdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfHPRUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfHPRUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:20:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29DC720665;
        Fri, 16 Aug 2019 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976042;
        bh=dNOS0LnqCohDGlt5COYLN7CpHwjC+0zqmb4wtlqBFvI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BLxrOKz05otBjxeQwZLSn2LJ4Upqg7rB91ODQCJxkEOKtcnvWyJOCOc/VoZC6V64f
         wd4O4KQKjBxEB2Kr7Ja75HBeEYykyiUI5XUhIdZ8ifhDUv3k6MSadP5ARD/h9/2EX0
         B06sOQI+BmUabwbsHzP+MAPm9NovLfLDCrse01pQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815160020.183334-4-sboyd@kernel.org>
References: <20190815160020.183334-1-sboyd@kernel.org> <20190815160020.183334-4-sboyd@kernel.org>
Subject: Re: [PATCH 3/4] rtc: sun6i: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:20:41 -0700
Message-Id: <20190816172042.29DC720665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-15 09:00:19)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

