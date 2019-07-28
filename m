Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F22DC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43722064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564325454;
	bh=X7hFTPq+VOJrwjcV0K1VA1iH3ggRNdqMyY0XEmfMbWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=azh0YwFhEK5E+aIfy3FJOxnPlLWFQSmQRYIa8J9smyqWC3XLMCxlY8E2UV9VuXx02
	 ZceM2dUr0eD22ackZz1UJtpferCTes+jvuquPM/BZtWcBBd7qjEOp24E0aJmSFQDdz
	 4HpsKvCgQSwVz3QkMvpqn5oZrnNnDioSivQgorV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfG1Ouw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 10:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfG1Ouw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:50:52 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC4921655
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564325451;
        bh=X7hFTPq+VOJrwjcV0K1VA1iH3ggRNdqMyY0XEmfMbWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MGObo1m6hdwWEA31EKdolfhteD4+QjYpTjQYIetLHI14/rqJle51qjtcwqkpvIBvR
         xwhqiPITe55ggfD43EdzvRKMmgB2hPp8O72mco1TvURWgldjQ6uc1wm6edKJgUCJsx
         T1E67AjZvEUxZX2RHdgOPW6INVkMO0h0dIapn3Dc=
Received: by mail-wm1-f45.google.com with SMTP id v19so51332724wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 07:50:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXWtJPSzJf4z9sjEEIveGGRuIg0usWe84YNkIau9JRQ0h+HsbmW
        pYokTK6AKjEzEm6r42s/ULwnX1u8sOaRDl9LXzq4uA==
X-Google-Smtp-Source: APXvYqz2QxhlN2yYUUJWCB9rpAZ+QKc/H2PCjh52I7/41f9ugEJdqSx2Nwy+zU/3cN+TLYG5AcbyNYhCJtrxGpey0Cw=
X-Received: by 2002:a1c:a942:: with SMTP id s63mr93823177wme.76.1564325449803;
 Sun, 28 Jul 2019 07:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190728131251.622415456@linutronix.de> <20190728131648.879156507@linutronix.de>
In-Reply-To: <20190728131648.879156507@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 28 Jul 2019 07:50:38 -0700
X-Gmail-Original-Message-ID: <CALCETrUpwYx2UdE=QykHAHA9OdHCtVhszeQewsmdpKjc0nJ04Q@mail.gmail.com>
Message-ID: <CALCETrUpwYx2UdE=QykHAHA9OdHCtVhszeQewsmdpKjc0nJ04Q@mail.gmail.com>
Subject: Re: [patch 4/5] x86/vdso/32: Use 32bit syscall fallback
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
> The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
> clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
> seccomp setups because these syscalls might be not (yet) allowed.
>
> Implement the 32bit variants which use the legacy syscalls and select the
> variant in the core library.
>
> The 64bit time variants are not removed because they are required for the
> time64 based vdso accessors.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
