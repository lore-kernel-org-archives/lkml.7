Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EEEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94C42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551457099;
	bh=pQZxI+lTrGnf6BDyuiwPKFiHZf1YGFZPwqykxff0EFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R72PpdtmL8oc5Tm0U0voHBq7Sxpw8jJUXUzG0I+xv2KuQLuaapL/kV9Sb1WxdtAkH
	 6LHVGMMIAVZp8jFuo7IReara5qpR/+EfSHqgBFTS9DbE1BEICU5jZI42nzt3836kOA
	 COQyKD8fj43zs8RucuZolDViKSfT/wqqLSm5olH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbfCAQSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:18:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46463 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCAQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:18:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id g12so18392239lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8v/eb+IFKLowNyk03dnxHDcDNubeGdJsc2lL7ebvVtg=;
        b=KiUlhF0IqIObgBaj6GqQWngnqaWOZjhErOYti+niC0BmfYPOJlZWXoybezseMXiwDQ
         Ih3JHk7VH4p85kA/Mgos7dl2baawCqKFF9036t/32UyEBMt1dQfAMEdKPhni+mmR2RpP
         CWqw5+AeER1WvIYAjRmPR0mC7yfB0cLt9jOwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8v/eb+IFKLowNyk03dnxHDcDNubeGdJsc2lL7ebvVtg=;
        b=aaqHOH08PShnvkWw2lF+8aJmk0drKwqNhGTy8NMvVuseicRHkQ1Azhqpl/6ULZuPIl
         dxvC537zO2RiTrTA+TMXpA/dNBFME1zmdyAUXHhHqo0+ewdIOlRojxh9EwUd8f6NLS1W
         SfLNyOW5htR5PfyWRsmYZnv7mef0n6Huy0sr82bOiZ+hLQRsPCkNjNE0gfpcwgvWJoAS
         91SgMjQCazNG5BKLZ9NEbLxtq5E/5kWekBhhEEa0uP7rLfpYilDYa5UB2fvYl4oSmt/+
         SMog9OYjMFQ78YWakW+WsYJiMM37NoM6W6JleKW5nUtNIcJxMzLwz4DQRVggEezCuIng
         MARg==
X-Gm-Message-State: APjAAAUYjvgjBdG2uFcthatDZWyz3K3r261H39JQFoImmlYCIOvt7NWe
        7wMIMcX2aKWIPISaPwHfjTodd5pXd8Y=
X-Google-Smtp-Source: APXvYqzbbRZ0k3ckHUxoGk4AEMQDTu1EVg7no1vs9GBqhXx83Vw0Jvc4i/lwJBTmxo5gMWT/8NSFZA==
X-Received: by 2002:a19:a345:: with SMTP id m66mr3578846lfe.84.1551457095421;
        Fri, 01 Mar 2019 08:18:15 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m16sm4676781ljb.50.2019.03.01.08.18.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:18:14 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id d24so20623304ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:18:14 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr3281364ljc.22.1551457093901;
 Fri, 01 Mar 2019 08:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
 <20190228175114.GG32494@hirez.programming.kicks-ass.net> <20190228180154.GO32534@hirez.programming.kicks-ass.net>
 <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
 <20190228190111.GI32494@hirez.programming.kicks-ass.net> <20190301103452.GQ32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190301103452.GQ32534@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Mar 2019 08:17:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiB2gRa8tsa3ndxgyTe0FZ+M40oe_ffW8jCoAu_KjQgHw@mail.gmail.com>
Message-ID: <CAHk-=wiB2gRa8tsa3ndxgyTe0FZ+M40oe_ffW8jCoAu_KjQgHw@mail.gmail.com>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 2:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> With the dodgy patch:
>
> CC      drivers/gpu/drm/i915/i915_gem_execbuffer.o
> drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: eb_relocate_slow()+0x1f9: call to kvfree() with UACCESS enabled
> drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x315: call to kvfree() with UACCESS enabled

Ok, so it looks like your patch does the right thing. Your fixups to
i915_gem_execbuffer.c (and the already commented-upon copy_user_tail
thing) also look sane.

               Linus
