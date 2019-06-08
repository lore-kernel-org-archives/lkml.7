Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B4C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB37208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560015783;
	bh=y+B0u27j0X/o4vIT/ZcDEUGy0RcuM0bgsnHnhiLpSMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lHKycpVI5DRr4+QhYxJCUmcG8ErNmd9+nQ+F/WkTxZVCNzL7w9ojmYKSbQVL9Yii3
	 Dzt0U184piDNT3QagOoZBSJ9aZickKZ2UCMhk9KE95eKEdowz07zptnQ9a0zaPVTZj
	 G6e5+BQ8DUBExyILcM4dOEJaV2QU/jjt8wuenVZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfFHRnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 13:43:02 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:37093 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfFHRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 13:43:02 -0400
Received: by mail-lf1-f51.google.com with SMTP id m15so3903937lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4wuZBASsrfrcVNwlwV9UqOEN6oWZwE6ONOc/qGw3VI=;
        b=Uu1B6CJ0y6i8Y4/pgQnaoS95gdTJiRuJ++PTvjfS1VHjeY7KoMbrI03rgRi88d8bO9
         gy6t9EHCiUmVjonW+cF34EBKqdCBxo0aHHhXx3ME8R4QFi0/niyGdSTdm1gMEAHSJKuE
         l0ftlnvh3k0TseM0yzFVUQwYJmRTVuUAqpwgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4wuZBASsrfrcVNwlwV9UqOEN6oWZwE6ONOc/qGw3VI=;
        b=nuRJxQBHr1GhwVGhI1s/VUqQ6VSaHlIUWhlhWyEU6ibcrVRj8ePIQJz68iDkZANQKz
         S2lfhvvjuDJ/r6K07a0jpNhtjDy6MqTmfWwr5NSEEvW5+KE0yX/JdNpD47CWCySUXLTb
         hUbQ/BPBiTn/LdxWu15fJh2VKfsvnYqtTbhdZBe/bSe9jXdphYcSwfTzNkgVg5wB0g0j
         F2kSbonfZ7re7QYyo6uqiDBMEl9tv/BpqvjPuy12xOcHWfiRBJLmnVVRds8pdUKQyU0j
         XVg6RHqTY3RqE3l/fbkjMD0vtnnoCtRB95JAOm5thK57uy2BO7tZPvzKyDZYcaQH5q3R
         D1Qg==
X-Gm-Message-State: APjAAAXH0lXnuoLUbpCQPG3plGNoEHYEEzpDzc3WR1zvUrc14EGTOZ4a
        hlHTu1YihbBTdO4EmnfRL5zlOGh4XRw=
X-Google-Smtp-Source: APXvYqybuCgWOTJ4UJuOH+/0A9L71xUjtDqQTYvqnBq7uQs76J79huSftKTUSSTy0y0k9VL0hLqexA==
X-Received: by 2002:a05:6512:64:: with SMTP id i4mr7072052lfo.32.1560015780008;
        Sat, 08 Jun 2019 10:43:00 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2sm49827lju.52.2019.06.08.10.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 10:42:58 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id z15so1208122lfh.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 10:42:58 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr29635980lfn.52.1560015777829;
 Sat, 08 Jun 2019 10:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190603200301.GM28207@linux.ibm.com> <Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org>
 <CAHk-=wgGnCw==uY8radrB+Tg_CEmzOtwzyjfMkuh7JmqFh+jzQ@mail.gmail.com>
 <20190607140949.tzwyprrhmqdx33iu@gondor.apana.org.au> <da5eedfe-92f9-6c50-b9e7-68886047dd25@gmail.com>
 <CAHk-=wgtY1hNQX9TM=4ono-UJ-hsoFA0OT36ixFWBG2eeO011w@mail.gmail.com> <20190608152707.GF28207@linux.ibm.com>
In-Reply-To: <20190608152707.GF28207@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jun 2019 10:42:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1G9nXMzAu=Ldbd4_bbzVtWgNORDKMD4bKTO6dRrMPmQ@mail.gmail.com>
Message-ID: <CAHk-=wj1G9nXMzAu=Ldbd4_bbzVtWgNORDKMD4bKTO6dRrMPmQ@mail.gmail.com>
Subject: Re: inet: frags: Turn fqdir->dead into an int for old Alphas
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 8, 2019 at 8:32 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Fri, Jun 07, 2019 at 09:19:42AM -0700, Linus Torvalds wrote:
> >
> >  - bitfields obviously do need locks. 'char' does not.
> >
> > If there's somebody who really notices the alpha issue in PRACTICE, we
> > can then bother to fix it. But there is approximately one user, and
> > it's not a heavy-duty one.
>
> C11 and later compilers are supposed to use read-modify-write atomic
> operations in this sort of situation anyway because they are not supposed
> to introduce data races.

I don't think that's possible on any common architecture. The
bitfields themselves will need locking, to serialize writes of
different fields against each other.

There are no atomic rmw sequences that have reasonable performance for
the bitfield updates themselves.

The fields *around* the bitfields had better be safe, but that's
something we already depend on, and which falls under the heading of
"we don't accept garbage compilers".

              Linus
