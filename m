Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968E9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621CD21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSIbP6BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfC2Gdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:33:51 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33786 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfC2Gdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:33:51 -0400
Received: by mail-it1-f195.google.com with SMTP id v8so10246045itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oqaIbL6ylI+8fFUXJYe7iARxhR7eGybBzyFMPOeBbw=;
        b=WSIbP6BUTVF4UEqxSfvegOb431EOvPR82Tqpus3TmHV9QEXg6Z+w3D1dwj864cAapz
         SmWEh3vGmywfzFCa9huCrxdUo2hhxFUUiLK/COYMNGVm1MDRoDUKhKUT7v+Nve+S26bj
         mT4b+cvzZsRxFsKNwwdyFCwq2pM7PTbbMzq49l/j5lLuLI5GL/LQP6xRKxz93JBVSZJL
         8mh9/egJbonaqQ6uvUI8/A4KMDb372nFzQx/6k7jd7mMxgmHf/FewKFoSgXbcuQdFVPJ
         1NacALFtXJwdO6XC/UB8AI8GwVk7DAoBDX24Cz4JF//ENzi3xPzmVZgrDXsvZ23AiEKQ
         8QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oqaIbL6ylI+8fFUXJYe7iARxhR7eGybBzyFMPOeBbw=;
        b=PZMo0525o2GHux8GRLCaHuOqtjJJNSd/dxF4fMgE6Mf8asw4a6Hnbk9LxObKQQHydj
         7wpjcxBeUHQlDcLb446cdiGHs/XPdHlyzFkE0KcqvkTrVp0PJNTiOEs6Th6nzKIQBHyF
         zKf7Opn6MQLfWysZgytI1RecV80pufztDKQZV2JiTlNGNF9BkW9jU2IyZJ2iXFNPmEYT
         QRzuEhMqF8bFAcNTQm++LosEclo8qhkWLQ7Afr8I6tNRH4hRt/IwtNM39FchJcOSCWZA
         OtZqozVlUzT1vGSpewvpfz5j3bTom3isYezmnRotDMEV+roFxee3nJbQKBbJODkEGu8m
         4ozw==
X-Gm-Message-State: APjAAAUSqB26igHtxfp7GFpDshsziCuKUaJnA8E3kOZttYfd6dfKDqxK
        1HMK6OgmC4MxXb2NCTRvzoO+AvbVnXs+KlTtQFw=
X-Google-Smtp-Source: APXvYqwr3xGhG8aitB+WszmzQ1y90VN97Gy+U7zH7Rxtj3gSRle4EP0mTw0sWFvqyCLRGCTOezntTD0xFWuPDtUgmPM=
X-Received: by 2002:a02:924d:: with SMTP id y13mr25249919jag.24.1553841230379;
 Thu, 28 Mar 2019 23:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190325050100.29517-1-andrew.smirnov@gmail.com>
 <CAOMZO5BOR2DS-w3oOHsT_hTttgK=OPQZYwUywXdZFLRzbrb6Zg@mail.gmail.com>
 <CAHQ1cqHGgJMWMFx04fEzhzONPUrbjqD=3yPEyFsE=XGJDbJjmg@mail.gmail.com> <CAOMZO5DkBp=BbgcBbktGYMun1jiXKf5aJFPO1L2YUghB-UQoHQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DkBp=BbgcBbktGYMun1jiXKf5aJFPO1L2YUghB-UQoHQ@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 28 Mar 2019 23:33:39 -0700
Message-ID: <CAHQ1cqGOxqY2qV8ipejU+vLgTvxa1Y+jn0-CPdgYaLWkKPhp+g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock
 for SDMA
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Angus Ainslie <angus@akkea.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 4:17 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Tue, Mar 26, 2019 at 11:52 PM Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > I think it is worth fixing in DT, regardless if we do anything about
> > SDMA driver or not. I'll add fixes for 6SX and 7D in v2.
>
> What about imx25, imx31, imx50, imx51, imx53, imx6sl, imx6ul, imx6sll,
> imx6ull, etc?
>

I believe imx25, imx31, imx35 already have proper clocks configured.
I'll add the rest in v3.

Thanks,
Andrey Smirnov
