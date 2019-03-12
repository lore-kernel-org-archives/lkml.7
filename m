Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B968EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B5D2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfCLPHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:07:51 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40549 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCLPHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:07:50 -0400
Received: by mail-vk1-f196.google.com with SMTP id d84so724429vke.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6NA9xEJq/R/fMUpYhoWJGQycpI2G7LRcBwpOEqvOUI=;
        b=aURqLt3T/9bthNaggma+ojNyRMAdNZhjkjMX6MgxsBBTkqNLG7ppWMa3L4lA4gePLI
         aG4TdM5PtqBUeKQaZkgztoA01sztpOJVqjMjNMUdyRfPapkJ3obTZykuGIDGDqBwXaYg
         wUtC0WytRjRrJedDlP27SNVi4Rj58AFuVtLoh2t2Ob7tZnAqYIOZvnMzdCDOOEuzftqq
         4sk0YHtLfFQfeUPXORiFOiCey7zgluIDf3G5Hejg0QfSYE6czFATkjeW40El8fJWOHHp
         gSrJS1d1+3gpOTdCSp7aYy8iAbRuhPtIjam+9KkizyAkl6VMY5HL0J6lvgg1Qoarmzvx
         rHpA==
X-Gm-Message-State: APjAAAW34xDT8lkHxIoVzcxXV71nmO+Y5B9f1j/yEtwsAl6BFnpPL0HY
        2//Lf6i5x5bC/13jeNJ1aAOo9tOTLdStVATYM9A=
X-Google-Smtp-Source: APXvYqz+f/b5NWf6VC5c9pnVvb8ZEwdW51NsdD1UVM5lbfNivGkIDp9l6M+9GMXtT6nE0xzicyhYYVdUKHmtqlZNjYU=
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr20177990vke.40.1552403269220;
 Tue, 12 Mar 2019 08:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com> <20190312144432.7668-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190312144432.7668-3-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 16:07:37 +0100
Message-ID: <CAMuHMdXML44wRji=VGU95kWnEj+zubha7N-L79f6Uz_bDbGAMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] auxdisplay: charlcd: Move to_priv() to charlcd namespace
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 12, 2019 at 3:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> In order to be more particular in names, rename to_priv() macro
> to charlcd_to_priv().

As this is a macro, not a function, the name doesn't end up as a symbol in
the binary anyway, and it's for internal use by the driver only.

> No functional change intended.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
