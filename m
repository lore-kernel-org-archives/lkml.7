Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED8C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F7E206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="bX8NzEIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfD1U4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:56:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46956 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfD1U4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 16:56:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so4080336pll.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PMSrmlfvNPSDiUeJDXR9q1eCVxoxW5mdLWF/ia7lsmo=;
        b=bX8NzEItRUJcNX4IEaO92aGZxzA30k0Cjey8QZMwYTNntpn6Jlk4zVsKp3WP/MmkYU
         K0khKZ4h23Y3mEWI18gykXFuiPYWX6wRxAxbi5rNuYiXHWvvFjk0Ee+uIDYXGdgY24u1
         uu0Je+tuLRIzW8l5DQHM3lL6bZivg7c7W0KZhWFhI/X08fzTGmc0KCGFkPf9K5EvEWYA
         fNgyNIY7G78xr6JAW8M+w6H2WcqfaH4S9OPmyPUQD9mJRg4HuxfEFS94KcbIrRNyzMQ9
         QS3wI7CPueMd5ksDLDX1Z+4Xb2HPRyT1KyVB517WedzUUGNGLkovD0ujdr5JGgzmtBa7
         0WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PMSrmlfvNPSDiUeJDXR9q1eCVxoxW5mdLWF/ia7lsmo=;
        b=EU4h5KrxiC/dBwcFhHXZo8GOaP8dnSOnW7dUHgFR30ILJuEMxbzqyPt7Dr07AeBpVm
         yT9ibsvyducozgcofoFIiJzIu4A4ngizcGlShJ/cp6E49qvY/FNGxxDtjr+GVxO9VbVG
         JAIfRltSYHf0LRuXcC40Y+Ewbu6z8XaoL0GGFq1z8dh9N2zHFBe0rvrsNLro2gklAs6B
         chjJ7LiXjT8xQr3JNRY7YeyKecQQUnI6c+Dm74u/IE6hALNGNahRzUhC5IfBzPIMo8Sg
         3FWbMqz0h4hGPi8ImKi4/iPdS+s7BgjJJaOGx8pMz0Fry0RAf9l6mCWYPs0XCcB1uxzD
         bF1A==
X-Gm-Message-State: APjAAAXLBNsMmwiQYqsWu70pfNB0oLsjraDu8AOw7dap7rEnKla/6w23
        buUYy8jHr48Xb/lOLJLY1NvKEA==
X-Google-Smtp-Source: APXvYqzdjuejzRMRDDBOeS+MzW068kwST63q5A5Q5pLQhcdP4++zAdcxzk0RDl8evG7cCpmts3B0qw==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr41852080pld.52.1556484993871;
        Sun, 28 Apr 2019 13:56:33 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:68a6:ac0c:7713:add7? ([2601:646:c200:1ef2:68a6:ac0c:7713:add7])
        by smtp.gmail.com with ESMTPSA id r138sm13730618pfr.2.2019.04.28.13.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 13:56:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] x86/thread_info: introduce ->ftrace_int3_stack member
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190428154345.789635b3@oasis.local.home>
Date:   Sun, 28 Apr 2019 13:56:31 -0700
Cc:     Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <249CA966-9EFF-4687-8BC9-9364EDD51388@amacapital.net>
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-2-nstange@suse.de> <F6268634-96D3-4267-B739-6D375FAB26A8@amacapital.net> <20190428135143.09d35bb6@oasis.local.home> <D5735AF7-D603-4B20-A3EE-B519044D1E5D@amacapital.net> <20190428154345.789635b3@oasis.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 28, 2019, at 12:43 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Sun, 28 Apr 2019 11:08:34 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>>>=20
>>> Perhaps adding another slot into pt_regs that gets used by int3 to
>>> store a slot to emulate a call on return?
>>>=20
>>>=20
>>=20
>> That=E2=80=99s not totally nuts, although finding pt_regs isn=E2=80=99t e=
ntirely trivial.
>=20
> I meant on the int3 handler (which stores the pt_regs).

But that=E2=80=99s below the stub=E2=80=99s RSP, so it=E2=80=99s toast if an=
other interrupt happens. Or am I misunderstanding you?

>=20
>>=20
>> I still think I prefer an approach where we just emulate the call directl=
y.
>=20
> Then, on the return of int3, if there's anything in that slot, then we
> could possibly shift the exception handler frame (that was added by the
> hardware), insert the slot data into the top of the stack, and then
> call iret (which the int3 handler, would add the return ip to be the
> function being called), which would in essence emulate the call directly.

Oh, I get it.

I liked Josh=E2=80=99s old proposal of unconditionally shifting the #BP fram=
e 8 bytes better. It will be interesting when kernel shadow stacks are throw=
n in the mix, but that=E2=80=99s a problem for another day.

