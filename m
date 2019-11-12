Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3FAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F682067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="huzbkS+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKLH1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:27:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47066 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLH1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:27:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so16535170ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4PBC6XASGOKS4JAF6qAY3nfg+656mf5Ffbsp2SjMOU=;
        b=huzbkS+lweY6CWt6g74Pcr8qGst6v0knwvUw3PlvRXbWDrZJjG00zTvIpdBw/HEfNK
         /Q9qG0Xe53I4vyhIQrQSxfyp9cwHiTVbUFGOtuR0m79ccrcyhqrNoy1bt393gXB6lSSw
         AGBx8KfNaFrMvD6a7IZI9Tu/SvTpjkrllxUnsPpS6EMQtLmHl9UcxC8rTiEzdBbxHgqm
         FkmbrQTaLetlUqbwjFxlXkpkwO73ZxGe7fKg4wKySyENfxQP+CFsVbCeqx6P9YXazcCb
         G35ca/AQ5mKGzU5jbXfhZoMJ+0a1baLTfGZz5zCeSGauOj8nAfLXt7PiucV7Q9jK95+m
         t7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4PBC6XASGOKS4JAF6qAY3nfg+656mf5Ffbsp2SjMOU=;
        b=B5dqK9qv/IZ4j4g4bVOc+qh5gylV7sdaVuxgziJRs9JDuaOhguXqbjCKdF/DTjnx3l
         olWirKw4/pwyi67uFiqqkAlwLSPT6s34uj/1P2qF5buZt1yBD4k1s+A88sb2O8/6P2IU
         QhN6zz/NiKQ8d62C7IfJYQtfhpXrvemFCYLoR6eQyaWCYee+xLQuQTdITL8MbdnkS2Co
         kr1Muz9uePH1kn+G5OoSiahDH58nxjux9Ytb8+1oD/CrCO+ZaTX9zn7ogRJ4Wp9jxPZ4
         VDZQIWEsbrcvTOh/cAiefT4say3Q9RbbNfBzn986xG0uCpsW6fzLmpPQQ0YoVngJh7LM
         5t0g==
X-Gm-Message-State: APjAAAWPvNLOSDDJHX6gn+ci8m6UgU5L11KIk/ecnIRVcZzlrZXq89h9
        mZDmJqcsFZVdjy+ojx7uU6Y34wCKwi7pAnkcnDVX2A==
X-Google-Smtp-Source: APXvYqwLYytt2T33G4K61Iai/NezRd71YPs7Z4MOUgQBlMexOGDjpoWKL4uuX0lRjlNJutRysjEUqzVXInQX8+/FI8E=
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr11252951ljq.20.1573543658646;
 Mon, 11 Nov 2019 23:27:38 -0800 (PST)
MIME-Version: 1.0
References: <201910301244.9C3CABCA0@keescook>
In-Reply-To: <201910301244.9C3CABCA0@keescook>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Nov 2019 12:57:27 +0530
Message-ID: <CA+G9fYvcD=rNmkQn_bsBO0RUVwhQA=TtzP1AeqLqwfKjorLWXg@mail.gmail.com>
Subject: Re: [PATCH] selftests: Move kselftest_module.sh into kselftest/
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Thanks for the fix patch.

On Thu, 31 Oct 2019 at 01:15, Kees Cook <keescook@chromium.org> wrote:
>
> The kselftest_module.sh file was not being installed by the Makefile
> "install" target, rendering the lib/*.sh tests nonfunction. This fixes
> that and takes the opportunity to move it into the kselftest/ subdirectory
> which is where the kselftest infrastructure bits are collecting.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYsfJpXQvOvHdjtg8z4a89dSStOQZOKa9zMjjQgWKng1aw@mail.gmail.com
> Fixes: d3460527706e ("kselftest: Add test runner creation script")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Now this patch merged into linux next tree.
Following tests getting pass.
 kselftest:
    * lib/bitmap.sh
    * lib/printf.sh
    * lib/strscpy.sh

Thank you.

Best regards
Naresh Kamboju
