Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C83D2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564439386;
	bh=JNZa/y24wXNDv30tuaj6kC0kdXk/z7BCg8JawB3obts=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=eL3tIQyYXxu68PLJF2s/slhqFrJ20DCdFrMu930GO6FF4RGA4j/rjfZrhcqeXW1Mi
	 yfkpEy65e+X1/o7cl0ozEnbKnHkVUFU2SgPmAaSx0Q9nM1n2hpb1Pbc1a0EBNresZf
	 cxD4qcNWssqoQGjr3Dp1ZVEUuXdIbAMWWYaoRbPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfG2W3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfG2W3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:29:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116DF2070D;
        Mon, 29 Jul 2019 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564439384;
        bh=JNZa/y24wXNDv30tuaj6kC0kdXk/z7BCg8JawB3obts=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=NxRV8PsJoRIZMOqn4xIbsmF2GL9TDcczIYDurDe3IMz/R+DKattIoWJbpF0FiXiYq
         efBhSe5r6QPkFdQmLo4rGXOmq2NrUakQbDpwJ5+M6Fuv6rfNHmYY3AJYIt+T6TYfqD
         6IEkE7SHbOp8MGy/bQESzADE7AowrIUrtnvHbSmo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190703122614.3579-3-jbrunet@baylibre.com>
References: <20190703122614.3579-1-jbrunet@baylibre.com> <20190703122614.3579-3-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] clk: meson: axg-audio: add g12a reset support
User-Agent: alot/0.8.1
Date:   Mon, 29 Jul 2019 15:29:43 -0700
Message-Id: <20190729222944.116DF2070D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-07-03 05:26:14)
> @@ -1005,8 +1087,27 @@ static int axg_audio_clkc_probe(struct platform_de=
vice *pdev)
>                 }
>         }
> =20
> -       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> -                                          data->hw_onecell_data);
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                       data->hw_onecell_data);
> +       if (ret)
> +               return ret;
> +
> +       /* Stop here if there is no reset */
> +       if (!data->reset_num)
> +               return 0;
> +
> +       rst =3D devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> +       if (!rst)
> +               return -ENOMEM;
> +
> +       rst->map =3D map;
> +       rst->offset =3D data->reset_offset;
> +       rst->rstc.nr_resets =3D data->reset_num;
> +       rst->rstc.ops =3D &axg_audio_rstc_ops;
> +       rst->rstc.of_node =3D dev->of_node;
> +       rst->rstc.owner =3D THIS_MODULE;
> +
> +       return ret =3D devm_reset_controller_register(dev, &rst->rstc);

IS this a typo? Just return devm instead?

>  }
> =20
>  static const struct audioclk_data axg_audioclk_data =3D {
