Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4071BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A5B207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEhGOqAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbfISKdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:33:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37428 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbfISKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:33:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so1983185lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fo7cMzw36a28m/r8Obxok4ZgaWlax9TMyQySR8fq2vo=;
        b=MEhGOqAMGWMHHchatTX9wNtJQnKTRcZaXQqnzw+IrGnmtSz2Y4HjblXYYKLy8Howpv
         xkJLR7asVj8OFYdHRzG39xTw1nkFxPOkbwDis7zrga12uLEHcWkrIfnOr4FYZ+Mwh72P
         7uzJVGCDKTxJhmMb8Lb5YsVlhKvlrJCz6AoFs1eegPzwtUcaw3hUnhG15lnwijQWZLWW
         7dE/NSwDfW0yieAyR80tr4IBa92YXsda8BLA08fzlEYT9T6d2oZYApeYF52WHHedMVuD
         XoKJ9k9MV+tInTCaC6/zus/C2JQX71j/1wkEWr6cJgfwLAg9zoVFPlTB15GhDgTIbbQN
         8WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fo7cMzw36a28m/r8Obxok4ZgaWlax9TMyQySR8fq2vo=;
        b=GJPvoGUuygqDbQ4+PHyOds6yGtMrF4nsG1nwUaF2REa3bp980v4mwIeZ6Q40QbcjRB
         rx8rDit7ClL5iDQ/KNnCkSiNm4wGGtqnDdkw8q0UyI2NYGMPeZL1Sox4vOS/lBGJjx4i
         ddkprgdNSMJ/K+HjKzPArNmYbrdFh/plnRK6jge4DtU75fzi9N64uL9o46MA+NQiXVVV
         2wlyxZlPdObsUPNTE8GC8CRX7Ifli9Oa98qvgAfb5y+XXJwz2eeUTxiytw7gkOvKydNY
         LnlxP8wZuVLtSSfRwjT2TC8rrikNWA2LBLB7BfX/cEWNz8tzKc/fJdNtIBCo9ghJL1/k
         TNZg==
X-Gm-Message-State: APjAAAXaJX+eW/HrOH0E0nM7UP34kmhCWw5RYLAmOiHuryUG9PdhiDmQ
        vMyflqHsnYiHpzBtNQF0EHoWR7nfYePUR+S7YzE=
X-Google-Smtp-Source: APXvYqw+AnkepIIO8D0IoEIWU57tO3l2Zw5feO8lefnd4aiB/eZJqHOJH6XA9JNFBpT4QPlfg5B+pBZNXOyNP2okf/I=
X-Received: by 2002:a19:c709:: with SMTP id x9mr4782140lff.20.1568889214837;
 Thu, 19 Sep 2019 03:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190911144943.21554-1-philipp.puschmann@emlix.com> <20190919102319.23368-1-philipp.puschmann@emlix.com>
In-Reply-To: <20190919102319.23368-1-philipp.puschmann@emlix.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 19 Sep 2019 07:33:33 -0300
Message-ID: <CAOMZO5Cp9qHSEOx3VnUC9SSbKyZrS2T0a_mTx7ubzs45Weud6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix UART DMA freezes for i.MX SOCs
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.or,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Thu, Sep 19, 2019 at 7:23 AM Philipp Puschmann
<philipp.puschmann@emlix.com> wrote:

> Philipp Puschmann (3):
>   dmaengine: imx-sdma: fix buffer ownership
>   dmaengine: imx-sdma: fix dma freezes

These two fixes deserve a Fixes tag so that they could be backported
to the stable tree.

Thanks
