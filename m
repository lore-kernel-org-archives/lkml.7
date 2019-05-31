Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FF6C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA5E26E10
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="J5vAQEVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfEaSoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:44:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46851 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfEaSoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:44:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so6688361pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JtOPz7Fd+4iciKonmNz8DuFoN9jGg9zWNkBBKxD/nT0=;
        b=J5vAQEVK88rYR6eiuj3C3oXJoViXiBtB7SmOEb7DZbr8Ovn0KFe8lJ0+n9hCs0jMWF
         XgKx/pfVVYnYrRKlIhNfKG6dadRMOICrmmnZFdE7jXl53QYdXwgZwG2uyluZ7ZYbOei0
         dHhqOdE3k4od92mqxvxGB6eFJMUvC0eBHk0GnnjsAdJ4xC6MawxRQfIn2DIGrY7t2F1g
         LE9rSSp5bBVHT9X0L8Do+Oj81y8wrytXS0RuWaTq1LLnyOFgT+5TWXI/Tc+DnEPcb6D/
         s141bdNg6WjAGjBoE4b4e0ZK160AEbkQ2EXrAGL4HMXvLLyHwQSWBwUF8g0aIhHsdC3c
         OLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JtOPz7Fd+4iciKonmNz8DuFoN9jGg9zWNkBBKxD/nT0=;
        b=InO1TecXjW58mC1OoYnLpLG7JlwwfOZNltJvJOX5Arfhf7Znu5aqJgjPjsXifB81Th
         44Jtu3YVK6w+lH2czqW6WcdFgeL35Er1jwKJi0MDJ/JGlpQglErAjn4baXRQcMIpJPwZ
         ou9bjOB7oXnrzFxbQEaDmWFFAipTSUi8xlK0z8/hGxBlUHx5iDCsWW6sIdRrsFMkuOol
         W2eu/a3l7bgaTFIcGhAJfD6+bKeddA/aP0oxwD0XCNBajwgRqvqhc7B8C/JVZmpZQACT
         tgWttJc93aVhU3UOeMHkMFBWtJ/WP4SkbwVBRK9+ZdDenkSTiZsOL9TXip9FqD14kFw4
         P7xg==
X-Gm-Message-State: APjAAAXulSuVJdfnEHZbL4Xj7snujD7u7zBu/KA21gHofUxJsJyQvMuE
        XEitttJb26ILXBZqSS/uxmcnOrTZLXFCBA==
X-Google-Smtp-Source: APXvYqyVAJJucpyS3amASTGYAfV2qT9FEj4E41JAXhoaG1owsdvywYVXfOsOsA/r9dpMSlABBc3c5g==
X-Received: by 2002:a17:90a:26a9:: with SMTP id m38mr11008051pje.50.1559328261455;
        Fri, 31 May 2019 11:44:21 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:4d40:e377:cfa4:3246? ([2601:646:c200:1ef2:4d40:e377:cfa4:3246])
        by smtp.gmail.com with ESMTPSA id w1sm5603317pgh.9.2019.05.31.11.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 11:44:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages for flushing
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190531105758.GO2623@hirez.programming.kicks-ass.net>
Date:   Fri, 31 May 2019 11:44:19 -0700
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <16D8E001-98A0-4ABC-AFE8-0F230B869027@amacapital.net>
References: <20190531063645.4697-1-namit@vmware.com> <20190531063645.4697-12-namit@vmware.com> <20190531105758.GO2623@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 31, 2019, at 3:57 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Thu, May 30, 2019 at 11:36:44PM -0700, Nadav Amit wrote:
>> When we flush userspace mappings, we can defer the TLB flushes, as long
>> the following conditions are met:
>>=20
>> 1. No tables are freed, since otherwise speculative page walks might
>>   cause machine-checks.
>>=20
>> 2. No one would access userspace before flush takes place. Specifically,
>>   NMI handlers and kprobes would avoid accessing userspace.
>>=20
>> Use the new SMP support to execute remote function calls with inlined
>> data for the matter. The function remote TLB flushing function would be
>> executed asynchronously and the local CPU would continue execution as
>> soon as the IPI was delivered, before the function was actually
>> executed. Since tlb_flush_info is copied, there is no risk it would
>> change before the TLB flush is actually executed.
>>=20
>> Change nmi_uaccess_okay() to check whether a remote TLB flush is
>> currently in progress on this CPU by checking whether the asynchronously
>> called function is the remote TLB flushing function. The current
>> implementation disallows access in such cases, but it is also possible
>> to flush the entire TLB in such case and allow access.
>=20
> ARGGH, brain hurt. I'm not sure I fully understand this one. How is it
> different from today, where the NMI can hit in the middle of the TLB
> invalidation?
>=20
> Also; since we're not waiting on the IPI, what prevents us from freeing
> the user pages before the remote CPU is 'done' with them? Currently the
> synchronous IPI is like a sync point where we *know* the remote CPU is
> completely done accessing the page.
>=20
> Where getting an IPI stops speculation, speculation again restarts
> inside the interrupt handler, and until we've passed the INVLPG/MOV CR3,
> speculation can happen on that TLB entry, even though we've already
> freed and re-used the user-page.
>=20
> Also, what happens if the TLB invalidation IPI is stuck behind another
> smp_function_call IPI that is doing user-access?
>=20
> As said,.. brain hurts.

Speculation aside, any code doing dirty tracking needs the flush to happen f=
or real before it reads the dirty bit.

How does this patch guarantee that the flush is really done before someone d=
epends on it?=
