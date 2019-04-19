Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB747C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FCD2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555702834;
	bh=8Xy3BH3ok43lXOEKvUk1aG2nIA1L/IAKSkP24QwVglk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yfd5TMbSmIIsF9lGjWjt59oOErj5GII7BwNOwgzrReOF3M1QmfSbxdNKALAxJnkmI
	 Srsk9D+ZvJSkYTybFs99ji50Bs8+dCYET9iD6h089Tmu4YQGVOEp5nE5RyUZcynIiL
	 +6BIKb2BXI8tB52Yi2PKF1bOEfIzQYVP3AF23TwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfDSTkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:40:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54433 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfDSTkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:40:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so7186285wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yv8sNlmOUSUFFszUmODIIclw3NeRdjYoHffY8iKyf+U=;
        b=lrqj2wzyBnqrtlzH+j772n4tj2tHzVxSDkwQT0vT6HBfqqvk7v3n6Q5yn8SE5hZgtA
         52P+6gBug9COUaSLJ6Sc5Bm3POXGLdW6q8sCfBdzebBhkPsbpLp9SVFak0jAjfFrnr7E
         Vt25fIe1axrn4fh+HwkTe0dDNbwhfGGkruO9bodwVUdCJ+Ylx2pfT7rFeXp/Jg0AuHdz
         qhKOawW+psB6DR2dDa69PI7kzbKNjGwjwpUdSopYRbZ+tGulBskiYYrZAynEQUgg3I4V
         YEjHiI9ej2vDjdYaw99PTIcqZO6J8thYOJ7ZxIy3yqiKfT59ohAXjBDOx+/WQwvUyJu2
         pG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yv8sNlmOUSUFFszUmODIIclw3NeRdjYoHffY8iKyf+U=;
        b=WR4zbxKZp9MrKapz1Hu5pix6umTMyiqIiu0nbfVi+VX9qmEvYuqPvG5C+Y8t/ypjFh
         +2oZZiL9P4wHKZRPkzvvuQyinpawyXUFXXfwqJIYjKyX1NJd5dvgbq6otWrTeF01UenR
         v/DjIi/blr6KIM9a3y+WkaSB2PqXueBIkkl7TwxdaOksBWpHxs6AfwK4dZmt2OWFDV3u
         ep0zXl69kzqwYAdmCJBWGmq6TG91kcqbnWN2Mr8QvEqbTAfnlcIgxxFm7UUGnIbn8pQU
         k3pX0/g+Z6DtZqRyU0Np/eeReWRNQUfCopX148e6uVnSDrFMDzCZ9dGGKIMVeD8Sdelh
         GqqQ==
X-Gm-Message-State: APjAAAUosLCTjo4Kt22GvsXkoR4Z64Z+nC5kymFF/7piAdnExtgnbyXR
        u+GAAk2fn4+b71+7Jt1lnAylldwn
X-Google-Smtp-Source: APXvYqy5yqAAeEeMBIi5mAMQzUHmY0tyqDIo0+d+UJ8uUhcjnKR636iMGs3O1KMaC6B8qtHXwaH+LQ==
X-Received: by 2002:a1c:23cc:: with SMTP id j195mr1985837wmj.74.1555663904442;
        Fri, 19 Apr 2019 01:51:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 192sm5554039wme.13.2019.04.19.01.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 01:51:43 -0700 (PDT)
Date:   Fri, 19 Apr 2019 10:51:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Saidi, Ali" <alisaidi@amazon.com>
Cc:     Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in
 mmap_base
Message-ID: <20190419085140.GA50390@gmail.com>
References: <20190312173248.13490-1-alisaidi@amazon.com>
 <20190312173248.13490-3-alisaidi@amazon.com>
 <CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com>
 <CAGXu5jKcBmj0kwAqjqROXuOi=90=Upy8-J8WviGMjD6FV_Guxg@mail.gmail.com>
 <34381CFC-A90F-4979-9802-2BA0E6539C68@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34381CFC-A90F-4979-9802-2BA0E6539C68@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Saidi, Ali <alisaidi@amazon.com> wrote:

> ﻿On 3/27/19, 2:52 PM, "linux-arm-kernel on behalf of Kees Cook" <linux-arm-kernel-bounces@lists.infradead.org on behalf of keescook@chromium.org> wrote:
> 
>     Adding some more people to CC... what do people think about this
>     moving of the brk to ELF_ET_DYN_BASE in this corner-case? Anything
>     that worked before should still work (i.e. the ultimately-launched
>     binary already had the brk very far from its text, so this should be
>     no different from a COMPAT_BRK standpoint). The only risk I see here
>     is that if someone started to suddenly depend on the entire memory
>     space above the mmap region being available when launching binaries
>     via a direct loader execs... which seems highly unlikely, I'd hope:
>     this would mean a binary would not work when execed normally.
> 
> Kees' proposal addresses the issue for me. Anyone have concerns on this proposed solution?

I'd suggest incorporating all feedback and sending a v2 series - it's 
much easier to get people's attention via code submitted. ;-)

Thanks,

	Ingo
