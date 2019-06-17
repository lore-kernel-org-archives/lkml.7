Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FC2208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dta4Ditz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFQRYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:24:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38912 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:24:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so6044415pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y6eoqXX48AC4b/1BAfJLRGGO77bOmgiz3VWkyz5cuoM=;
        b=Dta4DitzBZvBuK5H9Se3nxho4a24pUGIATMd0wHa75FwvPasTJvbM/I1q0oxKeGAeY
         BqNWqe3+jb7xxqttxLcpBw9aMVYMSOUfC2VkJboI8Gk6PgC/9xRNVPgU6tw7ztyN3dVq
         bgx4SU/jTTNPruE2mjcROWKwDV4dWB5sFRnsuX0kOhVEohKody22hP0TNkzrVD9ig7x/
         cpbOQAExjqshadJTyCHfoULi9MnbKTskDw8Q/IG1RsUXq0HAU5pcz2gS/8zc0xXQolWD
         WDCi4m6h8lmeZrxFXWpriphaiMjU7sjwrzHKiXaGcmT2ljuunpIpeTeQFYdZtfREIE2p
         /yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y6eoqXX48AC4b/1BAfJLRGGO77bOmgiz3VWkyz5cuoM=;
        b=jikVh2S9MVn+LWwlDGbVZHfvtRghhMLrdbbF/ti1rVy3/R6hwfTOYYs7p7S4qRpV10
         JJTCFu/z0YcRQUXW8R4FFU/Z3/w2pID/kGZMnH0A9lz3NYAhduaBNxRVdP6vRs8mdK92
         bbPgukfCgFelrNyeyG96UB1DnLvNh/IgyFuUTmAPoXxlQwcn9sjEksc79PHGak+qVD2A
         OWwOrlQgU9SVAHbSdgoHJxDtGOVLY/p+kaR/jDnaXsaOjy4GlRn5qSLGyDKJ3Tsyxe9/
         GJGZj0Fg8SbKVAjHnrLTYMLRR2hPsV5q6untQKBUJ6ujKcd6MoaqkS2RsHG4B06f3jGr
         DAhQ==
X-Gm-Message-State: APjAAAXy1OIJs14eQU2d7vBjsjvw82HOIZVTT0zo2UCzUkS3OPIF/zI8
        IWRS5x0k1nATO+BonWSffUbP
X-Google-Smtp-Source: APXvYqwjw0cYF4PF9C19Mmd/+R+HHKi/qreGcmQqREBD6uZbrofk4ANRNg3hPIdexnhf5sRkSWb9Iw==
X-Received: by 2002:a63:d458:: with SMTP id i24mr40457671pgj.171.1560792261503;
        Mon, 17 Jun 2019 10:24:21 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:629b:c246:9431:2a24:7932:6dba])
        by smtp.gmail.com with ESMTPSA id e22sm12717838pgb.9.2019.06.17.10.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 10:24:20 -0700 (PDT)
Date:   Mon, 17 Jun 2019 22:54:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20190617172413.GB16152@Mani-XPS-13-9360>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
 <20190617163015.GD5316@sirena.org.uk>
 <20190617163413.GA16152@Mani-XPS-13-9360>
 <20190617170356.GG5316@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617170356.GG5316@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:03:56PM +0100, Mark Brown wrote:
> On Mon, Jun 17, 2019 at 10:04:13PM +0530, Manivannan Sadhasivam wrote:
> 
> > > > + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > > You definitely didn't assign copyright to your employer?
> 
> > Yeah, that was intentional. This work is not part of Linaro working hours and
> > falls into my spare time works where I'm trying to complete the upstream support
> > for Actions Semi Owl series SoCs and target boards which I'm co-maintaining
> > (sort of)...
> 
> OK...  seems very weird to use your work address for developing on
> products closely associated with your employer in non-work time.

Agree. I was trying to setup my kernel.org mail address with git for
unofficial works like this but haven't done with it yet :/

Regards,
Mani


