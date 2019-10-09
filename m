Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C59DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE952133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIL1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbfJIL1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:27:46 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5DB781F11
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 11:27:45 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id i2so990174wrv.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 04:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ifVLEC5uXx0xXbZ5E3zE7qcYovO4iLtIeSopENFKhCg=;
        b=cBweikkdYNjeYI88z0rK4A2iP6QquUN1y0bRocm9E6X3eAiYtvdU9ExFsySCHCS+nE
         TZUh+vKWNzRKtZaKPdQQj59D30YkAqs/Zlpra7POdf1We5hRVFcod2qO00BTEoSEqQMX
         GyXDEMwOlPO0tVGrg43EmJokXElQIamCBGx2oaEdiR9jD8mXQpm6cLQ2sJGWAn8Plmhc
         ZOEmYl426Gh5QBop8atCyXbVRpok4aJu1854+rKLKwFg7tNd3m1HCZW5Ooz/HvvbjL9l
         r9e6yXJXnw6f/JnOvoJ9JSPOLqnOMbEV4auvxYrPXD9VjkABe7/X7N2LN/y/KVtt7KUS
         lV9w==
X-Gm-Message-State: APjAAAXHC36gSNQPh/x9W21d8F2hWA9n6OQ58htN42DRhboWjU/IOnVt
        KTl+ztJFSzYD+W0N+wEhVw5Jf6zHrnZ8hJtM9OuZAu1hi2z9dDMvuE127P805Gf6dlOKpJ8Fhv/
        wCjnEO/8gEkHquyetaX6PFttw
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr2242549wmd.176.1570620464528;
        Wed, 09 Oct 2019 04:27:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzhbHq0jBzIpVmXjFywxZ2l55Q3tKca7gUZJ83WF4NOur5t8DDjUN50FdCbtP55IeTz4hoFmQ==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr2242532wmd.176.1570620464298;
        Wed, 09 Oct 2019 04:27:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h10sm1982665wrq.95.2019.10.09.04.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 04:27:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 6/8] KVM: x86: Fold 'enum kvm_ex_reg' definitions into 'enum kvm_reg'
In-Reply-To: <57cae37d-acd0-074c-26cd-aaf7a7989905@redhat.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com> <20190927214523.3376-7-sean.j.christopherson@intel.com> <87ftke3zll.fsf@vitty.brq.redhat.com> <57cae37d-acd0-074c-26cd-aaf7a7989905@redhat.com>
Date:   Wed, 09 Oct 2019 13:27:42 +0200
Message-ID: <87a7aayx8x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/09/19 11:25, Vitaly Kuznetsov wrote:
>>> -enum kvm_reg_ex {
>>>  	VCPU_EXREG_PDPTR = NR_VCPU_REGS,
>> (Personally, I would've changed that to NR_VCPU_REGS + 1)
>> 
>
> Why?
>

Just so every entry in the enum is different and NR_VCPU_REGS acts as a
guardian.

-- 
Vitaly
