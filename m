Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E3C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF01220872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442652AbfIYHw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:52:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437273AbfIYHw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:52:57 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DF462A09B3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 07:52:57 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k184so1610059wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJ6wyP0bI3pA2TwxdshaPg0vZhCLWNJFj4q55kWGgHE=;
        b=T8fJNPn7HraiDvLNvnhcee9Ct08QrQtRkA3ImIN5Q5AFKPIYKSQ/N7UJXYDvceSYSr
         W17y3fmWRMuYUeMzUHuD3ZgvMLLlcqcKvo/h3htQjPZNRBX17Hz4ttU8WgHwLBJyNivD
         /JvSPZpL5LQ1wouSDBqH64kYK1CxgziSg5FSVnVfsXuungqhjx+cI2d1XCvWNTY6iLbu
         IxQsRb8arRlHP6zpWKXl1PsXU5C5AuzBY6ThKa367RE5SN6GgwyhH5UYYnyWkuB0gADm
         N0zyI6pCAuiNUI6odmjPjLGhuZYzXvTrvn1Wx1bracjMadBChc4k3EO3bfvgFQGfBBJ+
         39fg==
X-Gm-Message-State: APjAAAWXd2LyAnYjLT4Lom9D+EHx+7xoUoPOl7mvduPFcULwEqpqMggL
        P0tEQKSh+4+6pXVFFPCghQMh9JtBMw1cMOJfEOyM4DGmbdlTrElJP32xoxCFIpSHYVmlGpOFnqZ
        RjX1cdQgAF0qm4M/SBvJlHPp+
X-Received: by 2002:a5d:6302:: with SMTP id i2mr8197503wru.249.1569397974545;
        Wed, 25 Sep 2019 00:52:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfc4fQeO64LjuPyyOE4zcmr6EaHOEpbv8tYk/ZlLRcmQbwHMYuPntDJ92EzbDHh7HONJehDA==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr8197404wru.249.1569397973453;
        Wed, 25 Sep 2019 00:52:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id m18sm7610094wrg.97.2019.09.25.00.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 00:52:52 -0700 (PDT)
Subject: Re: [PATCH 14/17] KVM: monolithic: x86: inline more exit handlers in
 vmx.c
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-15-aarcange@redhat.com>
 <6a1d66a1-74c0-25b9-692f-8875e33b2fae@redhat.com>
 <20190924010056.GB4658@redhat.com>
 <a75d04e1-cfd6-fa2e-6120-1f3956e14153@redhat.com>
 <20190924015527.GC4658@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3ec06895-d05d-aacd-17cc-08eedb21ccba@redhat.com>
Date:   Wed, 25 Sep 2019 09:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924015527.GC4658@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/19 03:55, Andrea Arcangeli wrote:
>> So it's forty bytes.  I think we can leave this out.
> This commit I reverted adds literally 3 inlines called by 3 functions,
> in a very fast path, how many bytes of .text difference did you expect
> by dropping some call/ret from a very fast path when you asked me to
> test it? I mean it's just a couple of insn each.

Actually I was either expecting the difference to be zero, meaning GCC
was already inlining them.

I think it is not inlining the functions because they are still
referenced by vmx_exit_handlers.  After patch 15 you could drop them
from the array, and then GCC should inline them.

Paolo
