Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7081FC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3368620872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxhAh1UA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392674AbfIJKfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:35:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43378 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388874AbfIJKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:35:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id d5so15879828lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E17t9nsKObBUkkD0LBm1VvJsFUJUtomTh2F3C0pWBBg=;
        b=PxhAh1UA8/oxprqJ7vDTf4uNmw227REjjRYuMyrolLKKSoSEgnh4cKGRvvpCuVjjZb
         nTf7VTzl9FGS0WkPSHPqToRkOt3u2EibIaVFUW8xSBHs1O7BFylaxXmkkalSa4Dcv3kv
         GeRRA1HkVQnhC57raCgO4fm2Q0GBaeVgUUDJN6J4gkSDMaK8RRJOGehAOe2aP/7eT+CY
         yIh+DdshLaahOo1WDyvWvwyUT/vIZ4HZKeqFUhnDxTUBD7VRITghxXud1IRCNRvZTWwk
         fAzO9tOPqPBORXMLoL5lreJqxy3KytBYbFw+u4cND0CPJF1jE9kZyw01WLVi/pq0YY7G
         e8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E17t9nsKObBUkkD0LBm1VvJsFUJUtomTh2F3C0pWBBg=;
        b=TMBdPbegyVz+bORDmcgZNJkK+iuR/6u3A47P5nvysQOUFAG4VxVgszlnekRuYZU46w
         Tpc2wo/lfZ8ub+b9cwhArKuKtprmMlLLB3uSwdT985DU4WzpWKZQZcrJG8AL8oxz8ohy
         5QjlombTON6ajICstK7dgYiuctfBTciaB7Gwvmd1mdPObcEJjTcyKw9M9bMDkMqsf4+0
         W6b9HzkzGznOdzH6cXnKbkG9rtHuLyXVjLE4KQqN4HT9ygE4RFwDdBKiSqxuBIM8Bok4
         cTkljCo4QPjuAMTS23W1zTL6FDA2QvlNcV0WOd1y3+FzCG0ibgX8Cr4Xv/RY/LjZASjM
         TBCg==
X-Gm-Message-State: APjAAAX51lnvtlIVAu+z43z7MoOn14d5+1jgv84p7ndODsgz7uJvL0Pi
        p5JJprCKxnfp6g9Kh+bKCKczPsL6Yal1sL1Olex4NA==
X-Google-Smtp-Source: APXvYqwqbMlISNGBlmWQOwOUdX589aFpzFerGxuMZYnIj10DzE+NZDz4XIlI/VUYIt+UMAnE5LjH+X7ugc3++ZUFV/o=
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr11399051ljo.180.1568111737980;
 Tue, 10 Sep 2019 03:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190904172624.GA76617@dtor-ws>
In-Reply-To: <20190904172624.GA76617@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Sep 2019 11:35:26 +0100
Message-ID: <CACRpkdbc70pp=SwvxGTDq=-K3ofinQJuVVymFf8ere3_f_+qqA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: make acpi_can_fallback_to_crs() static
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 6:26 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> It is not used outside gpiolib-acpi.c module, so there is no need to
> export it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
