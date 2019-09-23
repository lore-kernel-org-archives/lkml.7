Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22175C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029F42089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502093AbfIWQxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:53:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502047AbfIWQxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:53:15 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CB9DC0546D5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:53:15 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id q10so5063432wro.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCclZaSuQHlKr6RAQuL34ylahD5MmenLni28jEE8EUE=;
        b=pZtWvREYPIribuJ9vouGFf1zDuf+Sd+bixi0gFfaxoy30w4HKuwbBAP81/m5psV7Tz
         HWdVIMaBzKR875sNsSIgZbAIY2f/32fmOsohuDQkFqNTFCkXfBfKjdwNJshkBGIkO/58
         zREFs0b0M0gc6M578Hv4O3btvs8XGELzPXTSq/em6EAzjH5F1juVE9pgqfn5FKmUYuK/
         YvmfQsnUAWPSkPukhpEzCAOjs2DuNnN2RvE4lHn9drbfPqV5vykTb1TB/DRZhHuL7xb+
         WGu143KrBQwQg5Ma5R+3z9tXr17e5/v9RVFxtKYGDM9wAn9HAuTEDy+k5fYsTJA8r7RS
         7j5Q==
X-Gm-Message-State: APjAAAWh8BQgooFAG4hkLFHjh/gY0xe6XVp2Hmx6aHKAtWzh3f+x5t9S
        7cGV3JhQInApECNwULrvZooC7Zm1EltvlLDw7NOhA2wwIMGqvigKBA30KrhNDADGXQBIUMMojAN
        F7Iq2sa2z4+rejw0Qenpj0X16
X-Received: by 2002:adf:fa90:: with SMTP id h16mr318630wrr.52.1569257594019;
        Mon, 23 Sep 2019 09:53:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1PrWGqSyv7BcQdJ7ID5JNf9nVJ2P4hXs/A2fRvAbEoPTgV55p280V+DXD5wa0V1ZMbivjFQ==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr318609wrr.52.1569257593797;
        Mon, 23 Sep 2019 09:53:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id b22sm12176606wmj.36.2019.09.23.09.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:53:13 -0700 (PDT)
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-16-aarcange@redhat.com>
 <87o8zb8ik1.fsf@vitty.brq.redhat.com>
 <20190923163746.GE18195@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <24dc5c23-eed8-22db-fd15-5a165a67e747@redhat.com>
Date:   Mon, 23 Sep 2019 18:53:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923163746.GE18195@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/19 18:37, Sean Christopherson wrote:
>> Would it be too much if we get rid of
>> kvm_vmx_exit_handlers completely replacing this code with one switch()?
> Hmm, that'd require redirects for nVMX functions since they are set at
> runtime.  That isn't necessarily a bad thing.  The approach could also be
> used if Paolo's idea of making kvm_vmx_max_exit_handlers const allows the
> compiler to avoid retpoline.

But aren't switch statements also retpolin-ized if they use a jump table?

Paolo
