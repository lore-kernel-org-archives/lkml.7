Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4377EC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8532075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 19:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfIKTAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 15:00:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfIKTAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 15:00:47 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B22C289AC4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 19:00:46 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id k22so21936949qtm.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 12:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GbrEn6qZqNk8hB7L2+kRT1tArBh8lvQk9OpZiosnvlQ=;
        b=FEwwFtDVywhAVq9UWFkS1keND3C5nhqI4Iz7ENxTHtd23eexrl6D0ldWYvwffua+j4
         npY0ePsPjbkQeUnhHv4NJuPoMrx4KQmKb5+zSJl17JS+V/dnrBa/C0HM3AjzhdNdWhFB
         LrIOr2NCvJ44zCA/2X4C+PCi2b4IWVpn8tkOlODdT2dJZwiBpOurYhKzS9/AQ9ZuKTd8
         RFXG07qhAO1lcmCNjfXtgBUhGI7RypfpuBW6QWIvUPOooMhfwB0gf+5Rpna+NztmFODV
         Gq8K6tHcsM8pn+qI8jBVO5xYf6pJq+AWGiTRw3/j0G6/Soc/CpIH6gulWCyiwGalZwgd
         EYFg==
X-Gm-Message-State: APjAAAV3A8jU9fIPGdSM0XRxSpWYdqxAKrGf3eGbToBmJCiiLAP70xs2
        ACHLWxagqngmaDNuwy6xb8QoCySd3yMhT8Ywo5AFEdvQl0rABqnjhNsWre9S29rIIZJJEPLOof9
        3oKcYbr86esa18gc0BO1LUK45
X-Received: by 2002:ae9:ef4c:: with SMTP id d73mr36153824qkg.57.1568228445882;
        Wed, 11 Sep 2019 12:00:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXFPZbhdDbQqKjZl2wxJNQJHt+WIAUtb8fiF2AknifKLJLpxZIaYfDi+H19hMWci80medUTQ==
X-Received: by 2002:ae9:ef4c:: with SMTP id d73mr36153781qkg.57.1568228445627;
        Wed, 11 Sep 2019 12:00:45 -0700 (PDT)
Received: from [192.168.1.4] (192-0-145-99.cpe.teksavvy.com. [192.0.145.99])
        by smtp.gmail.com with ESMTPSA id c26sm13444792qtk.93.2019.09.11.12.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 12:00:44 -0700 (PDT)
Subject: Re: [PATCH glibc 2.31 1/5] glibc: Perform rseq(2) registration at C
 startup and thread creation (v12)
To:     Florian Weimer <fweimer@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20190807142726.2579-1-mathieu.desnoyers@efficios.com>
 <20190807142726.2579-2-mathieu.desnoyers@efficios.com>
 <8736h2sn8y.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <7db64714-3dc5-b322-1edc-736b08ee7d63@redhat.com>
Date:   Wed, 11 Sep 2019 15:00:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8736h2sn8y.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 2:26 PM, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> +#ifdef SHARED
>> +  if (rtld_active ())
>> +    {
>> +      /* Register rseq ABI to the kernel.   */
>> +      (void) rseq_register_current_thread ();
>> +    }
>> +#else
> 
> I think this will need *another* check for the inner libc in an audit
> module.  See what we do in malloc.  __libc_multiple_libcs is supposed to
> cover that, but it's unfortunately not reliable.
> 
> I believe without that additional check, the first audit module we load
> will claim rseq, and the main program will not have control over the
> rseq area.  Reversed roles would be desirable here.
> 
> In October, I hope to fix __libc_multiple_libcs, and then you can use
> just that.  (We have a Fedora patch that is supposed to fix it, I need
> to documen the mechanism and upstream it.)

This is a technical issue we can resolve.

>> +/* Advertise Restartable Sequences registration ownership across
>> +   application and shared libraries.
>> +
>> +   Libraries and applications must check whether this variable is zero or
>> +   non-zero if they wish to perform rseq registration on their own. If it
>> +   is zero, it means restartable sequence registration is not handled, and
>> +   the library or application is free to perform rseq registration. In
>> +   that case, the library or application is taking ownership of rseq
>> +   registration, and may set __rseq_handled to 1. It may then set it back
>> +   to 0 after it completes unregistering rseq.
>> +
>> +   If __rseq_handled is found to be non-zero, it means that another
>> +   library (or the application) is currently handling rseq registration.
>> +
>> +   Typical use of __rseq_handled is within library constructors and
>> +   destructors, or at program startup.  */
>> +
>> +int __rseq_handled;
> 
> Are there any programs that use __rseq_handled *today*?
> 
> I'm less convinced that we actually need this.  I don't think we have
> ever done anything like that before, and I don't think it's necessary.
> Any secondary rseq library just needs to note if it could perform
> registration, and if it failed to do so, do not perform unregistration
> in a pthread destructor callback.
> 
> Sure, there's the matter of pthread destructor ordering, but that
> problem is not different from any other singleton (thread-local or not),
> and the fix for the last time this has come up (TLS destructors vs
> dlclose) was to upgrade glibc.

This is a braoder issue.

Mathieu,

It would be easier to merge the patch set if it were just an unconditional
registration like we do for set_robust_list().

What's your thought there?

-- 
Cheers,
Carlos.
