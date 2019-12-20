Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F6BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C057206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7xtH7YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLTDsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:48:25 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42453 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfLTDsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:48:25 -0500
Received: by mail-io1-f67.google.com with SMTP id n11so1311765iom.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 19:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5xRolE5dJvA7tdJmuE0DTxJx+uRpisDGCBUfeRMXSM=;
        b=K7xtH7YCSSZQ096YgPc5qIj9YHYxNW7cmkptjfJEDK3oxVfF6gislTzqxlNYnS8yZn
         cCgJoc+Gsu4kVIct/nNcP3H+Q0Un0h2GNn8HRpBdArpfg5D7EmR10Ne4ZxRPdXaE0ihI
         io81vp5+n9v3osGZrTjmzbMCy9OPTsFLywAS9aHXgFIrqAmXD41/GfXSEkfCWEzD4e2e
         NUFtpJfQqQwTQ+bULiaEOwmptPCIKgv8tBPZNySNkU5YDGVNsvN/SIiLqKhbjjdJ07ON
         ZvCNf+x9H9ISgmIZ3R9Caxb5hNrxFa2O+FTKb8h5h3b439NTowJ8jhso1uL3sKSpGnsj
         zjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5xRolE5dJvA7tdJmuE0DTxJx+uRpisDGCBUfeRMXSM=;
        b=swt2mk7tSvyOkv/nO3nwCHC3DLhhSOwNsz4OActFBZkNIYjNj+8O06Z/ymDGwo0ffB
         Egzqgm4voOXFEXdwJqhsLpFzIOtGWmj6HyTy+LtWKymqRtC7qgWgVkVoSeoYIYal3AQZ
         gkUlRcYH6XZEjxIuu5vIHmLwdMAuHvYSizmvUicxBLO54/+bcIdm4Behsvm9zJPxUrUY
         Z7ylG27xkBwQw7+LSgbSqF7a0rG69SPsvGj3gdcdiB/D9oDnGiWbbCPotTEn+ViQf/fK
         0J8/9RVgY3dNGSHCZ7wBQUJUPDXgC72uTEtCcDinNEEjzEo/wfx0VGWzyXaQNtpYSm8K
         VX5Q==
X-Gm-Message-State: APjAAAV2DUDUyBOjjSeka+tnf4pgOlrfel2/KgKg2pQcxXxFmeEE/E3E
        IK1LD6CLJ/cDOZYztoGuciE+8pmbVueKffygLK3t
X-Google-Smtp-Source: APXvYqyBJdasz/TCOTp+h3nWUu0XU27QVLvPuhBGMxADP6E4YYEQl/Q4OlO7SrDVk6HZzl+veZsHn2KikBNNkj/oDqM=
X-Received: by 2002:a6b:b717:: with SMTP id h23mr8598334iof.273.1576813704203;
 Thu, 19 Dec 2019 19:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20191219115812.102620-1-brgerst@gmail.com> <CALCETrW1zE0Uufrg_UG4JNQKMy3UFxnd+XmZye2gdTV36C-yTw@mail.gmail.com>
In-Reply-To: <CALCETrW1zE0Uufrg_UG4JNQKMy3UFxnd+XmZye2gdTV36C-yTw@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 19 Dec 2019 22:48:13 -0500
Message-ID: <CAMzpN2if2m4McWpL49U4QAEM1MJ+qgTe-emN8vKcjVc1H+84vA@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove force_iret()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 8:50 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Dec 19, 2019 at 3:58 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > force_iret() was originally intended to prevent the return to user mode with
> > the SYSRET or SYSEXIT instructions, in cases where the register state could
> > have been changed to be incompatible with those instructions.
>
> It's more than that.  Before the big syscall rework, we didn't restore
> the caller-saved regs.  See:
>
> commit 21d375b6b34ff511a507de27bf316b3dde6938d9
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Sun Jan 28 10:38:49 2018 -0800
>
>     x86/entry/64: Remove the SYSCALL64 fast path
>
> So if you changed r12, for example, the change would get lost.

force_iret() specifically dealt with changes to CS, SS and EFLAGS.
Saving and restoring the extra registers was a different problem
although it affected the same functions like ptrace, signals, and
exec.

--
Brian Gerst
