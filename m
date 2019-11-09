Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2ACC17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 02:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0E214DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 02:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM6g4pAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfKIC3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 21:29:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41750 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfKIC3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 21:29:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so6350195pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 18:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qNSiQdl3ZwenPCbCOWazKugSKkgISu7+mZNw6o59RZo=;
        b=kM6g4pATq5GdRAigFw42iUxJ/YwhRDauE8okdUyuzDuzUoo7Uofu2bfEmRsMVfWjDf
         /8ABMHE18e6eVEM0BdkkhTcn+3P4dvIYiqHTZtv4hXIGO5n/lbXgfrzztYHpOpaWtdaM
         eIUxoy80VngjqELFvW8sqVSWNaw7jB4AD/4xB03b6h14stANeyOJdeJHMRO+Lw8gCyeG
         q9YomsjYNmiDAXsvkTdWyVMeZ8PxqxrJ5pbqMdluFri/UYXrBNra4JC5273BUPeAgBNm
         JzdzGf2yZpeKzynZYxsQzg4MKzm1hlP4s5TYGJnvU8GwMNgsbo4hoOJtXQkDWiQyicV9
         /WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qNSiQdl3ZwenPCbCOWazKugSKkgISu7+mZNw6o59RZo=;
        b=UenHjRl7v2+zKq5dJ0ja0VMWlg43BLSIV+yq04L80umed/SkpUbUZOmgLjQS2cze4u
         x5b9JKRT/Fi+bIM8K4FnNTHdhxYCnuMra38mAijcvanB+y9McIoOrC6y0rhYsQoVnRog
         08VOdsVrlQ2E0KiCDkRiYMgY+OmUxzK31zWzR0f5WrRmncHn9geWWZ5LI33FUnepXS15
         2XkeMbd3zZMbMhMGq4tZ0gpM9gliCRVqZ/HKI4fT1SuaqFhuwJmq3mQ5NS5lW8hPUjrU
         yTKTixcfGgOfC7iCJpsG+dfedfxrgeg4qhWkkAdfSDWLsbSNghTlM28nGiD8Siua4Ggo
         lVKg==
X-Gm-Message-State: APjAAAWx9nMqAtA6wWmXth9bxySVHLgAzj1mpVPpz829jVQsaGDTVih6
        u/aBzMzlnNsKGzLYNVP+JAk=
X-Google-Smtp-Source: APXvYqyDIXRKakSRHU5zT9qxMd9r9qlmNlYqQMnMExV32fz8Wt4sHdaBfzcKT5h8oZ+JDmvjq3gbQw==
X-Received: by 2002:a17:90a:3808:: with SMTP id w8mr18440977pjb.143.1573266551382;
        Fri, 08 Nov 2019 18:29:11 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::2:f248])
        by smtp.gmail.com with ESMTPSA id 82sm8412448pfa.115.2019.11.08.18.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 18:29:10 -0800 (PST)
Date:   Fri, 8 Nov 2019 18:29:09 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191109022907.6zzo6orhxpt5n2sv@ast-mbp.dhcp.thefacebook.com>
References: <20191108212834.594904349@goodmis.org>
 <20191108213450.032003836@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108213450.032003836@goodmis.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 04:28:37PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add the start of the functionality to allow other trampolines to use the
> ftrace mcount/fentry/nop location. This adds two new functions:
> 
>  register_ftrace_direct() and unregister_ftrace_direct()
> 
> Both take two parameters: the first is the instruction address of where the
> mcount/fentry/nop exists, and the second is the trampoline to have that
> location called.
> 
> This will handle cases where ftrace is already used on that same location,
> and will make it still work, where the registered direct called trampoline
> will get called after all the registered ftrace callers are handled.
> 
> Currently, it will not allow for IP_MODIFY functions to be called at the
> same locations, which include some kprobes and live kernel patching.
> 
> At this point, no architecture supports this. This is only the start of
> implementing the framework.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
...
> +struct ftrace_ops direct_ops = {
> +	.func		= call_direct_funcs,
> +	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
> +			  | FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
> +			  | FTRACE_OPS_FL_PERMANENT,
> +};

The whole set looks great. Thank you for adding FL_PERMANENT to it.
Is there a way to do a replacement of direct call?
If I use unregister(old)+register(new) some events will be missed.
If I use register(new)+unregister(old) for short period of time both new and
old will be triggering on all cpus which will likely confuse bpf tracing.
Something like modify_ftrace_direct() should solve it. It's still racy. In a
sense that some cpus will be executing old while other cpus will be executing
new, but per-cpu there will be no double accounting. How difficult would be
to add such feature?

