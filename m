Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8054BECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A552214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2OqE7Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfJKLU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:20:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39409 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJKLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:20:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so9446408ljj.6;
        Fri, 11 Oct 2019 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtNnfZSNIM+FE/Ouxm1KBXCTSzFBGzlbFpsvpsa6fzI=;
        b=D2OqE7PnNRoUmWNbgTg4s/KS8g6W7Ej8Lz/BB12Px1dRFIkn9T/mePVU+H/hIHV56J
         64v5oYuvA2yBVwR0KjYpdXT/oXajCzphVepm43ADpOGt2tkvfG7g+ZFrAf7vUYqBiwfu
         EjGV7zGmT3Co3lrzt/KGm2dHBVc8id1bTLHciUJIAOh8xvd9figVUKdPFEFHeguDB88M
         MtLMtaaxHw6QUzwR1PJNwwgfViWo4DK6326sFZVy7QzQuw4tbK0TeUnOf345R0Q4EuZa
         CAzVC4ECxAv5aVbB5KLueckmLSFulPvJYY6CEPwIjImSvxfmQszWMcLYYEHWMSGewiS8
         AtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtNnfZSNIM+FE/Ouxm1KBXCTSzFBGzlbFpsvpsa6fzI=;
        b=gvq9R9vyMHd5xIHJO9sVkhc4ZHKQeCSaRWUZ2xA3jBiJUgBc+YYvBlczanXf/YAu+s
         dobcfRPRkdoHOEt3psHklGU1OMO1SneU1tlqQOEcvndWs4XO8g+myWz+vkfQMunBYay9
         0NwjHVDQrdlK9UkvJuafIYBl1kbURhmCjK5QDg7i3P8l+FBKFCc0wWTRW8XOtSS5DPEc
         B2qyrDZV4IN54K7APTcrPTZ1Cw8N/7tip4TOys8nSep3Ea41gNhr9rpVHoNffZxmi78p
         KwW7YNsPFscGy8urQcVs9kr3EJ0hx40CErLjM36zlSgYcd0u4xrMTlNXgWbUEVooVl4y
         CxTA==
X-Gm-Message-State: APjAAAWXJs2vlbMg+eBjL4QkIgFeVVUDz8urHFYzMXJKjCa6WhMcgDt6
        TxGfG3U+kxKWePQnb5fkOSbzVrcPF6bDiYCFuNBhmlYZ
X-Google-Smtp-Source: APXvYqzE/zVDPjPyTom42qRHj6q37hTnXXPuz3aalIoov7655nQZiN5T5dR7/JP1C+tRL0z2N/CI/hjBxsug7ERVx48=
X-Received: by 2002:a2e:42d6:: with SMTP id h83mr8801587ljf.21.1570792852255;
 Fri, 11 Oct 2019 04:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <1570784940-5965-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1570784940-5965-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 11 Oct 2019 08:20:43 -0300
Message-ID: <CAOMZO5D_Yxzq83zKGM=qUbBjP3c4UB9_GRBAAcMDEvzTYMuyfA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx7ulp: Correct DDR clock mux options
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 6:11 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> In the latest reference manual Rev.0,06/2019, the DDR clock mux
> is extended to 2 bits, and the clock options are also changed,
> correct them accordingly.
>
> Fixes: b1260067ac3d ("clk: imx: add imx7ulp clk driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
