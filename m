Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D8C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC552089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559924408;
	bh=xbgko6cdDWBOjT1jMNG96u3YTwm/fLHvGz6tg/uHQbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IczT2ec1vJg/FYClgadeI3j49OmCP9vLlbClqR74Tr1J80T+hFHGidXL8j0lO71ze
	 kXmNJKfmQ/fllPGR5h1NY8YbQrUMlZ81EL6qcRZedGLSLY1v7s6KUuJrMUCaqMTvhS
	 7mQXux6eqE1mhytQvW0+oHlmSiLhcFt1+SViJQGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfFGQUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:20:04 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:47013 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfFGQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:20:03 -0400
Received: by mail-lj1-f173.google.com with SMTP id m15so2227850ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sah1sze9qZQXC9dhxye7WQeDvgCv5Q6wpPURRp8bWQs=;
        b=GZp/BOH8X5Pg721SyiLtnieCJ/ZD2Ktw+FSJGwq590YKHcmVc4mKv9e4VgZjoepG+N
         L9grIrK4IatsF2cxfARKtaaDuUoOOYkIk1HZzSNsBgIVd6L0FrIRl1HF5p2lKnJv9IyM
         mXYfqUagFtpgySX1R/W0DkVdRgXr8y5qemuHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sah1sze9qZQXC9dhxye7WQeDvgCv5Q6wpPURRp8bWQs=;
        b=f/88a2EA4QBeQOmqXUv1SQijkGQzsKM7VDn02vFfJLKORgZdzOuz7tE69AEFtzmpyP
         JFxkdX1mTha4gDpGABAbciqkKhVt2BB1jGRvyGJA7SfPuq5VBnuzzbkAZEPAQQ5+7biZ
         biveTYxFEqp3s7OPP/93rUJNx3TmZFjYx6LlCNnpgdNU4lCgdWC0lpuTZRyIebZMgeu6
         nfaU+kyXL4kyfOOHm4L3jU5V1NdWaCDb9DOfSJ41qE+Kh3qfGXXjrIX0kdkeZdmsQQRm
         tRf13ebOJZ8X/qUfsSuQjpOhgVX6hv7VuEH8tHZ19fu5fV6WcmHKaoVezne/EMWrwkiv
         4kqg==
X-Gm-Message-State: APjAAAUIo9SkONQHq2mwqfOy3cJF4MsPp7jGj5leK5GpH5v7ouaDMHds
        xywzaC1Y6MDvWJxWevnCl07O0p0OEvw=
X-Google-Smtp-Source: APXvYqz8x/toTXpgkdtAerSapWe9y71n+HmIaR9PR7hrG2is45ZgwO/EZkn2lUAVuvS92IPZLy1+vg==
X-Received: by 2002:a2e:9c03:: with SMTP id s3mr13147824lji.209.1559924399645;
        Fri, 07 Jun 2019 09:19:59 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q1sm477157lfc.79.2019.06.07.09.19.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 09:19:58 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id y198so2079692lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:19:58 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr2437446lfb.134.1559924398137;
 Fri, 07 Jun 2019 09:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190603200301.GM28207@linux.ibm.com> <Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org>
 <CAHk-=wgGnCw==uY8radrB+Tg_CEmzOtwzyjfMkuh7JmqFh+jzQ@mail.gmail.com>
 <20190607140949.tzwyprrhmqdx33iu@gondor.apana.org.au> <da5eedfe-92f9-6c50-b9e7-68886047dd25@gmail.com>
In-Reply-To: <da5eedfe-92f9-6c50-b9e7-68886047dd25@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 09:19:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtY1hNQX9TM=4ono-UJ-hsoFA0OT36ixFWBG2eeO011w@mail.gmail.com>
Message-ID: <CAHk-=wgtY1hNQX9TM=4ono-UJ-hsoFA0OT36ixFWBG2eeO011w@mail.gmail.com>
Subject: Re: inet: frags: Turn fqdir->dead into an int for old Alphas
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
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

On Fri, Jun 7, 2019 at 8:26 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> There is common knowledge among us programmers that bit fields
> (or bool) sharing a common 'word' need to be protected
> with a common lock.
>
> Converting all bit fields to plain int/long would be quite a waste of memory.

Yeah, and we really don't care about alpha. So 'char' should be safe.

No compiler actually turns a 'bool' in a struct into a bitfield,
afaik, because you're still supposed to be able to take the address of
a boolean.

But on the whole, I do not believe that we should ever use 'bool' in
structures anyway, because it's such a badly defined type. I think
it's 'char' in practice on just about all architectures, but there
really were traditional use cases where 'bool' was int.

But:

 - we shouldn't turn them into 'int' anyway - alpha is dead, and no
sane architecture will make the same mistake anyway. People learnt.

 - we might want to make sure 'bool' really is 'char' in practice, to
double-check that fthe compiler doesn't do anything stupid.

 - bitfields obviously do need locks. 'char' does not.

If there's somebody who really notices the alpha issue in PRACTICE, we
can then bother to fix it. But there is approximately one user, and
it's not a heavy-duty one.

                   Linus
