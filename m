Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D246C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF57720659
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfJILL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:11:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfJILL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:11:28 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18F812A09CC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 11:11:28 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id l3so896079wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 04:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jGWgKZBUMvfPdzfHcqjjwuG5He2iv9Vy4sHR01HU1S8=;
        b=Dsd7pHyEnOIa8e+up05cQf3xSgmcgzVqwe1Vy3unMvGmzhQW4t31Ver/IHmF3JhTDj
         +VApgatmdcQ/FNKBTJHPw4sIHBU17RiBTw05r/Q2dkeSNvFIL+Zm5Wk///6x7XlXEkXk
         Notw9qYmLRL5kC3WcRwj+Uqwv5T0D8klD3rVBbhv1X9w+s4xg/j+lnTQA++UrzXHy1kZ
         2j8QuVcfX1+Bw6ka52Urj+ugc/uO+J8fNBlSd/fn6Di9y40hc48en84rGrcm7hYjD6t+
         d2yGDNXZEEgs7X0R7vlMQz9UpR0oToOvC0CliAwUKZndkuzQa3YXfGR1gJteXedYXod7
         cCLg==
X-Gm-Message-State: APjAAAWVmhy6QcmeqSLNoRFkrGrc211vPq4gvsIaFsLctGJOJrG6w4kI
        26GyTz1ehqOWOZgGtP2lwrXgJAUqrt2W1Tn/X9mEZVYOaiAL1daFI3JCO55W6Lc+gE4E5ozBtgX
        tJSjPexgURZcZshe3A41cb1kd
X-Received: by 2002:adf:a50b:: with SMTP id i11mr2567244wrb.308.1570619486789;
        Wed, 09 Oct 2019 04:11:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJge5bT4Fndd0jKpf2bsQCbdfhi5IMzvx6cG1fbrcbsmBTC0oy38p5pvjjVOE2QUkWlM6YLg==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr2567234wrb.308.1570619486543;
        Wed, 09 Oct 2019 04:11:26 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 36sm2872921wrp.30.2019.10.09.04.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 04:11:26 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: fix sync_regs_test with newer gccs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
References: <20191008180808.14181-1-vkuznets@redhat.com>
 <20191008183634.GF14020@linux.intel.com>
 <b7d20806-4e88-91af-31c1-8cbb0a8a330b@redhat.com>
 <87d0f6yzd3.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5b1b95e5-4836-ab55-fe4d-e9cc78a7a95e@redhat.com>
Date:   Wed, 9 Oct 2019 13:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87d0f6yzd3.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 12:42, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> There is no practical difference with Vitaly's patch.  The first
>> _vcpu_run has no pre-/post-conditions on the value of %rbx:
> 
> I think what Sean was suggesting is to prevent GCC from inserting
> anything (and thus clobbering RBX) between the call to guest_call() and
> the beginning of 'asm volatile' block by calling *inside* 'asm volatile'
> block instead.

Yes, but there is no way that clobbering RBX will break the test,
because RBX is not initialized until after the first _vcpu_run succeeds.

Paolo
