Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E1C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6107B206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmE9Y07J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfFRJib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:38:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43318 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfFRJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:38:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so13433478oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fLDkKRkgzc7eE1dlOkMBAFp8cWuW8s86ixr8n9TiM8=;
        b=AmE9Y07JUBPxzGcD1J9f0LpoVT6BW4XFItWxQtWsq1bOY1uSmIME0YmGeM/JuFbck/
         mFMt7hKWfsAFi3I9jHY8FyMesDuRlcSkqWgUAvggg6+SIBx0jkwrKFPuGSs+2N6hVVrw
         up5JrKDu8F2SS9VITpTPV7YlmjOiBwrkYBWGe7B8hlglXyYjYFND8YLX4qfXfiL060Y0
         TnKu57Az1hM5oyh54Erg+zAJHBIEfPfm51z/MWNjRy0LuylnMJYM5JjwpPAwOgbqzEVV
         lor1NIUfbs7NPp+NyNQ5OsK/xDhaGmzixxZUM8eEJTFfp9YayDBVVCUnv9wjiRQ8u2Ti
         k3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fLDkKRkgzc7eE1dlOkMBAFp8cWuW8s86ixr8n9TiM8=;
        b=MyzfZ+jIf81i/Y3K0wCO+aNE6amOZEO9U5D8wOpKEAxQceHTqM9MM8xwRMK8Zd4MkO
         ldZfIbyaQ1kWTi+skw3fmtvu4Iq++izoYuOjaojyipvhfMJpWpdtLyhPv2+4uDmy/RZP
         1xtStu2NGmyNxSFuq36YjedFz526yC1EI3Khs1619HinT4gzGeT4AkhwdfamUxD9WCDb
         55iK2Fb1bTaZLnNpX02zDJMgDBF5PCcVR2Ofi6jBaOlAlzgedpTxCdAejCoV6M5x6tv6
         LPT5z7f0NqkhN+6zUMcJ0HuKMGa8l73CxoJwDNuVVH3nBw89l4GYoec2i587NTa1XNyo
         2PAQ==
X-Gm-Message-State: APjAAAU6+U5hXOt4OgCZUqV3S75rh3nhNEmwyebWt4aS12rq0L5dv1X/
        FWpzP1TL/zrNN4JGKt5c1ks7tQYEuOx9m+IR7uwIz8hN
X-Google-Smtp-Source: APXvYqzDTLUQp01oTuXLSmw8BKDNfkPPwQAiDJmWwDWKcEFSmmLud111OCXmNXIGf5wq52BLBj3yiVgE6U8RxoSEHSc=
X-Received: by 2002:a9d:12b7:: with SMTP id g52mr32902066otg.32.1560850708603;
 Tue, 18 Jun 2019 02:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190618045503.39105-1-keescook@chromium.org> <20190618045503.39105-4-keescook@chromium.org>
In-Reply-To: <20190618045503.39105-4-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 18 Jun 2019 11:38:02 +0200
Message-ID: <CAG48ez37iY3pfTWn4wiqdt7zdkSPpOcvz3gtwjTWAYz9qKbBNA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86/asm: Pin sensitive CR0 bits
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 6:55 AM Kees Cook <keescook@chromium.org> wrote:
> With sensitive CR4 bits pinned now, it's possible that the WP bit for
> CR0 might become a target as well. Following the same reasoning for
> the CR4 pinning, this pins CR0's WP bit (but this can be done with a
> static value).
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/special_insns.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index c8c8143ab27b..b2e84d113f2a 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -31,7 +31,20 @@ static inline unsigned long native_read_cr0(void)
>
>  static inline void native_write_cr0(unsigned long val)
>  {

So, assuming a legitimate call to native_write_cr0(), we come in here...

> -       asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
> +       unsigned long bits_missing = 0;
> +
> +set_register:
> +       asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));

... here we've updated CR0...

> +       if (static_branch_likely(&cr_pinning)) {

... this branch is taken, since cr_pinning is set to true after boot...

> +               if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {

... this branch isn't taken, because a legitimate update preserves the WP bit...

> +                       bits_missing = X86_CR0_WP;
> +                       val |= bits_missing;
> +                       goto set_register;
> +               }
> +               /* Warn after we've set the missing bits. */
> +               WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");

... and we reach this WARN_ONCE()? Am I missing something, or does
every legitimate CR0 write after early boot now trigger a warning?

> +       }
>  }
