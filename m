Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1A8ECE58B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6E121655
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6HKMWfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfIZQir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:38:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36201 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfIZQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:38:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so1552923plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcizdKb+Z4/lJ6JqxlQ4rkSWRCdcDTnk4AuXkCAC72c=;
        b=a6HKMWfahkSRLhdXBqLOI4331GtOfMQLhJdeauMHBECSD7OBz9HusjF/ALZgOHT2TN
         ioDfXKJEvnRsLuzZfkuGFP8DbfgB5gYOJt9FVQ0wZA3JnoeK9aBcf6COKHE5v9MvLNaG
         N8DMYHjxgXQeJmZxg7NSZDh1hPDqyrtLByTnoHmNfFJwDF7VetVCo9DPrXQw9FQwb/jM
         rR0BU9uQhTI713siuR1mzReF5QCFwQTBz6KINp/nWcfOlX+yzqyK7WM765IquAy2Lg2b
         KUqi8QGxZT42240+yRuD4/KHmac5CpKsOox1N4gjE3o7wIeYgOtsFvNUKO7IkYud18xi
         2UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcizdKb+Z4/lJ6JqxlQ4rkSWRCdcDTnk4AuXkCAC72c=;
        b=IaHEVu/CAuDQm75pcJuJnUp7Fpb6ZQK+VDkNmPG6+e5r496Kxza9hXgHB8dt/vjkSo
         uvgjpGVDhrnPeEGiv1WRJDSU4KajbhmrcnumAHsCnq7etoGk/GIP38IgSZkvS+0lFYSR
         2/dmfOBtmwSNqVq+vSxK3z+nVo8UHTtbzXB1Y4+MAu3E2QiKmLvMVvRmA0aFdJJ9whij
         1bFPdo/wLbfievtpfUHHHXFuppjga95VazNWncpzpKKbmNJmlKvc+tR7eePjcjmUe+gz
         GgqdDeqhyqmFblq7WlOUiJm8sNfbV99i7Gs7xwY3sTMFB0jBz3UXICoA2hOk3z9HACOh
         upPw==
X-Gm-Message-State: APjAAAVNAIiR5eCpUNycV8GTFJRzowIg2k1idHkqewj7e5T48EZHOB0r
        klaEE8k2gqI7EEUTrsbCUKZk1AzVFFdtKRM8Gutzmw==
X-Google-Smtp-Source: APXvYqzSGsS4gRUL/eu2gcWx+JhX8X30L2iaC1ezMf5Qttm0lEecH4vESWL2CwHX0QI0ThBV2kSd1RqXI72KC6HZAkg=
X-Received: by 2002:a17:902:bb87:: with SMTP id m7mr4782990pls.179.1569515925719;
 Thu, 26 Sep 2019 09:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190925130926.50674-1-catalin.marinas@arm.com>
 <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com>
 <20190925170838.GK7042@arrakis.emea.arm.com> <a7e06b86-facd-21de-c47c-246d0da8d80d@arm.com>
 <20190926074717.GA26802@iMac.local>
In-Reply-To: <20190926074717.GA26802@iMac.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Sep 2019 09:38:34 -0700
Message-ID: <CAKwvOdk2KzXfLzKgMvmQsss_-CchE_dhWc7Sy24DUu8r+Ryg_Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: Allow disabling of the compat vDSO
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 12:47 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Sep 26, 2019 at 01:06:50AM +0100, Vincenzo Frascino wrote:
> > On 9/25/19 6:08 PM, Catalin Marinas wrote:
> > > On Wed, Sep 25, 2019 at 09:53:16AM -0700, Nick Desaulniers wrote:
> > >> On Wed, Sep 25, 2019 at 6:09 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >>> Suggestions for future improvements of the compat vDSO handling:
> > >>>
> > >>> - replace the CROSS_COMPILE_COMPAT prefix with a full COMPATCC; maybe
> > >>>   check that it indeed produces 32-bit code
> >
> > CROSS_COMPILE_COMPAT is called like this for symmetry with CROSS_COMPILE.
>
> Actually, what gets in the way is the CONFIG_CROSS_COMPILE_COMPAT_VDSO.
> We can keep CROSS_COMPILE_COMPAT together with COMPATCC initialised to
> $(CROSS_COMPILE_COMPAT)gcc. When we will be able to build the compat
> vDSO with clang, we just pass COMPATCC=clang on the make line and the
> kernel Makefile will figure out the --target option from
> CROSS_COMPILE_COMPAT (see how CLANG_FLAGS is handled).
>
> If we stick only to env variables or make cmd line (without Kconfig) for
> the compiler name, we can add a COMPATCC_IS_CLANG in the Kconfig
> directly and simply not allow the enabling the COMPAT_VDSO if we don't
> have the right compiler. This saves us warnings during build.

Yes, I think this would be a nice approach.
-- 
Thanks,
~Nick Desaulniers
