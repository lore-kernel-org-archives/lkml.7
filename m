Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E264C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6779521473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UfPN0oVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfDHQVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:21:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42583 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfDHQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:21:35 -0400
Received: by mail-vs1-f66.google.com with SMTP id f15so7946766vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVwIJHe59IlKUw1BxDIBCIGTtTTTGVaGbh2zIIuMoW4=;
        b=UfPN0oVk9XCcq2lfIooPLIRWVqwQO8QeNVcFgBNQnvzBWAOP6gO1F1UvEA2uuXc8Ej
         nlFc7jqLniLjTi0KB+YE6X4JdClkFvoksFUWWY9DrWk/mlffRs7dGFf6uVQpJyFtu2Uh
         QHh8X0PQ4QtUKnRlQkrGQ6ALoThBEvOQyzFq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVwIJHe59IlKUw1BxDIBCIGTtTTTGVaGbh2zIIuMoW4=;
        b=SR3VZYA75gJSdTCQ9El3QI+jtxsNhe6j89eFt5QS+8Pnn0yDtSIdGRWYE9YzIEVHxp
         vG+tQW1skFefsB1X5ZVpn8/6z0RuJlnQZBlRHu6cGYkSuRzk3bQGskGpgvL8EuP80Vtn
         ZXMXXucYRhb/B5KZW2z2w0lIMjYLvCc5aWBPftaoYqI6ej5DIQ3Vo3lZAceNOXIIuuS3
         M2JAGlwhzdV6eYpw9KcNdaj7P6EHf9TTtpe/Tw/1zioOe7Jrs4DAT2v2oCQ6YhNn8AHq
         NF/F6FnWrm9o9Rfq2oDphRWQtSiBEesXPPB3acljawVjZno5tvDzjSqBgE8U9G+FtI0g
         C1CQ==
X-Gm-Message-State: APjAAAXlM2lubjPi1dLrMGNhOQzxvMkWK+qyR9so9def1Zm1K5NY7XRo
        xhdtc2oK2nVwWO3WyKxU7AnFLQWFZtg=
X-Google-Smtp-Source: APXvYqzgRkjfcnzFtnlqW+FsjbNOZ2s5ycGUxDeSPTdVjohttup0qD8simvzd0+Ti2EBcIm9/bwCZw==
X-Received: by 2002:a67:8010:: with SMTP id b16mr17392020vsd.189.1554740493508;
        Mon, 08 Apr 2019 09:21:33 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id o1sm6741849vsd.21.2019.04.08.09.21.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:21:32 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id g127so7956737vsd.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:21:31 -0700 (PDT)
X-Received: by 2002:a67:7e12:: with SMTP id z18mr18051044vsc.82.1554740491255;
 Mon, 08 Apr 2019 09:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190408061358.21288-1-elena.reshetova@intel.com>
 <20190408124940.hb4d2mvwue7aydjj@treble> <2236FBA76BA1254E88B949DDB74E612BA4C43BBA@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C43BBA@IRSMSX102.ger.corp.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Apr 2019 09:21:19 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJzsR+uuqmHJbijbD6ikPtV37jjXw7C7WZK77t7QR_M3g@mail.gmail.com>
Message-ID: <CAGXu5jJzsR+uuqmHJbijbD6ikPtV37jjXw7C7WZK77t7QR_M3g@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 6:31 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
> Originally I was thinking that in-stack randomization makes sense
> only for x86_64, since this is what VMAP stack on x86 depends on.
> Without VMAP stack and guard pages, there are easier ways to attack,
> so hardening there does not really makes that much sense IMO.
> However the 32 emulation case is interesting, I didn't think of it before.
> I guess if it uses VMAP-based stack, then we should support these calls also
> with in-stack randomization.

I think there's value in the non-VMAP-stack case: e.g. if the target
is "uninitialized" values, repeated syscalls will make targeting the
area less robust. (Though one would hope anyone using stack offset
randomization would also be using one of the various "always
initialize" options too...)

-- 
Kees Cook
