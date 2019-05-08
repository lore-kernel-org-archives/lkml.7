Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A57C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4897B21019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oy7PTsrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfEHSUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:20:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45000 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfEHSUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:20:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id n134so13414021lfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1WmOHHPEdJ3yi2p5J+Oh8mr/EtgaDeprnRifRsdYb8=;
        b=oy7PTsrGWxgx4kbV0MYFtgfgxmTytAoHH7E1+r/ZLaAnp73jKA+ExWmgHyQcnGvZ+8
         aZf0ZReKWnTZoN6ettL98+v3Bl4zG4B5BHQnbVzfwtGip97b0bXQEY7gG+SLsUvvnArA
         glPMTIBT9k1FZ8AHue8U2u8RfkhUOtSFJk+yO/IaZdtU2RD+sJPfMuFv+0dbVp6F0/b0
         sFIS/Lj0X1pjDeppEo/1H3ryYslYR/sL7LIpv5HulSUQeXtJh60e6rBU9Ehgj4HpeXUh
         8LvFcCZZD/Rtjuo0AK57FwTf1AlpJToHW58kyAsW98/o/nslJz/b7S677ZIz3NdBT1Xs
         1eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1WmOHHPEdJ3yi2p5J+Oh8mr/EtgaDeprnRifRsdYb8=;
        b=B/WD1kHbmxxgsNs3jLSLxDHIq5UXYjQRTXjVWGmubUsUOHW2pf4FBQAbY26bkYRPeJ
         l94FN3BYgG1pmM71v5IBwElpdVQlTmGWI2B8VbgWH7xIsZz/F6EhLSF69p9XCIAdLprF
         PZ7AsyRRvMJM1OjqYhAq5ynep8aip2yJ52e8nW9itOPu8t7i73Cr0UDlIEhfevWKK1WP
         g6546b+5XNRuWfS7xLoG0g/cNIFz68rjvODcvWva80XoPe/7S6Z8+lP7Y6731noXV+5t
         3t9NkELQLweqjYPp7idYVWK20jddaai06Ftr9V7vwN+WJEj0y0++CNVxiHrygkNMZ7DP
         Y/Dw==
X-Gm-Message-State: APjAAAU2N7ZhOxL2Cl+y2Wgizq5Ja0sqXuvk5sMCJ8NJVh88pe3ZpEez
        +8eEIzQ/fcG6Gs2XEV0HfeKPUyJIOytuynSq+Sg=
X-Google-Smtp-Source: APXvYqx9K2KxbFhGltAks9qNDSNYnSv1emsQTgfF3DGp7bgkfI0HKSB7KVwYHgGTct0X8W2jL3Hq+HyEJoDsRaJbeG0=
X-Received: by 2002:a19:6b03:: with SMTP id d3mr14380616lfa.137.1557339602914;
 Wed, 08 May 2019 11:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190508174356.13952-1-borneo.antonio@gmail.com> <e9cccc6630eb2fd273e7aa47a635717041b92d05.camel@perches.com>
In-Reply-To: <e9cccc6630eb2fd273e7aa47a635717041b92d05.camel@perches.com>
From:   Antonio Borneo <borneo.antonio@gmail.com>
Date:   Wed, 8 May 2019 20:19:41 +0200
Message-ID: <CAAj6DX2=KYJb1_CmyDFra5gpufb2KHU8mT4Nd1UMTHhYs9N1zw@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add command-line option for TAB size
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 7:56 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-05-08 at 19:43 +0200, Antonio Borneo wrote:
> > The size of 8 characters used for both TAB and indentation is
> > embedded as magic value allover the checkpatch script, and this
> > makes the script less readable.
>
> I doubt this bit of the commit message is proper.
>
> Tabs _are_ 8 in the linux-kernel sources and checkpatch
> was written for the linux-kernel.
>
> Using a variable _could_ reasonably be described as an
> improvement, but readability wasn't and isn't really an
> issue here.

Well, it depends on own skill with regular expressions in perl :-)

I will change the commit message focusing on the new command line flag
and drop this part.

Thanks
Antonio
