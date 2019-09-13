Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FAFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E29D214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568414736;
	bh=8/PTuAQNJHqIvg2MM/HG3ygInLUH8FO9HvUCmgN7iCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CzR6QWSMlAuBF+wORrCtAlkvO8m4rqyvqX0sh+rYskV7B80q5W7u3J1OVPw0+9cLh
	 hANwrnGL4j77yGugt1AiXLUAN55dAV7tRMyYZZLS9lbBeVFQd9QEyL9dgcs2JzKJgJ
	 XW7h+IEcnuGoYJ6V4rYsvsSFgT/cxegyg/OR/oGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404181AbfIMWpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404024AbfIMWpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:45:34 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D750C214DE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 22:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568414734;
        bh=8/PTuAQNJHqIvg2MM/HG3ygInLUH8FO9HvUCmgN7iCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yyh5Z7sJFO6Dy8bjoesC7bphmvs9X4qf/Rp25qGuTBMNO8kbhu5iCTBQR/5N5qP1p
         v5hxQ62v96pZKpTlkyPE7izGs1OZwm6wscNeIDC31s7QhD7fKHAOaoIfN6TlEXT1Fd
         TUhGUG1U4Nx0UH8+AtwS8CdoJmwnJzjBLpyb4GJY=
Received: by mail-wm1-f48.google.com with SMTP id q18so4236015wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:45:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUvcyDlVtd7uzetKjhnpr5zK59JAWDlGmvD6P87AeDxyX445KRy
        fN4CYqv5WCOc/ldoQDR8jz92vMmp9lvVPY8TtQtz4A==
X-Google-Smtp-Source: APXvYqx8ZfA6BDLQIi6xmJuaPK+AZH4wFCYsHJz2279bw57Tv7CIqIvpjxAIqYhXh7Z3iLDQFOxo5K8uU0OdhTIAgkI=
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr5514402wmk.161.1568414732419;
 Fri, 13 Sep 2019 15:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190913210018.125266-4-samitolvanen@google.com>
In-Reply-To: <20190913210018.125266-4-samitolvanen@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Sep 2019 15:45:21 -0700
X-Gmail-Original-Message-ID: <CALCETrWquNJJ6yXdHA_F3h71hVrFjnpwmdH2NmGZyFu-V6Lnfg@mail.gmail.com>
Message-ID: <CALCETrWquNJJ6yXdHA_F3h71hVrFjnpwmdH2NmGZyFu-V6Lnfg@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86: use the correct function type for sys_ni_syscall
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 2:00 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Use the correct function type for sys_ni_syscall in system
> call tables to fix indirect call mismatches with Control-Flow
> Integrity (CFI) checking.

Should this be SYSCALL_DEFINE0?
