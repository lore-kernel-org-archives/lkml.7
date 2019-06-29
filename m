Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7330C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F572054F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhLZcTmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF2NNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 09:13:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42726 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF2NN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 09:13:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so4325229pff.9;
        Sat, 29 Jun 2019 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2DTm96VMPC+SANDW7RytV3OF74ZXwHYzOKAcpOyecY=;
        b=XhLZcTmJfYpzwjU0V7HvVdUhZri6ZRLPo6CgsE0VjEC4J16VMvpH24Eesk8x5bHP3x
         teGqebXrb0ngVywSPTqMcBrkYktWGxwNL2MtRhWNaYc6pXy1FJo1CF4pPKxpjPPyzD4+
         2tMoczuH33HirZ4jYCcVSGRGePN3QKNSIEri/XMfESioYKkt1jiH3FokHpxPc4MdaG6/
         +mndJKJfOYHonRScIsBiRvSRM5JDHJwasqSl/YX2FGTYAL6RjbJqN3DZgi1f27tte8m8
         gKcNS/73pls/mAYfrTaQa+Hx0foChjWIMq4i4Uiuz2hZxjV1pWGMm5N4tW7Cfp5CQoy7
         D0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2DTm96VMPC+SANDW7RytV3OF74ZXwHYzOKAcpOyecY=;
        b=CdcuqBq8SOZto1Z5Fb9aIoQ+DO8nrAMCox6t7dP1nYzNuUWWe5HJujwq+EjCSP7eHV
         Q4nII9WmQPodVkBSAsyLuZtEdbuPc6yQZKywAd8pXleXtYV3QTu9CScsuYJXuVOYgEO2
         DcjauaPmPW0gahgON4X2wmWOaauJFy2niTaOLJQ52RTW+xF1+s59t2bHLi6dQzKi/k1w
         taYb0NwkmO7tRgBxpQbhZiFJxHkd/vKQ/D+lYSS0iadVfw050phJAECD2LDACOYqVSHG
         fsO+cjAvClMKA7hv4lhOB7ZiZHJSFmPn+0GKVGtTMfjaMgF2KuhDJFG5AWhOUr/0Dlqg
         8UFA==
X-Gm-Message-State: APjAAAXukIrbYIvyhdXt+eNVifZu8yW++RZKhntMbBuDaEerodptBhzA
        UbwMLZ7RPBsDLS6InVVckKygEnMC9A4I0MaeovE=
X-Google-Smtp-Source: APXvYqzzgy2Ar5SXbXmGpjU1jqnGIsd4seAiMWAf2/Ruk57oeKMXWDwjPXm8uEOwvVRpVONHEOFJRT8j4zUWPRji8eI=
X-Received: by 2002:a63:f346:: with SMTP id t6mr15050123pgj.203.1561814008582;
 Sat, 29 Jun 2019 06:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190508164934.GA20064@embeddedor> <20190508230645.GB32286@wrath> <b1869c7f-0927-9a30-a195-a188719c748c@embeddedor.com>
In-Reply-To: <b1869c7f-0927-9a30-a195-a188719c748c@embeddedor.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 16:13:16 +0300
Message-ID: <CAHp75Vf52tq9UWx9sr3VihZSddQMoEcqeXWzW4y6CJFq7cgH0w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Darren Hart <dvhart@infradead.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 4:48 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> Commit 5c742b45dd5fbbb6cf74d3378341704f4b23c5e8 mentions that "This was fixed
> in acer_acpi some time ago, but I forgot to port the patch over to acer-wmi
> when it was merged." Notice that this driver (acer-wmi) is based on the
> no-longer existing acer_acpi driver. But after googling for a while I could
> found the fix the original author talks about:
>
> https://repo.or.cz/acer_acpi.git/commitdiff/74c08a38875ffa9989c3100947650ac8a388c189
>
> So, the fix is indeed similar and contains the same fall-throughs from case
> ACER_AMW0_V2 to case ACER_WMID in both functions get_u32() and set_u32().

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko
