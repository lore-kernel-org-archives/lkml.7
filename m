Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B94C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D2D20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409679AbfIXNzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 09:55:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409666AbfIXNzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:55:42 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FD68859FB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 13:55:42 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id z8so604116wrs.14
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 06:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OsafvY49lv+IdkcQBZiY+1pyMhsITwm284eCfBsvG3Q=;
        b=m00t2uTPLRNJXCJCdM1mABBqwRrPnyNXe2vuBMt8wdZ/GVqSFl4Aq9Id/opLvWujZi
         CYWDU+qH5oMP9mBr9LxQmyV2RzLbs6QG5NfmTC3Qon5Y5OqrLWlA9VRqHAOsDXD9x+tu
         jOVeYFxKQ9b8xMhE+SY3119OF1pop82uwKNzUIl0mCxeMecvBaK6dk6x87/GFJ2XrL58
         RqkzeHGN10CUy2fcZtSV3ZwRlGiHSfBMdShqj5SVrbQmvAUaITf1zpduFUf7fAPutGVa
         J3j+oB78Y9ShAkm6ro4Z68iHonui8tiqLoIt9PdCNOg5xejfCcGqqAQVL+IRpOmaWqu5
         NFfQ==
X-Gm-Message-State: APjAAAXn3PaJvJvs3eWJSZnYI1GS+DRdDGOYSH6JthYNPnw2QL78LX+B
        0UzRjzc411A5tfl0IkE243WKeHqo6jTVGSxnrGsvGFl74Ic7LD3nbxaw9zW1lZ47QIG+CVOjAOS
        kREiJVXPW889CT9U+y+sR7KLD
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr2412465wrx.156.1569333340906;
        Tue, 24 Sep 2019 06:55:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwg4Zkq5DqRbVkfGA29BmZtf2KR4d9hVorp2wEdWQ5fXNb3WiB0tDW4Xw1GTkf7h7ZkJFH54w==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr2412442wrx.156.1569333340651;
        Tue, 24 Sep 2019 06:55:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id s1sm4225070wrg.80.2019.09.24.06.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:55:39 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] KVM: X86: Fix userspace set broken combinations of
 CPUID and CR4
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org
References: <1568708186-20260-1-git-send-email-wanpengli@tencent.com>
 <1568708186-20260-2-git-send-email-wanpengli@tencent.com>
 <20190917173258.GB2876@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0c35f21-b262-2c4e-9109-4ab803487705@redhat.com>
Date:   Tue, 24 Sep 2019 15:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917173258.GB2876@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/19 19:32, Sean Christopherson wrote:
> 
> Paolo, can you provide an "official" ruling on how KVM_SET_SREGS should
> interact with reserved bits?  It's not at all clear from the git history
> if skipping the checks was intentional or an oversight.

It's okay to make it fail as long as KVM already checks the value of the
reserved bits on vmexit.  If not, some care might be required.

Paolo
