Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A3FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC86C21907
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfIQN3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:29:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfIQN3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:29:08 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EEF9C0546FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:29:08 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id c1so1314269wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXZxLZytW+Ec/U9NfhKAd9rWSe67nelrhj6Ad5wzBvs=;
        b=ojwo29XWCv2GtpRchFPpeeTT1USV4Pgs4c7W716cyQMazIHo6+8vhP/0IPFXLhoynU
         PmcsjWmErfaJFXC06DMSZZH0EBEEfV8csLChRnRuIl5YTBTAiTIfx5lOtV9IdjmM5+S8
         vzJ761yzuO9LK1UzoNhInvMhieC/fWFvWACyiGcwI/oMid25tsdJjPgAroMusyIlCOv+
         6UHxPgSwKUpFtEU0O3QRDVqBAOWB2U+Df23IPMjhwq5vSkkFjzxNxBk+k3liGOYn15wa
         yf26op+Ct9OMlKbY9oX1GyB27rXDk/wYmqCS7cCb7fHGdODM7wm8ktjAoA8Ck1UKMiR0
         fbxg==
X-Gm-Message-State: APjAAAWH5BZJ3gBcz3G9QOLG86BYobT4zzLBzlZFSh1yY4BwzmMHMVjG
        RwtQB7cGKxfHKLlN9g1tDZIiG9WrJyDDz6UWL1UoScEBiQwxYycL/8ncAIO/Ee2HH8e+GwVqVLF
        rRStFKkHcre/WTuAnmbjPD2Op
X-Received: by 2002:a1c:4946:: with SMTP id w67mr3573289wma.131.1568726946867;
        Tue, 17 Sep 2019 06:29:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyIy0o7GrSTEkbKwkS26Ko7u9M1cTVfp1PjWUa88+L9asfsPPlC0NJZ3Q0qF7wNbJLTo5g/Ug==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr3573269wma.131.1568726946641;
        Tue, 17 Sep 2019 06:29:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id y186sm4478852wmb.41.2019.09.17.06.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:29:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] KVM: x86: don't announce
 KVM_CAP_HYPERV_ENLIGHTENED_VMCS when it is unavailable
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
References: <20190828075905.24744-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0f3650ef-6a64-b6ab-5370-92e7c4d6cce1@redhat.com>
Date:   Tue, 17 Sep 2019 15:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828075905.24744-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/19 09:59, Vitaly Kuznetsov wrote:
> It was discovered that hyperv_cpuid test now fails on AMD as it tries to
> enable KVM_CAP_HYPERV_ENLIGHTENED_VMCS which is (wrongfully) reported as
> available.
> 
> Changes since v1:
> - This is a v2 for '[PATCH 0/3] KVM: x86: fix a couple of issues with
>  Enlightened VMCS enablement' renamed as the first patch of the series
>  was already merged.
> - Added Jim's Reviewed-by: to PATCH1
> - Added missing break in PATCH2 [Jim Mattson, Sean Christopherson] 
> 
> Vitaly Kuznetsov (2):
>   KVM: x86: svm: remove unneeded nested_enable_evmcs() hook
>   KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS support only when
>     it is available
> 
>  arch/x86/kvm/svm.c | 9 +--------
>  arch/x86/kvm/x86.c | 4 +++-
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 

Queued, thanks.

Paolo
