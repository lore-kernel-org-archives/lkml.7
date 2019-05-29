Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64161C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378D621734
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfE2BZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:25:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36163 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfE2BZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:25:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so464724wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rqj4DN+mKFOFN2ElIEBtWrUBDtgBpL5CxV4R4XTM10o=;
        b=RVx8hscCWqB6dFtYupixvrhbnbdxExxVQKAjrRfZQAw1TdPI7q/PkhLp0wd1ygxCot
         o/x4xNuwm1O8gx18DNvjxn9ZUDJ0Xk8sHtkRd1UPGSS4Z+ai7wR/gBHhpYArLC82Q96X
         XFgb4/iDoMiQXAQ9f9rbNmWYKcivHRwxJlWxjM/VI8YkeZMnP3irLJTI78RVDTDvy7lj
         xPITznJEYclHXsfmrzu8ppSs+VCbKeXKAiANbzIivdyHBrEe5myE4iEIe9mOSJNDPPtn
         EC19hL84R2w7UlqaQ9XyuYyh4NHSMqEJy87aE/hQCoTgkRWC2GfBJ9F0iU5UibI3m3pk
         Cftg==
X-Gm-Message-State: APjAAAWSpxcT5qMCRBa9LBRW5jc070oJeGT5MNukUOl4LAOPII2jwMuw
        2PjBnp9sjh4dl4CXRYF7R2MdAA==
X-Google-Smtp-Source: APXvYqwtWVxxE2Y3KBugsv4RW0JNUGuXKYKlfAWL8wp283sVlUi5mkh0LOf0h0ykT1V8TpWOn1NBog==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr14487648wrv.329.1559093141154;
        Tue, 28 May 2019 18:25:41 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id s15sm10845265wrn.68.2019.05.28.18.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 18:25:40 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] KVM: x86: add support for user wait instructions
To:     Peter Zijlstra <peterz@infradead.org>, Tao Xu <tao3.xu@intel.com>
Cc:     rkrcmar@redhat.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jingqi.liu@intel.com
References: <20190524075637.29496-1-tao3.xu@intel.com>
 <20190524075637.29496-2-tao3.xu@intel.com>
 <20190527103003.GX2623@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bcf669c8-81f4-0024-5f66-c40c6d519c62@redhat.com>
Date:   Wed, 29 May 2019 03:25:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527103003.GX2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/19 12:30, Peter Zijlstra wrote:
>> This patch adds support for UMONITOR, UMWAIT and TPAUSE instructions
>> in kvm, and by default dont't expose it to kvm and provide a capability
>> to enable it.
>
> I'm thinking this should be conditional on the guest being a 1:1 guest,
> and I also seem to remember we have bits for that already -- they were
> used to disable paravirt spinlocks for example.

This should be userspace's choice.  It would indeed be silly to enable
this while overcommitted, but KVM doesn't really care.

Paolo
