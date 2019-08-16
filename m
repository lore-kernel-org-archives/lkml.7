Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DAAC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F682171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yGyN6OAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfHPUoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:44:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38396 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:44:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3so2360738lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zJNFFtYFNXNppnrKTHuhLPDf9LLLnIdunHZPTN7U0E=;
        b=yGyN6OAQ4+vDjcA3DW21wfSQ3vjKHsDR9f0UHXWRd5/JGrX2jSpx0zvTDP9qscz8In
         IbzHO6FioxQlc7vpXnWhwDBCqQSWQ5FUeQv+4GGWPOKonV9RqsMO/kXtuUdrWLZx9wfe
         gfY9DET1ZiJMEmOqH8OB/bkJi/PdOpXJ/p6Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zJNFFtYFNXNppnrKTHuhLPDf9LLLnIdunHZPTN7U0E=;
        b=qeS73WuBN2rO4Zh98xjV5wVjnGV68VtKGhCeAO6f9qB85nP52n51/EjgTpJgu4OieJ
         WzvQ1pIe/09IxYjEh0ArZLPN1AovgNF5whK6GIfluA4KaF9LFJFH/2cFlf9tyh2tqyF/
         nWxGsKoN2106X8Ei921eLgiPeGto/aieH8iTClmdI3D1j3682LuMpMDKhHnvemVzI6lQ
         vmXbn3ljSva1kYTQkNIx2myBKjyj1fpTyP1GQVg/P9v4XPNaZPCuSH4ledq3WFss3F/F
         MtsUEl3/ghp9M4FyluK/RE/GfZbRbB/uHnmxxivs8EhMN3spWixHDmiN7VOqOl4qQQZj
         y2jA==
X-Gm-Message-State: APjAAAXL36clIowgCk5TIZczFQVpN0+naqp5CnVuXZcdhDDyxL+j23QK
        j/zcpo/SqvV7iObjHPueD/AaPvo/50p+FOpqy/9i4w==
X-Google-Smtp-Source: APXvYqz6BMyt5qIRB4sq855kK1mjed71nc3N7jzwhfaz6X1pqVpEGsKTeFTcqhqytU5M6vQt9E09r3WNaQz39pEptS8=
X-Received: by 2002:a2e:a415:: with SMTP id p21mr6572955ljn.111.1565988261752;
 Fri, 16 Aug 2019 13:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com> <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 16 Aug 2019 16:44:10 -0400
Message-ID: <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 3:19 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 16 Aug 2019, Mathieu Desnoyers wrote:
>
> > If you choose not to use READ_ONCE(), then the "load tearing" issue can
> > cause similar spurious 1 -> 0 -> 1 transitions near 16-bit counter
> > overflow as described above. The "Invented load" also becomes an issue,
> > because the compiler could use the loaded value for a branch, and re-load
> > that value between two branches which are expected to use the same value,
> > effectively generating a corrupted state.
> >
> > I think we need a statement about whether READ_ONCE/WRITE_ONCE should
> > be used in this kind of situation, or if we are fine dealing with the
> > awkward compiler side-effects when they will occur.
>
> The only real downside (apart from readability) of READ_ONCE and
> WRITE_ONCE is that they prevent the compiler from optimizing accesses
> to the location being read or written.  But if you're just doing a
> single access in each place, not multiple accesses, then there's
> nothing to optimize anyway.  So there's no real reason not to use
> READ_ONCE or WRITE_ONCE.

I am also more on the side of using *_ONCE. To me, by principal, I
would be willing to convert any concurrent plain access using _ONCE,
just so we don't have to worry about it now or in the future and also
documents the access.

Perhaps the commit message can be reworded to mention that the _ONCE
is an additional clean up for safe access.

thanks,

 - Joel
