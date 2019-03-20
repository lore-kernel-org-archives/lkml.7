Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F43C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DDB213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfCTNeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:34:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40235 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfCTNeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:34:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so2455220qts.7;
        Wed, 20 Mar 2019 06:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxb+cto02BIatCH7Gsn3jweAO4W1kfw2CVhMuPz2fqU=;
        b=Cfeb3wPaKiU9JH8ehNkOHiAq/mUbUXMdOnbFWoURTfzhCk0khmFrXUs7XnwYyj/s7Y
         gGUgnGVXpzb2ZddE+Dj/lGW9N2/9WDt+N2Z76gFyH3OKoQ1pS+DxLf1roiiKgtHrXea/
         QUHuM9LSaUCUOsRM9jUHqzTqbTDUCeNfQURah8dhEb+wwoUQ6xK3IWrwObzZlPzJIu1o
         XyyKX4rEV8SHpYWvYgSuB2paQ/06dsAg8v/SrDXQxwAh+/OEKq6VgAYi/gSnNEdq5yXY
         N/9tdVQWzAV5cu4mBqygwgqgjLPzq0WfZ+3RVsrXnndmDMDzKEBhrMpo9FUTHpdrfVFf
         s9gg==
X-Gm-Message-State: APjAAAX7WOEWCei9NqVuoM8Zat7MCT/H7J0FKkGnNI6HpYj6sj9CX+qD
        O6Gc3++b4LodGAbNaLMA7wUqNmbktXnfCEjP91o=
X-Google-Smtp-Source: APXvYqz9MW7CJwO9dJ+S+7Q1aJsu3zP2Bpyeyex9t6Dgx6Q7wQ4uZyS7kKe5y9Us8CNX6vU0d8jy9lg1/AmI+RSWdPc=
X-Received: by 2002:a0c:9487:: with SMTP id j7mr1278926qvj.180.1553088860133;
 Wed, 20 Mar 2019 06:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com> <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Mar 2019 14:34:02 +0100
Message-ID: <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I've added your patch to my randconfig test setup and will let you
> know if I see anything noticeable. I'm currently testing clang-arm32,
> clang-arm64 and gcc-x86.

This is the only additional bug that has come up so far:

`.exit.text' referenced in section `.alt.smp.init' of
drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
`exit.text' of drivers/char/ipmi/ipmi_msghandler.o

diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index 201100226301..84b12e33104d 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
 const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
        unsigned int machine_nr);
 #else
-static inline const struct machine_desc *
+static __always_inline const struct machine_desc *
 setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 {
        early_print("no ATAGS support: can't continue\n");
