Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0569BECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D930B206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfJIJVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:21:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbfJIJVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:21:55 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A21D33027C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 09:21:55 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id r21so432960wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3tiCUrFM7UgQAaYpJ9O5BDQtkAGta+t5JLpREvoir9o=;
        b=KGc67SWBI4esT1DG66YhK5JcQRQ6u1VTuo2DBvWoMws7LWpPWmewtqppA7C9IKlkbP
         S8sOHHhFog8V3qvGrCGDcGC6/1C/UUDwffX8SVx3Yi5o9lJqJ0TAAnJJybRTWmCasmef
         qvZFx9z5PpqGVFkK+Bie5TRkaPd+vzicCyXmpL6QlZftAuJc0As2QK2pT2DMGkXujXFh
         CWUBMsWhaCwy6aLklQhi0aHR8X8+yo4dsQ/x+2RLy1aM6Mk9tTRTuLjY4TMH96oJ3vWE
         S3ukRcMHJfATso/D8Ph++6StmyoZzBaX8Ck84zb0XbHenHQGjmNHmmA1c6+EhVxVrzGO
         tKZg==
X-Gm-Message-State: APjAAAWL6ohjJvGuoaRqC52LEAQTkKftCosb5cpyTjWdbxd7oJoJpuAc
        OHwb7rgL6XZOm6BMtlLrdkddBqWekcIu04glCMOV4/Wb1j4t1SOwbj7/gzT1bITpf0Hryslzv3O
        2vMuIA/wlmGoM9xyyMY4VQXWj
X-Received: by 2002:a5d:6383:: with SMTP id p3mr2022214wru.117.1570612913651;
        Wed, 09 Oct 2019 02:21:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyt4jidLqSxvWUpFVvEmT+Zc0ViyZ4kyo/v4ezLgFfgvWATdcGptPkPtWtKPREHv7Wr2f1eHQ==
X-Received: by 2002:a5d:6383:: with SMTP id p3mr2022201wru.117.1570612913395;
        Wed, 09 Oct 2019 02:21:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b0:55d4:57da:3527? ([2001:b07:6468:f312:f4b0:55d4:57da:3527])
        by smtp.gmail.com with ESMTPSA id 59sm2695456wrc.23.2019.10.09.02.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:21:52 -0700 (PDT)
Subject: Re: [PATCH v3 09/16] kvm: x86: hyperv: Use APICv deactivate request
 interface
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "graf@amazon.com" <graf@amazon.com>,
        "jschoenh@amazon.de" <jschoenh@amazon.de>,
        "karahmed@amazon.de" <karahmed@amazon.de>,
        "rimasluk@amazon.com" <rimasluk@amazon.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
References: <1568401242-260374-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1568401242-260374-10-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <449c5ea4-9353-1822-10e6-7b10f5a1a6f3@redhat.com>
Date:   Wed, 9 Oct 2019 11:21:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568401242-260374-10-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/19 21:01, Suthikulpanit, Suravee wrote:
> +	 *
> +	 * Since this requires updating
> +	 * APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
> +	 * also take srcu lock.

This comment is incorrect, it says you are entering a read-side critical
section to update the data structure.  It's only needed because
kvm_make_apicv_deactivate_request expects that it needs to unlock and
relock kvm->srcu.

Paolo

>  	 */
> -	kvm_vcpu_deactivate_apicv(vcpu);
> +	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
> +	kvm_make_apicv_deactivate_request(vcpu, true);
> +	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
> +

