Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF23C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF04921479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568111587;
	bh=LJtBmi1tzU6euOWenIIUw2u/xvJ895RqpElZGcqoEFA=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=BBG7vD3Lad62rPQU/YorJyKTXcWtyo12+6bNlw9Elj6n1W53CPkFB2iEet6eYHXQE
	 9mHPMOhG73I4661SlRKsSiU0ynAIeZ3EXn6je/ynBlF0y66b/oABxx5hWwWB/IBeoS
	 k+EJnSFBJQdUuGyRQLBU2gzbtqPWG08c8RXyqhkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393835AbfIJKdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfIJKdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:33:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E1B20872;
        Tue, 10 Sep 2019 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568111585;
        bh=LJtBmi1tzU6euOWenIIUw2u/xvJ895RqpElZGcqoEFA=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=OAZJ7pZnOmv9TWBnrIlLZYkgxdz9nE3yZkkswcGMUvEz1dDtQQtUpjisOcxQVWi8m
         pSr+mBZWVY9wjfPqJncBp2lPnBzesriGkO0xQ7zUSzOnyAUjNCPwVhecpHQPreRFHS
         JoMAZd14rknZjzD54lrSggDKmIYLet8VngkurqyI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190811210043.20122-2-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com> <20190811210043.20122-2-digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v10 01/15] clk: tegra20/30: Add custom EMC clock implementation
User-Agent: alot/0.8.1
Date:   Tue, 10 Sep 2019 03:33:04 -0700
Message-Id: <20190910103305.B4E1B20872@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-08-11 14:00:29)
> A proper External Memory Controller clock rounding and parent selection
> functionality is required by the EMC drivers, it is not available using
> the generic clock implementation because only the Memory Controller driver
> is aware of what clock rates are actually available for a particular
> device. EMC drivers will have to register a Tegra-specific CLK-API
> callback which will perform rounding of a requested rate. EMC clock users
> won't be able to request EMC clock by getting -EPROBE_DEFER until EMC
> driver is probed and the callback is set up.
>=20
> The functionality is somewhat similar to the clk-emc.c which serves
> Tegra124+ SoCs. The later HW generations support more parent clock sources
> and the HW configuration / integration with the EMC drivers differs a tad
> from the older gens, hence it's not really worth to try to squash
> everything into a single source file.
>=20
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

