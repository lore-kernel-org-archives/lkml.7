Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F44C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB83E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfHMHzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:55:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44610 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfHMHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:55:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so106827365wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bVL/mybMCWMTdXy3Ie2SVHe4c9Hx4KouLy8pC3F5wcA=;
        b=hAK7zL821iynuQSb+lAa+e2pDafH8gUxec4qgsp1sVfvHM57dWwOjMG8PFr+GynIdR
         NRPZs5NKk7nVwsdM+/3IeDKDJbDmW9iYG0W9iaUIfYl2LCCy5MXLvxaD8lbr8gZKEkot
         CXeNPWmui6S8sYuyd0QmWV4dETeXKsVXdXx9azYngksUHC0Uzx4lnO3AXQJ2ONdh1iHV
         eXInucOpfqArHdiZoqAfsEfdVbi1k7pBmbllE1bAyScFC3rnF0GA+Vq07JQU8iGid8jr
         X9mYOF45EFJKN/MvFQb96pMdqjyyNPtpqeNkPGV+hNCDVHIwiITEzWmaldI9neyIlOCh
         vu8g==
X-Gm-Message-State: APjAAAUB31NJoIheabOK7AC098RjtGS5pYNHLrDkvgYCsr/OnSeYKK+O
        WTC3pYZSyOsAH9iadD7Cgl3lUw==
X-Google-Smtp-Source: APXvYqwivA9E8nT6UWemqH28l7RGEjlSIsZbiQntGdA8wDZDm20vpIV9sc9NrxcWYynUjGx7YH+s4g==
X-Received: by 2002:a5d:62c1:: with SMTP id o1mr44926663wrv.293.1565682920051;
        Tue, 13 Aug 2019 00:55:20 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id c11sm2771923wrs.86.2019.08.13.00.55.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 00:55:19 -0700 (PDT)
Subject: Re: [PATCH] cpuidle-haltpoll: Enable kvm guest polling when dedicated
 physical CPUs are available
To:     Wanpeng Li <kernellwp@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <1564643196-7797-1-git-send-email-wanpengli@tencent.com>
 <7b1e3025-f513-7068-32ac-4830d67b65ac@intel.com>
 <c3fe182f-627f-88ad-cb4d-a4189202b438@redhat.com>
 <20190803202058.GA9316@amt.cnet>
 <CANRm+CwtHBOVWFcn+6Z3Ds7dEcNL2JP+b6hLRS=oeUW98A24MQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b33a432f-b6a5-e9e8-a744-f29c21c69fd8@redhat.com>
Date:   Tue, 13 Aug 2019 09:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CwtHBOVWFcn+6Z3Ds7dEcNL2JP+b6hLRS=oeUW98A24MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/19 02:55, Wanpeng Li wrote:
>> I think KVM_HINTS_REALTIME is being abused somewhat.
>> It has no clear meaning and used in different locations
>> for different purposes.
> 
> Now it disables pv queued spinlock, pv tlb shootdown, pv sched yield
> which are not expected present in vCPUs are never preempted for an
> unlimited time scenario.

Guest side polling definitely matches the purpose of KVM_HINTS_REALTIME.
 While host-side polling is conditional on single_task_running, this is
obviously not true of guest-side polling.

The alternative would be to enable it only if KVM_FEATURE_POLL_CONTROL
is available, but I prefer Wanpeng's patch.

Paolo

>> For example, i think that using pv queued spinlocks and
>> haltpoll is a desired scenario, which the patch below disallows.
> 
> So even if dedicated pCPU is available, pv queued spinlocks should
> still be chose if something like vhost-kthreads are used instead of
> DPDK/vhost-user. kvm adaptive halt-polling will compete with
> vhost-kthreads, however, poll in guest unaware other runnable tasks in
> the host which will defeat vhost-kthreads.
> 
> Regards,
> Wanpeng Li
> 

