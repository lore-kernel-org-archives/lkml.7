Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E09C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82D32087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZMOn8qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbfC0LRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:17:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45733 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfC0LRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:17:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so13978760ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5DCleKt9QkbGobITzNIH5rgVcLi1SuQghuCjb2U1JiU=;
        b=ZZMOn8qal027/dhlnt5f9KIJr3F81fPp6T6QmFkAYRy8zp7lWQsD5xMSPnOAj6gixN
         o4leAFdeYxf0SXs812/B80vXyDnZUb8NsZzGaf9tqNj9wRJjh817+QMTzv8tFA4xFffL
         7Ptmep7pcMf1XAdV4a4FtoIUo8TIcOo5RNczgbWdijQX4gMwzebOJ8pamjDwOJjQaOto
         Kk9zVVVUcdnEZ9+nA37fGCckT0ByBxXa3seNpmyZeim0LYJxrZdFhw0wjMbaKwIEmKun
         Vq9W8em9d9AbWh1WMod4xk/cnOEkrSp+hbNUcRZgW5ChsJR10GzznLK02W+vyd4/xA+1
         FbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5DCleKt9QkbGobITzNIH5rgVcLi1SuQghuCjb2U1JiU=;
        b=DoxENnw9XAYhWoQFkavAb7IJsJclqQGSdPakUobGCJ8FSZzmTEUNkScxE1tDMiwWhF
         WvTBAMHKe5unQHq/wmG4QMEBHJWijLILa+/HRDe3bAzku846WQCU9b0PQaE3Yu2MgYMa
         kq4kT3tCzQso9iJpB0U3inmhJqwm2LoYynv+1RGWZa5Z0rS+M3pCm+b0n5d/piVGWmLz
         rDGym9dOf3d2Z2D2goPKe89GPFhesCWmQeTQfc4E9Qa1FaQz0splahGrUS4e3U93eJXA
         ZY+HX4a99lk9qbM9H/dn/VzUm8dOsnlN89FZ/3e7FHTYqmnaogtdtHt6gmroWv00nXda
         focw==
X-Gm-Message-State: APjAAAUuGTP8xg8gwSgkLdhS+aIaGHyTeYhlC7emIqnfn5gZCT/eb/rl
        aE0ud07osn+p9GWI95QNfx6khu7Wrxn9JYUT9EU=
X-Google-Smtp-Source: APXvYqxyEVEyIR9UMgM7SXpM+fOpN5yzJy6nVzz7uadACqXXABbexOFxJTjdWOu66y4jgRNKJLPaRY5voi/k5HvC0m0=
X-Received: by 2002:a2e:9812:: with SMTP id a18mr14155093ljj.146.1553685433883;
 Wed, 27 Mar 2019 04:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190325050100.29517-1-andrew.smirnov@gmail.com>
 <CAOMZO5BOR2DS-w3oOHsT_hTttgK=OPQZYwUywXdZFLRzbrb6Zg@mail.gmail.com> <CAHQ1cqHGgJMWMFx04fEzhzONPUrbjqD=3yPEyFsE=XGJDbJjmg@mail.gmail.com>
In-Reply-To: <CAHQ1cqHGgJMWMFx04fEzhzONPUrbjqD=3yPEyFsE=XGJDbJjmg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Mar 2019 08:17:03 -0300
Message-ID: <CAOMZO5DkBp=BbgcBbktGYMun1jiXKf5aJFPO1L2YUghB-UQoHQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock
 for SDMA
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
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

Hi Andrey,

On Tue, Mar 26, 2019 at 11:52 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> I think it is worth fixing in DT, regardless if we do anything about
> SDMA driver or not. I'll add fixes for 6SX and 7D in v2.

What about imx25, imx31, imx50, imx51, imx53, imx6sl, imx6ul, imx6sll,
imx6ull, etc?

If we plan to fix the DT files, I think we should cover all i.MX SoCs then.

Thanks
