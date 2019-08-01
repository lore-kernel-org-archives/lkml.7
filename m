Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB03C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7F7206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564636910;
	bh=u+NSo7Xr4J1UtkMZ3fciXvWnaLTy5NZ6RahWBeS9LmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YelOZ1p5wT80jnciqY0vLCqbXWJ3KZaS0qXL5Z5y1wznlTVFZrSxb4Zf2tEnfSvFj
	 OTcdDvEjsim8RHtcVQK42qhGkEIDivsgVhqDBAsb0e0gsBi4RJBzhefcF8WqhKdQgh
	 mw6VzCJpcIM7N7MAeu3Wq+5CsAM+ZiJVDVnGX+jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfHAFVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHAFVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:21:48 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0266A2183F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2019 05:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564636907;
        bh=u+NSo7Xr4J1UtkMZ3fciXvWnaLTy5NZ6RahWBeS9LmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P+MZwFJ0im+H+jO2fdD2ReQyiopW4KXhSD0+dSryuJtAdLRRf9MwQokeX4GA+O2mw
         qoPaBTHr1IaaYhk5SOC2u03JldrYrYhzao9pkQomuzC5ZOQIe5FvitYlfgaM9CSa3P
         QzrSXrduG+A/0A0uYljv5kQhk9KTf5NUmASyzN2E=
Received: by mail-wr1-f54.google.com with SMTP id y4so72091782wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:21:46 -0700 (PDT)
X-Gm-Message-State: APjAAAW0k3NNiC7emX6BpZL82DLEFi2EwZwOUwFF5l+WeP/Vb07m+7jK
        RuBQGjR7lsUKRAtgg/Doa9BYb/8f0KYVVOwE54w7nQ==
X-Google-Smtp-Source: APXvYqxNJs/3/OM7xqG0+zDXb7EBWla6AbxRiGjvW6rkDb7FQKOQktYbohBvB/SLjkC7L+f9sGNcWYMeV/oHVVfUhzY=
X-Received: by 2002:adf:cf02:: with SMTP id o2mr118390659wrj.352.1564636905321;
 Wed, 31 Jul 2019 22:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-29-dima@arista.com>
In-Reply-To: <20190729215758.28405-29-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Jul 2019 22:21:33 -0700
X-Gmail-Original-Message-ID: <CALCETrXL6pzDoHfn9Niw_CxNX-_W3=yotDYuqK+kxPhOLofmNA@mail.gmail.com>
Message-ID: <CALCETrXL6pzDoHfn9Niw_CxNX-_W3=yotDYuqK+kxPhOLofmNA@mail.gmail.com>
Subject: Re: [PATCHv5 28/37] x86/vdso: Enable static branches for the timens vdso
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>
> From: Andrei Vagin <avagin@gmail.com>
>
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
>
> Addressing those problems, there are two versions of VDSO's .so:
> for host tasks (without any penalty) and for processes inside of time
> namespace with clk_to_ns() that subtracts offsets from host's time.
>
> The timens code in vdso looks like this:
>
> if (timens_static_branch_unlikely()) {
>        clk_to_ns(clk, ts);
> }

I'm confused.  Now we effectively have *three* versions: the vDSO
without timens, and vDSO with timens but with it switched off, and the
vDSO with timens on.  This seems like too much.

What you need is, IMO, a static-branch-ish thing that is per mm.  This
has a fundamental problem that the vDSO can be modified using
FOLL_FORCE.  Perhaps any CoW of the vDSO should implicitly switch the
static branch on, which at least gives some degree of correctness even
if it's a bit surprising.

--Andy
