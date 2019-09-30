Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16560C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B62216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfI3Kdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:33:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39380 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3Kdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:33:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so16309268qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgXGsq2qDG4C8cBxY/ksmuSKorFjC25Y3974yHPlwp4=;
        b=fMN0Fzx9kBvuF108MT4MelVF2lpP3tLmiiGztPBjQYlAxJcdFfBKP9mwhY0kevB2WB
         bZhfRVzswVCtFqeFzwJ/DRWgnh2Y81i1nlFbyQBGLnDUfRcpTtQ1H1yaW4yVcb7O+3xk
         h8wURdqCurxuHQaOWC7jIEgzXhZDLm+27YMtUi5V5X3dLxOluKh5CytW74dINlvgUXgG
         yUfKTaORxIRKtL7jIFRXHRWA2L6qbOOvgvREw49pFSfKew4bEyQXOOfQ68GPLSMTyUSY
         oxnJuoe05DFZ8aUWiV51fnSiH/MZgCz4rwa7VNStTAWYSmgIChnxbA9iz8B7qwzWPs4M
         HnXg==
X-Gm-Message-State: APjAAAW+Lo5X9JhxelyXVQTpIWUdw16jdHkIRfZx7Xqh+LDoGAAyXhlH
        H67jG4eyaW+iIESTBkdLoOHzaQheHIzYsCz9/qM=
X-Google-Smtp-Source: APXvYqxxeXCx+5QLul2l7M6cReMezN604YtNjFsEIIF0r/XlNTyZB6G92oWdWBQ2Pdjy6w3YfElqXH2vaUa/bH3CmOg=
X-Received: by 2002:a0c:e0c4:: with SMTP id x4mr19858932qvk.176.1569839616714;
 Mon, 30 Sep 2019 03:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <201908251609.ADAD5CAAC1@keescook>
In-Reply-To: <201908251609.ADAD5CAAC1@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 Sep 2019 12:33:19 +0200
Message-ID: <CAK8P3a3_sarrMKij5=sp-o16dXERfWkHhUr0fE49Xv8BvXDfaw@mail.gmail.com>
Subject: Re: [PATCH] uaccess: Add missing __must_check attributes
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
>
> The usercopy implementation comments describe that callers of the
> copy_*_user() family of functions must always have their return values
> checked. This can be enforced at compile time with __must_check, so add
> it where needed.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I can't find any other reports, so I'd point out here that this found what
looks like a bug in the x86 math-emu code:

arch/x86/math-emu/reg_ld_str.c:88:2: error: ignoring return value of
function declared with 'warn_unused_result' attribute
[-Werror,-Wunused-result]
        __copy_from_user(sti_ptr, s, 10);
        ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~
arch/x86/math-emu/reg_ld_str.c:1129:2: error: ignoring return value of
function declared with 'warn_unused_result' attribute
[-Werror,-Wunused-result]
        __copy_from_user(register_base + offset, s, other);
        ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_ld_str.c:1131:3: error: ignoring return value of
function declared with 'warn_unused_result' attribute
[-Werror,-Wunused-result]
                __copy_from_user(register_base, s + other, offset);
                ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Moreover, the same code also ignores the return value from most
get_user()/put_user()/FPU_get_user()/FPU_put_user() calls,
which have no warn_unused_result annotation (they are macros,
but I think something could be done if we want to have that
annotation to catch some of the other such users).

      Arnd
