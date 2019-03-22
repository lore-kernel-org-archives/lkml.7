Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B95BC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D81C2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOCcpVFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfCVQY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:24:58 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:40775 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCVQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:24:57 -0400
Received: by mail-lf1-f41.google.com with SMTP id u68so1797990lff.7;
        Fri, 22 Mar 2019 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q21Z3n1Ji4UMih2Bwv0c3Y75r3KmaheqeSAOtdPkmJA=;
        b=FOCcpVFK8lJ38EuhRnYL/f0FZnT1EJBYvNnFNDFn7+/gg2emQUFmwq+WQxQDSppoJz
         CGJZUpOtVbmoeVYleLHYCRCzgHlEu5rvErZ7MqrkmoqU5gu444iLs/3bYDPcFyVCJGhq
         m5QQZ7EKWHvL+HvZz8MmnvRTRLdfdrOnJ67USMUNgCMZq3ylelgfF8bTZ/mcgxqkOKSt
         pzacNpDsxSv3AFjNUP7P+Qa2bBtUNKhR1DRrPGnLelqBMW9/U1aLXW8fc52M+TmFaUk3
         rCb+EVhK4pnqCRzZ4tozvCXbae3I9X+Itt072CEqU7YPg0OB5OUSQCBmL6JAGthKXflo
         EDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q21Z3n1Ji4UMih2Bwv0c3Y75r3KmaheqeSAOtdPkmJA=;
        b=gCZQcD0UsTR2QJeTdh345u4ZOF3QQrXeGOqe4Er84UMG0T8DtwrbHvcQD+FOmtr8/6
         MWtEBafDWrn8plrG/q2B0w/scneSvDdfhJ0R1gq8MNuI0MVwKE/sflhS469YFQ5BDjya
         6+FddPEMWcwduB3994G1+QFjfnl46EI0nhx+sm4VeKvAjHQr8crwvJ1BUm0EVt0Jhl/s
         4UolBTAA9HSV1z5XMsFagHJa6O8uxemngSwrdA57wgT/mK5o9YOmDXtYldflJ+oTpqg/
         yKsAOXxm/aMkoN7YWrDGz+fhWYoedCy8ONi7pyHsNCQH+xpAmCftVc3M6P9R/mAkfz6m
         Gpqg==
X-Gm-Message-State: APjAAAWf3kI4e6uiCpmizGQ+HRAV2aeuNqI/Aue9DOCNVGfjDZdpVQFi
        VMBjb+8u/TOT6z76gfdsjAgOh8gbNXHFJbo3BvA=
X-Google-Smtp-Source: APXvYqxzzqY/UG6+LyjsWsLJULEZNZL6Eymp3Y7lCg18iN/cjGvY7j1E9BgN3KwZWQvBwt7ikcKlrdhKvmLv8O8qB1c=
X-Received: by 2002:ac2:5381:: with SMTP id g1mr5577801lfh.130.1553271895555;
 Fri, 22 Mar 2019 09:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 22 Mar 2019 13:24:54 -0300
Message-ID: <CAOMZO5DWpu9irOWR3rux-vV1sihfsDkTs5SJ7XXy8MgRBCd-Gw@mail.gmail.com>
Subject: Re: [RFC 00/19] clk: imx: Switch the imx6 and imx7 to clk_hw based API
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Fri, Mar 22, 2019 at 12:37 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> This work is part of the effort of switching the entire imx clock drivers
> towards clk_hw based API. In order to do that, we have to keep the old

Maybe I missed some earlier discussions on this topic, but let me ask
a fundamental question first: what is the motivation for this API
change?

I could not find the reasoning inside the series.
