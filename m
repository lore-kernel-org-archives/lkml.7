Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC264214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohEFVGMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfB1B5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:57:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45233 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfB1B5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:57:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id t82so15189025oie.12;
        Wed, 27 Feb 2019 17:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQi5FZ+dNTiuCbxeNafsl/pGPps88+ajcksmb6rUUGE=;
        b=ohEFVGMCNrk4Us8F23YF9QKDpOblBy8CTnah6u2wM7Re+8aK934f84KxDBdJlqhF6z
         RG8WIpD6bvPuMNEzz9WGDr65J4380g+yZcIJL6QcvP6rTVw4lZfsV61X7haoekqJEQ/k
         C8wZ6ICbIbAzMM7VhQJ2CqdiGNqLk8uwTJFhfewC2SWYkBn+P4QNZb96Qvwa87n4xQs7
         VhY9xtP1UOZwOY6OcEPv7KtPOXYs7wtTufLQZRhspX4+FKMffXyNTVwFX/KfsihHdSrn
         izk23ZOP7Ko5q46Ig3Pnbf60FPDXtdmh8P1EILMDukpFNoQvbALTjMn8jX3A8phIgwRq
         LWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQi5FZ+dNTiuCbxeNafsl/pGPps88+ajcksmb6rUUGE=;
        b=TarQxo6xNKxIma4MaDbLV/eIBdFyXNhQj/9u1nf90ROw2Ff8qjIuIsIFfGimpNw62r
         ag/fQCUmrU2Y51pwsgmJIuSdDxJC2I/KhH17QsVl2hCq7dXsy3+hscJ3kr8KEydHVBrg
         ZoRI/XPRzfqRBMtxG1GVJF8LG3R2XEE4R5eOfkTIebQ91LGwGZ7ut8f/OqEXFu0EE3jt
         yOjDrRzf22yvxc/v7BR+VDtenTyMKHO1EyvZ2zD2pviEJcRefjzXSzNVTQKr6SvKrKhq
         wFqgEQqoGZ01FTEcYHsKV4oYys5GqSU4SWGs01W4YajqFCSOZN8U7GpPJqe0eb5UdvC3
         dAYA==
X-Gm-Message-State: APjAAAUFKgRyItQ83O/Nbv/dodeOdmGw95ryQ1TwP2e+Hv897y5aTavR
        C80jGnvDLD1E3HhUopD8TFSQpRtAIuhNPOu+frM=
X-Google-Smtp-Source: APXvYqxajBdLoADfAIzS1LXZOdzUGXLTsRP7S7TdhiVKWNdFo6zH7QBu3J69FM1HDcxudpjk6JSJwOrc8pPDlLzSmCI=
X-Received: by 2002:aca:3746:: with SMTP id e67mr1535508oia.103.1551319054306;
 Wed, 27 Feb 2019 17:57:34 -0800 (PST)
MIME-Version: 1.0
References: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com>
 <1551316741-7848-2-git-send-email-Anson.Huang@nxp.com> <CAOMZO5DQM0-rBbWuWa7dZw8es1NbY8DwCGmU4_ZJ2FdFEXYC6Q@mail.gmail.com>
 <DB3PR0402MB391672641C4829C18DA0DB36F5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391672641C4829C18DA0DB36F5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Feb 2019 22:57:24 -0300
Message-ID: <CAOMZO5BXCgj+uqA0xoOFYo3GxbN_HfbFyfQFmNRa4_AHL3nx0g@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] ARM: dts: imx7ulp: add mmdc support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Feb 27, 2019 at 10:54 PM Anson Huang <anson.huang@nxp.com> wrote:

> If so, should I change other i.MX6 SoCs with single MMDC node as well?
> Remove them as well?

Only imx6qp needs the mmdc label.

I can send a patch removing it from the other i.MX SoCs, so don't need
to worry about it in your series.

Thanks
