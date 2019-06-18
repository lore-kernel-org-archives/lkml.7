Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F03BC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734542070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="T1wUG2r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfFRK7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:59:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33645 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:59:24 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so28822755iop.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDeuVf27dsWWQyi/G9Z1cR/nnFqjHy2XRRgIkWDwa+w=;
        b=T1wUG2r/CYW88UkEOUiQ7rn3R1tausZPc1kdqBEQIfxIQ9SSbgVOaTVYT/BDN6Z0Am
         hYXDY1Zib0Da5pwz+bxOXhsIs1AC7/iyzbrD6oihoif/2Rnd+FaZFJQYpHF1VLgYpKXo
         O6tD8pDILAHb9l68gGlzhLCUoZsRZY4jOGlPY/Rn2nMREMwL1N+U2BidEBPQUNfXWUYz
         2NkneM3j9QBpX2/lr9Rzjo9cX1ohCBkXmbjI8Vb0X8uNy0cTN4e8NwQedi7v+OHHRoZL
         4sBXCMpNc3bqtjIMZ22yHkjrRzfMvvcVrzyQc5JTtmBsGspb8vHTNwY1Yq5c0W7aSHhz
         223Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDeuVf27dsWWQyi/G9Z1cR/nnFqjHy2XRRgIkWDwa+w=;
        b=kLWtU6pJGgmDzuQt7nBWK4gNRvIoLd/nxGBUcKx3oFLRpFwqb5PV66j3m//YiMFpOK
         8K5vDAgyQLlpTvIas1sbVkszxpP2x8j04QSzIKlxRQtxPNIihpCu3yf2FZAT0x+/l10Z
         L+x00vgwQOG5w+VuG4k0kiXYYjezXBe6YmVeebSCwVqwjXGsXenFpKPbV63WMrhTmDKh
         pH9Ky5dUSpiPsLXY6+SFFkit4owO0DBSp2cFeEN4gIIl/I3Qn+mv0wNw9H05url2D8Zo
         ShkPUC2e91guAhUZw5qHUVTHxZ7s9z7ZP+bT2i8hw+PBJG0lUvMdjPsnPue4dLD/3Qzq
         YG6A==
X-Gm-Message-State: APjAAAXO2oyXD8A3evRB13xFjVxy5p65AgnOClTD9eX1ITtpdT4dg8RE
        Msai9OOnN++odNdBp2H+YlKr4dusGhF137uQR4waPQ==
X-Google-Smtp-Source: APXvYqygUc9NtkUKqHAZsrJLDcE1z7TbO5n2M0BkA4Kg2xoRZpQqn8fUKR360iFU7smgRnci3PL6o8QOmteT2MwzdH8=
X-Received: by 2002:a6b:9257:: with SMTP id u84mr2859483iod.278.1560855563794;
 Tue, 18 Jun 2019 03:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617123352.742876-1-arnd@arndb.de>
In-Reply-To: <20190617123352.742876-1-arnd@arndb.de>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 18 Jun 2019 11:59:12 +0100
Message-ID: <CAOesGMjEwQw05g7ARDddQNgfnuk9yUXkmVz7BTOEe8FKknSL4A@mail.gmail.com>
Subject: Re: [PATCH] firmware: trusted_foundations: add ARMv7 dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <treding@nvidia.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The "+sec" extension is invalid for older ARM architectures, but
> the code can now be built on any ARM configuration:
>
> /tmp/trusted_foundations-2d0882.s: Assembler messages:
> /tmp/trusted_foundations-2d0882.s:194: Error: architectural extension `sec' is not allowed for the current base architecture
> /tmp/trusted_foundations-2d0882.s:201: Error: selected processor does not support `smc #0' in ARM mode
> /tmp/trusted_foundations-2d0882.s:213: Error: architectural extension `sec' is not allowed for the current base architecture
> /tmp/trusted_foundations-2d0882.s:220: Error: selected processor does not support `smc #0' in ARM mode
>
> Add a dependency on ARMv7 for the build.
>
> Fixes: 4cb5d9eca143 ("firmware: Move Trusted Foundations support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to arm/fixes. Thanks!


-Olof
