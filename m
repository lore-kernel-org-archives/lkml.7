Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB086C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55158233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrCaTK0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393360AbfHVVYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:24:55 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:37748 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfHVVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:24:55 -0400
Received: by mail-qt1-f174.google.com with SMTP id y26so9377934qto.4;
        Thu, 22 Aug 2019 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z6P1XXc/MDFyK0VK+0+msiVJ14a7l2lhP1xH0WOny9g=;
        b=MrCaTK0NQP4pRYbzdrTHiSteXBhR0iwA19eyx/A12gHAXEeHvlbREbVraDQjta+PI3
         +mFIwD6mrTrd4QR5MDqKsqqTt1EvabGIaYvt8uJv/+sF4IBHex1lNiS6I8OsQ7p2Z6PW
         PG/bxCJZe0aOY0eH5HF4pvk4COdR60fytC/1B1dLuiY8ZOo/+/9kO32I2kkRaDsmQujh
         3UvMCeCd9rF0OzvjGnDiXMHvk9Wtdv9EeYqQx7CoY0VtvLTo/oXXtK48xRPRhv/ZVJIX
         2QQ5JNo4KWEqhCkkFmX8bZL//A4dDqsEVotSVzcG5kgFCn97kVRCQm6KFX54Du1t+sKj
         lmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z6P1XXc/MDFyK0VK+0+msiVJ14a7l2lhP1xH0WOny9g=;
        b=XJeyO4y+0WG7wUP/hkpqSphhfkqDdJ+slfXOVuDWyJybZxMhDOuQniLXxFxDxNCtA4
         Z55yRJtCuuF8ez7uW9f1HBr1i9cmwmtvWajDiYHgaOXKS+Rj2Ggq7sEHIQ6136PJUIFF
         dT26W28xIk/v7/sSTnJqIhr882IGGafd7jmnlu8JMZNH1jblZZIrD1NZZDPQLxBwkpRH
         Hwt+5NirlJV6htza5X98/p/tnnVbKZKbW/B/xzvV2tb+bJblSzJzKjlKhv/JaP3AjVE7
         M5qqjGzfZY4Wzoji4d3Bx7qAqOFsDiXYXEXl4bFSzzqQsFFglyDy2E78sK59CHXW2EJr
         atRg==
X-Gm-Message-State: APjAAAXClT7w6nmU1EYoWsTOB5MsdSPlt2mGADL4m8x9H6f0eIvb6t+f
        zQbY+U7my0Mgox5hCeQXv7w=
X-Google-Smtp-Source: APXvYqzEwjYkzKA9IiaxkLdIF9d+zqnVypDv4VIJ+Pofhhp5cXXXyhBYya87Iet8sCaWjivonluE8w==
X-Received: by 2002:ac8:460b:: with SMTP id p11mr1712144qtn.93.1566509093807;
        Thu, 22 Aug 2019 14:24:53 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.158.141.211])
        by smtp.gmail.com with ESMTPSA id g14sm456290qki.14.2019.08.22.14.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 14:24:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF2F640340; Thu, 22 Aug 2019 18:24:50 -0300 (-03)
Date:   Thu, 22 Aug 2019 18:24:50 -0300
To:     James Clark <James.Clark@arm.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: Re: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
Message-ID: <20190822212450.GK3929@kernel.org>
References: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
 <20190822212407.GJ3929@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822212407.GJ3929@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 22, 2019 at 06:24:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Aug 22, 2019 at 01:55:15PM +0000, James Clark escreveu:
> > Running 'perf test' with zstd compression linked will hang at the test
> > 'Zstd perf.data compression/decompression' because /dev/random blocks
> > reads until there is enough entropy. This means that the test will
> > appear to never complete unless the mouse is continually moved while
> > running it.
> 
> message came mangled, had to do it by hand and then hook up your header
> so as to get the correct date, attribution, etc, please check
> Documentation/process/email-clients.rst,

Having said that, thanks, applied.

- Arnaldo
