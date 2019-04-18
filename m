Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E62C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364542183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFnuC1B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbfDRO5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:57:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44877 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:57:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so1309528pgj.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vzt+IvVfPcUFXAJXqKinnzIHJN//5qQXUQEoWdemxK4=;
        b=mFnuC1B1jmRviVSU/TDtW3fU6j7vJdYQhlGOSl9aWYVpRI/8xhf/r1NsKjbnKyPDl+
         HyPTKYvHhmWe+wjorusotxqft3kGWz6J96jd10kZlAq1fXvU/9Fjlnq3q1IiscG4FRQ/
         0ZQU+1sEH+cTuTDByh+o8POuoX4Wm+H8Hnnc3N3FRsFSNsDFLd03BxgZJKpF0jocBste
         ZVZYJ4Sy2LbqeuhVN9HEd3Z5r1Ej4K4Uh4M+6dmAiHZWTg7TchiGw4cApn9UtGcpIUxq
         cZu6OdKTckqmqSUiuVcluZ4RHFToWM2tpcVdNkX//aTlpDWN470PZQyQnKJ4jIgrxgiR
         6Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vzt+IvVfPcUFXAJXqKinnzIHJN//5qQXUQEoWdemxK4=;
        b=Uo4GPHGhnSuVjW2uhIG5jUp6+mVebsKJp3GA5iUaG44ubqFjRxFeu9+u2SHpkYyG5J
         8OTEQ+SyLYfDFZ7asPBfnL5T64ncSraKP4Qq7KcPbXIzC5ALko/3auoZf6aNt9ipYSlm
         xBmT88VBQ8ke048peji/tyhe/YGeGoH2y4j+9NDPfVndMSGqipEi+r3rGTDigq4hjQ6M
         AoLQO18Kxt1X2rebxUV7aNJ+E3rAy4VlkSKl5Jc/OdBiWUva5F8j8TrHNnvc9gYAOLgS
         hyMzj+LeKINnXoGSS5K/MuJtHKkcMfqA2xvu64H2c6ZzqBIkLx1IxwHnxmWfaCTHnU+5
         aCVQ==
X-Gm-Message-State: APjAAAWWFT89JUq12dGrVG1gFL+gLkT3avHtkCv5ZTaw9eDwVZ/qNAeM
        Cx0zHGiGfc5SZg2ZuI/EnFc=
X-Google-Smtp-Source: APXvYqxbmcAju/uBvZxpqhYQAaEiPrZqmttopA/nozYFe/TRiHsydtop4oYNEjjFGBMj9yJbgcU4Hg==
X-Received: by 2002:a62:e710:: with SMTP id s16mr88143510pfh.74.1555599434386;
        Thu, 18 Apr 2019 07:57:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j19sm3661074pfr.155.2019.04.18.07.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:57:13 -0700 (PDT)
Date:   Thu, 18 Apr 2019 07:57:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Move brk out of mmap when doing direct
 loader exec
Message-ID: <20190418145711.GA15549@roeck-us.net>
References: <20190416042320.GA36924@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416042320.GA36924@beast>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 09:23:20PM -0700, Kees Cook wrote:
> Commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE"),
> made changes in the rare case when the ELF loader was directly invoked
> (e.g to set a non-inheritable LD_LIBRARY_PATH, testing new versions of
> the loader), by moving into the mmap region to avoid both ET_EXEC and PIE
> binaries. This had the effect of also moving the brk region into mmap,
> which could lead to the stack and brk being arbitrarily close to each
> other. An unlucky process wouldn't get its requested stack size and stack
> allocations could end up scribbling on the heap.
> 

This patch results in crashes of my xtensa boot tests.

Run /sbin/init as init process
Kernel panic - not syncing: Attempted to kill init!  exitcode=0x0000000b

Bisect log is attached. The crash is seen in next-20190417 and next-20190418.

Guenter

---
# bad: [3f018f4a019a1110527910bac52161e57107957c] Add linux-next specific files for 20190418
# good: [15ade5d2e7775667cf191cf2f94327a4889f8b9d] Linux 5.1-rc4
git bisect start 'HEAD' 'v5.1-rc4'
# good: [d49e1f8649c84f154e7df59300264f59b736f329] Merge remote-tracking branch 'crypto/master'
git bisect good d49e1f8649c84f154e7df59300264f59b736f329
# good: [06a21957e5c0aae87fb94b97ef965818bd7c9dac] Merge remote-tracking branch 'spi/for-next'
git bisect good 06a21957e5c0aae87fb94b97ef965818bd7c9dac
# good: [c44f3caed068c67fe01056329e7e6cbf8f4920a8] Merge remote-tracking branch 'staging/staging-next'
git bisect good c44f3caed068c67fe01056329e7e6cbf8f4920a8
# good: [ca75e0d0aafd76ceb1f5a8f8544d22f841b7e296] Merge remote-tracking branch 'coresight/next'
git bisect good ca75e0d0aafd76ceb1f5a8f8544d22f841b7e296
# bad: [711a07489617c04954816b16d0d500b1e81398c1] cpumask-fix-double-string-traverse-in-cpumask_parse-fix
git bisect bad 711a07489617c04954816b16d0d500b1e81398c1
# good: [47d765617fc96a61b317dd916a48f28bec14b32c] mm/hmm: mirror hugetlbfs (snapshoting, faulting and DMA mapping)
git bisect good 47d765617fc96a61b317dd916a48f28bec14b32c
# good: [99b8edbb7d2564aa751481aae99a5715170b80ea] mm, memcg: make scan aggression always exclude protection
git bisect good 99b8edbb7d2564aa751481aae99a5715170b80ea
# good: [9174b7e52219aebd841086d67988295096bab871] lib/sort: avoid indirect calls to built-in swap
git bisect good 9174b7e52219aebd841086d67988295096bab871
# good: [b7a32277de780ace15114ce9f89c32f5b28276a0] fs/binfmt_elf.c: remove unneeded initialization of mm->start_stack
git bisect good b7a32277de780ace15114ce9f89c32f5b28276a0
# bad: [9100e2f3a64a66c366cd1f4b8f46d3e2d916ec54] fix "fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec"
git bisect bad 9100e2f3a64a66c366cd1f4b8f46d3e2d916ec54
# good: [c1dcda60c739c3a4b3226317fca17dcd2827f604] fs/binfmt_elf.c: delete trailing "return;" in functions returning "void"
git bisect good c1dcda60c739c3a4b3226317fca17dcd2827f604
# good: [f39fe61cc3b48fe58ea1470ad7d6512cb45c76d3] fs//binfmt_elf.c: move variables initialization closer to their usage
git bisect good f39fe61cc3b48fe58ea1470ad7d6512cb45c76d3
# bad: [cb084e1ba0b0c3353e1fadf52f647ff85eb8989c] fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec
git bisect bad cb084e1ba0b0c3353e1fadf52f647ff85eb8989c
# first bad commit: [cb084e1ba0b0c3353e1fadf52f647ff85eb8989c] fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec
