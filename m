Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B5DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5010B21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soIdIhCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfDEOQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:16:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40267 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:16:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so5410472ljq.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1dKuJsaVThy3WomOfBc1jWEYoiCKYzEdwUgH3EuD3o=;
        b=soIdIhCTzW4lqwFOhXldArrOpijKvAEbo+3LClSNxnnLjCoHI1R69jxhdpsSKioQLK
         NYs/AdyxwgtvENczCaz/XBrkmCCaf2003tIGUENZN89AFIF2y+3IL6clBpar056ElAHj
         9Q/pXnuzXeS4D7tvX+RgIE4p25Mloo1jS40ErGLC6C0c8baS5MbMZubFomfoMwk2th92
         raUOloM/vKlaqmFaaxHbHxu8qNHiB1IPG+Rm9i+bQR0bd3hNmNL/kN9cY3yWdGa/WBkT
         kQzIriOAZ2ZFjJ3GKQILZ/2SrrLPRnoMRvIc3HiUf7URXkes69LygIxVUQhSCR3wPIad
         uuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1dKuJsaVThy3WomOfBc1jWEYoiCKYzEdwUgH3EuD3o=;
        b=RRvauypVHEj7pNMS7DKVcfqr3wdtRm6qnjGhE8jVpZ+4meQoeX2M+UH18CHMxP9FWj
         5bYhNiZqEu4jitYk+2g8OPvjqnkVL8OgOWZxDxQ2EVlAwo7IisMlLrRiHlc0EEPYoWDM
         ahqc4KxPh5j96QxpnnTUTjpO8FwYw/f6DIarJSoxjaheg3BMev7q35MKW/fP93J+a1bG
         xD1ZEZ6kN2A8COnmg5uK5F5aXE5sVhrwQdu3ZgU6S8vjfnu1jEjJUt4y0KSLsV2yOylp
         yOuuuT4lig9wW9O6ifyyATjhXFCKmTiYE+kzc1R9gJcqAz43obaS+i7r0arRZ9xzZVyt
         UA2g==
X-Gm-Message-State: APjAAAWHnULqoQHB5WId2cDW+KF4jkSDSZ3/kv0C4fuT2HXUzj57ZxXo
        BCIJ5BquYU4TpLlyzmPTGcsciR/CwU3CwplNNwU=
X-Google-Smtp-Source: APXvYqzeK6pQ58lslgunsq8LfAiHF5MCEiVf1qhb3GRDwMe6Gt8izavzDvjKdJ8Shd1PCVwv1/qVbpOCwpYOa9vkqrU=
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr7565019ljj.84.1554473808503;
 Fri, 05 Apr 2019 07:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190401022413.6682-1-andrew.smirnov@gmail.com> <20190401022413.6682-6-andrew.smirnov@gmail.com>
In-Reply-To: <20190401022413.6682-6-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Apr 2019 11:16:37 -0300
Message-ID: <CAOMZO5DGZ1ZxW07qyJsc32kB_eUzdmF+SrT-H1hq2DeNme3iVg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
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

On Sun, Mar 31, 2019 at 11:25 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> Enable PCIE0 interface connected to BCM4356 WiFi/Bluetooth module.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
