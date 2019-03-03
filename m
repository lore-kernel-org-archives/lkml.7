Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2483C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF70E2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551575515;
	bh=aeQcNudQANa/9O58tlI+sqExs+mP6kZ+zGbCittOyEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2MNcC2TjTp0Mj78YEmB6GmL2uT57iVKeNza2gn574LIWMoEvwg5WPVDNs1KI2F70a
	 u/Fno9eqaU0mGUmMuPWzS0X3AAX34M/DwiyufdKoSyyZcwYlvBDT3cXSeb5H2rkOkC
	 aQnGXcojkOztmVRFrHCK186L1RxIiXZvuS6VhbPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfCCBLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 20:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfCCBLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 20:11:53 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87E12086D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2019 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551575513;
        bh=aeQcNudQANa/9O58tlI+sqExs+mP6kZ+zGbCittOyEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iMOI3BDxBhhvdZdIcqElKOqDFlfv3W9qoWzA76mmfi84rfF1boPaOJ7z8ss2KewJK
         B1YFnvAra/1ejgoMuHGEvS/k6zP1Cs8HPpPTzKL7pGhf184GnqVnlFO1ELJ8A8TZ06
         U3kfnUleQqTJJ7VsrYr6LTppFm6hUSR9auA4C7gE=
Received: by mail-wr1-f50.google.com with SMTP id q1so1699486wrp.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 17:11:52 -0800 (PST)
X-Gm-Message-State: APjAAAUQRnNKGWnJBb1dgJwpKj+WYT2La9cgOPiebriDh2MgRotbq7ac
        ZkVpbBHD/Fa/ipghgpLLu8TPIf7RbpLErlHVdssWjA==
X-Google-Smtp-Source: APXvYqw5H814IruOE6KiflSk63yk0XpLxWMumnCT4d6g3D3LEBouwjR0Z0rqMrV+mGI06upNb53KEAiOR8SV+YPRVK8=
X-Received: by 2002:a5d:6252:: with SMTP id m18mr7652954wrv.199.1551575511385;
 Sat, 02 Mar 2019 17:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20190228183220.15626-1-sudeep.holla@arm.com> <20190228183220.15626-4-sudeep.holla@arm.com>
In-Reply-To: <20190228183220.15626-4-sudeep.holla@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 2 Mar 2019 17:11:40 -0800
X-Gmail-Original-Message-ID: <CALCETrVOJV0uBX3CbpmuwSGQa98Fabq3-GoRbGMb79m_OoJkmQ@mail.gmail.com>
Message-ID: <CALCETrVOJV0uBX3CbpmuwSGQa98Fabq3-GoRbGMb79m_OoJkmQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:32 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Now that we have a new hook ptrace_syscall_enter that can be called from
> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> can do some cleanup using the same in syscall_trace_enter.
>
> Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> in syscall_slow_exit_work seems unnecessary. Let's remove the same.

I wasn't cc'd on the whole series, so I can't easily review this.  Do
you have a test case to make sure that emulation still works?  Are
there adequate tests in tools/testing/selftests/x86?  Do they still
pass after this patch?

--Andy
