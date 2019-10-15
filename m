Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6C9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6209F20640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpChALqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbfJOOtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:49:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46769 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732949AbfJOOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:49:50 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so46371101ioo.13;
        Tue, 15 Oct 2019 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MnfGhBwoMQVplo0Mxn7uRwpUlFBd/nvB/PMi8g7Xh1U=;
        b=HpChALqW5ydj92GSRYuzlp/a2ptuL2yYJa9gu43hB86GrFD2wsntp8ZwrGiipcl4Io
         1+Jp8HIXVFih7E4dj18vLN2+zF7PktHbNlCWjgUVqLzofRBzEg5UyGO8Ytvk9VI8D+Rb
         ixa92S1aqah9LEEOfHVsw2rfoIUvuyFFFyENM98IzYOT3NeRZEjBSZ5kvrHCpqZsQK8d
         pkVkSYaflHnt0uHjPTtSvChOsK6mlx/tla+N6pBcZmdk1DYhNGzPtrwwEyYUTnmZ4ARc
         KhvCYtl3MJ/HznGBMkU+jGXry/UWXhsE2hF8k+vzbIAsl5FI0/DfEoGTENgs1ff8g9q/
         DXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MnfGhBwoMQVplo0Mxn7uRwpUlFBd/nvB/PMi8g7Xh1U=;
        b=ALnBrhIEsSo45W0YNxWQGRDpGq20UGLIgL51jH/IxWxdib7we+Nbx/urudcz3o/3mN
         gvGtaWYBgfn/82bPhSydz+RP0x+KwvcJuTtwFNj4+JYe7YBdeDJB5ar6nvm4X5Jx5ZsW
         G6hEHTMimFrmqfhnmlZ54+6FtsXErpO8OoQLXFE8ZrD8yPm/5WGolj8UbYKalBd4T59D
         bRHqi594gvT8wORtOWGZo9p6rNyQ25d0mgHnAPgkaQ09APoGyUO/lbWfZ1gtPdGvULgK
         Qkzf0WvFjWcip94s56wZ4J/1arMPtqxQaDP6p8qnQ2s8b+YRcWPgsy+UMVRV3fC13p7d
         vZPQ==
X-Gm-Message-State: APjAAAWTTAW5UlWQHVFm4b1nfkQGN06FF/2f4EROGzJqZA+CmxVd0kQS
        1CaGN+O5+iCIv5P7rH0hvsq4UEDCWK/loDgFwDo=
X-Google-Smtp-Source: APXvYqxTZYfSAInwbYJYC/2UZ9Wkj95sKUVbKbOdag8+jQHHQ0zR2edcTXeR50zAV5DWbzbCGXPPiw6GtJnoneBkA98=
X-Received: by 2002:a92:9ecd:: with SMTP id s74mr2230665ilk.145.1571150989602;
 Tue, 15 Oct 2019 07:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <7933ce8f-ca1b-6ed8-14b9-59679130dc47@web.de>
In-Reply-To: <7933ce8f-ca1b-6ed8-14b9-59679130dc47@web.de>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Tue, 15 Oct 2019 23:49:39 +0900
Message-ID: <CA+Ln22GpcMF5e8wjwoRH0wExyoGfta4n3YuaOBNDE+rfqhSZjg@mail.gmail.com>
Subject: Re: clk: samsung: Checking a kmemdup() call in _samsung_clk_register_pll()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

2019=E5=B9=B410=E6=9C=8812=E6=97=A5(=E5=9C=9F) 23:17 Markus Elfring <Markus=
.Elfring@web.de>:
>
> Hello,
>
> I tried another script for the semantic patch language out.
> This source code analysis approach points out that the implementation
> of the function =E2=80=9C_samsung_clk_register_pll=E2=80=9D contains also=
 a call
> of the function =E2=80=9Ckmemdup=E2=80=9D.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clk/samsung/clk-pll.c?id=3D1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a#=
n1275
> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/clk/samsung/clk-=
pll.c#L1275

Thanks for the report.

>
> * Do you find the usage of the format string =E2=80=9C%s: could not alloc=
ate
>   rate table for %s\n=E2=80=9D still appropriate at this place?

Yes, AFAICT there is nothing wrong with that format string.

>
> * Is there a need to adjust the error handling here?

No, there isn't much that can be done if we fail the allocation at
such an early stage.

That said, there is no need to print any warnings or error messages on
allocation failure, so technically they could be removed. It doesn't
really give us anything in case of existing code, though, and only
makes a potential for merge conflicts, so I'd just leave it alone.

Best regards,
Tomasz
