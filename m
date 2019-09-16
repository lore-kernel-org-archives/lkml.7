Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4B4C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9776206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQOCBpsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfIPIGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:06:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45682 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIPIGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:06:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so3813852wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 01:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W+6eVtm06G2DnerzsFFEVB5vtcZxnWEKRgFaaXCgWGo=;
        b=GQOCBpsSirGcGzdEHlMBfNDzJxPmMj0OYLiV9Nis/yw5ZZOxEauCXKX8VBw8RsVWuL
         5LIF2kZ60pyykpYmXokmE8Ilnhfw2o5V13r9g2PgBApARfipqyJK51ipdgKvzhNGCXzW
         kPWg4wZkXjT/Eq4D8amfyAwabb+GpLpEPNL8/oZbsTnUpAUD+hPiS4yYPCDg8Er7QzBc
         ZPkTbUBSxFg2r1nsJ06/U6hnXMZNJtL8hnn6EIWZdCIv44z2Uk24gaZtGD+UVV4Oblr6
         bq49385yj89jPCjNCz+E1LgaanKJPjcYwqIuhZgRDvsLC1NtRol/Nd99FUPtdwCJR6Ea
         FITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W+6eVtm06G2DnerzsFFEVB5vtcZxnWEKRgFaaXCgWGo=;
        b=L/wHY6X3ska8McEDkxYNvG4hC+ei7AbTwXHzE1ePJ8ixefvbkIDdv9/GRQs3Nm5qMm
         5tFFVojI9wZ6Q43TCEKe4GMyeyGSZcwjfAXDAP2g05FrVVzplroQfUM4PnxaTJj34acZ
         7wi8XeICV7xP9oIMRGepA89xLgHg2zkb5bPtXvdlmVqS5l3UFXj9f+Cg0TutmHCGA35O
         gj0S+oCw2GU82HmvkivpMAk5u3BeA9P+BBIz1TeG5P/R7jmNAqrF4/qP48bDzZbVSCIs
         wMJFHvCwYSSUAhWFqkR6+skqdwwfPW3wlC18f7IZNzNlIX/E7lpPAX9TBNNPf46wxk+Z
         3C4g==
X-Gm-Message-State: APjAAAXLqhQUEoLH97WonE9hSCaPTiLXowOG/66tUXS/DSTU1VZ8XA0k
        XX4JlG/34Sm0VJtEGsfYpYEf5w==
X-Google-Smtp-Source: APXvYqwwzj+YBGHiDs5snINLMmedhcTe4YAqB3nspNDmWc0373N7F0SNqZ0iNwFda6g+BLVUWjyeoQ==
X-Received: by 2002:adf:d848:: with SMTP id k8mr5370448wrl.254.1568621170584;
        Mon, 16 Sep 2019 01:06:10 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id a13sm72513725wrf.73.2019.09.16.01.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 01:06:09 -0700 (PDT)
Date:   Mon, 16 Sep 2019 09:06:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@mediatek.corp-partner.google.com>
Subject: Re: [PATCH] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20190916080608.GV26880@dell>
References: <1568275837-3560-1-git-send-email-gene.chen.richtek@gmail.com>
 <be0bbf3b-76f8-9e2a-7c51-d5987263a859@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be0bbf3b-76f8-9e2a-7c51-d5987263a859@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019, Matthias Brugger wrote:

> Hi Gene Chen,
> 
> Please use ./scripts/get_maintainer.pl to find out which are the maintainer(s)
> for a specific series/patch.
> 
> I added Lee Jones, who is the maintainer of the MTD subsystem.
> 
> Right now I have no time to review the patches, sorry.
> 
> Regards,
> Matthias
> 
> On 12/09/2019 10:10, Gene Chen wrote:
> > From: Gene Chen <gene_chen@mediatek.corp-partner.google.com>

Please resubmit this containing a suitable commit message with me on
Cc.

> > ---
> >  drivers/mfd/Kconfig       |  12 ++
> >  drivers/mfd/Makefile      |   1 +
> >  drivers/mfd/mt6360-core.c | 463 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 476 insertions(+)
> >  create mode 100644 drivers/mfd/mt6360-core.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
