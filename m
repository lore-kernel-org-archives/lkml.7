Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA907C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE6B2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn1cHfqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbfHATvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:51:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45642 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbfHATvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:51:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so12410462lfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XCwfy4InAD/rCvnsm3GlpR1/bbTrX2pT1Zwk3s2doU=;
        b=Yn1cHfqftzqjEKwQX6maQdLCLe66bVasGS9axaC0JhnFgeY3jc5ebAIqitT7YMQ753
         aKqhp6De/ns2cAqVqHxuU0c6mxMP0Qw8ZNt/wMFuNWi8JF0v8ss6GRpfazMejMYTASo6
         kDnxaYiCWgRA7Q+grGOTr4BMq3Yh5ccY+JHNsiWSlS8Qb/d1ZVpcXKBzSmIVWRW9RFEj
         VCR3pyDCKjGPhhLD10pNsPu4nIaJvB67ojjVQkSvAN3ezd7nWX+ME5ZIb1G8m50K07os
         4dNrLLtPzOa+PdBrTgcM0Fue6emyiwSQceXwQbF2FJYvUeqrkjo7cfK5pei4If+wbSP3
         aPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XCwfy4InAD/rCvnsm3GlpR1/bbTrX2pT1Zwk3s2doU=;
        b=Sus8lgh4sQ+Psm8tRX2RABZBqzLzNuJX5KYJppeu97cMej7GeY5njS1/tOM0I+6wQU
         HV2SkweRs7UF/y1t/tG6ftK3teIlx1fDHkIe0buJE+u7Ko+kg7WR0bcFf06x8bn3E1QJ
         XIZryCH4Q3LmURjzXtInET3szPqfL4aMocs/YJ6IX+RB7MMiaDh/dppEZ+EBgyvKJwYh
         j5Mo31u+V4Gw6HEmXhWX+Wvs1qYxVZr0wXlMiYZiRN9+nhCV4CX6HM6FXClzcTzjKKtR
         wz8dFEWzJwv74j4ulua8unaoz7LZUI770vx4iz6P3SFMW9fl9lI53tyFbrGnHrfAwgLX
         nXWw==
X-Gm-Message-State: APjAAAX+0EWaygtsCfAwxVKw6SalphPfediHCFlgETIukdq2TWCldom2
        2Ep7GbtDUDfg3ev6lDnSGKFiNyqr5fJ6RBcukfSGKA==
X-Google-Smtp-Source: APXvYqz7aoMlKbe+7pvRKOW5Fi3KI3vth+td70co6I94uFx2nwgr88DzCzQcnVWpYu1VbyTcxVnofnuK6QcEGTRDdGA=
X-Received: by 2002:ac2:5a1c:: with SMTP id q28mr52500122lfn.131.1564689065191;
 Thu, 01 Aug 2019 12:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 1 Aug 2019 21:50:54 +0200
Message-ID: <CANiq72nGak7da8OVYEeMxQwCmEtoBaeHhF8x26RL77dSg79rUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Update comment about simple_strto<foo>() functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 9:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There were discussions in the past about use cases for
> simple_strto<foo>() functions and, in some rare cases,
> they have a benefit over kstrto<foo>() ones.
>
> Update a comment to reduce confusion about special use cases.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

I don't recall suggesting this, but I have a bad memory :-)

Andrew, should I pick both patches myself or do you want to pick this one?

Cheers,
Miguel
