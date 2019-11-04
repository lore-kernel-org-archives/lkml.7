Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C57CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BB021D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfKDLSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:18:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKDLSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:18:14 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5112C057EC0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2019 11:18:13 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id e25so10296893wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 03:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tjh9olQgahzwzj0M0Iuuf9b2PFhQNU5RKbl2/F2MSnE=;
        b=pqiJYEkFKFd4ksLHNSKJ3oBZOstJ083YSaJCCaydlKXxCtixQ8szE8J8XGL6wg49M2
         D31ZS/2iVFyGwXrW81/01DfbL5mPrdrPshesT+ICR34dnr57RNw1vfDiwVjbddFZyJ5S
         nciBKi2+zH4TRLQpwV+aG60uxBz0RiJMYTQ4eFVOgboWz8QXm/6rzIF+1+4PFRgMxeU2
         BdF6pPhXWwe3nkQC4wXPrM5Fry8yVEfxrwq5Up33+3NrUkN4GJLSGv7JYj3eRJITjUZP
         H8LiSylgbiRP2PftUSDBQWCIEjSixIQ+hDruwWPc+h+V/lRonec1aA5QgoHaxScTzAEO
         5wxw==
X-Gm-Message-State: APjAAAXXuF2/nNk3BZl7S13v+e1pQy6Efm4/J3bp6S145+SPLNZtYKmw
        qFS5UzZIERHHoFNm7sU0E3m5YYpzOH5JHVy9ZKr5HZf8h7gCGffcP0wPDKgx/iIQMbiacZ7Q9H8
        zXB9pG1TQXwnSVqVis6PvjWwC
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr21333532wme.118.1572866292237;
        Mon, 04 Nov 2019 03:18:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7tIFTFPZwnaW75wp0LpGbyQrIIz5Dg2nZLh2pakGkHJ7adbfMTbGN+0kwlhpqk4p3mdOSdA==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr21333495wme.118.1572866291895;
        Mon, 04 Nov 2019 03:18:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id q9sm9962059wru.83.2019.11.04.03.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 03:18:11 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: Fix rcu splat if vm creation fails
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1572848879-21011-1-git-send-email-wanpengli@tencent.com>
 <1572848879-21011-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c32d632b-8fb0-f7c6-4937-07c30769b924@redhat.com>
Date:   Mon, 4 Nov 2019 12:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572848879-21011-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 07:27, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Reported by syzkaller:
> 
>    =============================
>    WARNING: suspicious RCU usage
>    -----------------------------
>    ./include/linux/kvm_host.h:536 suspicious rcu_dereference_check() usage!
>    
>    other info that might help us debug this:
> 
>    rcu_scheduler_active = 2, debug_locks = 1
>    no locks held by repro_11/12688.
>     
>    stack backtrace:
>    Call Trace:
>     dump_stack+0x7d/0xc5
>     lockdep_rcu_suspicious+0x123/0x170
>     kvm_dev_ioctl+0x9a9/0x1260 [kvm]
>     do_vfs_ioctl+0x1a1/0xfb0
>     ksys_ioctl+0x6d/0x80
>     __x64_sys_ioctl+0x73/0xb0
>     do_syscall_64+0x108/0xaa0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Commit a97b0e773e4 (kvm: call kvm_arch_destroy_vm if vm creation fails)
> sets users_count to 1 before kvm_arch_init_vm(), however, if kvm_arch_init_vm()
> fails, we need to dec this count. Or, we can move the sets refcount after 
> kvm_arch_init_vm().

I don't understand this one, hasn't

        WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));

decreased the conut already?  With your patch the refcount would then
underflow.

Paolo
