Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D15C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B287220661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/MCpXB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfCEWVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:21:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36974 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCEWVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:21:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so6774312pfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 14:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuMiW9RY58TRMDMG0Bef7Bg0VGbeYlI+2P5qAVOkc0w=;
        b=m/MCpXB4MewsriQzTTxTfH5qiw7rfqvrYAFrf93+kJsyzOXd/1JW1N+rkjWt7i8YTE
         OVxUbUqVUjnVqsFi0shvGnfwNHHLYrBNP51ptk5K32I9J3Mwqzz0esahnspngZlvgZt5
         hN34LAPo+S550WD9RfDycq3qL+5QrnzIYanxCRqt7r/j1f8+g0N1abtrWYvL8qV0teCT
         bF2bUK3aCnZpZkd5S1t3NEsT8yXS7sX2N/dIDDSm/XjvNV842ezb7bVCVu2myUFf/Ofh
         WqpzGf+sG/ccJmM9Mc0erTQ1MRrtfvUPX8Bh7hCt36mmpDRbNtaMk7Fk1Hp05ZpFpBZk
         yb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuMiW9RY58TRMDMG0Bef7Bg0VGbeYlI+2P5qAVOkc0w=;
        b=A7QItFL5M+reFTZMskZS5TynxiI7uhpazHbzbrBUKnpMEcnGe6BMHHwpIXbZP+jQWF
         zWPPpmB0Kw/EHjUTVizq5AzM+b3VKyL9uKxT3bnQwhDJe4K4TqP2tMGFLgxnMuqDwQF6
         ibQsS8tHO8lguPQwTi88B/Pow+RqNKCe/qmaJao0Y5dJmSBf5FzTIkS8Tl6NKoHF6Zlg
         mRUjiE5zW86QpAlCBOv5wxnOW41EWUYulwEMqtvTSB2eRxqAXDhaP44HGd+eOS8V7ogF
         R80C8zDeLOeLlmDLMJNvbAQk7mJ9CpeuPDgQA3lH/pE6Pw0y5b2qWIWsDBCcHg8WCWn7
         nsJg==
X-Gm-Message-State: APjAAAU4iH5hUlzTSn/QPcTkiAnUjpqPycskyfCp5npRPNGFvr2+cBDr
        ihmIzZ8PY49oUrd7ILetKhZX+N7k0SCWxKalnJjBmQ==
X-Google-Smtp-Source: APXvYqx+NqnC7vb1M06B/G6SsGLwC3WXicAv8uiyGA3LmVzUxQRcSI7nLfUU/VY/kYDKxyNy4M3ENUkaG/TWbR0D+Es=
X-Received: by 2002:a62:398d:: with SMTP id u13mr4032165pfj.32.1551824482852;
 Tue, 05 Mar 2019 14:21:22 -0800 (PST)
MIME-Version: 1.0
References: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
 <7b70b64738db468ab3b830c503524058163b5c3f.1551824161.git.stefan@agner.ch>
In-Reply-To: <7b70b64738db468ab3b830c503524058163b5c3f.1551824161.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Mar 2019 14:21:11 -0800
Message-ID: <CAKwvOd=1sEfg94kg6gbjCrrn3Wcp7BuwWKtGdD9pr_+P03eTMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: drop -mauto-it
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        julien.thierry@arm.com, Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 2:17 PM Stefan Agner <stefan@agner.ch> wrote:
>
> The assembler option -mauto-it is no longer a valid option. It has
> been removed from the documentation in July 2009, which is well
> before the release date of the currently supported binutils version
> 2.20.

Do you by chance have a link to the relevant commit?

>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 9561325c5201..ebf67bebe73d 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -113,8 +113,7 @@ CFLAGS_ABI  +=-funwind-tables
>  endif
>
>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
> -AFLAGS_AUTOIT  :=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
> -CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT)
> +CFLAGS_ISA     :=-mthumb -Wa$(comma)-mimplicit-it=always

Is $(comma) still needed? I thought it was only needed when a flag
that would contain commas would be in another set of parens (thus
making an ambiguity), like cc-ldoption or such?  Can you replace
`$(comma)` here with `,`?  I suspect it should work.

-- 
Thanks,
~Nick Desaulniers
