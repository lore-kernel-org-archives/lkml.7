Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7C8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2A6208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWMQzCqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfIMX0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:26:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33710 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:26:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id p13so992653vso.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuqlVIgEPj4t6xwCAnrh40E0/Lhnf5UdZRgHKliR78E=;
        b=TWMQzCqG86u/8Hd28PnVMaFkD8Vi7hNvYq3WNU0xwCh0yXl5lxLQoo+DbaE9pAKpyD
         Y6a6IjJkdEum2GDoilsVr36YRga/bb3L+Zz/7OgXYkO7keuc2EvBDEtdKx73XGd6w/K2
         CvuvXcHam4MVf5FUAZjumSeNv+s+tZp/bmlSRsx0QhFvtsUtnhyZiMJ9t7KYMXoJhz5b
         ck9PvONmzY+mcSuHM59SD5UJ9VZEj0dXWTPjxKdA+dmo4lvHQSJSQ0VlemCppPM1+FCS
         WjG2KsUWhbNKsVXAB5+X90532MBnhlc/JVVyLyQdpGl1bcWxkvtO7Svd/tlSojydmioQ
         9XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuqlVIgEPj4t6xwCAnrh40E0/Lhnf5UdZRgHKliR78E=;
        b=P2ZXxLunWU1abUf1McRGdFqvtBcRt1Tb1fWfM3x4gc/wQQEDHnt5ko2sKiS0BwY4pc
         dGUM+QNtwJdlNsg1sx19U60rWj55+92jzftcALsgtqSnWbltW1MD7ymqkzSaVUcIXWVG
         coIpMB3X97BKkhb6DeIauuQmtIEHt/V6PvUk/wkt4cYp7TdNhZmVFJEaosQzBn+aDOJT
         hBsau/2+ZpcFEyzQLv4G+fL7tcbk1Gt5rcw7AXxemadW4CKmjOQDvz2FaVo8Z8DC9GlQ
         +rzKUbKDvStsE91selJdT4CmAKIHbEG58xb9fH8O+Y7jU4Lf+q7Uwo6lDcMIFegYyv2G
         3esw==
X-Gm-Message-State: APjAAAW7j+VsF1tykO91bwdBKSPVuKjTMrr98FWtYydo6K41uqW955Lr
        a7N6Qto24iP1C/DitF8utWl1MUtuW9PTeixcfvAFvQ==
X-Google-Smtp-Source: APXvYqwycvdDYlTOOriF3z+vtDCUG8wP3ergny5/K5LW+3foMmRsvA7tb66lrgScvQMLqp3kDEI+TebwYJLkSkhsPks=
X-Received: by 2002:a67:2606:: with SMTP id m6mr6026464vsm.5.1568417208929;
 Fri, 13 Sep 2019 16:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
 <20190913210018.125266-4-samitolvanen@google.com> <CALCETrWquNJJ6yXdHA_F3h71hVrFjnpwmdH2NmGZyFu-V6Lnfg@mail.gmail.com>
In-Reply-To: <CALCETrWquNJJ6yXdHA_F3h71hVrFjnpwmdH2NmGZyFu-V6Lnfg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 13 Sep 2019 16:26:37 -0700
Message-ID: <CABCJKud9ikdsfy9-bugbqKb-C7VXEEPJ_P1bO5KpGqv62Wuc7Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86: use the correct function type for sys_ni_syscall
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 3:45 PM Andy Lutomirski <luto@kernel.org> wrote:
> Should this be SYSCALL_DEFINE0?

It can be, and that would also fix the issue. However, it does result
in unnecessary error injection to be hooked up here, which is why
arm64 preferred to avoid the macro when I fixed it there. S390 uses
SYSCALL_DEFINE0 for this though and since sys_ni_syscall always
returns -ENOSYS, it shouldn't be a huge problem. Thoughts?

Sami
