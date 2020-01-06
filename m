Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF555C33C99
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966AE20801
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578279793;
	bh=CNeeKXcxdQM66JWLklaMOAzOty0uI/w8076uzZzgDRI=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=iKsyulrgRSzzaDkYXmH+iHo9Mcg+QOf2yTLC1kQz8oXC2+4PBATV5e2LLfAjjYug6
	 8NiP46u+EC3R8hh6k0rDcAMXQF5iamoX53U0KXPXbilK3VSAs1EUjKqhTzWFYGfbCK
	 ASXn+Ikf3ydrunJ5byF6vsLCA85mKXyAFlz8kqi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgAFDDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:03:12 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6538820801;
        Mon,  6 Jan 2020 03:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578279791;
        bh=CNeeKXcxdQM66JWLklaMOAzOty0uI/w8076uzZzgDRI=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=B8jLcelHLRRSOCy+vJWPw+k53NEYrT9FYA57S9bX/rSFrb1QnF7jiZzenQE97Bki8
         bmLxQ9wbVrMV+s3MvgbJ7IelLc0T3WRD4sygIpTAo27zyJ0oW184daAwo9vXsqoCR7
         UJnYZl57w2F4em23l0WDNz1ohcgOJFr4qSBL+IXY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191226191224.3785282-3-martin.blumenstingl@googlemail.com>
References: <20191226191224.3785282-1-martin.blumenstingl@googlemail.com> <20191226191224.3785282-3-martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 2/2] clk: clarify that clk_set_rate() does updates from top to bottom
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 19:03:10 -0800
Message-Id: <20200106030311.6538820801@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-12-26 11:12:24)
> clk_set_rate() currently starts updating the rate for a clock at the
> top-most affected clock and then walks down the tree to update the
> bottom-most affected clock last.
> This behavior is important for protected clocks where we can switch
> between multiple parents to achieve the same output.
>=20
> An example for this is the mali clock tree on Amlogic SoCs:
>   mali_0_mux (must not change when enabled)
>     mali_0_div (must not change when enabled)
>      mali_0 (gate)
>   mali_1_mux (must not change when enabled)
>     mali_1_div (must not change when enabled)
>       mali_1 (gate)
> The final output can either use mali_0_gate or mali_1. To change the
> final output we must switch to the "inactive" tree. Assuming mali_0 is
> active, then we need to prepare mali_1 with the new desired rate and
> finally switch the output to the mali_1 tree. This process will then
> protect the mali_1 tree and at the same time unprotect the mali_0 tree.
> The next call to clk_set_rate() will then switch from the mali_1 tree
> back to mali_0.
>=20
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

