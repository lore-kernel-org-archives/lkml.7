Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A246CC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57321850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR41PYpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfGEM00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:26:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43169 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfGEM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:26:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id w79so7016767oif.10;
        Fri, 05 Jul 2019 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60adLkZbywPEuKsZCLqNo80zya9muW5FO6I+W0n23fY=;
        b=gR41PYpJoUr4wNhUj+7pOS/whyCQVlB3Y/FyW0MXD2QyAPmFIaSnPr098/+LTqlkaF
         UbXq0mYJxABiIJQ3so7RJcyrf3LxVOOhasmetOHb8+QYHEy/2oifmyt+2t4a9mGC2ve1
         K9Aa3Qr8DFM4YgqrWExIPCc+mCc929pXBJcazbnKwUpHfkH3EY5Zqd/VH6xjqOUklZ7v
         PB1Nj3kVv/30co+ycIaMtFK+5h/shWiDZ85EQV1w9nfGxSVdLOUe6sbpa8xqYHL8MwQR
         YsIK6mntMv+DvJywT2Z2CQVtFUAC/NO/9KtXN+AHYh/yx3dXTSBrJdEFgqJ9GvFxzeWn
         fUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60adLkZbywPEuKsZCLqNo80zya9muW5FO6I+W0n23fY=;
        b=oLiCvAz9hyPFyZD7ZxSnBnd0j2t/EXgXyVPvlzwNIeNjLOKvJxn0tv3+9NpFJokLtM
         DkFi+fL9U81bDKt5T9dPoWlAzwff9HFMQ702WF2+lmYwjJ0GpfMwB1hIHeFQ7kPXkXTM
         4X4M0HjbI8eHiwgUQESNoUqiAOq/hc1k+gs79UGB2uRVXbPTuAwL1Ud5liDupkvOsG0d
         fJQtDJ11Tm0KyEBQp7mq/21Mz3+KgytkZMylODU6OVmgzcputCoMsqf6vD2cn28XALbx
         2LBUB/CsMYm4X7ADaOPeKzP60eInUNbzGFrPRpFPsuku74Qfd5G919A2c5OzwWiC8eCz
         p2Fg==
X-Gm-Message-State: APjAAAVEyYsSgFOs2lPbDfoyLooMtMh/PV04HUEPyDZD8CJCCuPXQT91
        zbK94gPxKQPNaALbPDDc/AijnsPHF8kUNbqd09Q=
X-Google-Smtp-Source: APXvYqySiSmBKjmMw33BQAZIcvRHSfEaWhuwsnn5aoM4/Gm2bIvNUsuuNGFU+OG8Pfy+n9z73RhZ+f/DsrJ8XacvS3A=
X-Received: by 2002:aca:cf0f:: with SMTP id f15mr1784578oig.169.1562329584866;
 Fri, 05 Jul 2019 05:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190624140731.24080-1-TheSven73@gmail.com> <20190705072847.GA2911@vkoul-mobl>
In-Reply-To: <20190705072847.GA2911@vkoul-mobl>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 5 Jul 2019 08:26:12 -0400
Message-ID: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error path
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Fri, Jul 5, 2019 at 3:32 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> > +             if (ret)
> > +                     dev_warn(&pdev->dev, "failed to get firmware name\n");
>
> if should have braces!
> Applied after fixing braces!

checkpatch.pl output after adding braces:

WARNING: braces {} are not necessary for single statement blocks
#102: FILE: drivers/dma/imx-sdma.c:2165:
+ if (ret) {
+ dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
+ }

total: 0 errors, 1 warnings, 61 lines checked
