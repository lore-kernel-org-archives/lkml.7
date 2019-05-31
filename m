Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C0B26EAA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kV49vqq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfEaUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:06:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42362 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfEaUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:06:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id r22so6820896pfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TL9DcOEKgadixiKIuv445aeR9WBFQdFXZrUAgDcDlE=;
        b=kV49vqq86GuJyq1B2ExOHqAEHCBbLYAxLrlwX9YHW790oTpaKgrElCoYJHUXWkgOJV
         TyS26P7yQV73R8/GWkjjhukLJb66Q7zUUUJ7a2B93/pJZO6Shv5cFVuO06NhX0qS4a8f
         ckE9aHhSd9lIxLohPE/+lCMBZ2E8LEVATqVLm7wOqPKHieY8trNRGEwdnTfcrdqsN1Fz
         yu0mhBAzkmIxIgd+iih/pD0/QURI9+rxP04X2IHVXV+35kUITHS70Eb+sKRt40HBMm7w
         s6s3jP7zdEP+vz/WybVa2KYlVXm/9BI/SzyLBAfs7+4YVEhu/Sm8BI/uV6UgsPEc/XKh
         zXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TL9DcOEKgadixiKIuv445aeR9WBFQdFXZrUAgDcDlE=;
        b=a+FkKSYEKntZT0lwjABmXi5ZRPu/phRMy5Wfb380xirVtiGdB908pUVjALcCw5SauF
         THEPXTog8e/Hj23+Ivi6RWS3DtKdFEosokkxn5c1oVoY8rhN9W46AggmH9KAYv/hthBM
         eOU62l3uUyLjZn/PYh1dAEI4QluKqJNKQg3nf8Yk2+EETtVetMneRMHJGl2E8CQsS2fb
         oRpXLjfbai/IJWubMJCQKLtL4iQNBdzfB+PjM9FBYR+G4dQHyvyhqoS6FOFO36nPsgEC
         ruOD4qHK52lgyo9egVcHDY4Plp2mUIgDM5hs/s+OFR71cWjbJcxws7PmVidN+wh3ZIf4
         8jWA==
X-Gm-Message-State: APjAAAWYO+5t/NnFvK4mAtyGhssdjfa8q+Z/Ib/nQDLGwK6trrcJXxeN
        3/59ltfX/LrOAkRxpx729NF+loqHDT54KE0Vu2VzCA==
X-Google-Smtp-Source: APXvYqyEK1gsqxDA0Or/CK+vKBpJnggOs9awLB6ySElXj4BB/3+n9Gqj3w6GYh+I5qrhLxZWF88p5xir5ByMCP3e/lU=
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr3043266pjq.134.1559333185173;
 Fri, 31 May 2019 13:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190528235742.105510-1-natechancellor@gmail.com>
 <CAK8P3a0a0hMsZDkqKsfsyCWpdvDni72tjAxCz2VeAaU56zqrXg@mail.gmail.com>
 <20190531183227.GA34102@archlinux-epyc> <CAK8P3a1-_KRvoeK4w0b8775izox8fRm=NGJC=yicDRn7J5UW2Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1-_KRvoeK4w0b8775izox8fRm=NGJC=yicDRn7J5UW2Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 May 2019 13:06:13 -0700
Message-ID: <CAKwvOdkyk3qLMPquSZqXCFauTADJU5X9qJi_fhJqbUuCYBH-6Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with CONFIG_CC_IS_GCC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> clang, I would suggest dropping your patch then, and instead adding

I disagree.  The minimum version of gcc required to build the kernel
is 4.6, so the comment about older versions of gcc is irrelevant and
should be removed.

Nathan's -Rpass warnings are warning that vectorization was not
calculated to be profitable **for 1 of the 4 functions** by LLVM.
Surely we wouldn't disable NEON opts for XOR because 1 of 4 was not
vectorized?

-- 
Thanks,
~Nick Desaulniers
