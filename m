Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86F9C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8357E20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437522AbfIWQsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:48:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387750AbfIWQsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:48:30 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E5C885536
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:48:30 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so1895756wmg.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tZRb6baOmGI150lVZ1gc8cSyiavau4pWVjiukU4sc/o=;
        b=gPTgjE4t2oF0opgtVKmOvv8gCz9U8OxEyIUsp8oDPO1m2HSEzUqRk4BCsD0nmgeEo2
         kUslNS31MmG/mXop9Tw4nSe1xGIM21MJc3HBgLmXiZd6t9VpDpxGmpU/cIl7EsKgsU+f
         fLyPWp7seC6JsHcouVzSShoKgvPErb/VBBJXUcjAjunRCdfLXB7l2fxr0HUeKqQEN2so
         yET4afjlWei8PYc0B8CrC0L8G2xNzKTxw/UQInCQrbNiVMLMZdjQ5kHIohXfres0Ug94
         qhKQzkM++DaPHQ0sGPxIvBn3FKdMjVGjyY2+swBH6Mwnz4eHbXJe+p5pKVv1wVvq+AB9
         xvmA==
X-Gm-Message-State: APjAAAVuQ4WWfa6bxMnUfd0KHEO5Dn2/Y8lpTBykyQw8LP6d4jqOCwc4
        BVG3Q1hBfFLHeLZPnGVAPSYnN214LJjSdnCURiB98iNL6hmgYrlskbvvEyf0qAvkSU5McZRLzgf
        /IYu3LNgMlPnEzj6P3oyjfr6k
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr435306wmb.124.1569257308763;
        Mon, 23 Sep 2019 09:48:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKleoftvyPkeoDX6aFTInlvLMkcvJSxl8ouKtBOQtpSvrSkEsMlpES5OZY/GzkKzpGkare/g==
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr435269wmb.124.1569257308463;
        Mon, 23 Sep 2019 09:48:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id m62sm16138307wmm.35.2019.09.23.09.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:48:27 -0700 (PDT)
Subject: Re: [PATCH 2/3] KVM: x86: hyper-v: set NoNonArchitecturalCoreSharing
 CPUID bit when SMT is impossible
To:     Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
References: <20190916162258.6528-1-vkuznets@redhat.com>
 <20190916162258.6528-3-vkuznets@redhat.com>
 <20190923153713.GF2369@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <06687f31-0941-46ad-e05c-cb3cfe211051@redhat.com>
Date:   Mon, 23 Sep 2019 18:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923153713.GF2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/19 17:37, Peter Zijlstra wrote:
>> This patch reports NoNonArchitecturalCoreSharing bit in to userspace in the
>> first case. The second case is outside of KVM's domain of responsibility
>> (as vCPU pinning is actually done by someone who manages KVM's userspace -
>> e.g. libvirt pinning QEMU threads).
> This is purely about guest<->guest MDS, right? Ie. not worse than actual
> hardware.

Even within the same guest.  If vCPU 1 is on virtual core 1 and vCPU 2
is on virtual core 2, but they can share the same physical core, core
scheduling in the guest can do nothing about it.

Paolo
