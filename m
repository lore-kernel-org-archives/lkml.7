Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7904EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB9121872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTexE1Zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfDEOMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:12:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38212 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:12:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so5395574ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CT3BdQgSNzd/fN7mp4x3e0+G7QHy4ROaCb2UvtqrDkU=;
        b=sTexE1ZrqscOD+JblDoNNHg9HVs2fqz2lkequnIRne5lfQPLKFMrDcbaaRdjvDjxqr
         XxvbZGdS/wElubiCGYpWw3IhpyZ4F2G3Ustk8pFQsoBUEXKIb7UDn5tAayqQF2kpUMVB
         HBMNvnN7+uUq7lirm0W8Sg0bUku02pjPbx8K0gPG8In8eyClpok4RDO8PtROJJ6oY/31
         y6PgZli/zJBSw8Ei8ZdGeYjJK6fqNV4E10s1k/zUUUe+ina10ZKOA71iybIfrZ6u29FP
         xF5jMF4RzKYJq0FZm+WEGcCj0GwXRL8ekkMA/2Yn+CmY0un0A3LZ30bVTNJG6sKGolUb
         L1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CT3BdQgSNzd/fN7mp4x3e0+G7QHy4ROaCb2UvtqrDkU=;
        b=tgOLtp7yReFiO47F/zf4SwcnnWT8M2UMOx3ivEJmQ+uOVdomA49KpjRP2RjDUevjNO
         us1hEqYGGXV2MMuxp2LcuJVP8hTde9sJthU0ToPDbdYVqO3fo9vOwNkSV87NK6e6wCR5
         Q4WOxdwrSJ0a8fL6GRc1XQ/tg3WPDi7xLCY/3kpBVvS+YXv8pwKhvZLxVQMxUvrybJ1m
         aXs36NIsU+49YvFcCqjAIuKVCmaOoxxa4hhBp2C17QqU0eFIpIiLFNQ9dtblF9xhgVZj
         Si6jNbg0OyxBVUaJH0yBqKQTeptWBPIr2XK6FtRapwg+j6yOoiysnOCM0CpL4IJqfPB/
         Zm5A==
X-Gm-Message-State: APjAAAUkc4HZ09QcjbXdvkLVqLVb/1Ntxnf2Ia2v6bbmSKKBPsDMUqwN
        i/gNUt+RjzwgBL8nhIOgsnHHZCNZHpuuhKF+pxI=
X-Google-Smtp-Source: APXvYqw/N45Fg1UpHePR02S+cagLShyD0guua3tCpnMyfTiElZYP2qkhErL7j+U0wGm9BhMwr2kaA89QL1qar9bJZ24=
X-Received: by 2002:a2e:5518:: with SMTP id j24mr7025549ljb.167.1554473549550;
 Fri, 05 Apr 2019 07:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190401022413.6682-1-andrew.smirnov@gmail.com> <20190401022413.6682-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190401022413.6682-2-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Apr 2019 11:12:18 -0300
Message-ID: <CAOMZO5BT7pBfjPacKq-VFnRR+m3_RxCwNufWDFpLVL+zMx7X-g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:24 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
> to allow i.MX6 PCIe driver to use it.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
