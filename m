Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65921C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB1820644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bw7MDNV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfFYRb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:31:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41831 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbfFYRb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:31:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id y72so9291983pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cyylc5vV7TsZGRDCyy7xYsgD/ATtR25Cso04lfIPhzc=;
        b=Bw7MDNV5DpVOVq6ZsemLGJdp/8bE62eloGpw6B6Ewtu1fnalKbBFSV8P/w5xzliMo4
         G1lYQ8FEww9Lh5Frfvnb3KbqG/Hw17/Krc3kHt+w6sLrMmk7iIR1om9tYD+HjpqQsOTl
         epslcpbau6xLSLm3E3FOfJxAXpEON+d00o1CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cyylc5vV7TsZGRDCyy7xYsgD/ATtR25Cso04lfIPhzc=;
        b=l/dxerBcOdZlSiL0115BVT2gI6yprO+pqjNQx7xTjk2XXO4ObSB9HEvNYUcmgTVKi/
         BNuuM5R73YirjHuN97YoClby9xHde/B9D2p1M12DgBlxVhn/LyedHBDSq/tdjozAP4CE
         RkeqmPM6BWl1zLTPyji4qEvz22WEWs1K0+Le/E3QT72g6Q/mPC2lHYSb0rM6Sglr0yos
         EtV0FubGrFIDonWB4kaDmhdJD+rY10G0tcoZa5t5ZVkIj75jJ3vJniBVfdQO7VfYtIqg
         n8T2/EhuxqKC45KtOCY2CZIrp14zZ+FvXprF77UZLudr26GGawIRulS5iewNjNcc/C31
         996w==
X-Gm-Message-State: APjAAAWEa/j7K/bCzWSpTzDlLgLXeyLEGFzbfi7KXMRbqXSSmUlgU509
        jk7RUwXx0pqHrH70fZTuMEoTtQ==
X-Google-Smtp-Source: APXvYqyKVQEdx2DSisDXree3EW2eyfv9LAskBegykfDifXWazmrgiKraekkPr5majzLrVW1Vhcny7w==
X-Received: by 2002:a63:7150:: with SMTP id b16mr1030790pgn.328.1561483887787;
        Tue, 25 Jun 2019 10:31:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x8sm14704810pfa.46.2019.06.25.10.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 10:31:27 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:31:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] video: fbdev: s3c-fb: Mark expected switch fall-throughs
Message-ID: <201906251029.08B862130@keescook>
References: <20190625160103.GA13133@embeddedor>
 <2bdbbd7909c5c4ad96d32c0c5be4690292132a34.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bdbbd7909c5c4ad96d32c0c5be4690292132a34.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:52:23AM -0700, Joe Perches wrote:
> On Tue, 2019-06-25 at 11:01 -0500, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> []
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> 
> Just enable the thing already.

Linus has been pretty clear about not wanting warning options enabled
without first fixing all the cases it warns about first. If that's
changed, then sure, let's do it; but we went through a lot of coordination
with sfr for linux-next nag-mail coverage (where maintainers are now
fixing it themselves) when this came up during the last kernel summit,
and this approach was the agreed solution.

-- 
Kees Cook
