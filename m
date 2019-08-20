Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAFC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfHTGj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:39:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTGj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:39:58 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A8A42F30D8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:39:58 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id g2so204448wmk.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 23:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AEG28A+e5HQNRm3+K/rNuEWJbyCUec+vt5vla5rq9Tc=;
        b=BXyTp/5Y/3UD/1ml/4wpt4ZyYH1FAKsRKYOU1j3LSGkMHTObuFGydN7Z9pDxM+uqFZ
         4y6oxNtWzzxoQxQ0gN33uqfnirZQksw+IAqSNw7uGIMzbPK8UG84pS0tpHfESggwcMp5
         Xry/wsHowHSxBVxdVcTyWMf/kAcvMGheDUY3kPtM9L0XmW+3KzUADA4ZVkyOJL9b8bcS
         3OzOPh4VlLAdYk3ysTIMCEAUIILwtr3tk4cRGtc9WxFo5T4ECDnXjWkHSz5WbP3gRRE1
         p8nztQVicxi4ex83aakzoXbVg0knmvx2usqxsDKcqYpagxt06SSNS73JovSfSY/pEGFd
         Uwzg==
X-Gm-Message-State: APjAAAU6t7EkM6oCahC6xZn5fFOXnL4hvuN2Raq1GSvMCetfHAjJzen6
        p/bIvpnSXwFxkm4ZtxrnZRq24WidBlSJX8zXJaNS/Ds02DBtGrjbYaKZJFFJRW+uQGi2ilgARLy
        oG9FUhIjpFKpyitymXnlFZxmc
X-Received: by 2002:a1c:ef14:: with SMTP id n20mr16167960wmh.89.1566283196669;
        Mon, 19 Aug 2019 23:39:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwd4hNjvqCSuJiEt6Sxv6ofzCTMhDPqB4dqD3uD5gHwn88UwqcpABqBUFZaPI/mTCRngX9e6w==
X-Received: by 2002:a1c:ef14:: with SMTP id n20mr16167944wmh.89.1566283196317;
        Mon, 19 Aug 2019 23:39:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id a142sm13902746wme.2.2019.08.19.23.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 23:39:55 -0700 (PDT)
Subject: Re: [KVM] 323d73a8ec:
 kernel_selftests.kvm.vmx_set_nested_state_test.fail
To:     kernel test robot <rong.a.chen@intel.com>,
        Liran Alon <liran.alon@oracle.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
References: <20190820005206.GG734@shao2-debian>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <88004f6e-dbbc-e2a9-bd80-bbedb29c0d2c@redhat.com>
Date:   Tue, 20 Aug 2019 08:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820005206.GG734@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/19 02:52, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 323d73a8ecad22bf3284f11112a7cce576ade6af ("KVM: nVMX: Change KVM_STATE_NESTED_EVMCS to signal vmcs12 is copied from eVMCS")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: kernel_selftests
> with following parameters:
> 
> 	group: kselftests-01
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Patches for these are already on the list, but I'll add the Reported-by.

Paolo

> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> # selftests: kvm: vmx_set_nested_state_test
> # ==== Test Assertion Failure ====
> #   lib/kvm_util.c:1277: ret == 0
> #   pid=12810 tid=12810 - Invalid argument
> #      1	0x0000000000403624: vcpu_nested_state_set at kvm_util.c:1275
> #      2	0x0000000000401197: test_nested_state at vmx_set_nested_state_test.c:32
> #      3	0x0000000000401562: test_vmx_nested_state at vmx_set_nested_state_test.c:151
> #      4	0x000000000040100f: main at vmx_set_nested_state_test.c:283
> #      5	0x00007efdc57f409a: ?? ??:0
> #      6	0x0000000000401099: _start at ??:?
> #   KVM_SET_NESTED_STATE failed, ret: -1 errno: 22
> not ok 12 selftests: kvm: vmx_set_nested_state_test
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Rong Chen
> 

