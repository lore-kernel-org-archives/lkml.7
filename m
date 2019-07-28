Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518FC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945D32075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564324417;
	bh=568BtsUqc8XqUhtRjnSN3w+EBCiEmKgpCYKQqSABEwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LRJftS/Ho45dMzPbaFMPJ279Vz8oQ8Dz9rTBxGLMFROZ87NJvXclclqSENgyzryXp
	 +lsg8QcZi7gKSA2DdNbaQk653/mvT6RA9SrKGC/5JLijjQFKvCxciht4wE3YsxtIrJ
	 cEfikwkt8VE5/h8D8taHGrvUQonV/H9etiivhxww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfG1Odg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 10:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfG1Odf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:33:35 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCBF2087C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 14:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564324414;
        bh=568BtsUqc8XqUhtRjnSN3w+EBCiEmKgpCYKQqSABEwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvveJ75qt+j6eb3Y/RODAw7IF6zxiBmWJbsldTBJ7DGKl7rjeElH6GJh9FAK34paX
         +4zlwVkg9UA0gCkr6LWLbUL6K5Z2Yxp5oiVU4cgpIdlGLEsnsrPUYlQrPEnzRR7eXz
         RZ0K+3Ct0HaKVTm9FRzzgkYy8C9M5YlQ8pG8BqPk=
Received: by mail-wr1-f44.google.com with SMTP id f9so59030829wre.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 07:33:34 -0700 (PDT)
X-Gm-Message-State: APjAAAXC/P6t/Sg9MoP7BKzlVqiJTAliEWDl2UW5b4tOsR18bdznEGYg
        n3KIFN963iy27w56YdzGGDvw6A/1ce7gEoDsMAFNwA==
X-Google-Smtp-Source: APXvYqxj6ajkQA1lCB0rhoBWHvgOtiXhU361Nyt3E6wCXu4pDSXYXultL6K3BYbTzMFwQOtgAvpKt1isUEXiBKCW4Ts=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr108053550wrj.47.1564324413063;
 Sun, 28 Jul 2019 07:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190728131251.622415456@linutronix.de> <20190728131648.587523358@linutronix.de>
In-Reply-To: <20190728131648.587523358@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 28 Jul 2019 07:33:21 -0700
X-Gmail-Original-Message-ID: <CALCETrXbwPNt-SiudX+xup1vmkjksJpy-GJAT2K-g_dFw6d6vA@mail.gmail.com>
Message-ID: <CALCETrXbwPNt-SiudX+xup1vmkjksJpy-GJAT2K-g_dFw6d6vA@mail.gmail.com>
Subject: Re: [patch 1/5] lib/vdso/32: Remove inconsistent NULL pointer checks
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 6:20 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The 32bit variants of vdso_clock_gettime()/getres() have a NULL pointer
> check for the timespec pointer. That's inconsistent vs. 64bit.
>
> But the vdso implementation will never be consistent versus the syscall
> because the only case which it can handle is NULL. Any other invalid
> pointer will cause a segfault. So special casing NULL is not really useful.
>
> Remove it along with the superflouos syscall fallback invocation as that
> will return -EFAULT anyway. That also gets rid of the dubious typecast
> which only works because the pointer is NULL.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

FWIW, the equivalent change to gettimeofday would be an ABI break,
since we historically have that check, and it even makes sense there.
