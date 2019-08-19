Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA78AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D5920651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfHSPPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:15:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33505 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfHSPPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:15:00 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4A6A8125C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:14:59 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f9so5401663wrq.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7SoejRWRuHJ6BGslNq0HYAXwiWp4/65kEvpnkCVews=;
        b=nr8TXgPaLTNNwY2mtQCybqm8d6iqw0x3yEmEJPFifldAOOsbX00Kc5g1z0rdeXIyeU
         JcyQfZA6QiBWvq/gwQY5N7F5e5DvBSQRsVmTidHyT8JmH56fRROpkmVvvSCcowSo7DvW
         4zzrm/clpt5E/0/ij+YEPm9jhsYmiwRFqeWHkhqRABqAhE9xGBvL7T27E5n0Jls5L6rY
         1wzs4LPqLRPnQ6SFaHLEjgi1nzcxnhlcW7GzBkXuvcFfPj3r6XblFNLWfrcGjo7tK4mT
         dtkHdVcksS+OJA+l9yErdJm0ijeC0oOO3DwonESbtOZkTq8KvHw2I49UzEPRi2+uf33m
         TEyw==
X-Gm-Message-State: APjAAAWhdFkhNwGjm3GGNXyrsVLhQmEneQ2fcEtnNa+b2lLwO9rCw1tI
        fWm8wEg6dzpvBfy53NiTCFJxqSM2RJzsj8IUb4Ryu2Wkwc4CBb+Hl3+Q19jg4GQB7BelUArwr9Q
        lQSJgtyWlUwKDl0/KMPRhx0Li
X-Received: by 2002:a05:6000:4f:: with SMTP id k15mr27459824wrx.221.1566227698368;
        Mon, 19 Aug 2019 08:14:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9RZQLbX5VJkCPpbScttbojZgMXP2p2KsS260Ym4OCGfKaJxFH1bWjHnvJt9xyKMxddzVfVA==
X-Received: by 2002:a05:6000:4f:: with SMTP id k15mr27459793wrx.221.1566227698083;
        Mon, 19 Aug 2019 08:14:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id g14sm29413407wrb.38.2019.08.19.08.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:14:57 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 5/9] KVM: VMX: Add init/set/get functions for
 SPP
To:     Yang Weijiang <weijiang.yang@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        yu.c.zhang@intel.com, alazar@bitdefender.com
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-6-weijiang.yang@intel.com>
 <87a7cbapdw.fsf@vitty.brq.redhat.com>
 <20190815134329.GA11449@local-michael-cet-test>
 <CALMp9eTGXDDfVspFwFyEhagg9sdnqZqzSQhDksT0bkKzVNGSqw@mail.gmail.com>
 <20190815163844.GD27076@linux.intel.com>
 <20190816133130.GA14380@local-michael-cet-test.sh.intel.com>
 <CALMp9eRDhbxkFNqY-+GOMtfg+guafdKcCNq1OJt9UgnyFVvSGw@mail.gmail.com>
 <20190819020829.GA27450@local-michael-cet-test>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9a269d8-b410-2489-aaa3-24b487ffd1e2@redhat.com>
Date:   Mon, 19 Aug 2019 17:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819020829.GA27450@local-michael-cet-test>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/19 04:08, Yang Weijiang wrote:
>> KVM_GET_NESTED_STATE has the requested information. If
>> data.vmx.vmxon_pa is anything other than -1, then the vCPU is in VMX
>> operation. If (flags & KVM_STATE_NESTED_GUEST_MODE), then L2 is
>> active.
> Thanks Jim, I'll reference the code and make necessary change in next
> SPP patch release.

Since SPP will not be used very much in the beginning, it would be
simplest to enable it only if nested==0.

Paolo
