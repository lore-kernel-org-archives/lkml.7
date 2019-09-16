Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C33BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587AC214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfIPHtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:49:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43531 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIPHti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:49:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so631122qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 00:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnB6rF+kEoB0y/dLzKOFheHfeoq2PLYWg3/5pMHIOV0=;
        b=a1vtKIQkSg9ZSa20mc8C41mQpG1KVrJAxRD1J8U2lo2qsbmLu0q2S0aVduoMANtx+y
         zgQJtNjPX/1phT6ojR84ZRWqaBNBmv0iV65Vjal+yYfSw/dXQNeYPS20fZ/389+K6zNi
         U0u5Vg/FGM61Kn0jVXvWwrvCR6iSjKKkQXNbqkSX8d0l6xBFFdelXfglEQYDwkqb30VV
         xoALjm+SFJUJcA8fSZpeP8iXoOVUl3g+BaMHIUBxuGNrdT4C24xKPMMT6+Fk9PSc4c6D
         NrPx0FwISO0RPqllGgueIYCeniC0bzCyrL9CGXLpY5jety+N8NaGSiN6Plnf3GZH9N+5
         9gsg==
X-Gm-Message-State: APjAAAV+vNqDu7dfH4vl7Ta0c/QcU2tQCj+WIbRsdQsgNsrEjxy5cMT3
        89xJ4Oi+V1We6OrR6Q/BrUomcSoJryMOFKT1/NI=
X-Google-Smtp-Source: APXvYqyFZmHtVbkxl2VEYD0MBTCF/ulUgA/q2GShF0UOR6niQO7seRSw8CkjzspNUsZqPiPSFmIl13/oSJogmzO6JII=
X-Received: by 2002:ac8:1a2e:: with SMTP id v43mr6882713qtj.204.1568620177658;
 Mon, 16 Sep 2019 00:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20170130110512.6943-1-thierry.reding@gmail.com> <20190914152544.GA17499@roeck-us.net>
In-Reply-To: <20190914152544.GA17499@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Sep 2019 09:49:21 +0200
Message-ID: <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Jan 30, 2017 at 12:05:06PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Hi everyone,
> >
> > This small series is preparatory work for a series that I'm working on
> > which attempts to establish a formal framework for system restart and
> > power off.
> >
> > Guenter has done a lot of good work in this area, but it never got
> > merged. I think this set is a valuable addition to the kernel because
> > it converts all odd providers to the established mechanism for restart.
> >
> > Since this is stretched across both 32-bit and 64-bit ARM, as well as
> > PSCI, and given the SoC/board level of functionality, I think it might
> > make sense to take this through the ARM SoC tree in order to simplify
> > the interdependencies. But it should also be possible to take patches
> > 1-4 via their respective trees this cycle and patches 5-6 through the
> > ARM and arm64 trees for the next cycle, if that's preferred.
> >
>
> We tried this twice now, and it seems to go nowhere. What does it take
> to get it applied ?

Can you send a pull request to soc@kernel.org after the merge window,
with everyone else on Cc? If nobody objects, I'll merge it through
the soc tree.

        Arnd
