Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE831C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C49820830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfILMht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILMhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:37:48 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 435B111A1F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 12:37:48 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id u10so2363977wrn.21
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 05:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pTZv96VgCJM8wv+X/QLpv4XlW1A0G4Xstp3NDxBDKyo=;
        b=iRonZATuTE5kLETYiqAXCZeLd16VrvOo8gzTjO3IltVtj7QIt8qDnz46WhNoArmiVi
         M38ZOFOD59QwyFsBjs1CkAjkSE8YNkAMJTtYKfcYLdk24CSpqgGFVlM0p32mC3acg7Wm
         9+NrWo/l0lJ7SJmFB2tDd5KAyARvGMrjs+/wHjfBTFL17E/5M8SRzpNbJT71UVmKAilp
         yVvJH8Ydyg2U0sWCXqiXn+s6GWsfiKwHGjC5gsfc4CFDUwl18Borz9Q7jbCXtHO+aykr
         asWirSGQl8BrSocJKwnHVT1EoAOp4laX6NPuUYA0v5diCT4mHn2gumgUn8n4ji7/fFal
         riGg==
X-Gm-Message-State: APjAAAWlYtatEQ5rWQqeQdGfZsCFcJsJ0iwNYIU9ZjrODCCAFiG37Eh+
        Ffwy7u0CCbcWeYeXtS1XKbhlpKR2p3Fd2mrXO0fq5SDdz5tWZsi9TCw6IXpvr6GXJlLVAnadcJY
        B9WQ147DfdgpuOLAK8ASF+epX
X-Received: by 2002:adf:d4c5:: with SMTP id w5mr34308605wrk.280.1568291866878;
        Thu, 12 Sep 2019 05:37:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1mhu4LnobJt1OA0eB+e58fTNMsmy0X4vUrwR5SrILpKjnRo959U2YZY9ItQtIR8LbFYrB3Q==
X-Received: by 2002:adf:d4c5:: with SMTP id w5mr34308589wrk.280.1568291866654;
        Thu, 12 Sep 2019 05:37:46 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id m18sm33245834wrg.97.2019.09.12.05.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 05:37:46 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] KVM: LAPIC: Tune lapic_timer_advance_ns smoothly
To:     Wanpeng Li <wanpeng.li@hotmail.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1566980342-22045-1-git-send-email-wanpengli@tencent.com>
 <a1c6c974-a6f2-aa71-aa2e-4c987447f419@redhat.com>
 <TY2PR02MB4160421A8C88D96C8BCB971180B00@TY2PR02MB4160.apcprd02.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8054e73d-1e09-0f98-4beb-3caa501f2ac7@redhat.com>
Date:   Thu, 12 Sep 2019 14:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <TY2PR02MB4160421A8C88D96C8BCB971180B00@TY2PR02MB4160.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/19 02:34, Wanpeng Li wrote:
>>> -        timer_advance_ns -= min((u32)ns,
>>> -            timer_advance_ns / LAPIC_TIMER_ADVANCE_ADJUST_STEP);
>>> +        timer_advance_ns -= ns;

Looking more closely, this assignment...

>>>    } else {
>>>    /* too late */
>>>        ns = advance_expire_delta * 1000000ULL;
>>>        do_div(ns, vcpu->arch.virtual_tsc_khz);
>>> -        timer_advance_ns += min((u32)ns,
>>> -            timer_advance_ns / LAPIC_TIMER_ADVANCE_ADJUST_STEP);
>>> +        timer_advance_ns += ns;

... and this one are dead code now.  However...

>>>    }
>>>
>>> +    timer_advance_ns = (apic->lapic_timer.timer_advance_ns *
>>> +        (LAPIC_TIMER_ADVANCE_ADJUST_STEP - 1) + advance_expire_delta) /
>>> +        LAPIC_TIMER_ADVANCE_ADJUST_STEP;

... you should instead remove this new assignment and just make the
assignments above just

	timer_advance -= ns / LAPIC_TIMER_ADVANCE_ADJUST_STEP;

and

	timer_advance -= ns / LAPIC_TIMER_ADVANCE_ADJUST_STEP;

In fact this whole last assignment is buggy, since advance_expire_delta
is in TSC units rather than nanoseconds.

>>>    if (abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_DONE)
>>>        apic->lapic_timer.timer_advance_adjust_done = true;
>>>    if (unlikely(timer_advance_ns > 5000)) {
>> This looks great.  But instead of patch 2, why not remove
>> timer_advance_adjust_done altogether?
> It can fluctuate w/o stop.

Possibly because of the wrong calculation of timer_advance_ns?

Paolo
