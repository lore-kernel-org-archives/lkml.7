Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53CDC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CBF214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556170970;
	bh=8TchoO4JXCgkVVZ1SqwUN7jqXt7z1v8kVYF7jfyE7ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X+8g4lak6qXzhS1ue7uJFxfbmMH6BwJlA5ZzulK4T0UQ20eM6GNlsS/IXaTaXVOxa
	 7naAxrv7CPY6jC5SPzy54dOt/VNpYydUo8EwGRneDwKczDypH4WiXRChqmP9vePV3h
	 OGK6GCy99VCSMaMd4CxlW6apjbK0SlpLr08BAkFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfDYFmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:42:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40065 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfDYFms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:42:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so1764979wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mFaGk17zBVaZD9Ik72FhzKJm7fKCzkWf7LsFsFGH3Ms=;
        b=E0OEl58kIDsDj3OX2Dxz/ZJCU/A+rpc8cYFyHBQXnHAxBcXGOj/bEBKrHoQSCGcUT4
         v0ikdnhi3FemkJQvj8NpCcC+GlafSskKHA4YY39/3pGrJj6e7e/HKXn1EPR+PnMPQrQW
         YZfuZvlKIpsuQwB0UOo2277taH/NpcellJk8VsVuieZ4Bw1lzmHkgpMuZkCCArTciLP9
         2adLyAGwoTskYFyD7XpCpVZFebr5PvJ7kJCO0+UrBwPsqIQI5kha64IuqF8fUgBjRiSs
         BC5gLDWl3OaxuRCQQXfX0HM/7bOAkTThD9FPRS3K0nFBEOmx/MwbQyJqmEakQmU/3Kz1
         Dfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mFaGk17zBVaZD9Ik72FhzKJm7fKCzkWf7LsFsFGH3Ms=;
        b=NJ6HJjhz4cWy8qhJhdo/gukWN6q1SSiFydzb5Ab8rHlSCInFfcVWv2Q7H+wvbEjws0
         yhkuDwma5VpsyNFZUxw2wHSP6UqqZ6YaiJE1b9EtiM57NxHSvsRdL+AVYp3TEUYbqgAR
         WLn83PgSpMNxS6eOrmeBPR6fxwBqI0FgDfDeY/f9yg+ivaWup4eq6V7c8/MZNTaKmFAN
         8s5q6ca/IqY0IWoHorswP0RErFF7mcspXr5rgT/Lgj/kZrLcY6xuYyz3OBCY0FhSnwys
         7NW/uk6QkinLilJAPPbw0BvbTJ0BocDglMPRdcMt+NXUv0yrU1dA8ggOgsEntn96NwKl
         Losg==
X-Gm-Message-State: APjAAAXRenMnY/P2JKtOPW4AC7GnQYA28HVvKj3BUTWcKDukObraNF9q
        qCM3wKA8//cvc6arDhxPFRk=
X-Google-Smtp-Source: APXvYqwE4UYOfn07X6aedJFEOECNgVPLggSoZvRObm5IhchWEEMZ3b3FtXr+bnFj+EjlCMggfhFPgQ==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr2060638wmm.88.1556170966473;
        Wed, 24 Apr 2019 22:42:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m8sm10106121wrx.48.2019.04.24.22.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 22:42:45 -0700 (PDT)
Date:   Thu, 25 Apr 2019 07:42:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern
 CPUs
Message-ID: <20190425054242.GA7816@gmail.com>
References: <20190424203408.GA11386@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424203408.GA11386@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> The READ_IMPLIES_EXEC work-around was designed for old CPUs lacking NX
> (to have the visible permission flags on memory regions reflect reality:
> they are all executable), and for old toolchains that lacked the ELF
> PT_GNU_STACK marking (under the assumption that toolchains that couldn't
> even specify memory protection flags may have it wrong for all memory
> regions).
> 
> This logic is sensible, but was implemented in a way that equated having
> a PT_GNU_STACK marked executable as being as "broken" as lacking the
> PT_GNU_STACK marking entirely. This is not a reasonable assumption
> for CPUs that have had NX support from the start (or very close to
> the start). This confusion has led to situations where modern 64-bit
> programs with explicitly marked executable stack are forced into the
> READ_IMPLIES_EXEC state when no such thing is needed. (And leads to
> unexpected failures when mmap()ing regions of device driver memory that
> wish to disallow VM_EXEC[1].)
> 
> To fix this, elf_read_implies_exec() is adjusted on arm64 (where NX has
> always existed and toolchains have implemented PT_GNU_STACK for a while),
> and x86 is adjusted to handle this combination of possible outcomes:
> 
>               CPU: | lacks NX  | has NX, ia32     | has NX, x86_64   |
>  ELF:              |           |                  |                  |
>  ------------------------------|------------------|------------------|
>  missing GNU_STACK | needs RIE | needs RIE        | no RIE           |
>  GNU_STACK == RWX  | needs RIE | no RIE: stack X  | no RIE: stack X  |
>  GNU_STACK == RW   | needs RIE | no RIE: stack NX | no RIE: stack NX |
> 
> This has the effect of making binfmt_elf's EXSTACK_DEFAULT actually take
> on the correct architecture default of being non-executable on arm64 and
> x86_64, and being executable on ia32.

Just to make clear, is the change from the old behavior, in essence:


               CPU: | lacks NX  | has NX, ia32     | has NX, x86_64   |
  ELF:              |           |                  |                  |
  ------------------------------|------------------|------------------|
  missing GNU_STACK | exec-all  | exec-all         | exec-none        |
- GNU_STACK == RWX  | exec-all  | exec-all         | exec-all         |
+ GNU_STACK == RWX  | exec-all  | exec-stack       | exec-stack       |
  GNU_STACK == RW   | exec-all  | exec-none        | exec-none        |

correct?

Also note that in addition to marking the changes clearly, I also edited 
the table to be less confusing and more assertive:

   'exec-all'  : all user mappings are executable
   'exec-none' : only PROT_EXEC user mappings are executable
   'exec-stack': only the stack and PROT_EXEC user mappings are executable

Is this correct? (Please double check the edited table.)

In particular, what is the policy for write-only and exec-only mappings, 
what does read-implies-exec do for them?

Also, it would be nice to define it precisely what 'stack' means in this 
context: it's only the ELF loader defined process stack - other stacks 
such as any thread stacks, signal stacks or alt-stacks depend on the C 
library - or does the kernel policy extend there too?

I.e. it would be nice to clarify all this, because it's still rather 
confusing and ambiguous right now.

Thanks,

	Ingo
