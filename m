Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C99AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217E020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfDPLUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:20:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46253 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDPLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:20:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so26440075wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vX22ZljpvyzGqaDUGaMXFf3h/6G9La+s7NU9oDZqnu8=;
        b=PB/2ffXRBzdBsn5XVLD+HHNXK+LzYee9Is513bm7MEqHmutCt8meoWVkhpl7nAEMlK
         ORxH0tUbYVNlkG4NTSSOI5tmwN+PKLaKBDaEXMYzW9KvLBwW65Qdu27LdP1vQi+gU7hB
         K0JGi7Gs+5RV4hVIiKVXPbvfjATGdPehCpcZQIEUdKOLl1uACs3hfwf0/D3RxHsva16x
         PmcCgT71KCeqgTGiKDmWH4HYIZM6cK7hFDhsMaQ+kLcjOBY0dMOYNJzrfISomHyYI69j
         eAYvI0VGrXKfY2sgQaqNNiVK5eTo/8hr39Ph2KNHz2NhSkTHPYhxqhQhaMQthvrLhMAz
         KPCw==
X-Gm-Message-State: APjAAAVt9PlLP1dlu/fDXoWQt/5N7hbgSp/NOfjbTUQ7pKRw99rZJHkO
        +8TyBIQQE14eh1vpGRis0z0wrA==
X-Google-Smtp-Source: APXvYqxj2mg+mTtpSS0BEUuEYEVSTXX6lf+1zju0o/vwNw/rdPPfOt84rnPY3PCKVl+fx/gRJLtl7g==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr49244642wrj.228.1555413621350;
        Tue, 16 Apr 2019 04:20:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z10sm17162151wmi.15.2019.04.16.04.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 04:20:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "tglx\@linutronix.de" <tglx@linutronix.de>,
        "riel\@surriel.com" <riel@surriel.com>,
        "jpoimboe\@redhat.com" <jpoimboe@redhat.com>,
        "luto\@kernel.org" <luto@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "marcelo.cerri\@canonical.com" <marcelo.cerri@canonical.com>,
        "apw\@canonical.com" <apw@canonical.com>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "jasowang\@redhat.com" <jasowang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] smp: Do not warn if smp_call_function_single() is doing a self call.
In-Reply-To: <20190416093123.GR11158@hirez.programming.kicks-ass.net>
References: <20190412235341.29379-1-decui@microsoft.com> <20190415122128.GO11158@hirez.programming.kicks-ass.net> <PU1P153MB01695FDC44C6A2C32C7FB887BF2B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM> <20190416093123.GR11158@hirez.programming.kicks-ass.net>
Date:   Tue, 16 Apr 2019 13:20:19 +0200
Message-ID: <87o9562o3w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Apr 15, 2019 at 11:39:57PM +0000, Dexuan Cui wrote:
>> > From: Peter Zijlstra <peterz@infradead.org>
>> > Sent: Monday, April 15, 2019 5:21 AM
>> > To: Dexuan Cui <decui@microsoft.com>
>> > 
>> > On Fri, Apr 12, 2019 at 11:53:57PM +0000, Dexuan Cui wrote:
>> > > If smp_call_function_single() is calling the function for itself, it's safe
>> > > to run with irqs_disabled() == true.
>> > >
>> > > I hit the warning because I'm in the below path in the .suspend callback of
>> > > a "syscore_ops" to support hibernation for a VM running on Hyper-V:
>> > >
>> > >   hv_synic_cleanup() ->
>> > >     clockevents_unbind_device() ->
>> > >       clockevents_unbind() ->
>> > >         smp_call_function_single().
>> > >
>> > > When the .suspend callback runs, only CPU0 is online and irqs_disabled() is
>> > > true.
>> > 
>> > Pray tell, how well do you think mutex_lock() works with interrupts
>> > disabled?
>> 
>> Good point. I realized generally speaking this patch makes no sense, so let me
>> try the solution proposed by Vitaly, i.e. fix clockevents_unbind() instead.
>
> That's still not the problem. You're calling clockevents_unbind_device()
> with IRQs disabled, that's not correct. It doesn't matter what
> clockevents_unbind() does thereafter.
>

True. And before we start digging deeper into this, let's step back: why
do we need to do clockevents_unbind_device() on hybernation? Can we just
disable the device and re-enable it back on resume?

Actually, all usages of clockevents_unbind_device() in kernel are
limited to Hyper-V and with Michael's patches moving this out of VMBus
driver I think it can go away completely.

-- 
Vitaly
