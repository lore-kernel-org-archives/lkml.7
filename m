Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898FFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD8E20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7OnnKII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfJUWn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:43:28 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45815 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfJUWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 18:43:27 -0400
Received: by mail-vs1-f68.google.com with SMTP id y1so1212811vsg.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 15:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8E0A8Vlgzb4xSRYYj/bS6TXPUSZill0B9wa3qYYw0E=;
        b=b7OnnKIICEZMVXFl1NmYOdDcFZHXchQiF9AA/1N5pJuawnuvHkVE1IlsM/lRRh2pOy
         +tASGs8d3rjxlFCky/tFGjrZodoX0p4Deov9tvP++w+7DeZr8MYEjdMkf7sAhwlH6Gxc
         WJv6o+CSvqzoTlGP8vtZanFkkIcmQzBroXGREgjwNEhr/HuPvHIR+xU/UJcSYgDti2V1
         r1cQGVXNTkoPdaT2rZPVCTE/vqwrjXU7v+mianqUEVDhMJMb0ii90mYChlbeJqqrrVsO
         xszro/NyKQZOLCMnYcBtQPbBwGcEqBHnQ5xmgMZkhV8tOojOjuh3cxC3jt2Py6yycBJU
         fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8E0A8Vlgzb4xSRYYj/bS6TXPUSZill0B9wa3qYYw0E=;
        b=YRfrebDqfIEueUQHBxAlEWZNVJQATJ4W+eMUNYfv/g86jlrLO2RVifghqz8OrVWKh+
         UgL8vOEOlqTTECcsJhdjqUOomaO0LVqIHXyUTx433QL12ropc0Ns7QJVzWm/XlHqqHyV
         rjJp3FVO85ti6hJ2DDmEWyvu8+8KwzU8XYHmu4SwG08m3VfajHmjqDffWKjwITYLw+uY
         oJ9AOxMZ065mwJwacySkC2MU7JBJgITGna0dhVJ7fV4x9Bdw6/mwCDbjMc8T5LezzT+E
         u8eui0WA73k6whjOeXq68L02BCoaGvRr6vVmc30sRlrFRpzQLokszYR8+8+4KItuuF5Z
         PA7w==
X-Gm-Message-State: APjAAAVjWM+SXfyCqrF0J8gRURqVT/S1cO7hqPyCw3NzXcMhbGiJdR9p
        ZA7XrjhnL8xYaewO6Il6OCbPTWltajF/Z222asHw7w==
X-Google-Smtp-Source: APXvYqxm3g+B4XpEPIU+7n7e+ETZjean8RmHMKds1LlOCp+Q7indJHinK9NpFNA5K8TZ8NnejNJPfqBCKWSQ8YgLxPA=
X-Received: by 2002:a67:fb44:: with SMTP id e4mr113225vsr.112.1571697806489;
 Mon, 21 Oct 2019 15:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-14-samitolvanen@google.com> <20191021165649.GE56589@lakrids.cambridge.arm.com>
In-Reply-To: <20191021165649.GE56589@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 21 Oct 2019 15:43:14 -0700
Message-ID: <CABCJKucm2ETxe2dgJhb4Ruzq72psFMGsx=0D6TVnJ-_DL2FgfA@mail.gmail.com>
Subject: Re: [PATCH 13/18] arm64: preserve x18 when CPU is suspended
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 9:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
> This should have a corresponding change to cpu_suspend_ctx in
> <asm/suspend.h>. Otherwise we're corrupting a portion of the stack.

Ugh, correct. I'll fix this in the next version. Thanks.

Sami
