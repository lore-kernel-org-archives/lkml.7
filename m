Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B551C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA0220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JohBYW/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbfB1PSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:18:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32823 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbfB1PSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:18:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id x9so12308736qkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LHYYDw5IEr0Z3bfIZUydUHRrCoTE6ihZjbQOgO4Vu+4=;
        b=JohBYW/eB1ksawkZAU2cGTJ9LcqYmCdrmb2fSytbx4rI1ZIaoN99CgXI9uBzpXCrSq
         gK+42HPYcCAcRyi9lz2e+234+Bsw3Ou7wYBNtsDfbqJIuPo6IHs5+q8qaTcEd3aC0e5N
         73Up1gt6sJuQL7rrBEAor44MynmF2OvknxGVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHYYDw5IEr0Z3bfIZUydUHRrCoTE6ihZjbQOgO4Vu+4=;
        b=iesNqXBXzGa2O17TYGu/X6czIdCqthxr2exXRmdFNn+1vrGHFdsjO9QUzpSM/WMuWD
         1mjkf4iPtd0d5gIf57qDnLSt9+1Loqnl5A8vBQQbGQi/FO20Mgyb1TysjaUSQnORoSFc
         g/Z07adoOxqK73n+pSSfvOYtIeq9G2eBviRMOL9s3H6/PYUcJV9cuqc0KuzYXwa0wT1b
         cw8K1z68WcY8P2zTJ7RwPJqFxTV2KnLZupYlk8R22C+xe71Bz9cEwFh5rsQxQ+v+TxAh
         /MsnjCSapYRB4/BdN86S2yW2r/xUjLmj53DhbBZGSLd0LAYxgOCARvPQ3FV07cfzrdUk
         KwHg==
X-Gm-Message-State: AHQUAuYaYL1y6yHDKzbIok0GefkoMEtDFOYXaTIdMkpOY09SsLYFz3ML
        L+cx3XNCf7QS4P9AuGetNXdKxA==
X-Google-Smtp-Source: AHgI3IYHOWk/O1OBon0oIYArBhTiNa0+ysDbEu45eFkvPTAk1MwBlKOylPtF0WYScASqKHC3jBdJ8Q==
X-Received: by 2002:a05:620a:1333:: with SMTP id p19mr6556301qkj.165.1551367120811;
        Thu, 28 Feb 2019 07:18:40 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id r47sm12488154qtc.48.2019.02.28.07.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 07:18:39 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:18:39 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>, will.deacon@arm.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org, yhs@fb.com
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190228151839.GA159251@google.com>
References: <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home>
 <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home>
 <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
 <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <20190226152447.GA99670@google.com>
 <20190228212913.20079490b3df88d285664a56@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228212913.20079490b3df88d285664a56@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 09:29:13PM +0900, Masami Hiramatsu wrote:
> On Tue, 26 Feb 2019 10:24:47 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Fri, Feb 22, 2019 at 11:27:05AM -0800, Alexei Starovoitov wrote:
> > > On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> > > > 
> > > > Then we should still probably fix up "__probe_kernel_read()" to not
> > > > allow user accesses. The easiest way to do that is actually likely to
> > > > use the "unsafe_get_user()" functions *without* doing a
> > > > uaccess_begin(), which will mean that modern CPU's will simply fault
> > > > on a kernel access to user space.
> > > 
> > > On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
> > > and users pass both user and kernel addresses into it and expect
> > > that the helper will actually try to read from that address.
> > 
> > Slightly related and FWIW, BCC's eBPF-based opensnoop tool [1] installs a
> > kprobe on do_sys_open to monitor calls to the open syscall globally.
> > 
> > do_sys_open() has prototype:
> > 
> > long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode);
> > 
> > This causes a "blank" filename to be displayed by opensnoop when I run it on
> > my Pixel 3 (arm64), possibly because this is a user pointer. However, it
> > works fine on x86-64.
> > 
> > So it seems to me that on arm64, reading user pointers directly still doesn't
> > work even if there is a distinction between user/kernel addresses. In that
> > case reading the user pointer using user accessors (possibly using
> > bpf_probe_user_read helper) should be needed to fix this issue (as Yonghong
> > also privately discussed with me).
> 
> OK, it sounds like the same issue. Please add a bpf_user_read() and use it
> for __user pointer.

CC'd Yonghong who said eariler to me he would add it, but I could add it too
if he wants me to.

thanks,

 - Joel

