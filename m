Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE7CC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878B92133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565989520;
	bh=v0OnfDwgvQY00ufiCb01TTk/GgQIvvkU0mLWqEKfxbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uFrc4rHIILDEKReKiGVgHA4pFO/ZzhTYBkD/434r1TvrKf8LzZ4TTVlKTT+QzS1wY
	 VNDt1L8f9yUZ/3VdOHqAbjBasgl+H20BZEBigy0QALZTw0YXFG64dIYu+Xo3ecrZrI
	 Gwo9Ry6r3tx3z6VoqvlamR3xm1o8Lk3xDil5hHls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfHPVFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:05:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45435 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:05:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id l1so493966lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIkpg8Ze0IEwpK9vhZZEdvKSfS1Ar7WRyQ1w9OXfsfY=;
        b=Eu/AXif9yHBKrzKcrBa5aGGYFZy3RgSh2Dz0CW4CYMtYTexDblKx9Jqt7LjM1IzaSw
         ZVgzuHJyg2MXmAlI/9SzQmCC6M0ofLrdT/JeyWEonsMbEyO776NqmhDzv+UD4lgg3jHF
         qu50RsUOl66dxECQhSKUh0YqdRexNx7M/3690=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIkpg8Ze0IEwpK9vhZZEdvKSfS1Ar7WRyQ1w9OXfsfY=;
        b=bEzt/Q0Sy2/fjn/dfPpyl0IfUSsUqwACzl+IATaoWqnBGAA+rf+wTMGM/wAky8jxvQ
         Rqoysgs7oLmmoUnQonGaeBU055umuzXJ3A0EmdgSg6zQPsV2FTEEfOD3fhzMFLL0IYVZ
         2+UANfcszIpyM/5n7Z/vywzN1XSFnaVh+ipApEdkLH2aWiKsVA/2FcUkauwdWDdTmAmo
         uz9k7OrPmnx+a5kgOTuCQQtQUtHjjWqw6Keqx9e3hG9uwh352WDNhe3KmrXvkTlPDjS8
         9Lo7ptGEUkEIex46RZGvjNagOhMYNg0Yfl87J3EbeLMdqhakqd2NRsG6bRz7OGV/J18G
         AnEA==
X-Gm-Message-State: APjAAAWmnDUb0USwQFRBI/izAxRldlUFuJVMzCB5A2TaI9FawfE3XR27
        7rmCOk1RCGOpuNebYz8JwtzEJc265og=
X-Google-Smtp-Source: APXvYqyMICqdMnWcMgW+rnJZ2MMl2yYID9INRzsDmnr2Ro5WjWWzT/d2yDnEmbSsLSt6Fvhs9Kj+7A==
X-Received: by 2002:a2e:8616:: with SMTP id a22mr6744687lji.167.1565989515723;
        Fri, 16 Aug 2019 14:05:15 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id x21sm1115217ljj.57.2019.08.16.14.05.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 14:05:13 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id a30so4944101lfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:05:12 -0700 (PDT)
X-Received: by 2002:a19:c20b:: with SMTP id l11mr6228237lfc.106.1565989512392;
 Fri, 16 Aug 2019 14:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com> <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Aug 2019 14:04:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
Message-ID: <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 1:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Can we finally put a foot down and tell compiler and standard committee
> people to stop this insanity?

It's already effectively done.

Yes, values can be read from memory multiple times if they need
reloading. So "READ_ONCE()" when the value can change is a damn good
idea.

But it should only be used if the value *can* change. Inside a locked
region it is actively pointless and misleading.

Similarly, WRITE_ONCE() should only be used if you have a _reason_ for
using it (notably if you're not holding a lock).

If people use READ_ONCE/WRITE_ONCE when there are locks that prevent
the values from changing, they are only making the code illegible.
Don't do it.

But in the *absence* of locking, READ_ONCE/WRITE_ONCE is usually a
good thing.  The READ_ONCE actually tends to matter, because even if
the value is used only once at a source level, the compiler *could*
decide to do something else.

The WRITE_ONCE() may or may not matter (afaik, thanks to concurrency,
modern C standard does not allow optimistic writes anyway, and we
wouldn't really accept such a compiler option if it did).

But if the write is done without locking, it's good practice just to
show you are aware of the whole "done without locking" part.

              Linus
