Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021E0C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C519B2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVCeUOih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfFYGa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:30:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43115 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbfFYGa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:30:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so16384702wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x6yoOLge1MbtgvEjH/J5jaBEOcfczijGo4VV4KhuiO0=;
        b=kVCeUOihCb+2UQgI9Nlb557kKSPReIfQ/OqOsRDgSFyC4Addjdo5FydjKaKx/tfHKQ
         2C2DXms6KgT4ceP8Szn1fTWbP4n++BhKCH8XI/AcPNdU61x3Z1y9jf14jkErqFnnlF87
         w4OA0O4N7l/91fhFSKHottpNXZ0zEZernlK+MEqQMKRdHjoileYXvpIFqCTjiUmPe5IJ
         ANAoRMALZL1KYbXiyVW/Oq5Sb0XHfFTMnielWt1mi67shBAE42WFau4VOMzMj8L2oWxh
         pVBCLvDBkeKAXYNbiecAw0oJyaVlxGwauSa47Q1GkrFiA57JDiBEAz5NMswD0CLYBmhc
         hfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x6yoOLge1MbtgvEjH/J5jaBEOcfczijGo4VV4KhuiO0=;
        b=NeXQ54NrdDJCoFAl6zRHVekce2MNZ9C/7baSsJaHfVC3Zix5rUzYdUu0AIVL45t/Tp
         MtCi0wHUK2oERKVoaDKa5gvmCZVjjAli7KPAlWwxgDz159lbdMGubZ6snx1g2dmJW+W4
         DlnpvqvjjdWBA5uCvvpM/AStuO06l2gnSCcEJfxaFGh48OnJ+AiSGkJafdf+zW+8SNCp
         FqeFBXDZh+IKNSDSXvo2vVyUFWDxxPrVWeRdHF2puW1c73v1mBZ1Wjif004ve9QIXS/h
         6MSTCyd3rng/dOkwBHbRExS6YSmxOkB96Eq+kcNIXU1C4cbWHACpvq7XE9FGkagpWSe2
         sAXw==
X-Gm-Message-State: APjAAAX6oLxhhX1Twf9wCbyHryOjs+SW9GSjvxtlridOepFLtMoUcuLm
        CKDiLJQ1sJDTkQfo0HM9gf+CWQ==
X-Google-Smtp-Source: APXvYqxVi7ekjFNL5CEovpagDv1xhsUAPchxMQqebKHZbVpFnJItx8zjOM+tCHOAPjJGWJ7zRznalw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr95136948wrr.5.1561444256592;
        Mon, 24 Jun 2019 23:30:56 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id a2sm3431994wmj.9.2019.06.24.23.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 23:30:56 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:30:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, broonie@kernel.org,
        lgirdwood@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] LM36274 Introduction
Message-ID: <20190625063054.GD21119@dell>
References: <20190605125634.7042-1-dmurphy@ti.com>
 <20190624144217.GJ4699@dell>
 <3d2aa88c-c21c-b3a9-c8d9-fdb3a8fc3858@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d2aa88c-c21c-b3a9-c8d9-fdb3a8fc3858@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Dan Murphy wrote:

> Lee
> 
> On 6/24/19 9:42 AM, Lee Jones wrote:
> > On Wed, 05 Jun 2019, Dan Murphy wrote:
> > 
> > > Hello
> > > 
> > > The v5 patchset missed adding in the new validation code.
> > > Patch 1 of the v5 series was squashed into patch 4 of the v5 series.
> > > So this will reduce the patchset by 1.
> > > 
> > > Sorry for the extra noise on the patchsets.  The change was lost when I converted
> > > the patches from the mainline branch to the LED branch.
> > > 
> > > This change was made on top of the branch
> > > 
> > > repo: https://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
> > > branch: ti-lmu-led-drivers
> > > 
> > > 
> > > Dan Murphy (5):
> > >    dt-bindings: mfd: Add lm36274 bindings to ti-lmu
> > >    mfd: ti-lmu: Add LM36274 support to the ti-lmu
> > >    regulator: lm363x: Add support for LM36274
> > >    dt-bindings: leds: Add LED bindings for the LM36274
> > >    leds: lm36274: Introduce the TI LM36274 LED driver
> > > 
> > >   .../devicetree/bindings/leds/leds-lm36274.txt |  82 +++++++++
> > >   .../devicetree/bindings/mfd/ti-lmu.txt        |  54 ++++++
> > >   drivers/leds/Kconfig                          |   8 +
> > >   drivers/leds/Makefile                         |   1 +
> > >   drivers/leds/leds-lm36274.c                   | 174 ++++++++++++++++++
> > >   drivers/mfd/Kconfig                           |   5 +-
> > >   drivers/mfd/ti-lmu.c                          |  14 ++
> > >   drivers/regulator/Kconfig                     |   2 +-
> > >   drivers/regulator/lm363x-regulator.c          |  78 +++++++-
> > >   include/linux/mfd/ti-lmu-register.h           |  23 +++
> > >   include/linux/mfd/ti-lmu.h                    |   4 +
> > >   11 files changed, 437 insertions(+), 8 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/leds/leds-lm36274.txt
> > >   create mode 100644 drivers/leds/leds-lm36274.c
> > Can you finish of satisfying everyone's comments and re-send with all
> > the Acks you've collected so far?  If you turn this around quickly,
> > you might still get into v5.3.
> > 
> 
> The changes were made by Jacek and I reviewed and tested them
> 
> https://lkml.org/lkml/2019/6/11/455

Ah, this was related to the recent GIT PULL craziness.

Thanks for letting me know.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
