Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B8CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0562075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dgu3eS3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfDVWtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:49:15 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40488 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfDVWtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:49:15 -0400
Received: by mail-ua1-f66.google.com with SMTP id b8so4117229uaq.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+QhsgyQznwjFUiayG7lQhTqPlSCXa8PxDOjCql3V1M=;
        b=Dgu3eS3ZR4WVQyJUYWW6lInyMNK/ePH2bm6nl8G37BR1eVinyB6NjlblbgwTCvr8lo
         SK0mR5emrix683WzfOgJ3cWs6wOsEkbLoje6PmCsdkcqBPt0e2I69hg0/eI2sUvWpCGs
         OQmmvmhtWQfmWvVgH8QI3SHBADoIo2xS4CDSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+QhsgyQznwjFUiayG7lQhTqPlSCXa8PxDOjCql3V1M=;
        b=Buf2VS38Fie0hyaaFeuRNwK748ReebxLpVwkjrdGr6Z3hsXRfWr7P7PCT4FoaMG3SX
         7HyjYf3BgRbxSMvuhKoGAM1uYS/mFScCsrsK6IDd6FW+fzETPOy6WuPGGAvoYcoLfhBp
         j0XXbiEBhG0wz6LigEANeLWK9IA7e6ie5B0yFwLBM17WTIbNOg8cJEaTLQ38Ubvl1JAY
         elGr1HYa/vOoVmGqzRLN5EV0nmGFmYv8vP3ktpIppw2x/SPGa5vT4a3f5qn/22Fhz21m
         z3ltKhc64hWwcxoNdMHWfydDlOME6neiyhi1dEaZTmpeZn26TSqpB55I2cb29SyEL5Ot
         80rw==
X-Gm-Message-State: APjAAAULH9NCmyEC5/zfZeHOweR1bSTgUASpIRlinLZpohMjp0YsyJho
        De3GXECiELL7xK3JtG1oPs7GtF4rajs=
X-Google-Smtp-Source: APXvYqxJglrYSz3w4KjlhPg+5zrarWYNKZ0mbUvKM6hjYJfcWIMiWE/ThrENBTdK3iNjfOE4gB+JOQ==
X-Received: by 2002:ab0:21c5:: with SMTP id u5mr10493944uan.81.1555973353617;
        Mon, 22 Apr 2019 15:49:13 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id h78sm4823997vka.48.2019.04.22.15.49.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 15:49:12 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id n16so4111159uae.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 15:49:11 -0700 (PDT)
X-Received: by 2002:ab0:791:: with SMTP id c17mr715379uaf.96.1555973351413;
 Mon, 22 Apr 2019 15:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190416042320.GA36924@beast> <20190418145711.GA15549@roeck-us.net>
In-Reply-To: <20190418145711.GA15549@roeck-us.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 22 Apr 2019 15:48:58 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJsaKU1O7GQG0oEQfnMGSdRE-QEfd8c1Gn6YuPA66K-nQ@mail.gmail.com>
Message-ID: <CAGXu5jJsaKU1O7GQG0oEQfnMGSdRE-QEfd8c1Gn6YuPA66K-nQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Move brk out of mmap when doing direct loader exec
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 7:57 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Apr 15, 2019 at 09:23:20PM -0700, Kees Cook wrote:
> > Commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE"),
> > made changes in the rare case when the ELF loader was directly invoked
> > (e.g to set a non-inheritable LD_LIBRARY_PATH, testing new versions of
> > the loader), by moving into the mmap region to avoid both ET_EXEC and PIE
> > binaries. This had the effect of also moving the brk region into mmap,
> > which could lead to the stack and brk being arbitrarily close to each
> > other. An unlucky process wouldn't get its requested stack size and stack
> > allocations could end up scribbling on the heap.
> >
>
> This patch results in crashes of my xtensa boot tests.
>
> Run /sbin/init as init process
> Kernel panic - not syncing: Attempted to kill init!  exitcode=0x0000000b

Thanks for finding this! I *think* the issue is that I needed to be
testing for CONFIG_ARCH_HAS_ELF_RANDOMIZATION, which xtensa lacks.
I'll get this fixed up and resent through -mm.

-- 
Kees Cook
