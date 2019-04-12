Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB2AC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0873220850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSiugtdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfDLV1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:27:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDLV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:27:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so5719071pfd.8;
        Fri, 12 Apr 2019 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B+wEy+TCLeOhl90NXP78eV9UW4581ezgGAHLtxRD4bI=;
        b=FSiugtdjW9YSKjMNhWOqp5jmFrdnd+zZd0etYlQpj/YVBaavJf9xzpd6JrExmvrL4S
         JO+WiRjeSSDxfdl7S35yR5ekivPJoCD1BqGwHsE6fme1bDeyneip4/wb5fl5ftGfrMnA
         EEIZHrRP6E8JIgQvlC2Mv56/Is3PqGcwHzyV5EwBjHRg23f1E4WpHSi/A+DLKz9Op/+q
         P69mLcdNte4tikCCqs51Czyl1eqFPEyoK+2gmc5b5afXtgEyJtxm4I310+XaNeYVhxNu
         /4HOMMdLv5Fj9Q3HeczERbHg2LfGeViQ7vTEBxY3QCDEZ1tZY8jJTk8ijQTzGTU1E7tm
         Gl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+wEy+TCLeOhl90NXP78eV9UW4581ezgGAHLtxRD4bI=;
        b=fOcj905Djq1TdR2W6ZL4KeD4d0Fyg0cLu8HwOXwu9Ff0PffLwq8ugBvse6nVUP5Ibu
         bbGTV4U7HqmxheRo5ySnImsqJGMewrVMNJGSlY1Eaz1IbyJDxnCbZVl71JLYrjHC4Zjv
         g+/iVvWAKpWwwcUhOXgx0IAbm3FiXUmPFMe8Ys/9EyRPcanw9Z7/4nf0PJktOs9vND8n
         lEU6l8wLgOipcZfd6TubSC324p1l7V39LS/ilWvVM/H4+bTijP2Dr7YVJuFds2qA/nHu
         wLlxDeOiZqJ7/izq3IgFW+LU8+RSKCTY9NiQUqUHUxNkl7AdeoA1kaVaQp1hf5eOqch0
         wRpA==
X-Gm-Message-State: APjAAAVExhLaVtrloeB/RtFgIg+n1UWERFIxCkvAO3kOwGrUCJWZl0CO
        jxHnTNeRo8hFm64vEuaUoJh46gO4
X-Google-Smtp-Source: APXvYqzoIqEpTpq5iS2e+nkFsZfzWd15MpWcf4W6chh7nZhPh9Cmb2KWzmGqaryFh1TtMYt3Q3RmvQ==
X-Received: by 2002:a62:4602:: with SMTP id t2mr58883228pfa.26.1555104436814;
        Fri, 12 Apr 2019 14:27:16 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:e505])
        by smtp.gmail.com with ESMTPSA id v19sm58098423pfn.62.2019.04.12.14.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 14:27:15 -0700 (PDT)
Date:   Fri, 12 Apr 2019 14:27:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        guro@fb.com, kernel-team@fb.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jannh@google.com
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
Message-ID: <20190412212712.iv6ksgtfr7nhcelv@ast-mbp.dhcp.thefacebook.com>
References: <cover.1554485409.git.rdna@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554485409.git.rdna@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 12:35:22PM -0700, Andrey Ignatov wrote:
> v2->v3:
> - simplify C based selftests by relying on variable offset stack access.
> 
> v1->v2:
> - add fs/proc/proc_sysctl.c mainteners to Cc:.
> 
> The patch set introduces new BPF hook for sysctl.
> 
> It adds new program type BPF_PROG_TYPE_CGROUP_SYSCTL and attach type
> BPF_CGROUP_SYSCTL.
> 
> BPF_CGROUP_SYSCTL hook is placed before calling to sysctl's proc_handler so
> that accesses (read/write) to sysctl can be controlled for specific cgroup
> and either allowed or denied, or traced.
> 
> The hook has access to sysctl name, current sysctl value and (on write
> only) to new sysctl value via corresponding helpers. New sysctl value can
> be overridden by program. Both name and values (current/new) are
> represented as strings same way they're visible in /proc/sys/. It is up to
> program to parse these strings.
> 
> To help with parsing the most common kind of sysctl value, vector of
> integers, two new helpers are provided: bpf_strtol and bpf_strtoul with
> semantic similar to user space strtol(3) and strtoul(3).
> 
> The hook also provides bpf_sysctl context with two fields:
> * @write indicates whether sysctl is being read (= 0) or written (= 1);
> * @file_pos is sysctl file position to read from or write to, can be
>   overridden.
> 
> The hook allows to make better isolation for containerized applications
> that are run as root so that one container can't change a sysctl and affect
> all other containers on a host, make changes to allowed sysctl in a safer
> way and simplify sysctl tracing for cgroups.

Applied to bpf-next. Thanks!

Andrey,
as a follow up please add a doc describing that this bpf hook cannot be used
as a security mechanism to limit sysctl usage.
Like: explaining that task_dfl_cgroup(current) is checked at the time of read/write,
it's not a replacement for sysctl_perm, root can detach bpf progs, etc.
I think the commit 7568f4cbbeae ("selftests/bpf: C based test for sysctl and strtoX")
gives an idea of what is possible with this hook and intended usage,
but it needs to be clearly documented that it's for 'trusted root' environment.

