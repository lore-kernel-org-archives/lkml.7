Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA93CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE39B2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeDUOpDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfJZTUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 15:20:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34774 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJZTUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:20:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id 139so6780353ljf.1;
        Sat, 26 Oct 2019 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWsuoyZAPYwca/EI+O1VE1qcAi/s4YJoaszzQreRPF4=;
        b=TeDUOpDL4hTaTuuw4pizV86DSL17k4SGI2tz5Mir3tX3hbG+UF750wESPULT64i5Fa
         DEnXuPiiBBlPAk7+3ZXVu9DjESJI44nFyrewyYrgIfVjBGEeTNz67gpP4vAckxL5qaGq
         W/FoPayExUNlvhqsu8LYuua0xFky44Jr6DIaY1vi5al2roFxnhK0BbkimrXdyvkAKw9s
         Z/qUBkM7UK+Q2un4H3DFIG7ABhsTsZJrd4CGFFD8q9+YFB35nwIE5vp3siMH8+BoNzRD
         jGVqvwwi7IALYd2B+hL6eqS1Mnk2+imgEtBu/Rab3nCmpWtXMykRhNNJLMldyslLGkuf
         jpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWsuoyZAPYwca/EI+O1VE1qcAi/s4YJoaszzQreRPF4=;
        b=LC35kd+UpoZmbEUfsJLf28pd9eomjV0c2KLmCyv51HM0cSweHV0zKc4HG+Pv0Q0idn
         /NvBA9Sst4Et7TtSL5RMYne+IlA2Gg7XqNjcX1iVdMQjXlhS36SdAccA1XkL7td0OgjX
         hu3iUB7qYBe94IBrjYTuqmF2+dKz0RTbcaCNMCaYJfbYaYv6rU9JJ+g5bGZkDd/1+5lu
         PKKQWYYVFzSCgZSNggqX0+rR4b8dBFE0tkxElJdzVV5E2mEgBJvFA9Lt71to+4FcQumG
         Xh9vUeETRl948fWwOv/lO/W08xgnoc8KD2NXoqU7LUBpp1QACBuZKxrV56+6hIdI5Fna
         PNOQ==
X-Gm-Message-State: APjAAAVTkVuolj3adgTPg7xVotaDH8mEZezcSenqPOvCOsOZ81lwnomY
        Zrsbg5viAIE7cxLvVkqlvuzzDL7F4yKVgxCxE58=
X-Google-Smtp-Source: APXvYqxK5PEuDVL1bg3Au4IojFJdnipM55bXALNKVuwOG9O05h1SfUnaIBX/iObuEqHXNCOEqiNYoZMdiO08hmXs/Ew=
X-Received: by 2002:a2e:42d6:: with SMTP id h83mr6637936ljf.21.1572117609221;
 Sat, 26 Oct 2019 12:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191025082247.3371-1-offougajoris@gmail.com> <20191025184544.7gwwbsrketjtwrwi@pengutronix.de>
 <5a73d00e-397a-f4ed-2bfa-bb26324685ba@gmail.com>
In-Reply-To: <5a73d00e-397a-f4ed-2bfa-bb26324685ba@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 26 Oct 2019 16:20:10 -0300
Message-ID: <CAOMZO5CPg=mJSKNuNVFF=zGUaZqMpr9Ocv89msS-120Shc0=RA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-pico: Add LCD support
To:     Joris Offouga <offougajoris@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joris,

On Fri, Oct 25, 2019 at 6:16 PM Joris Offouga <offougajoris@gmail.com> wrote:

> otherwise Fabio made me notice that I should leave his From however with
> the changes made I should put mine?

It is normal when we submit someone else's patch and we need to change
a few things based on review feedback.

Even so, the original From should be kept.
