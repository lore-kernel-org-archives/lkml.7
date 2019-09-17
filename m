Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6559D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568752736;
	bh=kVUefUbXR0mBH5Ui5KzFtZDJlyTMzgtjcJqAGMFeGQc=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=ZXY/WEh+c9dQgHcZPqcLDmghvN3omCG2omFV2O8RZEPxDKAfQW7igveG03UaNfGGM
	 wKroIFGb44OKvfIG+jXSyIvshKl8Ht3KyLdzp/M5mMFzzYURwDHf3EKtw/WPuwFFm/
	 tKZHk2YBz/EC7ax319GHqmUTiSvmLb0P2y6TAAMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfIQUiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfIQUiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:38:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF702054F;
        Tue, 17 Sep 2019 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568752734;
        bh=kVUefUbXR0mBH5Ui5KzFtZDJlyTMzgtjcJqAGMFeGQc=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=DqQiSuG8aBiB88+nJ8OiopeOGKmBr7luh2PMR/vvYacQpSyOGMkttJlq/epSiU9ML
         Z7kCDaXWsgcZ5v+U/SpGFQgKncN1BZ0e1ajvmg3ZtM5x8dWtKKSlFLDUvhEuHrFMSF
         79UguoiFq3rajxJtBDsAZoxbmPHKwTS9xAB/pQms=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190916161447.32715-3-manivannan.sadhasivam@linaro.org>
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org> <20190916161447.32715-3-manivannan.sadhasivam@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 2/8] clk: Warn if clk_init_data is not zero initialized
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 13:38:53 -0700
Message-Id: <20190917203854.8CF702054F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-09-16 09:14:41)
> The new implementation for determining parent map uses multiple ways
> to pass parent info. The order in which it gets processed depends on
> the first available member. Hence, it is necessary to zero init the
> clk_init_data struct so that the expected member gets processed correctly.
> So, add a warning if multiple clk_init_data members are available during
> clk registration.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/clk/clk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..7d6d6984c979 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3497,6 +3497,14 @@ static int clk_core_populate_parent_map(struct clk=
_core *core)
>         if (!num_parents)
>                 return 0;
> =20
> +       /*
> +        * Check for non-zero initialized clk_init_data struct. This is
> +        * required because, we only require one of the (parent_names/
> +        * parent_data/parent_hws) to be set at a time. Otherwise, the
> +        * current code would use first available member.
> +        */
> +       WARN_ON((parent_names && parent_data) || (parent_names && parent_=
hws));
> +

This will warn for many drivers because they set clk_init_data on the
stack and assign parent_names but let junk from the stack be assigned to
parent_data. The code uses parent_names first and then looks for
parent_data or parent_hws because of this fact of life that we've never
required clk_init_data to be initialized to all zero.

>         /*
>          * Avoid unnecessary string look-ups of clk_core's possible paren=
ts by
>          * having a cache of names/clk_hw pointers to clk_core pointers.
