Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EB1C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D299220449
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="VlByBvhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfHARLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:11:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37350 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfHARLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:11:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so34431251pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=S5pAcAWsPPL0MV2KKFJY33gKzjahDxo4hJJq/wxTMVc=;
        b=VlByBvhvRL+XmaFAU3VB8OborKi+m09XsvzhG9WU/pWtCUbQQ+E5NH79qqWsZa00LZ
         jJ4RJmrvEmR7zeeOgNkLeNf89Gt4rmY0tRsf6KccJxr98X/AqTQQo1vlpeoMtphmSGnm
         NK1ZKbZH+c8wowIfHC6do4T6UHziLYOJxIHNfTAwiYnxBVhBziQbkAL24FMnFp1R8MP1
         KmcRY3F2+2C8iZBkCXD6A8J/RQ8CEUdesFlMRC9BP4rL1x/XU/xmBK/JL8irNrAhSspO
         PSQ/0rzQj6VCfUWIZg1/DpoDJ7lV3NjnflJOyfWShiGixzr1Wy5TaQZbJHel9xjdroVx
         gcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=S5pAcAWsPPL0MV2KKFJY33gKzjahDxo4hJJq/wxTMVc=;
        b=c2tsNaolKBDJY3PLSXIDLnX3iHCoUusxFMDKzYb40BjVbFgKdImMcvmgsepLNXe1fX
         4VgEk43KSRLYji1u8DBeUsoUe+wEMT006xwXG6am2Zeki/F1CMX51U630D3LWQLMWp4s
         uaVoibrpK3KrlBh8crCHJ0IoTrU1BDmvSoQ5+3hbDxNYPLU9LtK/tT/xFoSU+nGSDKxL
         pkZyRzB6E+F9LKfA6z26cPVh31YQHIe7t6sRS4TMUSTC2REwOlyyU5sIVYCnzwe/7sR/
         ZWFLww9/jA/o5XqJ/f+E9hZ5ijMO3AqZNqYx7r47IYpdG02dl5MiTmdHWnBs9FW8joWy
         cVeA==
X-Gm-Message-State: APjAAAWMuVTjRxvK3xLuGEEo+Ql573RaQi+kD80h5wEJMHmbCnISSAGu
        OoY812toX+vb09nCfG8VgT1mlA==
X-Google-Smtp-Source: APXvYqykClrbWkVs37QIGRuxgTaiZdW7Mkeb95+2ryFaT6ZIRFtDjFKWRRz+f2vMZYg2i7+zRfgqDA==
X-Received: by 2002:a63:d315:: with SMTP id b21mr97212834pgg.326.1564679489621;
        Thu, 01 Aug 2019 10:11:29 -0700 (PDT)
Received: from ?IPv6:2600:1010:b05c:1777:5b8:a455:199a:e2a8? ([2600:1010:b05c:1777:5b8:a455:199a:e2a8])
        by smtp.gmail.com with ESMTPSA id r27sm79185309pgn.25.2019.08.01.10.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 10:11:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 1/5] tracehook: Provide TIF_NOTIFY_RESUME handling for KVM
Date:   Thu, 1 Aug 2019 10:02:38 -0700
Message-Id: <05C28F0C-5D8C-4A77-8D1B-FAC91DCF1115@amacapital.net>
References: <20190801143250.370326052@linutronix.de> <20190801143657.785902257@linutronix.de> <20190801144814.GC31398@hirez.programming.kicks-ass.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org,
        Radim Krcmar <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
In-Reply-To: <20190801144814.GC31398@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (16F203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 1, 2019, at 7:48 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Thu, Aug 01, 2019 at 04:32:51PM +0200, Thomas Gleixner wrote:
>> +#ifdef CONFIG_HAVE_ARCH_TRACEHOOK
>> +/**
>> + * tracehook_handle_notify_resume - Notify resume handling for virt
>> + *
>> + * Called with interrupts and preemption enabled from VMENTER/EXIT.
>> + */
>> +void tracehook_handle_notify_resume(void)
>> +{
>> +    local_irq_disable();
>> +    while (test_and_clear_thread_flag(TIF_NOTIFY_RESUME)) {
>> +        local_irq_enable();
>> +        tracehook_notify_resume(NULL);
>> +        local_irq_disable();
>> +    }
>> +    local_irq_enable();
> 
> I'm confused by the IRQ state swizzling here, what is it doing?

Me too. Also, why is a loop needed?

> 
>> +}
>> +EXPORT_SYMBOL_GPL(tracehook_handle_notify_resume);
>> +#endif
>> 
>> 
