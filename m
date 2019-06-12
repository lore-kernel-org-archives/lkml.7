Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD4FC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0662086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560305909;
	bh=hezTM3xs3yDOSwlePrC/DRIR4iSzDzXICogq1H8Zefc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s03ClXpMUCZQ07gt+bqGSRGBMExW1ocnnF/+Nk/WyIUe5rGLyc0wAIOWlWLcve+Yv
	 twtnmwQWftUoPDbsJTb55zwvf43R1bgw98VyYWhu/kjM6LV+l687vlrX9dvd0QihZe
	 JeEnqc9uAgU5CMhc3SRCob66buH4M5cypsl44SFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436484AbfFLCS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:18:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42594 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408343AbfFLCS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:18:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so13595414lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQ6UZZSMFwXSziql0q4Iq7xcEoj6RMO4R+oEBZibVKs=;
        b=ZkjB2SoYz4qRYdkSnfCZtZukuCJA92FA1EX5eS3hQG3BjIweRCWV3Ub7+a8w6JYlL6
         eCwSKtL75JuS4EjDkdwu5ZyRTBSeu0W7upyx7WgPm4QcLL4VuXvFrhpEAN0G9jDF7ScK
         buYMGMugpVr42AxnvK6GO4t+hUwkB3oVIf11s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQ6UZZSMFwXSziql0q4Iq7xcEoj6RMO4R+oEBZibVKs=;
        b=YxEdT7+bdt/WEaoO8l1AZUFK+MvVIYDxFHxwBnq+MPkO/e9xHWDUXllHfcw9HAyb8t
         wjOn3sascHyM3sEVuxLu8JT03P0SW/LxP1sl5wT+I0KTj6tPbg5WpBfgCDkON0aTZS4P
         dfeM2TqO8mazUyfOhsJEGR4uoc2M3pjs2VWu8WhUnD1cDp48JQiA8A+vFi0z+RMKW+y5
         YD7HyqzxCpRFh04K2YeRlqcY8pQ2hIKiA7sJGPDw+yFpOD1rri+o1Sp1u6vX4bniuXwF
         8a2gz58vz5CT3f7nRMSJWoxix8wqAaK55MAjkeAliUxMTvabcXQgeui5CoOZeKAGkdax
         SsTw==
X-Gm-Message-State: APjAAAUEHXg9YQ9wpq3Kn8Lp0B498YsZjhAE7Kqh5yYZkuY+yvcKwu58
        fXV+L4grVRtDyyuW4/pAa9daIX6UA/s=
X-Google-Smtp-Source: APXvYqxdowW9CDDmNWnyzz9pXdSHgnj2E1hL9C3JqANAtcL+RSKoKLCPm3SA2NZUDuuP9WaKmSuSsQ==
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr27084370ljj.185.1560305905454;
        Tue, 11 Jun 2019 19:18:25 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h22sm2911310ljk.86.2019.06.11.19.18.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:18:24 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id x25so9023951ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:18:24 -0700 (PDT)
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr747270ljj.205.1560305904002;
 Tue, 11 Jun 2019 19:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
In-Reply-To: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jun 2019 16:18:07 -1000
X-Gmail-Original-Message-ID: <CAHk-=wih2Ko+9CBRrdp36G7DPy4EDZKxZQ6q0CNyXRWsy5ujyA@mail.gmail.com>
Message-ID: <CAHk-=wih2Ko+9CBRrdp36G7DPy4EDZKxZQ6q0CNyXRWsy5ujyA@mail.gmail.com>
Subject: Re: [RFC PATCH] Add script to add/remove/rename/renumber syscalls and
 resolve conflicts
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 3:27 AM David Howells <dhowells@redhat.com> wrote:
>
> Add a script that simplifies the process of altering system call tables in
> the kernel sources.  It has five functions available:

Ugh, I hate it.

I'm sure the script is all kinds of clever and useful, but I really
think the solution is not this kind of helper script, but simply that
we should work at not having each architecture add new system calls
individually in the first place.

IOW, we should look at having just one unified table for new system
call numbers, and aim for the per-architecture ones to be for "legacy
numbering".

Maybe that won't happen, but in the _hope_ that it happens, I really
would prefer that people not work at making scripts for the current
nasty situation.

                 Linus
