Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBD0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A84D2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjL3UQw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfFTVRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:17:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41824 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:17:06 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so1965411ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWgtzmK5Dffhp4w0dM9JIEpJpXc3nwLUXojPORvneWU=;
        b=IjL3UQw6IiWddx8lu54V03rfMWEuut/voSjceIGDeCcMAi7rRstiXLjeq1Fzu1i/t7
         PCiN2rVxYN6WdaE4QuxkUCZeiRpPhT/zyV0k/ehEir/pe6W8bnf7ObJ/zkj6N2EPayT6
         vDCMOFScw+BqmympZrvhFKKoqL7MWkTq6Cqq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWgtzmK5Dffhp4w0dM9JIEpJpXc3nwLUXojPORvneWU=;
        b=MxmeWYBjdnGNDuqhQilHy9JwBAvLSpYFvHs7ubMrcSXYHr5xj8BjwVCjgP7Mxyp0M9
         Js4JkM6tWqnhfIEgqw1l9i+rP4J1qD432SGr1ltpFFlOoGmcppLj8Kjyl14EW5AeASQT
         3HHnFIjWmJ/gMy3anRJ65m0ajWpAJz+nEQSyENNoBgNpaSXWH0E9y8sOnBONdufSNi2W
         UWRnYse5yGlpZMCncedS7QAyu7E5o0pD0kis9khz9vDeqdtuNsLbBLAKfKbaqfPB5hrg
         hIq1FJJtY5qr5LgkF7tUbPq8Mu6FJhdtpqnb9Lq3TexNM8z0y/M7ovzVosunoSHXebg0
         62Eg==
X-Gm-Message-State: APjAAAW/YXT83iDxrpgtMTbHhLUiwuxCgmgdt7g9tpVPvjRHrLghb4Eb
        HL2S4STxDwOgPpiH8x8cZwxxFQJ4ZKY=
X-Google-Smtp-Source: APXvYqyr9wyBrPBbfk9HiV0Jr7lGQ8QZdHfjMT4Gx7L0vQ0hgTW2WOCVGha05kN2IhBLwuwyKxXWWQ==
X-Received: by 2002:a02:a493:: with SMTP id d19mr10676765jam.22.1561065425261;
        Thu, 20 Jun 2019 14:17:05 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id l11sm1408032ioj.32.2019.06.20.14.17.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:17:04 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id u19so154265ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:17:04 -0700 (PDT)
X-Received: by 2002:a02:5b05:: with SMTP id g5mr101301999jab.114.1561065423991;
 Thu, 20 Jun 2019 14:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190620152432.1408278-1-lkundrak@v3.sk> <CAPDyKFrSQR7+POv++8jW5VF4hTcQbNwZzqHntK1k4eNpy2gH=Q@mail.gmail.com>
In-Reply-To: <CAPDyKFrSQR7+POv++8jW5VF4hTcQbNwZzqHntK1k4eNpy2gH=Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Jun 2019 14:16:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBycK5hfa75e0vJ=9sjEG88TJyzU4--jsB6UyDe6nGVA@mail.gmail.com>
Message-ID: <CAD=FV=WBycK5hfa75e0vJ=9sjEG88TJyzU4--jsB6UyDe6nGVA@mail.gmail.com>
Subject: Re: [PATCH RESEND] mmc: core: try to use an id from the devicetree
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 8:37 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Doug
>
> On Thu, 20 Jun 2019 at 17:24, Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > If there's a mmc* alias in the device tree, take the device number from
> > it, so that we end up with a device name that matches the alias.
>
> Lots of people would be happy if I queue something along the lines of
> what you propose. I am not really having any big problems with it, but
> I am reluctant to queue it because of other peoples quite strong
> opinions [1] that have been expressed in regards to this already.
>
> Kind regards
> Uffe
>
> [1]
> https://www.spinics.net/lists/devicetree-spec/msg00254.html

Yeah, I personally like being able to assign numbers too, but
unfortunately there are lots of people who objected.  BTW: if you
prefer the patchwork view of the same discussion that Ulf pointed to:

https://lore.kernel.org/patchwork/cover/674381/

As per that discussion, I think might be OK if we could find a way to
assign a string-based name to devices.  Then if your user manual calls
them "emmc", "sd", and "sdio" you could name them that way.  ...and if
your manual calls them "emmc", "sd0", "sd1" you could name them that
way.  ...but I wouldn't swear that people would actually truly like
that.

Given the total number of people who keep feeling like this is an
issue that needs to be solved, though, it does seem worthwhile for
someone to come up with a solution.


-Doug
