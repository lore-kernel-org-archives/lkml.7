Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B29C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5292067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8XxYqkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbfG2Pkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:40:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39660 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfG2Pks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:40:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so42360690lfa.6;
        Mon, 29 Jul 2019 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygvdaoF3+MRGVxrKdrfWYm+4OCrrKROdzHxrvWgJex4=;
        b=m8XxYqkfG1lFlK0q9OvLEvaxXZdlYLP2pqDe3rEKCzGuY5WY6tUh7BdeOCFzUrsZGL
         hP6pkfRusqmRGKtRrmcAlLrzp/f3CvqADN6p/InmKpPflgowHxWAD5+PR8H3ZS6m3dt7
         agZoRJte8xXzCerRKAGx8qHYSRI8vJJDJDNssaahxMZYp+c28xKEjeVOC/hBJs/EsZEf
         kIMX8+9MCLPYXfYx75LGeb2aC/DKUBVWaqlgyzZSTgbGRcC/Bfj5/CIZoonINMw1Zr0s
         K3Q3Ojd1w1IAlqxTvxnI31xez3rsG6/pasKCkvGealgN7waki/8m5rItbOsiCt++T58d
         rKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygvdaoF3+MRGVxrKdrfWYm+4OCrrKROdzHxrvWgJex4=;
        b=Oe5P5ae+vKVV9TVRCGGlpAVibhbnTPESmpcLzEET+Zd8ZqcaagOBJscmbUVveLptmw
         +cwYB8GvKBR9GJhlMQKDuTBgSx2bHtwizK7IJWb87nDUG8xTCHH2DsVPkBm2XHkCc3Iy
         nH/x1Be3HCAlH5tSNZxNWEZZxLVegwwpF86hLdEvpwcaeYo0XxUDRbnHx90PsxVx2iQa
         vt2BJ86cSI3RZMCtHHs+Tby7KZzpuwoEdLinQNdKCo8VZoDkTSvKQFFADF46RQea8Tj3
         CDpbnDxwfGHu6/tU5xl51MifMMFsND8wAEcPB1et/PhpvABoniec9D/Io72atbxRbetM
         6U/Q==
X-Gm-Message-State: APjAAAXTLIQXjkMhlSv+Mt834nBsg1WS55OfHCoBJvdt9xG2Mh5ck/7C
        ePKOXL2kiHVKH0iwJ6ZOA04P7VLppAd/+JG9yDY=
X-Google-Smtp-Source: APXvYqytcOJq5av6hjEfe681aqs4buj3oTGGah+PBtkNvnzioLMiUV0ZMVFGTtZSBbHSH8ik1gCq894GR8C2lvaebnw=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr42182072lfk.20.1564414846457;
 Mon, 29 Jul 2019 08:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <1564384997-16775-1-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5C0WbaDzFcjeXeS1PivWUme=bzPur6Hj_xNz1oVzvpW2Q@mail.gmail.com> <20190729150712.3ah2ayeonhdfrt5n@fsr-ub1664-175>
In-Reply-To: <20190729150712.3ah2ayeonhdfrt5n@fsr-ub1664-175>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jul 2019 12:40:51 -0300
Message-ID: <CAOMZO5Bn0zeuDsMk7SbJxaqFsHtd8oO1xiN48Sx-RSkeGQ3dhw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx8mq: Mark AHB clock as critical
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Guido Gunther <agx@sigxcpu.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Mon, Jul 29, 2019 at 12:07 PM Abel Vesa <abel.vesa@nxp.com> wrote:

> Please have a the explanation here:
>
> https://lkml.org/lkml/2019/7/28/306

I read that and it is still not clear for me: which hang exactly are
you referring to in your comment below the --- line?

Reading the commit log it is not clear if the patch fixes a real bug
or if it is just an improvement.

Please make this clear in the commit log.
