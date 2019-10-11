Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0033CC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD423206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DECCbZCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfJKLOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:14:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46220 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfJKLOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:14:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so6716950lfc.13;
        Fri, 11 Oct 2019 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XRPBHy88G3xNbXeVwV2n/tikjG8xG4XiQm2Q6YAxdE=;
        b=DECCbZCrPys8WgUmo5NZZ/FL3X6q4Z5+ZpwOXV54DB3G5hd/25jr47OrIkjJcANpST
         BG8NJmQ7IMuptLOapxCuYAI8VX9tsRTkPq/cXcXwi8fkg5mpmMpzWg7ohb2/k3apksqM
         rd00NENTAa56ZoMa7BmK4MizGGqkyF7RaZ867Mb1Y3MQbAgmXKQYbvnjDsZYijLpe0IN
         L78X5rzLMRfeMHP2dpPD+M6fGeToVIlEUpfRcsXe2VohjsEnsowXoZ0BGBcSw2O8FuR4
         SmT6IB3o5ncGJMV+bswtra2cdQMzlDd61uuU4nBwKZ73wb4YY3iqhcNQe+hHXfrgIeWQ
         RKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XRPBHy88G3xNbXeVwV2n/tikjG8xG4XiQm2Q6YAxdE=;
        b=jYbCoznkByg2dyEgIHDhK2IPVeUmYAnzvgq1ONvLPLHS02emZxsMlQwlMbdPrw3OTm
         BjySIpX8M7PUw1V+amHhkh7buhTVqrjDRnfq39Ma7wd+EV/+6D+39aojwX3PiY+8mPLy
         YRHjMtJg56oyflkoUFKDKis4fIyHubWrhMHSWwE2O78MmelnUQf6t2avIz+3K3ts/CEM
         ZEYpar38vIvFKOcAUO4xdj9KnAuikZH3TgX7XVoaCIrs9X2S6ixhCGJSmJd2bhiDVgxr
         GITW7sJLRuNqyjbam4ushE9g16mMkyI5RFhmuroqOwvOvYwLpBfzsGr7eFc5oc8KMMbg
         ji9A==
X-Gm-Message-State: APjAAAWoncLhe6ag+8j9yrqL8NrJ2LWwmyBiaOxIb7/1RpTj84QGHeje
        9PSrnprBuMONZz8GqngOLDHrPgkbCQIVHnc7XlOO7/EC
X-Google-Smtp-Source: APXvYqzwJzXOjPEkwfUFJfsMRUF053ml+64En13k0ziyab36K6XmeWqmRmcPA8CPnGkIkrbLsecdf4oj7wNXaGr4c9A=
X-Received: by 2002:ac2:4c13:: with SMTP id t19mr8718845lfq.20.1570792482568;
 Fri, 11 Oct 2019 04:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <1570783006-28099-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1570783006-28099-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 11 Oct 2019 08:14:33 -0300
Message-ID: <CAOMZO5DUVv_cT59pTBmfa60TM0E9=6rFdpDw71g_6cQidOPW+A@mail.gmail.com>
Subject: Re: [PATCH] clk: imx7ulp: Correct system clock source option #7
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

On Fri, Oct 11, 2019 at 5:39 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> In the latest reference manual Rev.0,06/2019, the SCG1's system

This should be SCS instead of SCG1.

> clock source option #7 is no longer from upll, it is reserved,
> update clock driver accordingly.
>
> Fixes: b1260067ac3d ("clk: imx: add imx7ulp clk driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
