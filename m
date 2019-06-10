Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F11C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5380221721
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560185893;
	bh=r6t36RuY3YSeP5ZeuupJ/jO6mRzKiIh8KEEeX5jSAYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QrHZ6ILCbKO8vSva5YsDp6fMMRq4o9jOmb1EZJtsCLa3Zn5B/i7HMPR5zMRH30kGz
	 ltPdwwMPk0fZtIPzagAZeRG8F+WQyQQUITNhFN9LYSFxpwuo7SDIjRVkLpBpSw0xll
	 /IFvQzz8JpJUP+4rXVCF3kMN8EbejWAR9iz6NGIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbfFJQ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfFJQ6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:58:12 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84DD621743
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560185891;
        bh=r6t36RuY3YSeP5ZeuupJ/jO6mRzKiIh8KEEeX5jSAYQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RIZjL8xuTYdxq1Cetu873xMcSXzCdn2IC83WmmgLogvO9fsf2poutLTkD9wbbRQXb
         rvkaW43qQiiObLw8YqK5Mjtsynrh+g859nM+IH84blfWTDUQVx/ilKWbtiOcxX5W7n
         vG6IYz4N+59OF5/WOhgUF5UaDG8NA3NtHF1NQwKM=
Received: by mail-wm1-f46.google.com with SMTP id s15so71719wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 09:58:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVeabJDuJ3MIu8cpzQWtJg6qJZtoGDdO8wlitQ17RVVsp6TeBER
        ebLbzIRH/qOdMmrx5yIcJUEtXNUyfCMAIErYZtYoTA==
X-Google-Smtp-Source: APXvYqzwrsZuuIhECtAIx/89DTjfF4K8XkTeidID7yE7yekDKBmcHs4PHyFJ1xCTlBz6MSKjTXosQte07xsHykc0pKk=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr14441740wmj.79.1560185890024;
 Mon, 10 Jun 2019 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190605130753.327195108@infradead.org> <20190605131944.946978563@infradead.org>
 <20190610165258.t7rcvggdjihtdrfz@treble>
In-Reply-To: <20190610165258.t7rcvggdjihtdrfz@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Jun 2019 09:57:58 -0700
X-Gmail-Original-Message-ID: <CALCETrVRuMP4vF+dN-tK_cw=guv6J5EqgD1H-PxMow+d=1DT4g@mail.gmail.com>
Message-ID: <CALCETrVRuMP4vF+dN-tK_cw=guv6J5EqgD1H-PxMow+d=1DT4g@mail.gmail.com>
Subject: Re: [PATCH 07/15] x86: Add int3_emulate_call() selftest
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 9:53 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Jun 05, 2019 at 03:08:00PM +0200, Peter Zijlstra wrote:
> > Given that the entry_*.S changes for this functionality are somewhat
> > tricky, make sure the paths are tested every boot, instead of on the
> > rare occasion when we trip an INT3 while rewriting text.
> >
> > Requested-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
>

Looks good to me, too, except that I seriously hate die notifiers that
return NOTIFY_STOP, and I eventually want to remove support for them.
This can wait, though.
