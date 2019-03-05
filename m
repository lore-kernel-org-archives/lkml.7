Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEDDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E342082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfCEIaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:30:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45393 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfCEIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:30:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so8130262qtg.12;
        Tue, 05 Mar 2019 00:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DW4hMhVOXcoGIUO0/Ao+GynSdYYHc794RGehIvtBeVQ=;
        b=IN6nDZc+nWGWEmbbeg+kTWCN3KqF8XWynZRcTCn/WaA/jujGEA6qEwGYdOX7elzYZv
         yjAkuM/cr4Rst9U4fsNWD6R2CGJ6VyQXXnNSBOk/9mv/y6dvAnde4xFl0IPM9t7otzAE
         Sy1+0FoR1OrO4Cg5AhLPR6HtdnPn31Wzgc74IfmCE6VVf7oZ8zJ+rRATamPaW1SPZrEO
         tKNdOtWJ9nI0CWQqOvFzXpwGs9Wz7zMXg+5Zttn5GhBebwkEz3oRDqBGc/nUWyk2oc/T
         WyOmTgjOCzvaNfwLEG0Iqtyh76bqfmloms9mSap1YJMy7mkaCfBUwVsRnLru/FSlmxUY
         NciA==
X-Gm-Message-State: APjAAAUBP3aPlTefgIStN5NvTX+6VDuyWCt+iNpdDlYtlLxHKCi/WbRQ
        KpNWB6TsreuICh50MnaZzlHkGFeLeB9QJe38D4o=
X-Google-Smtp-Source: APXvYqxlIsRIUcVnUVtZEW/SLR7S1VH/rDIv3tjZdM48+STgLkBwy1fSV5VVPRUvc6ylbnaYpqvKmSCwZmsqahcrpqI=
X-Received: by 2002:ac8:3251:: with SMTP id y17mr557556qta.152.1551774596380;
 Tue, 05 Mar 2019 00:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20190304202640.1765847-1-arnd@arndb.de> <AM0PR04MB42119B4C4FE9DE3A352A0FB480720@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42119B4C4FE9DE3A352A0FB480720@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 09:29:40 +0100
Message-ID: <CAK8P3a2jAc_5A1cTF8BEmmqNRVDp0vAhcKTcPT7eK4GQYn-tOw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: fix link errors
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 4:00 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> Hi Arnd,
>
> > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > Sent: Tuesday, March 5, 2019 4:26 AM
> >
> > Submitted by Anders Roxell already
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> How would suggest to handle this patch?
>
> I've already given an Ack to Andres' v3 patch with a few additional comments,
> but seems did not see any follow ups.
>
> https://lore.kernel.org/patchwork/patch/1034330/


Sorry about that, I sent this out as part of a long set of bugfixes, and the
comment in my patch was supposed to tell me not to send it. Please just
ignore my submission, and let's go on with his version.

       Arnd
