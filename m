Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996AAC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706BE20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561494750;
	bh=79veobl52Z84hPCuz8vwU8EIU+giIpnO94zX6uPPBxQ=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=K4U63GNI3pnoohMBHWOLtdKignhGa5fGVZKuFpwZZgKOet3yVUss0XF9u4VgS1sr8
	 IR4aeiZEB34425dn44aEC6kvi5ezEd9mrKi3oCuyhlgRYSkTgxhA3rk7XnYjta+rAC
	 sLjNLtjIbOiuTmRaFcc4kkfbSRo07UKfZPuNiOlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfFYUc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfFYUc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:32:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9696920665;
        Tue, 25 Jun 2019 20:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561494747;
        bh=79veobl52Z84hPCuz8vwU8EIU+giIpnO94zX6uPPBxQ=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=bALF2utkmoFHF613ojuyDcQASrKDND1ya3U6U0eClfPxV/Nx5hC7HmsdkJpE3e7mE
         1FYGhYF7BUYeIlGvlPj/CAPVC2fZAQoy44jGbEpsYgU37i/zOK0VWP8VTpygJ5OUAW
         DdO1IFTBHrD6ajecFLXcF64/VyjYkj88D6Hv0XQo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190620150013.13462-3-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com> <20190620150013.13462-3-narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC/RFT 02/14] clk: core: introduce clk_hw_set_parent()
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 13:32:26 -0700
Message-Id: <20190625203227.9696920665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-06-20 08:00:01)
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index aa51756fd4d6..3e98f7dec626 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2490,6 +2490,11 @@ static int clk_core_set_parent_nolock(struct clk_c=
ore *core,
>         return ret;
>  }
> =20
> +int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *parent)
> +{
> +       return clk_core_set_parent_nolock(hw->core, parent->core);
> +}

Will this be used from a module? Maybe it needs an EXPORT_SYMBOL_GPL().

> +
>  /**
>   * clk_set_parent - switch the parent of a mux clk
>   * @clk: the mux clk whose input we are switching
