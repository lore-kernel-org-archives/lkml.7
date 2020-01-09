Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3107C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 01:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D712075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 01:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxBMXD1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgAIB67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 20:58:59 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36019 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIB67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:58:59 -0500
Received: by mail-lf1-f54.google.com with SMTP id n12so3980480lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 17:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HLXba65IV99LLkH3oDHgUrEsAK+Af9w2DfQh6SRBRg=;
        b=CxBMXD1K0oXMPSBhBEDTwmq8dZh1xY7iXli6Q2oINfshT8e+3LbrF1lPNkx8u/PGJQ
         luQnZipBucOXUA2y/xdFuXxvcQVPdpncXK5I/Tt+Cijw7UsEFPD5rCKKLMIzr5WLVIU8
         z5nt5NTPz9s8EfX4UlaEZklWXYSWuxDLieUTyZ4ap8vS0J2mP+pXEDT1FfTzecqy9fir
         Vd4jqS7IE5WQqoYuKYvoYELlNZJAsQ5qh//KKqTvJhIe6JukyPt0c62N5NPmFmZ0ljUn
         wpmT2arhfy5K4eSN16I8A8JhXCLmv5cn90HaIIFpmXxjZy3BmxIic1u3P/HEjFi9DKbT
         5npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HLXba65IV99LLkH3oDHgUrEsAK+Af9w2DfQh6SRBRg=;
        b=JuB4B5NUR5EI3rjmeA6JzWdmeK0YMtGzsy06ZfCPEM2c+Fia8tCy4LhtqMVRQWjIE7
         O8dAAxDCLCuN8HofbN4XxcsbN+2Dw5bHZPsdS2uz0fhAhI2w8DsoQAdx96B8d7RQZk7y
         FFeVLh8CC5ARntPYtVfwqk68HWS1miF4vb5jgWGA3EhLnvlIbDP2c5Atjeaqb4D4p9Ic
         Tg02tuLCXj9fSyAo74MSdB8iEm8s+CfSsRG9UouuY9c/yS3deEsEIQfk0PnEoNgx7J2B
         j2ItiNi9N7MsxMYZx8hqvfuuScz5b1EPa53QAtvUXkDAenX44nlw+IBBdQJdS11+mJ6S
         +PRA==
X-Gm-Message-State: APjAAAUyFJhSSa+bPu6qb7Nf112eeDHokTdW3zihmg2dU0AcsZ1ybi6t
        d6AxJqGj+sgwjxREYxzmY4jad+UGYf6rHgV2/5MKFw==
X-Google-Smtp-Source: APXvYqym0x25O7/j2uOuILFJYpslF8H/cNSZB9HqV2Amzfra19PlmFsNj9gYjF3rDfVcy/PgZQAtlMNHT3HlwBxcZQ4=
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr4539518lfg.117.1578535137217;
 Wed, 08 Jan 2020 17:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20200109112836.0649c578@canb.auug.org.au>
In-Reply-To: <20200109112836.0649c578@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jan 2020 02:58:46 +0100
Message-ID: <CACRpkdbZi3qV1RFvA4SDa_7T-b-eSaKGdA9_m4s_1gk=2MQNDQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ma Feng <mafeng.ma@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 1:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> In commit
>
>   d5d3594db9f0 ("pinctrl: armada-37xx: Remove unneeded semicolon")
>
> Fixes tag
>
>   Fixes: commit 5715092a458c ("pinctrl: armada-37xx: Add gpio support")
>
> has these problem(s):
>
>   - leading word 'commit' unexpected
>
> Also, each line listating a fixed commit should have a Fixes: prefix and
> all the commit message tags should be kept together at the end of the
> commit message.

Do we have to fix this? It is a trivial fix to a non-critial non-regression
problem so it's not like we need those Fixes tags to get it picked to
stable or anything. To me it's just some random free-form commit
message.

I have merged a bunch of pull requests on top so I need a real good
reason to back all that out. :/ it just doesn't seem worth it.

Yours,
Linus Walleij
