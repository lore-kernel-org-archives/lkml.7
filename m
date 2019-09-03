Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF4CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821EF21897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567527184;
	bh=KFqgqdQ3pGDtjCG4UTcpzV2z895sdercfEv8QwliLtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IBCzCCv6XPvKtRzNyjw5vd4aBVhYga4kJhDtF9GmNSmb4AuLDU1E1oOMI1NE5p1Fy
	 wJLtQqXKY9EeVuGQGs1mAf2hSpip6wul2BlFhc3nVh35567xvCtgDC7udmWlq+q2Es
	 62KD4kvF5o7NtniHz19ucM3xnxDy11ClY1vRG2ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfICQND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:13:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35900 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfICQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:13:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id l20so2175476ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hv4kOe1VKjXUkrvGrBeqo5ExN9L2dWKCmjy289pdDpQ=;
        b=H/3/d6xMLAjlOR5eNENXnRk9imQUfFu89C+DmFKWCU5gRq1bUeUFFFQeyAMnTbxLIN
         ChTPIMIL6ytleW8mRmjBNooCJZXb9Oj/u6i1hFP0NnBQZC7GH3Q/cNhWylF+LUiVXzp+
         /yOleW9Nnc711XM4jCWSLwilsHrPRf+iXxBoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hv4kOe1VKjXUkrvGrBeqo5ExN9L2dWKCmjy289pdDpQ=;
        b=duuJMQIQL3qyvJfwzoZQHLcIHksIL3YUcjr8DP1lX262E4T/b7N7YfAKF1gCtuvycF
         KNds+Tm4sOF5nsljkS2llSBPXOWSqeOsIEDsOnKyUYZFqVeGFyTP39HxTxxiB3u+1exG
         A8az6igsN0LPDLtloR/rZl425xKueTkdDDD7wrJBcQ1f2xnO9EyS2ibCl/gQZjcQUh5c
         8u734yL76WN9gdepe0wdQTXBtdyfYZu9nSmZPmzYwB0ELsyiKa6lqoJLiucVdv9jMpxY
         qVvljCkUMWiyUmtO4PRwF0irJ47eBgB4YSd9UF7hPEqg2w3vmcH05fHxQkdFxpOF+eGH
         TeJg==
X-Gm-Message-State: APjAAAWNn0MPrKMPDEViD6t+thTOrveXQgZeI3/Ka4KyK/IpsE7ZvVza
        YQP5HTdCA2E3GY8fZiSxfOzxguhFOQc=
X-Google-Smtp-Source: APXvYqwlBuKFODJPJYS67nKSNwWz9EQwafbzlGHkGwjVtdYoTIzLqmUIjUCBrksK4jFxuUq7v/RUBA==
X-Received: by 2002:a2e:1518:: with SMTP id s24mr18952323ljd.205.1567527180701;
        Tue, 03 Sep 2019 09:13:00 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d17sm2558344lji.41.2019.09.03.09.12.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 09:13:00 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u14so10067226ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:12:59 -0700 (PDT)
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr12625125ljo.90.1567527179509;
 Tue, 03 Sep 2019 09:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com> <20190903160036.2400-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190903160036.2400-2-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Sep 2019 09:12:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3YyA95bevUaW_fTxmq58ffoHgfFANk-8_RJcGESXEsw@mail.gmail.com>
Message-ID: <CAHk-=wg3YyA95bevUaW_fTxmq58ffoHgfFANk-8_RJcGESXEsw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Fix: sched: task_rcu_dereference: check
 probe_kernel_address return value
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 9:00 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> probe_kernel_address can return -EFAULT on error, which leads to use of
> an uninitialized or partially initialized sighand variable.

I think this comment and this code is actively misleading.

There is no "uninitialized or partially initialized sighand variable".
That's completely wrong.

The sighand variable is always completely initialized. It's just that
the check for "is it initialized" is _not_ the return value from
probe_kernel_address(), because that return value is simply not
sufficient.

So this is just wrong. Don't do it. You're just confusing the issue,
and you're making statments that aren't true in the commit message,
and making the code do a pointless and odd check.

If you want to change this code for legibility, you should just add a
comment above the probe_kernel_address() about why the return value is
ignored, and why the check _below_ that code verifies the value of
sighand with a different check.

                Linus
