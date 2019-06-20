Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BD4C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD372084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfFTJAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:00:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36583 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfFTJAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:00:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so2301997wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vddaDNU08aTNsQcXmYBUi4ms30pth+CnMAqKshaYelA=;
        b=X5W5G/XNsjuAaE6IkFzJT4B+bK5C6vYSD22gFr2CVxPzXrrjjt4RVoEOKzUCB1Oft1
         K4XrWjlbX12Udflv9DnyxKjci2jWn/tWYi5VW84q8dU29GOS58bb/FDeffC8TinD19DD
         HFZgqIg3JsssRFcTkddIzH4mWu1rdSA69D3xpPd4uwVWv9rFqMuwErRjDebjA9M/zqcw
         iC54CgTFYDVf9MUXUjIjbdTtRn1U0uBp+s1rgOfJ7NUk2YQxaY8E6rYoBsemi8ATFs0D
         oU5yMor2Z2NkqBz1kRki48K/kC9rNfnHXs4lq4t0JrV5uK6WNuvZgqUIjYTzPhYniQ8U
         drXw==
X-Gm-Message-State: APjAAAVMfAQTVWX+UUF+OfNtjtxu9DfC23e8nqDI9j2MTqlMQg1loBNF
        e/UIPUn+Ps85ysLJsaYiR37PypDvDX0=
X-Google-Smtp-Source: APXvYqzbNKZHwFaDBe6SMO2bSr6qfYnU7CP2hxFaCBO+4IgEmShvwUEIym/VhGTbzqTkuDXSF9OE5g==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr1823342wmc.33.1561021197712;
        Thu, 20 Jun 2019 01:59:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab? ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
        by smtp.gmail.com with ESMTPSA id a2sm4789699wmj.9.2019.06.20.01.59.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 01:59:57 -0700 (PDT)
Subject: Re: [PATCH] KVM: vmx: Fix the broken usage of vmx_xsaves_supported
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Wanpeng Li <kernellwp@gmail.com>, Tao Xu <tao3.xu@intel.com>
Cc:     Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190620050301.1149-1-tao3.xu@intel.com>
 <CANRm+Cwg7ogTN1w=xNyn+8CfxwofdxRykULFe217pXidzEhh6Q@mail.gmail.com>
 <f358c914-ae58-9889-a8ef-6ea9f3b2650e@linux.intel.com>
 <b3f76acd-cc7e-9cd7-d7f7-404ba756ab87@redhat.com>
 <2032f811-b583-eca1-3ece-d1e95738ff64@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9b3e4ff-e14b-1bc5-2a7e-c89b545bb2fc@redhat.com>
Date:   Thu, 20 Jun 2019 10:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2032f811-b583-eca1-3ece-d1e95738ff64@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/19 10:55, Xiaoyao Li wrote:
> 
>> However I may be wrong because I didn't review the code very closely:
>> the old code is obvious and so there is no point in changing it.
> 
> you mean this part about XSS_EXIT_BITMAP? how about the other part in
> vmx_set/get_msr() in this patch?

Yes, only the XSS_EXIT_BITMAP part.  The other is a bugfix, I didn't
understand Wanpeng's objection very well.

Paolo
