Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0138EC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89632086A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="auysCQzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392837AbfIJD1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 23:27:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39776 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfIJD1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 23:27:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id l11so12219923lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 20:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ropqFminAsuYzLc+qA9K24nUNWnD7cn3AN/0FfpV44M=;
        b=auysCQzPijlKbJ8dj8RvUZmk6jgRVymv2glX5u2Ca08XLuwMRh+1OyCCZNBpXOpPXX
         LbbVNuA6VM+3y6KQE58M5Y6pnkcZssZo4yOra6Hobd8cT2oqx1nNnbIt9HXeBi5mgoqx
         i7oyVOpS9eASObqUbyci7/CyCeMy1qp0gEPnTPZdjO5iMgR5+Pmk3s3JFG08FDoYnEgV
         2lh+gs73JByv8yUfwrHoFZKTlCKTeLvETjUZ61b1IG27loNPtdmujlL+FQgNfAB/hqzM
         +nAHSxwnaKaiXQXaRXyfGOHI5V4b7ZvIAyT5CA8U+/IgLSCtEf1EexVlhG7OxL5zCxsc
         zXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ropqFminAsuYzLc+qA9K24nUNWnD7cn3AN/0FfpV44M=;
        b=D9VLgG7t54aFItI1e8hVgZ8WHaJ+0nEWWR9iLHDn/ckY0dd8QD0Y2UwJKaAgqJEB5w
         rzgDkICbIST7H2Fus0JF6FvVbzdrIHtA3qa/3Vy0qGQ6P6yTwC7LkH60EydzQlBxe9w7
         ejiTYCDiwS7fhLCSlkEHXif+2HyEUSkQDSdSt0UzEmcyymkGowPMwwofcEAIYVdha7i8
         6yVnXzPlsxETk7KjBR7j3Te8ODiH5At0S9pD3JlTNaqo7qewYd1U5JvnwbkkAwC+E84w
         UNGXljI/Fbqw5bQyWkhL+LSwvO5NR9tHGWKh2FwEg6UERcxV8Vys6Hp/uG53g1DiBB8U
         g4BQ==
X-Gm-Message-State: APjAAAU0pUNR9fP/pwTng+Gf2CBgiZYqerbYzH6M/schI0n6VVoIrLMO
        hVcEzsQSfCqTBp0PQHbVzKlnzyrS4g9zhDzueprBFg==
X-Google-Smtp-Source: APXvYqypB9y/im+Z9qxmaZUuMkgXQGzTCs7vAzL0uU20Vdq5CFvQMJu0Kd+GW2/zmWzljJE618/x2qTXAZhWQCSOXPY=
X-Received: by 2002:ac2:4424:: with SMTP id w4mr18492565lfl.65.1568086041766;
 Mon, 09 Sep 2019 20:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567740135.git.baolin.wang@linaro.org> <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
 <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com> <CAMz4kuKsk7ZN2BnD4zp53PQE22jD-BTsJLL53SL3ndZ5=OCHYA@mail.gmail.com>
 <3d83db18-7e80-944c-fc4b-244249c71bbf@intel.com>
In-Reply-To: <3d83db18-7e80-944c-fc4b-244249c71bbf@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 10 Sep 2019 11:27:09 +0800
Message-ID: <CAMz4kuLLjDC_bLpen9qEsxEJTF5WWg9zsH_J-3Xp=Mj_Wss7Eg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: Add virtual command queue support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019 at 20:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 9/09/19 3:16 PM, Baolin Wang wrote:
> > Hi Adrian,
> >
> > On Mon, 9 Sep 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 6/09/19 6:52 AM, Baolin Wang wrote:
> >>> Now the MMC read/write stack will always wait for previous request is
> >>> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> >>> or queue a work to complete request, that will bring context switching
> >>> overhead, especially for high I/O per second rates, to affect the IO
> >>> performance.
> >>>
> >>> Thus this patch introduces virtual command queue interface, which is
> >>> similar with the hardware command queue engine's idea, that can remove
> >>> the context switching.
> >>
> >> CQHCI is a hardware interface for eMMC's that support command queuing.  What
> >> you are doing is a software issue queue, unrelated to CQHCI.  I think you
> >
> > Yes.
> >
> >> should avoid all reference to CQHCI i.e. call it something else.
> >
> > Since its process is similar with CQHCI and re-use the CQHCI's
> > interfaces, I called it virtual command queue. I am not sure what else
> > name is better, any thoughts? VCQHCI? Thanks.
>
> What about swq for software queue.  Maybe Ulf can suggest something?

Um, though changing to use swq, still need reuse command queue's
interfaces, like 'mq->use-cqe', 'host->cqe_depth' and cqe ops and so
on, looks a little weird for me. But if you all agree with this name,
then I am okay. Ulf, what do you suggest?

-- 
Baolin Wang
Best Regards
