Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E910C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22309206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556267514;
	bh=SHcKjo86YRaBtbcui6ZNjTGtHieGQh8h35OGLG1KJxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ca8aVVg9hZh2Yon2xFkW6vv9ZOsB2cqEu2IXXst1SkNpieU5bQWeSswbDsUDiDlNy
	 W44JPbtXffKFNaeZEpZli6YrcAKsEpT/AeLzHAeom8O+cC+MbSMfWkKSvgvw2huVKf
	 3Hib506/yniFECXsqtU+MD9aSVFS2FCL7bsLEkCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfDZIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:31:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38420 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfDZIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:31:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id k16so3253306wrn.5;
        Fri, 26 Apr 2019 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8yEHGmmpSB8zJvfnDs0qm8YJnL5/w4ezpyP4pzX7OU=;
        b=VkXjRe45hyNXVj6ZfWoXHr6MTHjtWL9wxGXVZSzLMcje4P0FbuT/Q7Jd+vA1p9zEB/
         8RqkOkiJthWGtNBekTaSFZY4oXZh1GyFrxsJ68xk0BZzJnK06NtdNo3O+axMJWfCl1qE
         GyHF+8T/9FBm0+DjXetmbgG3M0v8zroVHiOtLPRpaT6MrSmy9XOu160qeULDV180k0xa
         kY+zWM78luJUpw4oMLsj3nAbD5QeSMjPf76uIIhHD82smYQ4sa2Gw/bOFqlaYzMnrmOq
         /DJvD0YVbwD+SffY8PXAy25ufW7lJrslVydjKCvITbMXQredlQKDjMDmHDbLgT49Ymtn
         CxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8yEHGmmpSB8zJvfnDs0qm8YJnL5/w4ezpyP4pzX7OU=;
        b=jM7zytu7j/90bBqtngv2yQGzbvslQWvn1ANQhMtl4oUnPe1+cLiNzrbg35oG+YT1Nw
         /ueimIvaeDaCzk9HdAQaxshUy+rClzoPv7S50SpQ/PfulLYYeGX5QuIgdHMa6qIBTcKx
         7FH3oHng+/bNaXYKGCq9hqouQm2KBQlCSym5dd+cuey5sa87gcF+2L3FWQoo9u2jGrUx
         iqTSZFOWaGRe3QkkGRVhMUBT1s4IpLu0oxqcQ8i1oVSc5bUENE9X7KaMA4fKcmqJkQKJ
         HHsEXl3uNHKvvQkQvoMR1RvmP/2//N2+ZrDX1qVJSWDHMkbSSVThyNz0Vady3UhTRi73
         huNg==
X-Gm-Message-State: APjAAAX3QdY2Lv9SXr2O4FQwhzd6+iyWrpaPZFlHwyS8ORN6tqwPwtlL
        qsdbd6xwRdX+0XGIjaVEWfE=
X-Google-Smtp-Source: APXvYqz7R4wqcBRnF5mLwlUAgAYn64tt07z4jLjy3OlElfpQAtlWfTSEl2f9ae5ADnCd69ZUlZdi4A==
X-Received: by 2002:a5d:654a:: with SMTP id z10mr3402530wrv.153.1556267507780;
        Fri, 26 Apr 2019 01:31:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v16sm20304256wru.76.2019.04.26.01.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 01:31:46 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:31:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
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
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
Message-ID: <20190426083144.GA126896@gmail.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Rapoport <rppt@linux.ibm.com> wrote:

> When enabled, the system call isolation (SCI) would allow execution of 
> the system calls with reduced page tables. These page tables are almost 
> identical to the user page tables in PTI. The only addition is the code 
> page containing system call entry function that will continue 
> exectution after the context switch.
> 
> Unlike PTI page tables, there is no sharing at higher levels and all 
> the hierarchy for SCI page tables is cloned.
> 
> The SCI page tables are created when a system call that requires 
> isolation is executed for the first time.
> 
> Whenever a system call should be executed in the isolated environment, 
> the context is switched to the SCI page tables. Any further access to 
> the kernel memory will generate a page fault. The page fault handler 
> can verify that the access is safe and grant it or kill the task 
> otherwise.
> 
> The initial SCI implementation allows access to any kernel data, but it
> limits access to the code in the following way:
> * calls and jumps to known code symbols without offset are allowed
> * calls and jumps into a known symbol with offset are allowed only if that
> symbol was already accessed and the offset is in the next page
> * all other code access are blocked
> 
> After the isolated system call finishes, the mappings created during its
> execution are cleared.
> 
> The entire SCI page table is lazily freed at task exit() time.

So this basically uses a similar mechanism to the horrendous PTI CR3 
switching overhead whenever a syscall seeks "protection", which overhead 
is only somewhat mitigated by PCID.

This might work on PTI-encumbered CPUs.

While AMD CPUs don't need PTI, nor do they have PCID.

So this feature is hurting the CPU maker who didn't mess up, and is 
hurting future CPUs that don't need PTI ..

I really don't like it where this is going. In a couple of years I really 
want to be able to think of PTI as a bad dream that is mostly over 
fortunately.

I have the feeling that compiler level protection that avoids corrupting 
the stack in the first place is going to be lower overhead, and would 
work in a much broader range of environments. Do we have analysis of what 
the compiler would have to do to prevent most ROP attacks, and what the 
runtime cost of that is?

I mean, C# and Java programs aren't able to corrupt the stack as long as 
the language runtime is corect. Has to be possible, right?

Thanks,

	Ingo
