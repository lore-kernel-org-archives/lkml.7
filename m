Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60E120818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQiOlIKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbfHFMlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:41:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46037 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:41:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so62772669qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3j7GHBDsYZqcSC8c4X3v5Uqt8dzZQfTUO2AFNMReDw=;
        b=FQiOlIKSS0eD3TNtMvXsXdQcFHSPt4S2/O13HOgIQF3BBpPJEmNhphRaVESxB+/v5C
         5qBKNPqAnIj4ckp9pVzB+X1YH4IRmRsnQakvc4frqPJDe7skXyviwbRSZdePcurXFtit
         oxjolhSUD1cakBBxKrDx9RBqbke20Mi49ynO9U1QqWWooGBS+MUZ4xFkbDqU2yxb3HO7
         BW5iBjS+8k/QajGvHuy8V6TrXCrTBwVpUmgqImFyVQbjhHfT0WTImxnJ9vTxADZIzNNq
         Cy7g42vqtxjAzrmfVgDuIjTO2G7d0JJDjSEgJkcLFpRLqwPKzhWyLFG20xWlOKi1pa5M
         Y+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3j7GHBDsYZqcSC8c4X3v5Uqt8dzZQfTUO2AFNMReDw=;
        b=sKLgS6CDTs4AuzQm40RU2k4/iPrd42BsCEo4WKvjxequ4D/y+TSp2otsnkNIyEz+gH
         xvwFyD8NU/TmRACE+OgFrTAJ/VkfA5x5Vvw7yR/Ks9Q0ENmGW0AGbAfjXcZjUkB9nX0p
         VP/jkP0gaGpYvYkR6ad4HUV4ODp4q5s1cmN5/2qjX3cx5H+SDhRnOo2z9NYQHyqN6/+C
         w93nD5vY+naqUN7sPFKNSMexT0viJarOrxddr9EVI4oynK0sp9l7/zxQTBtLchOAuOWs
         QRhDIwR5uYAja1jMmT6bji0mTfA9s9rLhKBBEs/RTeDDO2DvujMbo4jJLYaW3zhZj029
         XJhg==
X-Gm-Message-State: APjAAAV4NZMG1hVBDO+n0M+yk8KsrlFl0eHUrrABrVyzxC0OuJnbVGgx
        q+YLGP0/+62IORIPF8BDgF+Tn3KVxQq5j7LDgqU=
X-Google-Smtp-Source: APXvYqwzNqb9edIQMJJtQ4zXYoFI3EmafHysUGgbYIqu6baWRHFYOyvHMS2DcqHFT1zgAp/i0ioY67vWj8f9l/lAoJM=
X-Received: by 2002:a37:9a0b:: with SMTP id c11mr3085312qke.204.1565095290395;
 Tue, 06 Aug 2019 05:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190806030718.29048-1-luaraneda@gmail.com> <20190806030718.29048-2-luaraneda@gmail.com>
 <17a45e21-8362-e888-d222-812c879a38a8@xilinx.com>
In-Reply-To: <17a45e21-8362-e888-d222-812c879a38a8@xilinx.com>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Tue, 6 Aug 2019 08:40:37 -0400
Message-ID: <CAHbBuxosAnWdpee8jS7feR06+KF_PjOiTF2+PsiMnMAjwfUFKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: zynq: support smp in thumb mode
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 6, 2019 at 2:39 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 06. 08. 19 5:07, Luis Araneda wrote:
> > Add .arm directive to headsmp.S to ensure that the
> > CPU starts in 32-bit ARM mode and the correct code
> > size is copied on smp bring-up
> >
> > Additionally, start secondary CPUs on secondary_startup_arm
> > to automatically switch from ARM to thumb on a thumb kernel
[...]
>
> It is really a question if this should go to stable tree. It is pretty
> much new feature.
> Will be good to also add link to similar patch for example this one
> 5616f36713ea77f57ae908bf2fef641364403c9f.

Ok, I'm dropping stable from CC. From the previous comments, I thought
that the two patches were part of the same fix, but now I realized
this is a feature rather than a fix.

Michal, do you want a new version with the link to the similar patch
or would you take it in its current form?

Thanks,
Luis Araneda.
