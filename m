Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45781C28EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1802020840
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj8WbwXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfFJCXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 22:23:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46333 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfFJCXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 22:23:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so8901475qtn.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zBkMGLED9l3FmX17OsaydHaK4tKEhb0w4jXMZi0ccg=;
        b=Zj8WbwXAV390RUM8igQnwN61lwTTn/QbFvp7GcZyBuJTSfCO9v8ItH0DUz5AJwZKsL
         yjsuCAo5jnkIuAgHavR0/2yY+KjqQFuhtBlgScpFJIGNHxNuOfFQzvysVmLkKjN8l8kc
         E2U0AJGuEI/Hh15D86vvyGuVN5avU22QMBAZzMnkvdX/ft3/mmqouRkdh6z8j6W+zYJX
         T0EWFI1oel+e2/ez/t+bhwWIR4bTVslecnKGaJ4/XMKs7na+Rr0QGCfBh0RPG+Jdew7J
         uzi52nr3Fcmn66ktZ4fin9On0w8vICKx6gtvErIui78HM40zjdNKhIGHKArloFA9MWld
         AT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zBkMGLED9l3FmX17OsaydHaK4tKEhb0w4jXMZi0ccg=;
        b=dWJKAorwOLUkU/Sjz9xb7UHiIweIfKE2rRYjvd+0NIqoWzwilmMw2pHktDVisLzkrA
         /FDgZe+BYBBtqKISET1ngKEYQUx91Toe8sSV+3CdN9V6asuwU5Qv/TpMEkVgarGoqXlk
         6nr47z6hI+/fFf8XfaXX14bi9rmJ9Yw6UejsCXZelbf0EPwx8FDZN58++KE14NN2gdJ7
         Kpc9Fl8ifEVEjn1XrYIsFBf5SMzFdZ0YRFGV3EI5nq7Z5l0gipzdu+CGu8J298rtj8Ba
         tY1myP7xoLuh78zELT1k+j2PQop2yJpHfdadgIja8tnUCgFGu4XIPaqQJObBo0cmY6gs
         gPnw==
X-Gm-Message-State: APjAAAXnartV7jiEegrwjvcsG9av6Te5C3sAmCaaNb7X/FPGx4l/EHwD
        tJx7YIz2AgLNogHW+RX2oxaTPRGXEKYRWjTAjnO+FEkG940=
X-Google-Smtp-Source: APXvYqzBnLgtfH/jTIbc9mlUXwmH0geVF9fRd/xlU6Yr9cEj5fr+msC3D6w//Icba3eeagHGlzEfVC5sFpKCinCZowk=
X-Received: by 2002:a0c:a8d1:: with SMTP id h17mr24478187qvc.117.1560133409793;
 Sun, 09 Jun 2019 19:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <1559855690.6132.50.camel@lca.pw> <CAHttsrYCD1xvL6hf6dXZ_6rB2pEra0HDZ+m5n8EMQr3+5AShnQ@mail.gmail.com>
 <1559916886.6132.52.camel@lca.pw>
In-Reply-To: <1559916886.6132.52.camel@lca.pw>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Mon, 10 Jun 2019 10:23:18 +0800
Message-ID: <CAHttsrZN09-_GXujv2H5gAORLHcO2onrotFND5GrDXRGRtFpJQ@mail.gmail.com>
Subject: Re: "locking/lockdep: Consolidate lock usage bit initialization" is buggy
To:     Qian Cai <cai@lca.pw>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the further validation.

On Fri, 7 Jun 2019 at 22:14, Qian Cai <cai@lca.pw> wrote:
> Reverted the commit on the top of linux-next fixed the issue.
>
> With the commit (triggering the warning
> DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)),
>
> # cat /proc/lockdep_stats
> lock-classes:                         1110 [max: 8192]
> stack-trace entries:                     0 [max: 524288]
> combined max dependencies:               1
> uncategorized locks:                     0
> unused locks:                         1110
> max locking depth:                      14
> debug_locks:                             0
>
> Without the commit (no warning),
>
> # cat /proc/lockdep_stats
> lock-classes:                         1110 [max: 8192]
> stack-trace entries:                  9932 [max: 524288]
> combined max dependencies:               1
> uncategorized locks:                  1113
> unused locks:                            0
> max locking depth:                      14
> debug_locks:                             1

Then it is obviously we are talking on different things; then it is
obviously a configuration problem. Fix will be posted soon.

Sorry the bug.

Thanks,
Yuyang
