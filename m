Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6EC218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XymbbZ9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfC3Qhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:37:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33640 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfC3Qhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:37:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id q3so4626353edg.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lAlaBvZln3OcH8jWEtLWTfLVSLJFabZ2pEmyETLvNgY=;
        b=XymbbZ9aoBF582S/LUqJzGPgzyYz7pEwzE20We6kOZ0cgO4myilhavLpjB0L9qBm+T
         2c+50oEl+uVhKymm+JMTIllfLG8sWc+B32pDLvEcpSmilV+qqoJ/VOHE82EOljlF8Fqt
         0+CNB6WwKQ5m0yoso4X2ppQm2wryLy9QsAEIDyFSJ9A7gjx37z86pc3LTuKwuTrNt4Bf
         VLqQpuFClkZlJpqFG06Oq4m1SOJDcs7WhJh34FxICm9IFAF/Mkz7zjwvwf+bTwqaJtHr
         VkuLFJaLc4zIDH0YNM/UeNxhkUOQ2CHfqkW1yZUreqGy0Ac+j7FgpnF+7OJI2gAKdy/b
         x0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lAlaBvZln3OcH8jWEtLWTfLVSLJFabZ2pEmyETLvNgY=;
        b=KNubk1B3BSeqYpH090FCW81OSlYajc1pITLfOMzLcsupPYmnsvSexMeBVOzEuk0JhE
         seVkKs1HMPuoVBZl0pSpjzgu4TL1/kGm7l2Mh17sUDhBpO4jrfZsXsIE2kB2swhuxJV1
         Jo8ahereIoLFhtF1fwLU/bggTCPlofKIOKXlYgoMlzVVqqNrUQ+gE9M0gmONvCbLYOKR
         dbLllDIa7Tf7tR+J4BZwG5rIC5+s2kb1W2ONP1WBYCHJCEcTgAybTvFdaZXJOs9ksG+G
         sIDelPAFuM6XM4nJvPg7JGiDBqADZfA7nE4ibh5GoTWNCHuLgMjLt6/PKpNO9FLbB/jv
         EX6A==
X-Gm-Message-State: APjAAAXcA67LB2hEZibj8RzxbfsO4ePugtW0MNNIVRDhoPdgMMfG+ZF5
        3yTRE+BETTW9Ic9GydATjQa61A==
X-Google-Smtp-Source: APXvYqzYqB3nRE4UGZZ6gVBV5A6Y4ZoQZ8H+EWV0nJMeBfAhns7o0+2KJPvFZEUeTjQgBEzYlSvCXQ==
X-Received: by 2002:a17:906:3619:: with SMTP id q25mr10178252ejb.239.1553963873096;
        Sat, 30 Mar 2019 09:37:53 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id p35sm1627192edc.78.2019.03.30.09.37.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 30 Mar 2019 09:37:52 -0700 (PDT)
Date:   Sat, 30 Mar 2019 17:37:51 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190330163750.xrrqmcyfd2mchamf@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 09:24:23AM -0700, Linus Torvalds wrote:
> On Sat, Mar 30, 2019 at 9:19 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > From pure API perspective that's all I care about: independence of procfs.
> > Once we have pidfd_open() we can cleanly signal threads etc.
> 
> But "independence from procfs" means that you damn well don't then do
> "oh, now I have a pidfd, I want to turn it into a /proc fd and then
> munge around there".
> 
> So I'm literally saying that it had better really *be* independent
> from /proc. It is the standalone version, but it's most definitely
> also the version that doesn't then give you secret access to /proc.
> 
> And it weorries me a lot that people are trying to play these kinds of
> games. I'm just seeing some android patch that adds this horror and
> then starts using it.

The original need for this conversion thing came from Android indeed. I
won't go forward with any such patches. 

Christian
