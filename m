Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22883C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32EF2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Po6sn+Uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfC1RHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:07:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42071 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1RHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:07:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id x61so12212185edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xo5m4lzWljKFa45FWhqQys+N1R7vTTwn+vwGeAbfBus=;
        b=Po6sn+Uw832pyRVp4TvXPg/SODeW16fvejyM7SGXFwIhkaQOSJcy+I0Hugn26Oq1B+
         bR3r8kdJSv/6w3JqxhWAcy+lQzYjpQFS7uSUSgGyb5CVdpNGUK5L7XUscwDlHgklwgtS
         6vYqrpHBTvSCIgqTrbVftQs4nxvKZVHXHfga2wfBtEkyWM+HlCc+92xH1K322ePgnbab
         iSGQAYWSpMqXNitwqZz7euC89QjgFMyy27C0Dco2+mGEmS5euk/F3UfcuOUVllwJxzox
         whdE7eh4uzmjWXaK8iLTYXXXyPcVln7hPPYCBWd8oxf2s8b97qPWq19wtgORwNojoMeT
         poLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xo5m4lzWljKFa45FWhqQys+N1R7vTTwn+vwGeAbfBus=;
        b=oOWcIgrLxV81uDHemjNw73Lz0qCyIMCb82W504z9ioi28tbfoD9g+Yhce0m72D7Ihh
         l+40kOsQH54244S5D1v1TIhfw3jQk8CbK5eII5MfSwUFF6TErL978HeNa5jt0kL1EjDf
         5qWPmaNR5zbUklnnactP4t51YwLvGdeZaV7aAzcsg4UoRpMTVapSsLW8sCi7HVeh2x7H
         TPAfKzKlnzPT8SW4XlOfttM9ntQ8EYrajZrPyFIevzmnYVxbhxBGPDRZIk91KrqxP15r
         RiZncjuDifjPvCGiq4mYYCw+Ku9R7riFJRLamLcpIvCY6YoexJuNZarew5fFqSAhTdfm
         fIUw==
X-Gm-Message-State: APjAAAWA5V/sCmqrHussUCScfCh/LZ/sy8G4cRi/6n35ilRX9Eth1Cdj
        hi5vOJ5UP4u3May+x+zVzNoKEw==
X-Google-Smtp-Source: APXvYqwVD9W/R5exyx1tGi+FWlVOWCpmq4uWogiqZ/+TscEY5UkCFq2mWhpI2VhXiNDCpmtIa10F1A==
X-Received: by 2002:aa7:c891:: with SMTP id p17mr13103876eds.183.1553792823150;
        Thu, 28 Mar 2019 10:07:03 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id a28sm1341486edm.91.2019.03.28.10.07.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 10:07:02 -0700 (PDT)
Date:   Thu, 28 Mar 2019 18:07:01 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Jann Horn <jannh@google.com>,
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
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
Message-ID: <20190328170700.hx5ywsij77wawmon@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io>
 <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
 <20190327213404.pv4wqtkjbufkx36u@brauner.io>
 <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com>
 <20190327222543.huugotqcew6jyytv@brauner.io>
 <CAGLj2rG0Sbho6MnPSmcS73Xj=oG92E4W_QLRu4dD8NfweoUm5Q@mail.gmail.com>
 <20190328103813.eogszrqbitw3e7k7@brauner.io>
 <533075A9-A6CF-4549-AFC8-B90505B198FD@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <533075A9-A6CF-4549-AFC8-B90505B198FD@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:59:46PM -0400, Joel Fernandes wrote:
> 
> 
> On March 28, 2019 6:38:15 AM EDT, Christian Brauner <christian@brauner.io> wrote:
> >> All that said, thanks for the work on this once again. My intention
> >is
> >> just that we don't end up with an API that could have been done
> >better
> >> and be cleaner to use for potential users in the coming years.
> >
> >Thanks for your input on all of this. I still don't find multiplexers
> >in
> >the style of seccomp()/fsconfig()/keyctl() to be a problem since they
> >deal with a specific task. They are very much different from ioctl()s
> >in
> >that regard. But since Joel, you, and Daniel found the pidctl()
> >approach
> >not very nice I dropped it. The interface needs to be satisfactory for
> >all of us especially since Android and other system managers will be
> >the
> >main consumers.
> >So let's split this into pidfd_open(pid_t pid, unsigned int flags)
> >which
> >allows to cleanly get pidfds independent procfs and do the translation
> >to procpidfds in an ioctl() as we've discussed in prior threads. This
> >should also accommodate comments and ideas from Andy and Jann.
> >I'm coding this up now.
> 
> This sounds quite sensible to me. Thanks!

Thanks! I have it ready and hope to send it out later today.

Christian
