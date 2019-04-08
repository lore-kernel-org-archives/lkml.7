Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB4BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA29A208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e10dChI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDHLEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:04:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42204 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDHLEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:04:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so10795723lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fN2q96xVycurDGmq4UjJL5OOPxCnIpFiqWWnRAd8kvg=;
        b=e10dChI9McDOtOAqTLHnBgNwF5SmWGMmEZcCnR0U88vnCiaS7nr13D1OrOHC28rVfU
         U00tX9G3rWH97Bw6QOnxmiTa0fISfrlyHe1Y4xua3prqGbuRHp1vwcBjrv+xxtQ1ggA4
         lx//5C+M+zytlCLF6ph8Du2LbNn2MOGLoxWFKm/T0kSUdM5h9PxwtBvYhc0h507zORdo
         i6zREbvZ8ZOB57RVOgluW3dwZ5GBWSzYe9+Sm7Kg114kgs32ToBVXRHEzx2QGIXNKcGD
         DZWc3KrWheDxHjlAY+bvIgUuAZ3xAxj7aMfS+T5ZDb4zZVns1gGhleBQ3azd3z3dyMHV
         SZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fN2q96xVycurDGmq4UjJL5OOPxCnIpFiqWWnRAd8kvg=;
        b=syPtFgWUiiBq/zu7lXsr5oDOcb1NI88lOlaamCw8pk1vXVYwvO0Bj/tl48iQNPxu8X
         G+VMQYTKiztuOGKsGHYfAVxhRHHQhw3SB+qlhZQ4AUfXJFf/+btE/hDkDiEpZFdVyfNU
         ICG+0Uw+2j7UVrVRaMMVLR8fHRNv0Tw+Mgbup9tbBe8+XvBnf5YS5l6qumvtZQPqG3XA
         KOYnBxulaBxnA/uVNTfnBiTXOUzd/0vOOWWntwgIc/EjElDhZvksZeaUTti6RDiOT7qb
         0vRKzdHhd31dBc/EgCpuKpLzqUZc2rCuOTBHiw90qis2yNBHlB3jUKW6d7rwqDYvhtwJ
         2SBg==
X-Gm-Message-State: APjAAAXnUWcGBt3YFJ7WltVA0oD7D5jXLqYkEh7wyTHZ4FClRMEQIgtz
        alBBoCuk/KKaUETjGdjR5eKLvpV0az16LjeC058ymQ==
X-Google-Smtp-Source: APXvYqx/Rf8XzMbh6t42iYf7W66VeqeMOFrmw7qPFixc5UDiRQzu7Fp4IBZWCY/9PF3dsIycbx6I4ZgzevceUWQ+xOk=
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr15612473ljb.74.1554721478718;
 Mon, 08 Apr 2019 04:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190329084229.17018-1-geert+renesas@glider.be>
In-Reply-To: <20190329084229.17018-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 13:04:27 +0200
Message-ID: <CACRpkdY2G6xJf7WbraXvH0p2Rp=FVJxnsnJBCzCpZZmPag5bNw@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: Optimize quirk checks
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 9:42 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Simple string comparisons are cheaper than DT lookups, as the latter
> involve taking a spinlock and traversing properties.
> Hence optimize quirk checks by postponing DT lookups after string
> comparisons.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert! I merged v5.1-rc3 into my devel branch and
applied this on top.

Yours,
Linus Walleij
