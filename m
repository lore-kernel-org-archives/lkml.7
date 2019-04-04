Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B24C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA472075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oShr81BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDDSzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:55:41 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39270 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:55:40 -0400
Received: by mail-yb1-f196.google.com with SMTP id b88so1436698ybi.6;
        Thu, 04 Apr 2019 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25sghkzH7+QQTBx8fQe0oQc1kNQMTCVYK21rCY5qth4=;
        b=oShr81BXfJmMNACrlPJNe3qZjMk8TVDODP/4DOZSEiguPFnp1XoQQSzj2L+/S7OgcZ
         xlRxsRSl3LKCT8cceZDc18vbr0akZuu8eHO9YvBuQC+ZF/Bg8Nd03nDvnFvPx3DTgSB8
         stQjWpAL9qfP/+KDg6paUcBuFqxkPiT8XzUlvjf8FjjvD7SiRbtUnQVK6FFEUypEDtYr
         qEOfIrGQMIzPvqW5P7S02ntouLCBWfQfbcVkwPGrsbjjwDMVuxZQUHNol5XmKFpEaG1w
         tH/XQqKdk0d4pVTwSgCh0Dh/8KyNP9gBybXk1tsa55B2gmsPvleeNJBUVZHmlKELfyUB
         hvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25sghkzH7+QQTBx8fQe0oQc1kNQMTCVYK21rCY5qth4=;
        b=QH/Zp5hjqFssyt5jMr0iNkwZlmUInoU2/O0B1WBiRHxfP+FQqRfNGWcNttquLQTid9
         Wg4HAxlyzoCZZDlBkmHZX4rJlJgwJOW9DFo26ZY4H0Ck9SvSbbbCJwgM4C9BjVaKHheu
         6dZoHIwDEYB0VmBsIMzP6Kma12pM9ApYoW7MPyq+H3CgOp1d/C5DE4VNMRYg2h65T4tP
         zBE0OPyyt9qrCd15he5zCpfUYnemlb+4AgSttv8gleFBKp53Ybqg9V9WNGU3CjAz8aGY
         1Y1ru8jQIvC6tq8aOoVnZ/762eSosAJgJgM2YNiZWtoRQR2Iol/vNo6/LQkDIXPpU95+
         Gn4A==
X-Gm-Message-State: APjAAAV5Rm+tfuTs5ab+BLeroFuO9xHAzKBwSdhTytxIVx/YEL+Vw6HI
        spQp7cgDFwKa6elEigtlITHPzmuYPPJaENJaIvFcFf83pnU=
X-Google-Smtp-Source: APXvYqzh21O0ITqX+GxLGlXQTKYy8XTPMJsQuockVZOBkdbHKpkJnf7AUuLxdh0xNW+jLZEdFbPk0yqWF+qcuNBCN9g=
X-Received: by 2002:a25:6e56:: with SMTP id j83mr7056113ybc.16.1554404139647;
 Thu, 04 Apr 2019 11:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org> <20190401134421.442323029@goodmis.org>
In-Reply-To: <20190401134421.442323029@goodmis.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 4 Apr 2019 11:55:29 -0700
Message-ID: <CAMo8BfLooVJgKCPQFDXUAfieH3XAF=Bhz2PmAb+3t7BhVBW5FQ@mail.gmail.com>
Subject: Re: [PATCH 6/6 v3] syscalls: Remove start and number from
 syscall_set_arguments() args
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Dave Martin <dave.martin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 6:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> After removing the start and count arguments of syscall_get_arguments() it
> seems reasonable to remove them from syscall_set_arguments(). Note, as of
> today, there are no users of syscall_set_arguments(). But we are told that
> there will be soon. But for now, at least make it consistent with
> syscall_get_arguments().

[...]

>  arch/xtensa/include/asm/syscall.h     | 17 ++-----

For xtensa changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
