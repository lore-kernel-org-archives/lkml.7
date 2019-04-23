Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F574C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C85A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zc+jl51s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfDWLYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:24:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37858 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfDWLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:24:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id h126so803906lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sklbcYzNqovbbF6MsELRrYfyZSdx6tMLKKR3nRrUTaE=;
        b=Zc+jl51sb/+RGKPr/L9O6Y/DQ22ZztuSOx9pgv5FD3BX08CEY8sZ3kSp1VAD9ggVCC
         /qJDplvmW/h8c3MuFUFNOU4nuuZtjvW1S2/DQOHIWIX5JWOnwvHr2JwO0P5qGJ21Hwf9
         jUp31zdsvjn+oUofziR8qAO2z7E/T9qz9UOXWgY2clEisc1B2Uq9QvZxzZk5mV6oJzDT
         77PIoAbO+/VbrxmGPObHtGAwX5sNXucmPORh/xOVpubVsdh7URxJWFxF6X0n3B2kddSv
         QibQxNLJIwHJnbBBKieJw9jz7kVJXy/6lcwQJnMQCZboQPCXdGv9U1XRlvJtOX0OwvHB
         X0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sklbcYzNqovbbF6MsELRrYfyZSdx6tMLKKR3nRrUTaE=;
        b=cdZptsTvVWBRrteuyS1GsTbCwxnBxOoy1V3fCQiKp+mjdV58jMe9PJGYpyINyRzgOo
         kTsMjkx2JzL64wv0WFXxfsh6wQWlj9GrBetonbS87zrqk5B7TSx2GhcNZHJQDOAEGQyo
         BadwjSnGmhjUAIQVBHOu4jx4vQdTXzy46LoVw03CBGRV1JD7MJcaWyL2pLQtPG1/byWN
         Aixa759hGF1dQTgZRKCXSVeSRwejikT1GBiFYNz053WiJ6Pj/OmimNrjlEhUTyGq7rhb
         LglMelOkaHOhR6ZWQiCRFg0VFkAJwqDj28yAyA70DDJdUOB+B7mNaD2nfGkElCVkkxCh
         Xo+w==
X-Gm-Message-State: APjAAAVfoRckcJzE2fRtPr6yyTSjcDxSBqy8kCplL32NgfouNax4cBIx
        NujGGadF3/llaV1xKB4na9VP1KdQ4ZGbTfzwUgD8Ug==
X-Google-Smtp-Source: APXvYqz79nvA1Q60yFlEIyZ8GBjQyq2vM2GSFZNS5rIDI5trbwQBBNz8mWJ8moYs+x9QlkywPZ1zZEDeENCxMnrGMC0=
X-Received: by 2002:ac2:5381:: with SMTP id g1mr13340228lfh.130.1556018641520;
 Tue, 23 Apr 2019 04:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555938375.git.mchehab+samsung@kernel.org> <03cdacc3db76c5ff984c1507ea6434650d36d822.1555938376.git.mchehab+samsung@kernel.org>
In-Reply-To: <03cdacc3db76c5ff984c1507ea6434650d36d822.1555938376.git.mchehab+samsung@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:23:50 +0200
Message-ID: <CACRpkdY=YurusedRbMDWstJUP4CLUosW0rLetvE=Hkov1Y9HGQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/79] docs: gpio: convert docs to ReST and rename to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 3:28 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:

> The API described at sysfs.txt is deprecated.
>
> Still, as it is still part of the Kernel (and will likely be
> there for some time, as we don't simply remove APIs). So,
> it makes sense to keep it there.
>
> The conversion of this file is trivial:
>   - add blank lines and identation in order to identify paragraphs;
>   - mark a literal block as such.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Same question as the v1: should I apply it or will you :)

Yours,
Linus Walleij
