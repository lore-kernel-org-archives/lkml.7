Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC147C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09AD2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8QifJmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDKW00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:26:26 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33495 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKW00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:26:26 -0400
Received: by mail-vk1-f196.google.com with SMTP id x194so1750724vke.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UoLLVcygV1LfDNeTQawdNC4kbLBy8PL1K4CMsysgYOI=;
        b=O8QifJmKkEaCqV0Lg7upTka7UzOg3j4RKHYARveM3TStNChlnUbLNvHZD9Q99/dmFQ
         IH4mILno+UkON4pq+BiHlJH6FQHtK78mj7okhJdz7MnMgVvgHJ6z5X8ituV/3Kacwg7/
         yh62X6ITMYlQMZYqvJNAKgyiO5B/DQKPZQ6sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UoLLVcygV1LfDNeTQawdNC4kbLBy8PL1K4CMsysgYOI=;
        b=FK9r98ID/gxD5pIlZgvyGztLGeTBotpoGb/9aInpEeBjJD+Vo1CtKwZk3QXdREIosf
         hJQwlDLbiKWbtCLag7j3ROImA+5iO/dHMcV1+dWgfKJrvIey/eEsgcTsnwsb8UrSwqoI
         4ZKjmtQbDt7QCpyvO6DN45eRz5vgcNlFhcaImZAJJ7/FtQTuKktgEHX239btvauNRjG4
         kAgNvhtCW0aW2V1FIAu7r6fU8p3ZibODqtB7fGBXNWzEVfx6nOx+y8LDpiLMg0TqZdcL
         rSgpS2Yb4I4okltxnmbqb6l4ESyFnncX3zFPDeOUNd9UT6o2G/gQgQT7T3czutNPqh7w
         d35w==
X-Gm-Message-State: APjAAAXTnZCKOo2q/Utuo/uz9UipH/m1BMo+I5ovKg10JmuChFVmuXHG
        XOVDftnegvHmHm6e3sHzshg42CE62Jw=
X-Google-Smtp-Source: APXvYqw1s7Wj+jiRbwSK7eyqTxTv3VeG+6COx7DnsA8OE0Q73McHwJD52pjzg3rkBOV5Lmr2ND6B7g==
X-Received: by 2002:a1f:1284:: with SMTP id 126mr29196109vks.72.1555021584782;
        Thu, 11 Apr 2019 15:26:24 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id m23sm59598606vsl.24.2019.04.11.15.26.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:26:24 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id f22so4432101vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:26:24 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr28491004vsc.115.1555021281313;
 Thu, 11 Apr 2019 15:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190410224213.20651-1-okaya@kernel.org> <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
 <135E84E9-F068-44CB-B4F6-A5AC2F4CDE3D@joshtriplett.org> <CAGXu5jLc_Z=TiNsMd40GN8-0D117RVbdD7Hy4MzjPQNbFf=bcg@mail.gmail.com>
 <FF2E07CA-99D7-4F9C-B281-425897535C84@joshtriplett.org> <e901a9cc-f335-fb31-535c-97dce2ca8f5b@kernel.org>
 <20190411221645.GA8692@localhost>
In-Reply-To: <20190411221645.GA8692@localhost>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 15:21:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKa4dUuCxc1kPdRGH5qrXeH0y09hnScb41-SQDo_amv8Q@mail.gmail.com>
Message-ID: <CAGXu5jKa4dUuCxc1kPdRGH5qrXeH0y09hnScb41-SQDo_amv8Q@mail.gmail.com>
Subject: Re: [PATCH v2] init: Do not select DEBUG_KERNEL by default
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Sinan Kaya <Okaya@kernel.org>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 3:16 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Wed, Apr 10, 2019 at 11:13:52PM -0400, Sinan Kaya wrote:
> > On 4/10/2019 11:02 PM, Josh Triplett wrote:
> > > Then let's fix*that*, and get checkpatch to help enforce it in the future. EXPERT doesn't affect code generation, and neither should this.
> >
> > I think we have to do both. We need to go after the users as well as
> > solve the immediate problem per this patch.
> >
> > As Mathieu identified, CONFIG_DEBUG_KERNEL is being used all over the
> > place and getting subsystem owners to remove let alone add a check
> > to checkpatch is just going to take time.
> >
> > Please let us know if you are OK with this plan.
>
> I'm not OK with this plan. Turning on EXPERT should make the options
> under DEBUG_KERNEL visible; it's a bug that DEBUG_KERNEL affects code
> generation as well.
>
> Proposed alternative plan: let's add a new symbol, something like
> DEBUG_MISC ("Miscellaneous debug code that should be under a more
> specific debug option but isn't"), make it depend on DEBUG_KERNEL and be
> "default DEBUG_KERNEL" but allow itself to be turned off, and then
> mechanically change the small handful of "#ifdef CONFIG_DEBUG_KERNEL" to
> "#ifdef CONFIG_DEBUG_MISC".
>
> Does that sound like an appropriately rapid solution for this bug?

Sure, that sounds fine to me. Sinan can you take care of that for v4?

-- 
Kees Cook
