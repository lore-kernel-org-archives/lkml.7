Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D77206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWfGQJGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfKKUZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:25:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33122 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:25:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id m193so12687670oig.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOfyNjirhZJpCYD/14r+NEmeylR+17cr7FHoRrl56Eg=;
        b=dWfGQJGbeWaicejJBkwOAjX8oYfy6+0uZOeGW/ISyKeITlGByBW9LZD0ef0cBcubzE
         5VowYn+IFL3EjC5xJN98eoBJ9cxZurvUFXmKGHv1gMlwUAt2IJQhnG3HCcFE4yDs3pWb
         XLdbPgHB58v6MJSb7XzlKSm8nHqKiutilSbBjh40Ow8IDfWkiK9Zc47coLaMutfIxTpv
         xiOAoKCAR3q6SIm1Xx6H30p83uuVTAoIrXdrC6aCa9jLbptNxGMx/X6uQA01wED4UyBo
         ad+zy/cCPRnzazbtYB2TFdfXk0pT7JRbUbwCY3lgBPQdFIOMfyQqU8r4WxBMICIuDJ57
         wbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOfyNjirhZJpCYD/14r+NEmeylR+17cr7FHoRrl56Eg=;
        b=SEachN9Lv8vdewPtCXIKMywvx544UHmeOl0aFPKr4zVnucrnp5eFZCp3OPQX3BeRLP
         IMkTH5vwx7n2eh7tYQq3FQocmt8/6Re9sL4TA+lQOkk24DtgK835JuV0ouL3HMaIdHRS
         TeXlEnFE+GJeLVC/6IaiFawmCzqlBaZeOQsL7wWszBqWIDT+q7orkKVN0QptEpwW5JPm
         lFL4wix5vycgDxM+6OC4igoKo9GFysQTHGhiPkn5/xPEdbF24Wmr7iO9bvngD9fK6eGx
         iYG8asqR4Ah/5pmpQVtvlKwF5CpCnvlf53Hucn+K9UjjamiCShqdfU8zqyBpPslS907+
         0UlA==
X-Gm-Message-State: APjAAAVeaQc4gHc51WOF9l4Tolj3lbXMqmhkqLFs+qVZn+SqZb2dL5QP
        JBrxQ1fAK04gdOIEzA7J00PW571xBkyRg7qvh5/SaQ==
X-Google-Smtp-Source: APXvYqy1VzfjRJuVb1MDElB7+dHlzd2kffgrpg+vPM+DJzWy3J/vzxZA0hSOvGwfYP2VYVG9yRo/VcuFRjBJ95zHNq8=
X-Received: by 2002:a05:6808:9a1:: with SMTP id e1mr689381oig.175.1573503899982;
 Mon, 11 Nov 2019 12:24:59 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein> <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
 <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com> <20191111165800.GD7017@mit.edu>
In-Reply-To: <20191111165800.GD7017@mit.edu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 11 Nov 2019 21:24:33 +0100
Message-ID: <CAG48ez3K6g7NSFmeuw-4paqPQTDYmNkZ-nVvufk25EB+Us850w@mail.gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 5:58 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Nov 11, 2019 at 03:55:35PM +0100, Jann Horn wrote:
> > Not on Linux, but on OpenBSD, they do use MAP_STACK now AFAIK; this
> > was announced here:
> > <http://openbsd-archive.7691.n7.nabble.com/stack-register-checking-td338238.html>.
> > Basically they periodically check whether the userspace stack pointer
> > points into a MAP_STACK region, and if not, they kill the process. So
> > even if it's a no-op on Linux...
>
> Hmm, is that something we should do in Linux?  Even if we only check
> on syscall entry, which should be pretty inexpensive, it seems like it
> would be very effective in protecting various ROP techniques.

I'm not a big fan, especially if that would only happen on syscall
entry; at the point where you have enough control to perform syscalls,
it probably isn't too difficult to move your ROP stack over to a
legitimate stack.
