Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B2C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7BC2789C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 09:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFBJEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 05:04:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45154 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfFBJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 05:04:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so4184263lfm.12;
        Sun, 02 Jun 2019 02:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRCW1o4GdnDTTwiENrsOUXxx3rdgPikwY37hABnif3E=;
        b=etaQJjuax+yPTkcvPdWmpeLaxdfEGAXPfyIrRXDglyEQIyVnA5zQan50KeLm8F0wHM
         qiORht5DbSb1+cGSwDGvsnFn2udmzuxBadiZexAvU4f7W+4Jwngv0wowr2I+g++D9rdo
         K7KwuwBDk6Z9CGpLD+RhSCEOMeRdwz84rf1XQQ+oF8r8bPWfuIr+ItEtV5+A2L2Neiir
         8CgPrK5hzLLgHPqjr+SkNMJaocpT7TmV8mZbV3KmcuJjZ11lIqI1ISy8+47ZBJmf6vyN
         ndnZQrpyyd8OBW7IqXGxn08HQAeBqnFxQ4mChQiry1xZcC9w8NFDvOi5ksOSrXHWfXcD
         QhqQ==
X-Gm-Message-State: APjAAAUKmgJ3V9iWHoBJ53dmZ98hNsOZ9jD+MNwgNy8vfK1CU+kPvrcy
        H++AiM5iNHa2wV7o0qMZexJEO11tyFG2wSUweas=
X-Google-Smtp-Source: APXvYqx4R3CkZ66/i5qLA/4ODaVt1vONSi/4rrdmsiYdDOOlB/HAeTuNDypKunxR3+HarPEimeyV0wVERXodVvNSMGk=
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr10710134lfm.87.1559466274493;
 Sun, 02 Jun 2019 02:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559438652.git.fthain@telegraphics.com.au> <a69c9e248f46f02a2cdef95e2ff3d3b08531c6fa.1559438652.git.fthain@telegraphics.com.au>
In-Reply-To: <a69c9e248f46f02a2cdef95e2ff3d3b08531c6fa.1559438652.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Jun 2019 11:04:22 +0200
Message-ID: <CAMuHMdXbJ5kuPxLKOR6v=-98vzJxoiduVkYfK0EeWze7tm5uVw@mail.gmail.com>
Subject: Re: [PATCH 6/7] scsi: mac_scsi: Enable PDMA on Mac IIfx
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sun, Jun 2, 2019 at 3:29 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Add support for Apple's custom "SCSI DMA" chip. This patch doesn't make
> use of its DMA capability. Just the PDMA capability is sufficient to
> improve sequential read throughput by a factor of 5.
>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Joshua Thompson <funaho@jurai.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

> ---
>  arch/m68k/mac/config.c  | 10 +++++++--

For the  m68k change to go in through the SCSI tree:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
