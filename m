Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D36C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEFE2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Aq0SQFOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDHUa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:30:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45477 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDHUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:30:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id t15so6650046lfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zwfQiKHSSkXAIElEhtTEITR+MWS8OD6EsM2BJiNfDs=;
        b=Aq0SQFOFcBEuudianTY7PvkImwOepaL099DEx+sU9TVY1xNgbnQKcrggUuu9hX5Qe5
         euGv6SIVbcS+kXnZVU+2CmY4JMbK2/IlQki2nCcen0V0KY+zyevIeQtIho1ofnTwOybq
         ZuKII13tvpFQGuozTy3d8UCXK2h1lrOllOHpDo5vHA2Mfrro3fHt+1Cig8SonEEpPVbP
         0I39kh6ki6F7YKhxMwNwLQPCadlzbLh1cCYEvk9jPF0aalt+laLHpZYfPzZF9+gftIeQ
         p8BqCaTudb/w8ElH9rQQ8/G8NyBr1/Mk5jNaJGiygVMgIPizjshqnVEsN4oDJC7v/VBJ
         YHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zwfQiKHSSkXAIElEhtTEITR+MWS8OD6EsM2BJiNfDs=;
        b=ZRuepnd+2VXGen/U4ZEAm8ljUb4EHAHWkmYpXoSOYw185AjbVN5Wfg5V2QNv9fErhh
         +3HD3pCgR7YLEdKsW9f+5Gaxiras2RN/2erKWIc851f/v28roprP4Seprv8o3hAM9OsP
         cAJdBPqRfAQDLLN8olMXUaOycXNEkxDgRcYw42d44VSgIuPKWu+qdy9x0imL9ZLgoXaQ
         LgC9lLjBNwIqvGqsQJqzGJNWezC8nfWz2FykiHmW9CvjguMIRfnxhkmLGgmgQkrwAieS
         oGrkoLl/h6sOxzCLTFVMa74bvdkbnIlWLnIrSWofKX0hIwsu3d6ONDl+E+szlxAUwAX2
         aiaw==
X-Gm-Message-State: APjAAAVldDo5lROYrHcvqWuklTeUuhSYZY4kwsup3HozxixBhm2zsG0q
        S+R6qXNNaN4H1C99ycjQGLj+ViPCWIfZn1i+BYJ+
X-Google-Smtp-Source: APXvYqwlDJjE852hXTxz9FLZRzzDpsJK6DCGPH+j2a7/7xVH+76mQztdx3QYmFPE1/y0uMVEeOXdzDw8a9Bp0HjG4NA=
X-Received: by 2002:ac2:4148:: with SMTP id c8mr17418404lfi.2.1554755423194;
 Mon, 08 Apr 2019 13:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190408113131.222f480a@canb.auug.org.au> <20190408171534.GA11717@altlinux.org>
In-Reply-To: <20190408171534.GA11717@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Apr 2019 16:30:12 -0400
Message-ID: <CAHC9VhRT3WDbidC2=0wGnKEB5syHh6D=zWS4TX2ZGYAKxfxASw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the audit tree with Linus' tree
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 1:15 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Mon, Apr 08, 2019 at 11:31:31AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the audit tree got conflicts in:
> >
> >   arch/mips/kernel/ptrace.c
> >   kernel/seccomp.c
> >
> > between commit:
> >
> >   b35f549df1d7 ("syscalls: Remove start and number from syscall_get_arguments() args")
> >
> > from Linus' tree and commit:
> >
> >   16add411645c ("syscall_get_arch: add "struct task_struct *" argument")
> >
> > from the audit tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
>
> Thanks, the merge fix is correct.
> I've also re-tested it using the new selftests/ptrace test
> from PTRACE_GET_SYSCALL_INFO patchset.

Thanks for the verification Dmitry.

Stephen, thanks for the heads-up, I'll pass this along to Linus come merge time.

-- 
paul moore
www.paul-moore.com
