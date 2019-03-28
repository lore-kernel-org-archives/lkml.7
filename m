Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0843C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23620823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="x21E6PQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfC1Q7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:59:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45100 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfC1Q7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:59:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so23882804qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=4UMhVq3UP9f9k0FZzPmJtmU8g8TAD99GZw+T8fR4nqw=;
        b=x21E6PQqkaknXgbB/lgdXRYZK0p1M1vGoLDbjTP6ntjQOGQepKOTCoBBvrBCbvMWPP
         K5xz2aRvUP6X4HCBRZ7o6WqZ+I4gzC6h1HAlk172EC3wN6krgtA/8aVLxOrtMzZddXnU
         Pj0NBgcc+LLPM5OX+5F5wNL0/AXtepZOODGGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=4UMhVq3UP9f9k0FZzPmJtmU8g8TAD99GZw+T8fR4nqw=;
        b=WKzhjWAXNgs52X2TUrL4Dj66vw5xtQFxzBpfe8RCdPXWriQECozSqEyX1Eq/y81dp1
         IwXIthlWoIq8xCbL93WccI1TW8JR3QI2/2b7YuYiL4jvZkliyodFVyg8DJMRUoPOb5Jx
         oQXZW59L95vgg2zdsgKBWJTUyZLGOAtME9DOdDVsOICxNLc/qVWetOXkDp8+q/FWezS7
         a1aUVuAko9wF9y6x2NHccd7BPpbFwpVI3J8ZnzYv/JGmAVrIN8WapI7D3jw/NePLH4Pk
         uiG5tHbv5uq2ravgqVCNyWJFitGsU2NrpmPZ5/nktF3qEFNPbfb+xDmbidMs0LnsekIx
         Lx5w==
X-Gm-Message-State: APjAAAVmGjGCgTm/1LeZHnLGF3Ze6FqH3DwG6ickjnasf2F0t31FCUxZ
        edSULgmFJ5ER0CbKi2cD2CjzYg==
X-Google-Smtp-Source: APXvYqyn6MK3+dpDn+oyXMm79hHUk9IlaFqgUUZYOPKWE8OD+ofHmlIJc9Kf+tK2/tIBJK9NiqyBqA==
X-Received: by 2002:ac8:23ce:: with SMTP id r14mr13346008qtr.156.1553792391154;
        Thu, 28 Mar 2019 09:59:51 -0700 (PDT)
Received: from ?IPv6:2600:1003:b458:e69f:1dab:f161:4244:99fa? ([2600:1003:b458:e69f:1dab:f161:4244:99fa])
        by smtp.gmail.com with ESMTPSA id n70sm12263994qkn.5.2019.03.28.09.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:59:50 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:59:46 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20190328103813.eogszrqbitw3e7k7@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-3-christian@brauner.io> <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com> <20190327213404.pv4wqtkjbufkx36u@brauner.io> <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com> <20190327222543.huugotqcew6jyytv@brauner.io> <CAGLj2rG0Sbho6MnPSmcS73Xj=oG92E4W_QLRu4dD8NfweoUm5Q@mail.gmail.com> <20190328103813.eogszrqbitw3e7k7@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>
CC:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Colascione <dancol@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Message-ID: <533075A9-A6CF-4549-AFC8-B90505B198FD@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 28, 2019 6:38:15 AM EDT, Christian Brauner <christian@brauner=2Ei=
o> wrote:
>> All that said, thanks for the work on this once again=2E My intention
>is
>> just that we don't end up with an API that could have been done
>better
>> and be cleaner to use for potential users in the coming years=2E
>
>Thanks for your input on all of this=2E I still don't find multiplexers
>in
>the style of seccomp()/fsconfig()/keyctl() to be a problem since they
>deal with a specific task=2E They are very much different from ioctl()s
>in
>that regard=2E But since Joel, you, and Daniel found the pidctl()
>approach
>not very nice I dropped it=2E The interface needs to be satisfactory for
>all of us especially since Android and other system managers will be
>the
>main consumers=2E
>So let's split this into pidfd_open(pid_t pid, unsigned int flags)
>which
>allows to cleanly get pidfds independent procfs and do the translation
>to procpidfds in an ioctl() as we've discussed in prior threads=2E This
>should also accommodate comments and ideas from Andy and Jann=2E
>I'm coding this up now=2E

This sounds quite sensible to me=2E Thanks!


Joel Fernandes, Android kernel team
Sent from k9-mail on Android
