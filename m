Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B48C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942882171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551356960;
	bh=pNtoIm19/RbLA530zaYV92DVB139pC7B3avkF0tQ5PI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yqhEgfPzTbDLZPR2kaRLEOoDAmDlTJjeXKPhTQi7rBNXPKatiOjwANBh4qcvPTAXi
	 TMQYLikhri36d8UokeJOPtsFmLt0aoDMywivih9BFJa2mf9xybOdz3n+BSJIcVycpb
	 PcT+bwiPodVoG/hjUFsLrRBMSR1eMUtXgbIXyOhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfB1M3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:29:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbfB1M3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:29:18 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581EA2083D;
        Thu, 28 Feb 2019 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551356957;
        bh=pNtoIm19/RbLA530zaYV92DVB139pC7B3avkF0tQ5PI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=omgd/yZw4ojeqpb7pfcFA91qgLNCXdlJselo4cKLcltpHI98GV7a0T7uHggPLa8WA
         tepmvVe/uMhQ7Ro4odpHy5ahACxo867l86bYRTiVnqHP8Ty8VgAcRUnbUvBwH2kiZT
         MuXa1i+GYgtRKwzwksjLc6nwFE1AaJaJAJTs/bqQ=
Date:   Thu, 28 Feb 2019 21:29:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190228212913.20079490b3df88d285664a56@kernel.org>
In-Reply-To: <20190226152447.GA99670@google.com>
References: <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
        <20190219111802.1d6dbaa3@gandalf.local.home>
        <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
        <20190219140330.5dd9e876@gandalf.local.home>
        <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
        <20190220094926.0ab575b3@gandalf.local.home>
        <20190222172745.2c7205d62003c0a858e33278@kernel.org>
        <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
        <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
        <20190226152447.GA99670@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 10:24:47 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Fri, Feb 22, 2019 at 11:27:05AM -0800, Alexei Starovoitov wrote:
> > On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> > > 
> > > Then we should still probably fix up "__probe_kernel_read()" to not
> > > allow user accesses. The easiest way to do that is actually likely to
> > > use the "unsafe_get_user()" functions *without* doing a
> > > uaccess_begin(), which will mean that modern CPU's will simply fault
> > > on a kernel access to user space.
> > 
> > On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
> > and users pass both user and kernel addresses into it and expect
> > that the helper will actually try to read from that address.
> 
> Slightly related and FWIW, BCC's eBPF-based opensnoop tool [1] installs a
> kprobe on do_sys_open to monitor calls to the open syscall globally.
> 
> do_sys_open() has prototype:
> 
> long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode);
> 
> This causes a "blank" filename to be displayed by opensnoop when I run it on
> my Pixel 3 (arm64), possibly because this is a user pointer. However, it
> works fine on x86-64.
> 
> So it seems to me that on arm64, reading user pointers directly still doesn't
> work even if there is a distinction between user/kernel addresses. In that
> case reading the user pointer using user accessors (possibly using
> bpf_probe_user_read helper) should be needed to fix this issue (as Yonghong
> also privately discussed with me).

OK, it sounds like the same issue. Please add a bpf_user_read() and use it
for __user pointer.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
