Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9717C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFDF2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxEmBkk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfLIRnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:43:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40398 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:43:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so17174764wrn.7;
        Mon, 09 Dec 2019 09:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=C8TlBCTzJ8R9+7Ovu0+GB3ZN7MCWzPCKO24ypqK2F+o=;
        b=hxEmBkk+s9/itP46V5s5Vsrmn8iFeT423bz+J7vHgj3Y1bM8kITeaSp86kKAGiKXKm
         /L9W004c2j3F/r6CtdpkEbIHWuHysyrh69njhty/rJwUMXRvBe3JqqawlPasDZKC+twL
         OF3NpwothaqPm8A8mWrKJeghy0kOtowTHHCMixhPDrK6msz7v7qnGSuyY9QTCO+XJoOi
         5A4CqeIzAg/GXntYrkJZVL37ybSWIVvV23hbGt5LKKuaRjJIUarWcLbnyDHe0yCh3eeK
         35pI7ph2Mws1clV/X7h3st4UCIH8QbiZZM5bSHKxVm9YBA9iCuIuYjw22fk3zFn9KWpw
         BQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=C8TlBCTzJ8R9+7Ovu0+GB3ZN7MCWzPCKO24ypqK2F+o=;
        b=hw3FrQRph8xyCcVxzzRRds66OotAkMe6/SP5OZWxjIaStoWoVomjcGQUlPPxkKhkB8
         PBMGeGGMO1Dre3Q3nNFoUNsDayb6gDB310tm6Tb5FSoGhRifs3Etw4fxfi0Al9FazuYv
         4YIhOGhJqgNDABeJhF199J6eWOuz88oNXngfbbiz38Sg3fzcCusCaceDIwM9GrLGGKtP
         s35B713+3MX2/3dNXwsApigSuTZmKuZKqvHSO5/yoxujpnwLNHJIHbRB+5dqFmFAR+C9
         dMiRFfZLLRQ5chwCbo6bMikUCr18dTCScqfsuAvm32agZITEJ55g7VupV7Aj/15HkB9h
         0ZiA==
X-Gm-Message-State: APjAAAXsuLrgrCxVlkDdenV1BVbgdsmX9VzgtxjFjyI61+K8dCYR8gRp
        gF1TAFj7802gyVh0GqB5YnLIG76t
X-Google-Smtp-Source: APXvYqywc4NaCEnKSHeJEcYzeJORT8xHbqw2hIUsAZOUQHsgSE7SPMkwx+tbW2RS5rrl1XKCw8zukQ==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr3364307wrm.107.1575913397943;
        Mon, 09 Dec 2019 09:43:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id y20sm72147wmi.25.2019.12.09.09.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 09:43:16 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     will@kernel.org
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>, notify@kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [PATCH v2] Documentation/barriers/kokr: Remove references to [smp_]read_barrier_depends()
Date:   Mon,  9 Dec 2019 18:43:07 +0100
Message-Id: <20191209174307.23698-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191209170633.GC7489@willie-the-truck> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 17:06:34 +0000 Will Deacon <will@kernel.org> wrote:

>On Mon, Dec 09, 2019 at 09:00:57AM -0800, Paul E. McKenney wrote:
>> On Mon, Dec 09, 2019 at 09:44:33AM +0000, Will Deacon wrote:
>> > On Fri, Dec 06, 2019 at 02:51:56PM -0800, Paul E. McKenney wrote:
>> > > On Fri, Dec 06, 2019 at 11:38:22PM +0100, SeongJae Park wrote:
>> > > > On Fri, Dec 6, 2019 at 11:08 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> > > > > But since Jon seems to be taking these in his capacity and Documentation
>> > > > > maintainer, could you please resend CCing him?  If we have these changes
>> > > > > scattered across too many trees, someone is going to get confused,
>> > > > > and it probably will be me.  ;-)
>> > > >
>> > > > Agreed, CC-ing Jon to this mail.  That said, this is a followup of Will's
>> > > > patch[1] and the patch is also not queued in Jon's tree.  So, I would like to
>> > > > hear Will's opinion either, if possible.
>> > > >
>> > > > [1]  https://lore.kernel.org/lkml/20191108170120.22331-10-will@kernel.org/
>> > >
>> > > Ah, this one got caught out in the conversion from .html to .rst.
>> > >
>> > > I did get an ack on one of those, and thus queued it.  I clearly need to
>> > > take another look at Will's series, and thank you for the reminder!
>> >
>> > I was planning to include this in the next posting of my series, but I was
>> > waiting for the merge window to close first. Now that we have -rc1, I'll
>> > post it this week, although the patches are also queued up in my tree here
>> > [1] (warning -- rebasing development branch).
>> >
>> > I'll leave the patches that are unrelated to smp_read_barrier_depends() to
>> > Paul and Jon, unless they indicate a preference to the contrary.
>>
>> I don't know about Jon, but I might need a reminder as to which patches
>> those are.  ;-)
>
>https://lore.kernel.org/lkml/20191121234125.28032-1-sj38.park@gmail.com
>
>...but it actually looks like Jon picked those all up, so I think we're good.
>
>SeongJae -- please shout if we've missed something (the link above, plus
>this patch).

Sorry for making things too complicated.  So, below is the timeline:

2019-11-08
----------

Will posted a patchset containing a patch removing references to
[smp_]read_barrier_depends() from memory-barriers.txt.
https://lore.kernel.org/lkml/20191108170120.22331-1-will@kernel.org/

2019-11-21
----------

I posted a translation of the patch (patchset 1):
https://lore.kernel.org/lkml/20191121193209.15687-1-sj38.park@gmail.com/

2019-11-22
----------

I posted another patchset for the Korean translations (patchset 2):
https://lore.kernel.org/linux-doc/20191121234125.28032-1-sj38.park@gmail.com/

2019-11-26
----------

Paul queued the `patchset 1` and `patchset 2`.  He also asked me to
get a review from other Korean, if possible:
https://lore.kernel.org/lkml/20191126222004.GV2889@paulmck-ThinkPad-P72/

Same day, Jon queued the `patchset 2` (not `patchset 1`) and noticed the
conflict.  Paul dropped both `patchset 1` and `patchset 2` from his tree.
Maybe this is the start of the confusion.

2019-11-29
----------

I got a review results from another Korean for both patchset 1 and patchset 2.
Because patchset 1 has already merged in Linus's tree, I made another patchset
containing fix of the patchset 1 (patchset 1-1):
https://lore.kernel.org/linux-doc/20191129182823.8710-1-sjpark@amazon.de/

Because patchset 2 is not merged in any tree, I made and posted the second
version of the patchset 2 (patchset 2-1):
https://lore.kernel.org/lkml/20191129180837.7233-1-sjpark@amazon.de/


So, patchset 1 is already merged by Jon, and patchset 2 is abandoned.
Patchset 1-1 is waiting for Jon's review, and patchset 2-1 is merged in Will's
tree.  Will would send the patchset 2-1 with his patches again in near future.

Sorry again for introducing messy confusion and hope this to finally make
things clear.  If you have any problem, please let me know.


>
>Will
