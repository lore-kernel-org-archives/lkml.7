Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D050AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AP439BzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZRB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:01:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36425 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfDZRB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:01:26 -0400
Received: by mail-it1-f196.google.com with SMTP id y10so6883529itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zDIZQ9ehjNOQSUbZQgzdpHMfF6sVsj/oslNkVq4cSrY=;
        b=AP439BzAHjJKyAid09DT103cdZDtF9UrIhHFn2Pt44VgL+IbSW15o1KwPQqYNy0LpU
         qLX7aOtbMaw2JewrDg2e/3Cdx6kVRMmzV8PkU0p2GGinJ3rpWbP5/UyllZzF+UsH5OMk
         D0wnOFHTOTklPo4a1dsAGd2yKBJRY73MIYrYcfkxG7LN4KvVdobuEjVJbc4wF4YK50kN
         LSGSeS1o3FNENzRPgB2SXAFCcmrN+rXz1PoFZ161N6+EL775INq8o06VvLJrJw7LhktX
         3Ho0hpz3NcIfZrnncbBYxLN0BhGsJ8Kwq08/YbeudM+isW27iJaOBO4bXzk4a+hiJqGt
         3zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zDIZQ9ehjNOQSUbZQgzdpHMfF6sVsj/oslNkVq4cSrY=;
        b=r2gk0NoUINp3BgKMMgZbl91tEXOLpenRrXaH2wzKrOURT5Rx7nAIetTISnjUvhloh0
         soJQAK8nMCxze6z7iWwh4nf/JQAszWvJyKwAOHAD3BpwzCVg7hmSGf+pFJSX7rTyM6j6
         VV4EmTAD7vu/A/LEqZnbZW8oRJpZkrkWlTpHl4tO1y/TtvXx5DvwKsYNA1I0YRKSYke8
         8OUvFXnl/AkR8+uHk06iAxk5bjcf3ROZskbGZUl0QhE6c8/k433rxNakce7NHW1A0KaY
         gOcLJmVnJXmVS3zE8AxMlRiH2Ez8rI4EiR9NnnKzE4CpSukZJIEbjK1vgKR0H05Z11KG
         5dkg==
X-Gm-Message-State: APjAAAXTZcLXX4kz52zupTd8PBPKMXdnDvFhSXz7fqkfikXz4Pgdc8QS
        DJJW2P9BpHWCHtuesx1ovHI1eg==
X-Google-Smtp-Source: APXvYqwbG6fHNL5fErzNNkXgu9Hs1MIDmYaGtcDj67ArLLjXDisa5LhrqDJcfgJBSkXwyuFQoNwpdg==
X-Received: by 2002:a02:5143:: with SMTP id s64mr32790119jaa.54.1556298085393;
        Fri, 26 Apr 2019 10:01:25 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id n15sm8746976ioa.26.2019.04.26.10.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:01:24 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:01:23 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Stephen Boyd <sboyd@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com
Subject: Re: [PATCH v3 0/3] clk: add driver for the SiFive FU540 PRCI and
 PLLs it controls
In-Reply-To: <155624271876.15276.8637203698438742304@swboyd.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.9999.1904261000090.28496@viisi.sifive.com>
References: <20190411082618.3502-1-paul.walmsley@sifive.com> <155624271876.15276.8637203698438742304@swboyd.mtv.corp.google.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, 25 Apr 2019, Stephen Boyd wrote:

> Quoting Paul Walmsley (2019-04-11 01:26:16)
> > clk: add driver for the SiFive FU540 PRCI and PLLs it controls
> > 
> > Add a driver for the SiFive FU540 PRCI IP block, which handles clock and
> > some device reset control for the SiFive FU540 chip.  Also add a driver-
> > independent library for the Analog Bits Wide-Range PLL (WRPLL), used by
> > the PRCI driver to monitor and control the WRPLL instances on the FU540
> > chip.
> > 
> > Boot-tested on a SiFive HiFive Unleashed board, using BBL and the
> > open-source FSBL with a mainline-focused DTB.
> > 
> > This third version incorporates changes requested by Stephen Boyd
> > <sboyd@kernel.org> and Rob Herring <robh@kernel.org>.
> > 
> > This patch series is also available, along with the DT macro prerequisite
> > patch, at:
> 
> Can you please send the dt macro patch along with the rest of the
> patches? I can't apply these patches and build them without it.

It's upstream now as commit 6ec4bae178d8 ("dt-bindings: clock: sifive: add 
FU540-C000 PRCI clock constants")

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6ec4bae178d8a1e9814eb3bfdd321b0475de0468


- Paul
