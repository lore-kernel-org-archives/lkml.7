Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00621C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE18B20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogZ/4tmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCHMFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:05:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46948 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfCHMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:05:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id c18so17117888otl.13;
        Fri, 08 Mar 2019 04:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0w9n6GaF5JpJfR4rjFvSXTsvU44A+26mUez2eKCOkxM=;
        b=ogZ/4tmi3YgFxtLLs2T70JHMuMRe+iRxGdCjODydOmeuuvKYA5qs2xsn7vu7kRG9ty
         77xs8JlfAYBKGhj05ECnG/w3Lm6CtkLI0FIKbMms5VGq590q122u96oiN2dO0+DR9jfs
         6T1e94MEw7qdaSUmDUQRdmV1hfYD5LWS1ycp7y3rkYzhGV1xFC3bg8i1tlavKYiVcV6Y
         A5NQD/jpusisTn5TPDkLEE4PCu5W6cuNoPQmZTBsQLUNWPvJDEysQhfPrkkjldalS2al
         BXaa5nskZFypxatTQAITdS6SPL1i7tNnmh/yFhVIwRvbdcsv9Bmk4Fd4cgBWThMT3mIT
         vPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0w9n6GaF5JpJfR4rjFvSXTsvU44A+26mUez2eKCOkxM=;
        b=GLlpG/GcQ7wTPyX4gPebyuV8qHmuoCrtKR5cGBZ4OD1qpsJrgZsYZ/E5LV54fdL6tC
         rLSFEC+b9PfhAsG9yDSIZgvtdgkf68ml08T5nXoLzV+0jH5j1HGDifz6l6pNCO+/wYjX
         FGl/zSrboY8s4ezIE0+Cko1xWHs5d/tSrU5KwodhhGowmLKnkoiqeXVWO+AbL4B3wYNh
         c+GWiaiiNemhi+vWi3BpayN41nHUKG8hmrJWakWuwvoLLQhYY3G+LviEiKuweGIMxQB7
         bgssHzBTZNZblXw/ivUveNUXyP+6POLgjG8BOKj/JnQwMRc7ncZkDx3U36rw1utBO8aR
         f97w==
X-Gm-Message-State: APjAAAVgcsfwbC9BjW7mtoRB86/qqul2ueAmfVMTbneXKNvAYqQuDS6n
        dLvJHo7C16wQ1PXDrZJpI+PGu+nTczDTJZZP/S8=
X-Google-Smtp-Source: APXvYqwtm+HF7+ijQTowyrCRFE1JjI6wWvJX0Du9xHopsQsLDjDxgM0l18ChCju7A4uWJpx6qHNhmYqj4iVSzmDGI3M=
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr11419464otn.203.1552046702003;
 Fri, 08 Mar 2019 04:05:02 -0800 (PST)
MIME-Version: 1.0
References: <20190308120141.3698-1-daniel.baluta@nxp.com> <20190308120141.3698-3-daniel.baluta@nxp.com>
In-Reply-To: <20190308120141.3698-3-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 8 Mar 2019 09:05:02 -0300
Message-ID: <CAOMZO5BTgF3pM_nYXqsH0irw8Tptrvy4_BENRrKcSh=UNv428Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
 compatbile string
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 9:02 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> Add imx8mq sdma support.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
