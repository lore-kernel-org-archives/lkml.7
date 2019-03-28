Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4F221773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZkCKdfEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1KiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:38:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40552 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1KiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:38:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so16739879edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wPs/ROg3NojSX8Iex5vQIqGN91Jge8rJf2vXW7hGp3I=;
        b=ZkCKdfEZ/kmy4ie/chVWkFJoTOejSH7ngJ/U3AI6yPlQpac/2q2gNXdGBmJ4pJuxty
         xwIkneUYQ79b98wY5ouD7kLobHHZ1DAzJBPLZ7T3/4olM1I79zJM8xwJAg872pOIdffw
         2dJltMlmnAgqkCb2bstd9RMS8dWWC0bo7QckuCY+BAbpITgxACPuH7Bino7+LgEvzjMo
         GeMbUFrE2LtfWCethYAiQ27niEOeqIBfoopRxMxBUJlyUs3ZGx/UVBEeI4v9/2v1GFe8
         EMwNDgjtC2Yn557s8lLbsk1Dzb2WdlBpWSgTbLObkWwfgVFkX8OsgfoCjMNGDDb/YJyR
         5k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wPs/ROg3NojSX8Iex5vQIqGN91Jge8rJf2vXW7hGp3I=;
        b=gxmV0SbvaLQ8bvOGQkeQsq1ZwoR0X1zfxWBj+/afzeU42yq4sv5OysmDWjwoy8rlEQ
         M0h9arumYW7Wxs1hBBDHv4hzeHgeZOyhkAI9QpZTlPuDz05gXUg9x4MHHtTcrLa+qtmL
         bTGtj+RsW4GyL/vEx3iybwqnWPhJoRC15BZ3B6xQbMR0NwoA54yd5iiJYoH86e/AXYGZ
         Ad9hEYBSL5dZS5/8zcGy+xmedtsF5osA3IMno8zr/wr23WFPvTGGxdPW7ct9ehKvXSLz
         6frxIFrTqWZixvjidHjUbj49QlFRmCKAPyFqeQQKqnkFRDqrpnTGWkDBh3dlDaBy48Nm
         UyLQ==
X-Gm-Message-State: APjAAAVNYdaQ1tliAoy1qxB1mORl6hgJUGXkbBmfdm7GgMxK0a4e4Qw0
        N7ntIax9+A57vu8hi9Aujg1MTw==
X-Google-Smtp-Source: APXvYqwqAv+niijeJOOsI2NoS2ya3p3iAeIMCFDqZQwRdQDRazjJhn9WbJNkK9DCxz3xsjCBVqYIbw==
X-Received: by 2002:a50:eac8:: with SMTP id u8mr9421404edp.125.1553769498202;
        Thu, 28 Mar 2019 03:38:18 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id w25sm407050eds.39.2019.03.28.03.38.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 03:38:17 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:38:15 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
Message-ID: <20190328103813.eogszrqbitw3e7k7@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io>
 <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
 <20190327213404.pv4wqtkjbufkx36u@brauner.io>
 <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com>
 <20190327222543.huugotqcew6jyytv@brauner.io>
 <CAGLj2rG0Sbho6MnPSmcS73Xj=oG92E4W_QLRu4dD8NfweoUm5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGLj2rG0Sbho6MnPSmcS73Xj=oG92E4W_QLRu4dD8NfweoUm5Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> All that said, thanks for the work on this once again. My intention is
> just that we don't end up with an API that could have been done better
> and be cleaner to use for potential users in the coming years.

Thanks for your input on all of this. I still don't find multiplexers in
the style of seccomp()/fsconfig()/keyctl() to be a problem since they
deal with a specific task. They are very much different from ioctl()s in
that regard. But since Joel, you, and Daniel found the pidctl() approach
not very nice I dropped it. The interface needs to be satisfactory for
all of us especially since Android and other system managers will be the
main consumers.
So let's split this into pidfd_open(pid_t pid, unsigned int flags) which
allows to cleanly get pidfds independent procfs and do the translation
to procpidfds in an ioctl() as we've discussed in prior threads. This
should also accommodate comments and ideas from Andy and Jann.
I'm coding this up now.

Christian
