Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13853C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 06:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDFA20868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 06:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7YJ+BPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfFIGvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 02:51:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34083 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfFIGvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 02:51:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so125814qkt.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=heURi6LynaMTZ5g0eudG6hqYJ4FK/vscKytezEoes00=;
        b=l7YJ+BPKOJZr2S6Q56GRv9FJmqmdNu2ucZDnQVU1r8VMDrj2VQLwqz7N8EnbV9gaUi
         4D2U2AaRfQsrg1uPiWf1byHDgk7FIR27EFAQb9bTZ+kpUkiD+FFbxC3O/GQ4v8stHhq0
         zxejTWDBmXWngOSq3QuxW5hc17jBJIkIR0iyKnc5VqJob4b4yU2fw5RZ4O0UhasQenWl
         qM69/ZJl+PHQd0W+Jrkba2VyNgl4K10JIiYVUkCOzlnrfzu9z5YvzOu+OCQIFE10jvfb
         /w4nwSaH3TzdDCzTWX226sGxP6vNzF0LOQknc9mnPBmmk8Nt0V9pxnCELAbFsOhbwaUc
         HbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=heURi6LynaMTZ5g0eudG6hqYJ4FK/vscKytezEoes00=;
        b=d3qmOnbwkGO+MhkyB7+zJPiYTOk6x1A7Y/z0m6zMeKDnh5hWtkFeziF1mgIIYAOTqs
         xbnH5IHnWLl5uvt1OouB4EM0aR4LdSp9MWw5dZpvWG1crgR2FBvjyBtOpkHoeGRFYl0H
         IMLvl9flOaDI7C/fadzCLHfeZPpX4VSmoAscbROMU80aadgoTTStBZUczU5XETC+B6+Q
         B5Ekl39GoOgX+XP4fnE8Zp23Y41ou+/xNOB+Qs/MrsVztV3HBaDj8naF1ngOMo98PEhv
         n9UCiL+7RgBBu13uojFnbGKlIj8RtwSC60lyzuWAWFfTvKMkekNAUdbuwTXFzSmiSFvF
         QSNw==
X-Gm-Message-State: APjAAAVcD9V+2by1i602jKOO5Fj9SI0kf8e/X/AUQkhLFdCdSukfb1Wf
        xCxOtMfLOP7vS31pt0II4euflg==
X-Google-Smtp-Source: APXvYqydZoqjFUbt/qIi2n0C1bU+sajFrIHxWpzcFSWVldpERYP3gQHwq/dydPovJzSrHBqbgEVSEw==
X-Received: by 2002:a37:a98c:: with SMTP id s134mr49571604qke.176.1560063076471;
        Sat, 08 Jun 2019 23:51:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id s44sm1432186qtc.8.2019.06.08.23.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Jun 2019 23:51:15 -0700 (PDT)
Date:   Sun, 9 Jun 2019 14:51:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Properly set the value of 'old' and 'head'
 in snapshot mode
Message-ID: <20190609065101.GA6357@leoy-ThinkPad-X240s>
References: <20190605161633.12245-1-mathieu.poirier@linaro.org>
 <20190606201056.GJ21245@kernel.org>
 <20190607064425.GF5970@leoy-ThinkPad-X240s>
 <20190607182325.GL21245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607182325.GL21245@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Jun 07, 2019 at 03:23:25PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 07, 2019 at 02:44:25PM +0800, Leo Yan escreveu:
> > On Thu, Jun 06, 2019 at 05:10:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Jun 05, 2019 at 10:16:33AM -0600, Mathieu Poirier escreveu:
> > > > This patch adds the necessay intelligence to properly compute the value
> > > > of 'old' and 'head' when operating in snapshot mode.  That way we can get
> > > > the latest information in the AUX buffer and be compatible with the
> > > > generic AUX ring buffer mechanic.
> > > 
> > > Leo, have you had the chance to test/review this one? Suzuki?
> > 
> > Sure.  I applied this patch on the perf/core branch (with latest
> > commit 3e4fbf36c1e3 'perf augmented_raw_syscalls: Move reading
> > filename to the loop') and passed testing with below steps:
> > 
> > # perf record -e cs_etm/@tmc_etr0/ -S -m,64 --per-thread ./sort &
> > [1] 19097
> > Bubble sorting array of 30000 elements
> > 
> > # kill -USR2 19097
> > # kill -USR2 19097
> > # kill -USR2 19097
> > [ perf record: Woken up 4 times to write data ]
> > [ perf record: Captured and wrote 0.753 MB perf.data ]
> > 
> > FWIW:
> > 
> > Tested-by: Leo Yan <leo.yan@linaro.org>
> 
> Thanks a lot, I've added your "Tester notes:" and also your Tested-by:.
> 
> As I don't have hardware (yet) to test these patches, tests by people
> who can test on real hardware is always super appreciated.

You are very welcome and it's my pleasure :)

> Any suggestions for a SBC that I could buy to be able to do so?

Below are several Arm development boards for referrence:

- DB410c [1]: This board is the first choice for myself, since this
  board provides Debian (and Fedora :) support and it supports the
  mainline kernel pretty well; the CoreSight also is well supported.

  This board is about 80 USD so the cost is not expensive; on the
  other hand, please note one cons is the SDRAM is only 1GB, this will
  be impossible if you build some big projects (e.g. LLVM/Clang and
  BCC); but it's sufficient for perf related development and
  verification.

- There have other several boards are in my mind:

  Raspberry Pi3 [2] and Hikey960 [3].

  Raspberry Pi3 misses some features in the mainline kernel [4] and it
  has not enabled CoreSight hardware tracing feature; Hikey960 also
  have some patches are out of the mainline kenrel.

  Except you have special requirement (e.g. you want to use the board to
  build LLVM/Clang/BCC with big DDR size, etc), these two boards can be
  secondary choices.

Please feel free let me know if you have questions for boards.

Thanks,
Leo Yan

[1] https://www.96boards.org/product/dragonboard410c/
[2] https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/
[3] https://www.96boards.org/product/hikey960/
[4] https://www.raspberrypi.org/forums/viewtopic.php?t=236568
