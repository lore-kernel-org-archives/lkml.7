Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3878EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 05:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0017620869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 05:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve3DLFov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDUFmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 01:42:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32995 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfDUFmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 01:42:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so4412830pgh.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JOTJduBw8Kbj981+gHoyU+cGs+zjrK7BpE6zdFadBbo=;
        b=Ve3DLFovFLk4u62BN4fu71K6Y+OXozDMijEJmJYIjPBvKv66ZAvBQ9B59e+9gMWJ8c
         f2jeRq6/IVPrssctq3keciot6uVpfrB8CYCkHD+cwzOerADkvPsW+sIwm9azGWFNHOfh
         z+F9VOPxsZ2+Xlv5v26s+ylgsQSzlh5yRLFko9qE6i9Txtlru78akKt+FHrmgWguHikx
         e6DaR9/XLB0PeZ4QK+m3aCe0gqbA5JZ4RKex2SKsxGYKVSxg66tRwTuS5zqJ9Rs25dRh
         UW39rWLriQS1lXeSWf15LfO1lwqww/VkpQ7A9uoFR61dk6DP0z1tE2/V0cbdwiNGdFkc
         eRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JOTJduBw8Kbj981+gHoyU+cGs+zjrK7BpE6zdFadBbo=;
        b=SDGpp6jmw7WWiTlWKaIflBjNtYaBU1o08VQ50/gfsw7+nH2fI08BAxI92RcUR1z1B/
         0HHNdU87Z8GoZ0uI9tTNeSBuG4xj01oH8zY35NU+VuuYA/opQNKwsg1hw1BbTH1B6dfX
         KYkeoXrdl1N3KguhMXOe1pKIQWtGwlUc4dEcdKKN/eN19ZxzUIgGVg4W+fEKHX3nQUTZ
         s45vQ+68xHK6fa+ez3OnE1dtTraafn1kqR8iRbARDMAWhYHiliQXZa51FUvJR4jvFBJy
         udSo1XIcw6KKurtgbrAy2WLHSnwFr4bFnQ0j1V28OJ+jv6/PiZfYgEQnumQoDjAvpQJI
         K7ww==
X-Gm-Message-State: APjAAAUNK7vaFgYAubGzSDomJVE1Yvfb9+WL6kEDzfwhuMQpRbh3PHWS
        DJdO+RiCC8Bv8XjMlrJmmmU=
X-Google-Smtp-Source: APXvYqxN39rpPzoz2ICYNYsd/xJ1W5HMYxuCAYUiE7h9p14Wmi4kCZyxQv+G6fjWwnI6683IGakemg==
X-Received: by 2002:a65:6091:: with SMTP id t17mr12473447pgu.328.1555825340556;
        Sat, 20 Apr 2019 22:42:20 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a6sm12491699pfn.181.2019.04.20.22.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 22:42:20 -0700 (PDT)
Date:   Sat, 20 Apr 2019 22:42:15 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 0/2] Add runtime PM for SAI digital audio interface
Message-ID: <20190421054214.GA683@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420155846.10027-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 03:59:03PM +0000, Daniel Baluta wrote:
> First patch uses system PM handlers to implement runtime PM. While
> the second patch moves clock handling from startup/shutdown to runtime
> PM handlers.
> 
>   ASoC: fsl: sai: Add support for runtime pm
>   ASoC: fsl: Move clock operation to PM runtime

Both patches should use the prefix:
ASoC: fsl_sai: Xxxxx yyyy

Thanks
