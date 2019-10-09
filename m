Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DCDC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2960A206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfJIIHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:07:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbfJIIHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:07:48 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C85D8666C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 08:07:48 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id l3so678166wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z0y/kaqROMSQwixPGrDGFO1uNp0GzEL3EiMZkT03d78=;
        b=IpAf0hLPXVzj9PURdQSEcsRRQmWYmBnwqKKpZL2WgVF4emVFt/Owtqzbr+t7WBskDm
         0bQqIgjnQyc4GbcnUpY6KKQGigOui5Q2HF8ZSkaa/mde6lckRh40de1m6IfePTtcZZSJ
         wM7uTqjxkA+YXGe4GChmLbvcu1CdkhmbT5LoqkdiBqEZaXDv+bb/5xVNNn8SoUgODmdG
         HyHsRsIo3A6j0U5jejJoJw2wrun+tAA9TfJ9Di5gj3ffhYMulhmsuhLWhqSACWkybRz9
         AuCxMM7/461V5Rk2WP/8l3YiWCfo4rsWJMch9eFDLdNoMQgX8fCAzik9SjsmRif8MYS/
         ADDg==
X-Gm-Message-State: APjAAAUkBNpBPEoDStNhrq7xlU2eotYahIqvilH6/61qbzH7PS57wY0z
        57JgytQjxoG0+bIy6YiwJ8NmMBrh6SLZffd5FCUeGsElt21LZYZzuHUCmgM08Toi8+WZoL8yevM
        AP9ern1Go9yMDBIhCqtDOY1Nq
X-Received: by 2002:a05:6000:11c7:: with SMTP id i7mr1777958wrx.231.1570608467034;
        Wed, 09 Oct 2019 01:07:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/eHrg0/wcEpQE6iKLjzqO5LVj8GZku3C/nkYgSAPsWhpBLDl4gU2YAKzvz9fKLln3dIXYBA==
X-Received: by 2002:a05:6000:11c7:: with SMTP id i7mr1777945wrx.231.1570608466817;
        Wed, 09 Oct 2019 01:07:46 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id e15sm1410502wrt.94.2019.10.09.01.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:07:46 -0700 (PDT)
Subject: Re: [PATCH 0/3] selftests: kvm: improvements to VMX support check
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
References: <20191008194338.24159-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e331c1a7-b102-956c-9f26-170966872ff2@redhat.com>
Date:   Wed, 9 Oct 2019 10:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008194338.24159-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/19 21:43, Vitaly Kuznetsov wrote:
> vmx_dirty_log_test fails on AMD and this is no surprise as it is VMX
> specific. Consolidate checks from other VMX tests into a library routine
> and add a check to skip the test when !VMX.
> 
> Vitaly Kuznetsov (3):
>   selftests: kvm: vmx_set_nested_state_test: don't check for VMX support
>     twice
>   selftests: kvm: consolidate VMX support checks
>   selftests: kvm: vmx_dirty_log_test: skip the test when VMX is not
>     supported
> 
>  tools/testing/selftests/kvm/include/x86_64/vmx.h    |  2 ++
>  tools/testing/selftests/kvm/lib/x86_64/vmx.c        | 10 ++++++++++
>  .../kvm/x86_64/vmx_close_while_nested_test.c        |  6 +-----
>  .../selftests/kvm/x86_64/vmx_dirty_log_test.c       |  2 ++
>  .../kvm/x86_64/vmx_set_nested_state_test.c          | 13 ++-----------
>  .../selftests/kvm/x86_64/vmx_tsc_adjust_test.c      |  6 +-----
>  6 files changed, 18 insertions(+), 21 deletions(-)
> 

Queued, thanks.

Paolo
