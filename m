Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3560C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4B3206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeceTOiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLPJkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:40:07 -0500
Received: from mail-vs1-f51.google.com ([209.85.217.51]:40978 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfLPJkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:40:07 -0500
Received: by mail-vs1-f51.google.com with SMTP id f8so3687379vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efbgTWq8E30bo1goC1Duh6RnWJItngSdLLJmSmuEoCQ=;
        b=IeceTOiP/bP5mLWy6gexUgBuP0MKYDGPWylM/W5iUxdPtrbnLOCXqdgQOSlQZmsf5I
         WPTqE/EBeYAC6RyL/f326H5ADcf3h6RzfpRDWROV0jSNRtphHY/N+qX7f1T8KxUiz1Wc
         XaERWbd3adzRFB4UTgjOKlNGyCP8gNeF5ZFXoFbb/YLnQ8QdJTAD2OFL3NnH0Ci1Wb3O
         kyguCiBbNZa/XFGRk5R1dM0BZw5g56GYPzVkNEr0Aa9+dXnWZlSGmUN5QB0VbWoCjEaj
         uHnFCpIzs3LvWfbfBsOAEhIlmTdCYhApk6HD5rluMzRhGYozvn2J8dqTI/ecRBmlMFXu
         8UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efbgTWq8E30bo1goC1Duh6RnWJItngSdLLJmSmuEoCQ=;
        b=Bfm6tr5N7Cwuty3G6CQpQVNJAzEBIQMVzYGGRwz1OHDswXe64d3CoXc1XZ2x7t+yWM
         pS3K/r/7zS2xtwoP6mAbgzCpcZCHc40RCct1iBpIxqFUm2InWHMpllABEoeC6fkYxL/p
         tSII/Df5vZrtOtHeWiS0jh2S0vQDmiQEWBHEG2jiZ1xPF0QZGC3Y+AHwM75NnjP1uAR8
         V9JrX82tXfxGxcYa96FnLooQN5VWXBpp6vq45Wne60RJZsaOQ3xxHhX+2eCA9RNloOYn
         V3nIdPQvptLBtJuxwAnbYowjmoRBlaUG+e2edKLUqA2jjneMzsgFqesgnQg7TpMJUUAt
         AwXg==
X-Gm-Message-State: APjAAAWDpYJynFfI7nKcGoQ5zjbHvX8Y8qDD5M0+jy1TGqDj7nNnJP5D
        gJzOdAQycwqrFZNrQ9Bq0hSXaAE09twZuqTg2ePCkg==
X-Google-Smtp-Source: APXvYqygsUmNTJXK7DCAfnCkmj0NTzev1RnLNm4j1bpfg63GyKPTUK5gJhsgCmXCmCJc7a5Vu0oHcyWwruDqsIwR8HI=
X-Received: by 2002:a67:d592:: with SMTP id m18mr20795571vsj.85.1576489205893;
 Mon, 16 Dec 2019 01:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20191212135016.GH25745@shell.armlinux.org.uk>
In-Reply-To: <20191212135016.GH25745@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 10:39:54 +0100
Message-ID: <CACRpkdbAWkuyVK8uejvvKgpg4qhVfZ_a3dNmXAKsK5fu=Ns6zQ@mail.gmail.com>
Subject: Re: Link: documentation seems to be misplaced
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Thu, Dec 12, 2019 at 2:50 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> Surely, the format of the Link: tag should be documented in the
> submitting-patches document with all the other attributations that
> we define in a commit message, with a reference to that from
> Documentation/maintainer/configure-git.rst ?

I agree, so I sent a rough patch as a starting point so we get
something going here.

Yours,
Linus Walleij
