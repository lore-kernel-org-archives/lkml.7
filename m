Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA31C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AF1206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573679439;
	bh=3hEkcmaUqAnk2YtPx/2AinQ4e6drdpknUYtp2Kk23H8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UFN2HisoQ3ZdJGyPIVIRJsR2vF8jf8nDHTQXFPrwdf7dV8vUDA/CmtS/jUaIrxoiJ
	 BuH/p3/potpoOh8lPC/vdzV6xTVfHM6Jadys9BiBrsBlDwuXGVujR/r1VmEXU9uwVp
	 z7iLqCl4zb78R/BfBBxfZDJkM/Kau9yAn7CCXS4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKMVKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:10:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46005 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:10:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so4166968ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91N9W8fnm/Fhfqn455X3m9/csATT/jXc8I2Ji17aZzc=;
        b=Mf6ceFn3HIXyCXGllj+S6+rL0Oyk5Vg2Ksehm712c1feeeeBFfn38uvk8g+ZDi2lDM
         /DKVg58REdap/+mZuUAckUJIgt624cVXCYbpq3AlNnquRj209aGdVCbiQNLt25vbCoR/
         PKHeiM7sE8M6mbU6rdxidHxwniSU4DXq8pTw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91N9W8fnm/Fhfqn455X3m9/csATT/jXc8I2Ji17aZzc=;
        b=KEWxraZY0z33MM3xX4oHnUk53ehzJOekMlw1MHN1uTLRM0H8ZLxNyMqvvEzElB7Ktb
         thMf9YK0ZqMGd+rpgA7usaT2BK6SKC7RZqG9TrT8bjOs8SX8DF7zOn7od+K44KjJSvTv
         aLzyRwlvDK3/7uNXXuRkedAXAmrgMKfZTyN/EisVkBTKi1mc1mVpaZKC6PLAyiZxl3z+
         /bbldkHSaqe3/lQ989imVtP8pHcyQz8sfRe7OD6KhAJxO0rLsY+NIHxyjtfkYfq5M5tM
         KZoLUDJUQasyvZ5lVzfM1DOFISUGJXKsi37upaik/tV96jhgcN3NeT1S00YYP5JkJu3c
         AXRw==
X-Gm-Message-State: APjAAAV7PgPLwJ4M4tWcMbYMOGZEzw6YTw7qoDXkPpGO6cazRHnOU6D1
        h6Zr0LBkia06ndVU2o0CvnyCTg4MjMY=
X-Google-Smtp-Source: APXvYqz3qiKdlr/wJPbgPL1JAkSz1Ox/1kNvBfOkzYXg0KNlAhmaYaaWDiSeA6xHaORXCoEc/VdktQ==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr4014354ljj.105.1573679433227;
        Wed, 13 Nov 2019 13:10:33 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x23sm1554871lfe.8.2019.11.13.13.10.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:10:32 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id d22so4193140lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:10:32 -0800 (PST)
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr4116040lji.148.1573679429322;
 Wed, 13 Nov 2019 13:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20191113204240.767922595@linutronix.de> <20191113210103.911310593@linutronix.de>
In-Reply-To: <20191113210103.911310593@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Nov 2019 13:10:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNAEuNPU3Oy_-EpjOojpysWcCh4uqDgOt2RjBNx2xBSg@mail.gmail.com>
Message-ID: <CAHk-=whNAEuNPU3Oy_-EpjOojpysWcCh4uqDgOt2RjBNx2xBSg@mail.gmail.com>
Subject: Re: [patch V3 02/20] x86/process: Unify copy_thread_tls()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 1:02 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> +int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
> +                   unsigned long arg, struct task_struct *p, unsigned long tls)
...
> +#ifdef CONFIG_X86_64
..
> +#else
> +       /* Clear all status flags including IF and set fixed bit. */
> +       frame->flags = X86_EFLAGS_FIXED;
> +#endif

Hmm. The unification I like, but it also shows these differences that
I don't remember the reason for.

Remind me why __switch_to_asm() on 32-bit safes eflags, but we don't
do it on x86-64?

The comment just talks about callee-saved registers, but flags isn't
callee-saved, so there's something else going on.

This patch clearly doesn't change anything, I'm not complaining about
the patch at all. I'm just wondering about the odd difference that the
patch exposes.

               Linus
