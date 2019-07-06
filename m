Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44796C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 20:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFE220830
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562445024;
	bh=KvUUoo3OTmfZW6uWkzCyS1YjGqyjeIFakuL0yMmPQTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KkKDpHpKk9IZ30uIeMXrSlXJtwaHgsUwZbvRcefuOMVaJa+1dfxF2zAZeaAh/jCHd
	 sU7pqbLYULlSPFwPPyyvuGfgdfvvWn0DT0q3Jyvx76iFZofnosGsgkrDHHuk9Scmjy
	 oww+mAgUhexGdUW8gkD5TbcCgjIrJHNk7vSR+lkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGFU3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 16:29:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40545 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfGFU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 16:29:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so6762088wrl.7;
        Sat, 06 Jul 2019 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8D0i/MU8VOyyI2UbbiG2Trw+JlgwG1EN/AypK/G5nPc=;
        b=rOgXJomQbBHPpbxHLg+t9OQnvQUqq3jyOzaKGpGil/ffpyy0CwlcMbbcgpAvvC6F67
         13tb49OmudWhYf+eZr95IItQhK7PY+5kgHreEvo4C05PEM3W0cXTjrKD+W6nyMXPRE9e
         ELhfhU2cS0STnOJKD9BhVYAWZrtEqgPUwv02mpO6riKS9qcu6c99NRJBag27yjuAbVed
         wwNYQCcqmqq9yR625WP3nBoobfl8zM1e9yF/BqlnRYFOF98pWupKsao50Psbe2FlE7Zs
         ratus5XzAPHmQlveo6ruMzoSs8UOOKWBCi33MXt4cI3Btwcg+b+q1/V9FfkXk85rb8V5
         h2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8D0i/MU8VOyyI2UbbiG2Trw+JlgwG1EN/AypK/G5nPc=;
        b=UniU0UFNH5J9cSepWmPEFL6boHJTXQoyXFZ0UgqcUotwLAS+wyUSRbuLTJjTcAPSdu
         mOKLOh8E3TPPNYviTsvjKbFEaudbqJ+UQVyp+mv36lf+ZPQWOo/4j6I+vF4/gdMOdgML
         IlJPMQbQmv+S0xq/6ddfPhnz91jKEyRvSwqRtF4dMdQYVxyqkVEkHb94uch2DOJ1DJPr
         062kaXah2uEs1u5Fovu3ZN8guh48l5ZhmYf9IoG7A+Ndooj2RocveT0Br6RZaYLTz/sK
         BMLcFJWJYS3NKdXA9AJ8/sJDSJ0YRZbEvrN6SmaA43M63/LMUHV+G4K2iIN8vIiO6u5b
         TdYw==
X-Gm-Message-State: APjAAAVbB5/WNqHpSqHXGyskTRlnpa9VuR+zZLq6MAkd0vkbjSCbz5Ub
        kRx2N/9EDbCwxllT5GOshEo=
X-Google-Smtp-Source: APXvYqxrKiqJ1LkaqRmsTdBRjXqB3k2ua5y4YnZ1iEJmdVVXqehMsL+V7LgkXAgQcwcm6rb/TVZBKw==
X-Received: by 2002:a05:6000:11cf:: with SMTP id i15mr9703536wrx.20.1562444986817;
        Sat, 06 Jul 2019 13:29:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a8sm5561702wma.31.2019.07.06.13.29.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 13:29:45 -0700 (PDT)
Date:   Sat, 6 Jul 2019 22:29:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com,
        songliubraving@fb.com, tglx@linutronix.de, rostedt@goodmis.org,
        kasong@redhat.com, daniel@iogearbox.net, ast@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
Message-ID: <20190706202942.GA123403@gmail.com>
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
 <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for Josh Poimboeuf <tipbot@zytor.com> wrote:

> Commit-ID:  b22cf36c189f31883ad0238a69ccf82aa1f3b16b
> Gitweb:     https://git.kernel.org/tip/b22cf36c189f31883ad0238a69ccf82aa1f3b16b
> Author:     Josh Poimboeuf <jpoimboe@redhat.com>
> AuthorDate: Thu, 27 Jun 2019 20:50:47 -0500
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sat, 29 Jun 2019 07:55:14 +0200
> 
> bpf: Fix ORC unwinding in non-JIT BPF code
> 
> Objtool previously ignored ___bpf_prog_run() because it didn't understand
> the jump table.  This resulted in the ORC unwinder not being able to unwind
> through non-JIT BPF code.
> 
> Now that objtool knows how to read jump tables, remove the whitelist and
> annotate the jump table so objtool can recognize it.
> 
> Also add an additional "const" to the jump table definition to clarify that
> the text pointers are constant.  Otherwise GCC sets the section writable
> flag and the assembler spits out warnings.
> 
> Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> Reported-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kairui Song <kasong@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lkml.kernel.org/r/881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com
> 
> ---
>  kernel/bpf/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Hm, I get this new build warning on x86-64 defconfig-ish kernels plus 
these enabled:

 CONFIG_BPF=y
 CONFIG_BPF_JIT=y

kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x8da: sibling call from callable instruction with modified stack frame

Thanks,

	Ingo
