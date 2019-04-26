Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE0CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7B0206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556238630;
	bh=ZsIbUeLOxUI7bxZ1I5VzBXBiV9Win2BFl2iIJvXToNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LLtR9NJaeJRNqJjHG6AIP5f+JwRDXgXbl57tg11wGOeQIVOBBijtZokQGiZl7AMAO
	 QS5lwuMN35RPpd1/5k8yKz26cGMaQsBEVtAKw5hakq5h3FjF1DazrPsW05NlOBp/uj
	 hBb+N9IwkFf0ftisC1N6Tem4U0eSJlzVnJniYtvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfDZAa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfDZAa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:30:28 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF9B21537
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556238627;
        bh=ZsIbUeLOxUI7bxZ1I5VzBXBiV9Win2BFl2iIJvXToNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XPVgj3+qb+Ykb0MjNHKhNcV3Yo9b7Oh8+K4gAy33Im/oRgNOCSVgtwla7/2VYGvA7
         7XZU2rkWj1/g4+Ifz2JGp6nZfJbSva/pRSNhUX4xbErQ3YzyJ3apIdcwE6dO7TFu04
         GHSqHZvCo/ZbCqBSb7qZRx7OySOrA0h4CSc5WPc0=
Received: by mail-wr1-f48.google.com with SMTP id s18so1930148wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:30:26 -0700 (PDT)
X-Gm-Message-State: APjAAAXtlgN1pQ1XVAJ71VKHrcOFBYu0FwqVrXbHSc/3Ui+hAERJzupi
        BlMzjkHbiCPq+QzadXOx+lovmMM+R9eiHiUeBoGwKg==
X-Google-Smtp-Source: APXvYqxbTskaCiO3hbeKzbx/74RUetFFRSKpivliZ4T8CAe9gU+OYeZj1yN2RbB4/grljATC54DI2BoSF0qT+eHhBmU=
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr12902589wrw.199.1556238625152;
 Thu, 25 Apr 2019 17:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Apr 2019 17:30:13 -0700
X-Gmail-Original-Message-ID: <CALCETrWkYYh=L1nSO7GYt0FvMhjCcEaQiM2JEi3FfkJbYJFh2g@mail.gmail.com>
Message-ID: <CALCETrWkYYh=L1nSO7GYt0FvMhjCcEaQiM2JEi3FfkJbYJFh2g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] x86: introduce system calls addess space isolation
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 2:46 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi,
>
> Address space isolation has been used to protect the kernel from the
> userspace and userspace programs from each other since the invention of the
> virtual memory.
>
> Assuming that kernel bugs and therefore vulnerabilities are inevitable it
> might be worth isolating parts of the kernel to minimize damage that these
> vulnerabilities can cause.
>
> The idea here is to allow an untrusted user access to a potentially
> vulnerable kernel in such a way that any kernel vulnerability they find to
> exploit is either prevented or the consequences confined to their isolated
> address space such that the compromise attempt has minimal impact on other
> tenants or the protected structures of the monolithic kernel.  Although we
> hope to prevent many classes of attack, the first target we're looking at
> is ROP gadget protection.
>
> These patches implement a "system call isolation (SCI)" mechanism that
> allows running system calls in an isolated address space with reduced page
> tables to prevent ROP attacks.
>
> ROP attacks involve corrupting the stack return address to repoint it to a
> segment of code you know exists in the kernel that can be used to perform
> the action you need to exploit the system.
>
> The idea behind the prevention is that if we fault in pages in the
> execution path, we can compare target address against the kernel symbol
> table.  So if we're in a function, we allow local jumps (and simply falling
> of the end of a page) but if we're jumping to a new function it must be to
> an external label in the symbol table.

That's quite an assumption.  The entry code at least uses .L labels.
Do you get that right?

As far as I can see, most of what's going on here has very little to
do with jumps and calls.  The benefit seems to come from making sure
that the RET instruction actually goes somewhere that's already been
faulted in.  Am I understanding right?

--Andy
