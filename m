Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013D120811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyJ84B3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfCYOxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:53:15 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56018 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfCYOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:53:15 -0400
Received: by mail-it1-f193.google.com with SMTP id z126so14334981itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gL79n4SDs8mJ6tqC6/tJGoVZQD1amtCrTdwiOLVsLQ8=;
        b=gyJ84B3Oq47yjkN+PilAR2kP7OwL56dthb1ZmkEWYBOAnG+B/lFbdo3/T/BIel1Uuq
         gcpFlzBrRuNUJJNyPApR2IT3zkdt8TBt5aTI5ef6smGgn/Hs3VyLjhxqOY5COO6ScClV
         cHFtuyveVIhbZtr1axMcvBbbNtUIFjj8ri5IC+PzQq7kOFdrHHP5DrsEBMXVzThrlity
         23A+3nCLJgG3ymOG9oxIv1MXQZt262CD4QtftMdOnyJqxzquEfjVEvRRzKWbpH0AawvU
         p0uR97PRrDS4ci2z/Y7zQ+005KWfR0wH5jfhUV7aZ68KsoW9ff+Acw4w+5rfE3Echdil
         +Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gL79n4SDs8mJ6tqC6/tJGoVZQD1amtCrTdwiOLVsLQ8=;
        b=QzdkEOgYMDaYqMGsQ9VvnAHd8I5vHsHbJCyUWuZ00JdxQpPSNFUQy3wEVeUuDpZW6l
         6vu6YPFsMblINceHIpeySC6e58LtYE81BkQPXE82o4Jprzm5nQpb4Lvfx2o1e2UJlRO8
         LIgtRzxE2zcFt/85bRuHWli+NV7Ymq2HB3otZirMmI0lb1RnARyrIA+EEKuoDJ2a1T37
         DVIgvbHtEOU7MMXvjELKO0hJbQmUiwmBUT1YCv4/14NtRSE/hmOmZlMR1MbO+pvjkUi3
         W1bWznlwbtVGJfYvXYXypx+jLzkKG+5ToEG693NbLc1Cnj1ZLnuUmAPTMp1JXrkRQd7u
         4aYw==
X-Gm-Message-State: APjAAAU9jwITP5Lnn2s8Pnd9/K+4FN7MzmifY+57HMJrr60/XBrlBuVQ
        kfxwNcOvmFc6s02pqxtvvo7vqXpKAy8p4IMOVwZpkm6C
X-Google-Smtp-Source: APXvYqwbS8m3pUKTvehe69yyWJZTTnF9PJulTHKPnWQu3KpmNht5BqGZn+xchBlI1HCkyXhH6XjMliLv2vor7VhH4+M=
X-Received: by 2002:a24:b643:: with SMTP id d3mr8789397itj.146.1553525594462;
 Mon, 25 Mar 2019 07:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190324223227.1987c866@canb.auug.org.au>
In-Reply-To: <20190324223227.1987c866@canb.auug.org.au>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 25 Mar 2019 08:53:03 -0600
Message-ID: <CANLsYkz3bmb0+iwaPm9Nc6F=HTa9+_Uukx5hDTi28QSCOHyKWA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the coresight tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Stephen,

On Sun, 24 Mar 2019 at 05:32, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Mathieu,
>
> Commits
>
>   0a3a3dfb0d15 ("perf tools: Add missing case value")
>   0dd14fd06504 ("perf cs-etm: return errcode in cs_etm__process_auxtrace_info()")
>   9b884872f9be ("perf cs-etm: Remove errnoeous ERR_PTR() usage in cs_etm__process_auxtrace_info")
>
> are missing a Signed-off-by from their committer.

Fixed and pushed - thanks for pointing this out.

Mathieu

>
> --
> Cheers,
> Stephen Rothwell
