Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F96C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AB62087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bns0Ectz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfEGCYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 22:24:50 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34538 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEGCYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 22:24:50 -0400
Received: by mail-oi1-f177.google.com with SMTP id v10so11223920oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 19:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENt8EH2AAnwBKCorpSXemefyGkNkcFdd76Kvn0m/73I=;
        b=Bns0EctzfedQpalxj+ZfwBrnI8ZtOQ3/N3ixrvIbT5nXLenik6VZUxxKdWfB18lZTz
         l3nzmIyPnXWgQ21B9uVy3vKuGTuKTw5S+4q9XCObk/ziGBvRoTsPW36reK51sWC7fZok
         BrCLD8yfUlGYzrVtHDldVmfZqgYlnBc6KiaxCK19X8nTCtb5CrT7/wJk90lLw2w+6ts0
         xBC3qfcxw9KiJBILYFaHM2hyIk/pKa5s32kY81F+OJKysmygMBTwGyjhYGboL1kxqs8t
         cYj9Fl2LhCmcarl0ArssFpmyt34UhTz6ApSHUwXzvOwc3bC1y36MIAxo0emuNofnGPx1
         hP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENt8EH2AAnwBKCorpSXemefyGkNkcFdd76Kvn0m/73I=;
        b=tqEbCLterg2dZYHTefOks40xgsp1tWr/2kCthuFZ2JjCh/mJVhHawe25+tIFQHT+AE
         cWhGBwxTBEfUeOIlOC44UuntCvvdCkcg1BJzSGRnBqe46a9jQBtzu/ean5HmMZNDBnEr
         /aZkoXk+pT7rIfh+xEK7n0pkcU2AeHXcUBLeBEAftaIvmt1UE0qYDZI8d8WM6W52oa3U
         tU1SQ0neKfoEnTbbc/9pzeHqny27V8gHedm047ez/JQkRDg3iOBxc+hrsOLkpHF/DiKB
         2bQBa6MKQyC+6QwtnFvlwttEqAud3vG8O0vCSTcZuY/NHLSUwF6btuAxPk/BAHUgMEZw
         oi0A==
X-Gm-Message-State: APjAAAXNuhkeFsbF3kILlNPnvVwLWTgcORtzT1xTw90DRriDq6evVbpW
        5tox6j/gWuJMNIIxC3Z8XU9vhet3VLBkJawO8/5WUw==
X-Google-Smtp-Source: APXvYqxDFhz3zuwYGZ7tCI6PtDhGBgsbl0VYgZTW61EsTkBcv+Uine20QXZFV3YEWb4Lpi368CvUqaZLnGfKujZezk4=
X-Received: by 2002:aca:b8c4:: with SMTP id i187mr861789oif.6.1557195889449;
 Mon, 06 May 2019 19:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <ee4a22c3491628abf94c8d356dccd67984604811.1555049554.git.baolin.wang@linaro.org>
 <20190418102606.AE0181126DA9@debutante.sirena.org.uk> <CAMz4kuLK_XS93Wpq+BkXVAJA3M+vFnL8pR0gR7aRpYxBzwLv9w@mail.gmail.com>
 <20190506134856.GP14916@sirena.org.uk>
In-Reply-To: <20190506134856.GP14916@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 7 May 2019 10:24:38 +0800
Message-ID: <CAMz4kuLdRspCGNFxATjzWXvBMwBGwXFczGUQKFEyiOSxGwaMcw@mail.gmail.com>
Subject: Re: Applied "ASoC: sprd: Add reserved DMA memory support" to the asoc tree
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 at 21:49, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, May 06, 2019 at 03:37:39PM +0800, Baolin Wang wrote:
>
> > I did not find this patch in your sound git tree and the linux-next
> > tree, so could you check if you missed this patch? Or did I miss
> > anything? Thanks a lot.
>
> Something seems to have gone wrong at some point which caused some
> patches to go AWOL, not sure what.  I thought I'd caught all of them but
> I guess not this one, I restored it now.

OK. Thanks :)

-- 
Baolin Wang
Best Regards
