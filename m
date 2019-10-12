Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1CAC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00083206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZg4aI3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfJLMp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 08:45:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43565 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfJLMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 08:43:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so12318004ljj.10;
        Sat, 12 Oct 2019 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CADlOUghANhRG0HNGinC5AsguWpKsMKBHiOplFJxWw=;
        b=VZg4aI3IFPw1ni74/UsQXVoams17Q70FhdajE5eAzynPoqGYPD5ihMK0e16g/WQmKh
         ioddabTuOQiv5A6b3GnrkkzDuNKs/MpAOHoG3cFm9JLnKy06mlN5YPBxK8ExLptwWl/J
         rIvL0YuQxe9y2+yPiI3gE5lLkDFwzmlN4t0x68uT9gKhu7l9TIxgEGE5IpDsPWCDWb5i
         BkM9OXGKRynz3ztXS7307U2LiE0XKkwX3Pwsx80PVoXtqhBU7hjsC3NQFJrv3d51rlnr
         pSxrDio6YN60VY+X2C/sb0XPpMeOgdD4ZLBOI/mTaqFUPEKYiz53ZA3xSebC91KnKC2k
         lkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CADlOUghANhRG0HNGinC5AsguWpKsMKBHiOplFJxWw=;
        b=hhHDFTKwFF4VrVWkLmcrVISCZIIrZa3qzDe+DmqZWGzgV3PY/pRD+SzPk18jMAor+7
         YaugaH0Dqjg8WCeywQzcJiNofPds5AccyexL8WPC9qgDojqals7c7vf5OxEDNXerZXcm
         kwkiXKpkaoAb22LIbALFwPGqLR16JHNJDausSBpyrLVvS78KEydBgPCrNSISP0co1Otr
         TsnWUxuY6FEh2JDWWQP95Bj9Bjal7LtKNixSFeIp701Sla6H5HVEWkFxOixGyFKS4wr5
         OqpcMcF/X3WpMJXAYtQDU9dWIjvQ+SugUpvVD/3bRbHsxDSEzc+1DNQgZv2cx2nMS6AW
         LZUA==
X-Gm-Message-State: APjAAAXgDKvZuWyEzGgxCg03DQknLIYtZAD/tcCg57evvoL+0ZuvrXAC
        PgQPHOKmRvKzkRB4vR537XQfGPOK5af0ioSzc/o=
X-Google-Smtp-Source: APXvYqygSUnmZtuIfmzJugXxu14SrCzb03W4144W6rGpVhHWELNeoEFWiIrj9eMmuk1ByG9SW1xei+QzlZLFo8GqUyE=
X-Received: by 2002:a2e:9205:: with SMTP id k5mr5181539ljg.202.1570884236119;
 Sat, 12 Oct 2019 05:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <1570783006-28099-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DUVv_cT59pTBmfa60TM0E9=6rFdpDw71g_6cQidOPW+A@mail.gmail.com> <DB3PR0402MB391628A077B9D689469D38E3F5960@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391628A077B9D689469D38E3F5960@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 12 Oct 2019 09:43:49 -0300
Message-ID: <CAOMZO5DH0dfmd-=b1F3nSdoLiPE+Y871RBnrBUg_pC864JQ=Dg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx7ulp: Correct system clock source option #7
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Fri, Oct 11, 2019 at 10:05 PM Anson Huang <anson.huang@nxp.com> wrote:

> The reference states SCG system clock, SCS stands for system clock source, so I think
> it is actually meaning SCG1's system clock source
>
> Selects the SCG system clock.

Yes, SCG is the name used in the Reference Manual and also the driver
calls it scs_sels,
so it would be better to keep consistency and spell SCG in the commit log.

Thanks
