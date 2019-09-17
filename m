Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A11AC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB052171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfIQOHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfIQOHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:07:21 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43A8EC05168C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 14:07:20 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f11so1349645wrt.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 07:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jS+ZWi+aIzVL4RGXZzRns8oVj2lE4iWxT+LDZNVf+Zo=;
        b=Ytfc8Xt2yeggPe0qEcD+pg+Lmkhx4ISHnq/T4U4f7zSdyQgBKrddwojaXiuCslW45G
         K9tunQXEgK4K+gm/LymfrR0nQjJ2n+mkyK2RnQNmjRy1cqURQnJl05ewpaAvml1lo60M
         s3IjohdFMWi5D8J5lC/kYEk8lc7j1wQO/sua6/MHB2iuipz22W1VKSAEJgc6Ya4vM+yN
         B0Dy6qSh2+IeozJRoU/v1IV0+qx4774nMZ2S86wXH/LFawNFUX6TBpo3Za3GOXEBTXDA
         7ZSwjEbZqoGKFSjn8RjmEawUMaHtYeTJiuTj0tf+7QrbgWUSKvJmgMQvdzsZ4tGBPuh3
         CJIw==
X-Gm-Message-State: APjAAAXn5BdhuAshg6F3cgqIVeW8qz0siGU8XdvbLZKPy5ZdpP2573te
        u2QnqbsKdyPok1tu/BZJHAUtQR8Jq7CfTiXJX4yN8ZcjM6OLbVnwzUl0uXFDYzCsJWBPeR8ROhd
        4LNMXAhVrOaFC+78AWUm+11I1
X-Received: by 2002:a5d:5403:: with SMTP id g3mr3107317wrv.338.1568729238785;
        Tue, 17 Sep 2019 07:07:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8uoge2CoGr9jKjogtJP8t5aSiNDgVit1M/+Wy752+dibN7SEQXSGxTmF3SRmYokSmnGgUoQ==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr3107294wrv.338.1568729238531;
        Tue, 17 Sep 2019 07:07:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id h17sm4148586wme.6.2019.09.17.07.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 07:07:17 -0700 (PDT)
Subject: Re: [PATCH 1/3] cpu/SMT: create and export cpu_smt_possible()
To:     Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
References: <20190916162258.6528-1-vkuznets@redhat.com>
 <20190916162258.6528-2-vkuznets@redhat.com>
 <CALMp9eQP7Dup+mMuAiShNtH754R_Wwuvf63hezygh3TGR=a9rg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4704aac9-cac2-f04d-8344-6642432c31e2@redhat.com>
Date:   Tue, 17 Sep 2019 16:07:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQP7Dup+mMuAiShNtH754R_Wwuvf63hezygh3TGR=a9rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/19 19:16, Jim Mattson wrote:
>> KVM needs to know if SMT is theoretically possible, this means it is
>> supported and not forcefully disabled ('nosmt=force'). Create and
>> export cpu_smt_possible() answering this question.
> It seems to me that KVM really just wants to know if the scheduler can
> be trusted to avoid violating the invariant expressed by the Hyper-V
> enlightenment, NoNonArchitecturalCoreSharing. It is possible to do
> that even when SMT is enabled, if the scheduler is core-aware.
> Wouldn't it be better to implement a scheduler API that told you
> exactly what you wanted to know, rather than trying to infer the
> answer from various breadcrumbs?

Yes, however that scheduler API could also rely on something like
cpu_smt_possible(), at least in the case where core scheduling is not
active, so this is still a step in the right direction.

Paolo
