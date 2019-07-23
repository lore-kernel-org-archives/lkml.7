Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFE3C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09932238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GybFe+jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfGWXnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:43:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41143 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGWXnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:43:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so9844184pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULjvNu8XqxCLyK7lX3vJgWCh6vPqYwiwOi/5y16BH3Y=;
        b=GybFe+jttEiHAN54hWf3fGA7UFjS+U2eNj3SotzkCQljsnOD9pSo4HeEXHRUjzwYq0
         dqioBctjZKd0XfyyrX85hkdUUbv9K4F6HB4+KvmNyTDd2z5YRZMgWRLWwyLuxWhvyT5U
         hu3dagm6zvIxm7JavoPfQC18+BL65C3Lr7aXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULjvNu8XqxCLyK7lX3vJgWCh6vPqYwiwOi/5y16BH3Y=;
        b=L9riMK0Is8LFtx689ez2ZpNxsuz1FzBVE/hZNKKKd8etM3r8PNyCgkn0HU541PF4IF
         4raXY46adepefZX+mxU64zY0ru/ESICqHnqvYtiEJC+GVyNtagMOojVms7nzF6l5+Bqq
         Dpb6F9an0MtLrlGINe1Zer7MQP/81vvf4P8mGRPKBBYzyIJqqzcDLbGAiPjn5YBzwB0l
         IaDi+jVUjyZrnL+2yJjHQOUa18S0ZwVlpnmzJbBKKBY2/zs36AzO0VAswhLCXeUv4+q8
         cCPkUovW9amLYAr8tIublObe1Y6hG+NFhVcafsLcDX26pyuZRJd0OTBXJAjA8YgbehNt
         JzWA==
X-Gm-Message-State: APjAAAUJ6WGevldrYaM7DYPmnlqLHKKQp79BbzHaoWj9ekSD3MR5pqbi
        1jyBYvAyqWop/lyJFshpxxg6rA==
X-Google-Smtp-Source: APXvYqwZE+Dl+uWmNXDDPfO5/dJvqFZBEB0U4nE6GUAd3Xda+N6LHB28/0TS6z+8nRqqXobjOHp+xg==
X-Received: by 2002:a62:7552:: with SMTP id q79mr8304730pfc.71.1563925386175;
        Tue, 23 Jul 2019 16:43:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm34825460pff.4.2019.07.23.16.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 16:43:05 -0700 (PDT)
Date:   Tue, 23 Jul 2019 16:43:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
Message-ID: <201907231636.AD3ED717D@keescook>
References: <20190719170343.GA13680@linux.intel.com>
 <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook>
 <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook>
 <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
 <201907231437.DB20BEBD3@keescook>
 <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:59:03AM +0200, Thomas Gleixner wrote:
> And as we have sys_clock_gettime64() exposed for 32bit anyway you need to
> deal with that in seccomp independently of the VDSO. It does not make sense
> to treat sys_clock_gettime() differently than sys_clock_gettime64(). They
> both expose the same information, but the latter is y2038 safe.

Okay, so combining Andy's ideas on aliasing and "more seccomp flags",
we could declare that clock_gettime64() is not filterable on 32-bit at
all without the magic SECCOMP_IGNORE_ALIASES flag or something. Then we
would alias clock_gettime64 to clock_gettime _before_ the first evaluation
(unless SECCOMP_IGNORE_ALIASES is set)?

(When was clock_gettime64() introduced? Is it too long ago to do this
"you can't filter it without a special flag" change?)

-- 
Kees Cook
