Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4B7C352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8813E21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8U76DKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfIZSKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:10:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32864 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfIZSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:10:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so2427564lfc.0;
        Thu, 26 Sep 2019 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=58oAE4FBJrvRDbJC9Z0EK/F0sTVW2LhvzqkiBlcRcx8=;
        b=u8U76DKjRJoT8QCsQV+FPzbekduPDZgnFTln6B26fZz44ZHloyZi9UTQ0fHPQUj/Ue
         ohQAL9LYNvJaf7453XeiAM2FJbop88jKCf7o4tTUYe2yccfTc2+6mLxb6QikGQt/jHOx
         9GdlqiqxFAI3tBWFd9kdukJQqgF8PUShBKEwSisgbyB8SdQjWryFQRL57AmkIaqgrSgn
         etD/9GT0+9mPKJnvRPH7WEN1rdlakfS3UtkwBlMd/EvqPvkPP2H+16kM5sRfByZ7dOUU
         q4+z87r+y6FWA0Ovm8HpizSQlw48AtbvE00/5s8valSjwbplHbhOlTBTdH3+PVQ6kkXK
         ZfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=58oAE4FBJrvRDbJC9Z0EK/F0sTVW2LhvzqkiBlcRcx8=;
        b=aU1TrFPUv/Iee1lqtL9lnBAdzymsBbdIzSa4Kb0TxEj2AjYrlJIHBYi1g7tzsnGcR4
         XbdpJXyUSAMIjxZddx4kXeb65tzl2aI5ok1HbMDPU8GLNRbmnV2gJV40SvDXmpfU8k3x
         u6ZVZzjzeZoKuOWMA3KDi8uV6J1RY8RkCxZB026n/eitnXFpmNDpx9ERaRmOkFd0dDME
         tVbsqkDPNXolLfT61QwiMvpxFVgMUP1RQm+vgsndwqSu8+rEIxbj2s7rCANGUfJBsfDB
         52nVtL1/Quiqey+2VWZsMX07gTIsgcxZC05vP2xK1cm74BocWT7awIZ9eesQjx4Y3hDo
         F+oQ==
X-Gm-Message-State: APjAAAUQcB6lGUzeugOsGdg9W/xr+kdWq8V6pDAL7XbQCK7fgXjHfCPe
        mRcURXMgJIjCwKHMmYVraWG2WCH0CBONcgplhno=
X-Google-Smtp-Source: APXvYqzubaCnRVu7ayU2jYF8LqYdVO+Sza2X45C+oWz4ZSoRko77F0nvAR95UPKZWe40qIwNje8/fb835ElINZntf1I=
X-Received: by 2002:a19:f11c:: with SMTP id p28mr2982279lfh.44.1569521438172;
 Thu, 26 Sep 2019 11:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
 <1556169264-31683-2-git-send-email-Anson.Huang@nxp.com> <155623699177.15276.12577395377027956830@swboyd.mtv.corp.google.com>
 <DB3PR0402MB39165F69F8B684D323C683B1F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F96CD6F3E874204E6972F5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916F96CD6F3E874204E6972F5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 Sep 2019 15:10:48 -0300
Message-ID: <CAOMZO5AweYkXXuBqvw+T_fOttKpbOnekKq5CA2-3a_ag1DwnWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: imx: disable i.mx7ulp composite clock during initialization
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, Aug 5, 2019 at 11:25 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Stephen
>         I think we should resume this thread, without this patch, mainlin=
e kernel boot up will cause mmc timeout all the time. If it is NOT good to =
disabling those peripheral devices' clock in i.MX7ULP's clock driver, then =
we have to change the core framework to disable clock explicitly if the CLK=
_SET_RATE_GATE/CLK_SET_PARENT_GATE is present, most likely it will impact o=
ther platforms I think, so the most safe way is just to do it inside our i.=
MX7ULP composite clock driver. What do you think?

Just tested your patch against 5.3 and mmc card can be detected with it.

Please note that I had to manually add:
#include <linux/io.h>

so that it can build.

I agree we need to come to a solution for this.

Stephen, please let us know your thoughts.

Thanks
