Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD83C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD4921835
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569022878;
	bh=ojAYYfdBkOdiTnCiA1MZE0e9UnZ9KGpCsdeXCBLihcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tdNi++7u3AKDArnVKDPEeSWwRrSvUiSylh16TZA69XQZ5JYs0E/B0z9qflPourWBY
	 9Py/wddEDOUjkoQoXx4d8iGY2HP0uxk5xTv1JYMESfzs1w7AKLNRoP9wTPtt5Jv1sj
	 2JAxk/MQ9vOrQZMDMj3cM5QyiH0mj2M7PyEhee8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407197AbfITXlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407175AbfITXlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:41:17 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0F12173E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 23:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569022876;
        bh=ojAYYfdBkOdiTnCiA1MZE0e9UnZ9KGpCsdeXCBLihcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rRhlAFmKhTi8/d1bAbrqXiBMB11FjQ24vMk8BFohSyIIt8xzlBcJRXaziWx7WDay1
         Rhuq+5+kFyadtLXDOYW4lUBPyJZuOEuC7sw5Tn4pPxgLGdRijMtILsDh4Isu3oTUHE
         1Q/TQhKXZ7YzbceZ9p38MWMduagEjHcPO2Rw69cQ=
Received: by mail-wr1-f44.google.com with SMTP id h7so8327317wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:41:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUFH8Izla3KU15rDcB6YJJNUPwmhdxUwV2Zi3sQ3diyvIjwoVZZ
        xIIrr3sq/BDcibVrpLT3PDRWSEZ/gnx9lAi4l0qT2Q==
X-Google-Smtp-Source: APXvYqyf3OotoH6d4iFXDED9a48fTftKQ2+trQoK9GWGc2XYOC0HoaAixE0iut5qmepC7ZoXIEFCZutTrx67cZb/8w0=
X-Received: by 2002:adf:cc0a:: with SMTP id x10mr13505181wrh.195.1569022874617;
 Fri, 20 Sep 2019 16:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de> <20190919150808.724554170@linutronix.de>
In-Reply-To: <20190919150808.724554170@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 16:41:03 -0700
X-Gmail-Original-Message-ID: <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com>
Message-ID: <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com>
Subject: Re: [RFC patch 03/15] x86/entry: Use generic syscall entry function
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Replace the syscall entry work handling with the generic version, Provide
> the necessary helper inlines to handle the real architecture specific
> parts, e.g. audit and seccomp invocations.

> -       if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> -               ret = tracehook_report_syscall_entry(regs);
> -               if (ret || (work & _TIF_SYSCALL_EMU))
> -                       return -1L;
> -       }

Unless I missed something, you lost the _TIF_SYSCALL_EMU abomination.
