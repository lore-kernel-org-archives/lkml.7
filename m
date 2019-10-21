Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF883CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C46E20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfJUP2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfJUP2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:28:36 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC28059455
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 15:28:35 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z5so3271036wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HEmIeXds/Gv0xSpUczzsnAMQ34YFmWv/ybBjSlwqKDI=;
        b=uOrMMsvWOl+pO+PzPt3m0gtRZtmkEhqQ1afyb+nzWiLt/xdzQsuC+vFthUObl5mkVZ
         YCFis2nzA3jHNSn4Y65rxDp7JtT7h8dpyO971LmnnabFztl3h3VuhO4Jzwr9nNAMbz0W
         104et9R8rMwwl9UUcd+2eINh38ih66PHTfSPbXriUvP+IZIfLRkuxS3kQPVN6DKPUBi4
         e8Am9ieVWlWIV/R11K2b5Du1j0jORzVxtoi0DQ1TTpCSzeBZbauOZfvOzHtIwz5O2opi
         v+JLX+iDEA7keYPI7O8SMrKhVXdIu+F78Ly8xMYhQLgGRPOB/oOGaHmoVnTfTugjVNL2
         E9uA==
X-Gm-Message-State: APjAAAWeyPi44NS75BRMS6m/KUya50RD4vIPDM9O3Ez/CFUSsCLBTSVL
        mi1JJfsZuYagZwj8PAMkykwflcuYQOM41x2n9qLdBonp0Ogq/lY0JgKc4WtKfPZUMoombm40EZ1
        NU0EliOA1/Y4prC58WL5pZSPD
X-Received: by 2002:adf:fcd1:: with SMTP id f17mr4908326wrs.82.1571671714172;
        Mon, 21 Oct 2019 08:28:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxbXQZvDtUPX3OgBdKqjnT8Xk1PJokt8PI4arS1ny3lsG5USqzk+Rt03RIBSFxDHJDa143s/g==
X-Received: by 2002:adf:fcd1:: with SMTP id f17mr4908292wrs.82.1571671713880;
        Mon, 21 Oct 2019 08:28:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:847b:6afc:17c:89dd? ([2001:b07:6468:f312:847b:6afc:17c:89dd])
        by smtp.gmail.com with ESMTPSA id a2sm2635979wrv.39.2019.10.21.08.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 08:28:33 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] KVM: x86/vPMU: Add lazy mechanism to release
 perf_event per vPMC
To:     Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org
Cc:     peterz@infradead.org, Jim Mattson <jmattson@google.com>,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ak@linux.intel.com, wei.w.wang@intel.com, kan.liang@intel.com,
        like.xu@intel.com, ehankland@google.com, arbel.moshe@oracle.com,
        linux-kernel@vger.kernel.org
References: <20191013091533.12971-1-like.xu@linux.intel.com>
 <20191013091533.12971-5-like.xu@linux.intel.com>
 <5eb638a3-5ebe-219a-c975-19808ab702b9@redhat.com>
 <c2979d05-4536-e3b5-e2f6-3e6740c1a82d@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2175c2cd-2c1e-22e8-2f67-3fc334ef2a40@redhat.com>
Date:   Mon, 21 Oct 2019 17:28:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c2979d05-4536-e3b5-e2f6-3e6740c1a82d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/19 16:04, Like Xu wrote:
> 
>>
>> 2) introduce a new callback msr_idx_to_pmc that returns a struct
>> kvm_pmc*, and change kvm_pmu_is_valid_msr to do
> 
> For callback msr_idx_to_pmc,
> how do we deal with the input 'MSR_CORE_PERF_FIXED_CTR_CTRL'
> which may return several fixed kvm_pmcs not just one?

For RDMSR, do not do anything.  For WRMSR, you can handle it in the
set_msr callback.

>>
>> static int kvm_pmu_mark_pmc_in_use(struct kvm_vcpu *vcpu, u32 msr)
> 
> s/static int/static void/.
> 
>> {
>>     struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>     struct kvm_pmc *pmc = kvm_x86_ops->pmu_ops->msr_idx_to_pmc(vcpu, msr);
> 
> We need 'if(pmc)' here.

Agreed, sorry for the sloppiness.  Never interpret my suggestions as
more than pseudocode. :)

Paolo
