Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CF7ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2294206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfJIJVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbfJIJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:21:49 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4261C057F2E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 09:21:48 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w2so828603wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5UOftSR0L2Uy+6rXXf5VN2VI0Ck5ZEnoLKqgZauYpms=;
        b=qOiV9rjzkx81Qv9wCoXhSR/eI/gniLsc4njacTtp9z1pl0kQVpMee6sVWP9rL+cjOA
         Kz79BVz/fZq/GUQoI/1dh2QrDsLZXhvliWokmI3WKY6gah+PCizyJLOCkNQRw8ibW4bX
         4B4aTyIDO6gtibNqXz1MyuXgifZgBgkVdlPZEGmpSSFdI/LwmVxEEVIz5nvtEcQiLfLN
         6+Dvpbx1LhzUIrNLNRuLWHFD2pgDHwJ1JjnK24q07JK9HW3eYsSBKaRT3R4LbmyrTtBG
         gglKoZDMNadw2Jp5CYwbnWJi7HBltDJYX8+YMm8mX3CS8pNaltXTLgoExYt1Y8VJuCBt
         S97Q==
X-Gm-Message-State: APjAAAWs++0uldFpIlhyii4+38L+Xw9QEO7YCS7jwqHYpYDTqChsSq1j
        t6IhFk2U6Y2fbXTMGwTgomzAphrstMM9phRxJQkKg9nPh4yGpm9pgaqC/dL61sdtx59UiIbKbb0
        x6KsyIsYCDmicEXKzOU8/16Wx
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr1925556wrn.218.1570612907378;
        Wed, 09 Oct 2019 02:21:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqym+cQGYf9CM/t0sJaislEuu5YXuJhel3/HtTY1qtUbx7ZskQ8ozBSvEmOThRKvMVcYMQinBA==
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr1925540wrn.218.1570612907109;
        Wed, 09 Oct 2019 02:21:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b0:55d4:57da:3527? ([2001:b07:6468:f312:f4b0:55d4:57da:3527])
        by smtp.gmail.com with ESMTPSA id w9sm3231973wrt.62.2019.10.09.02.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:21:46 -0700 (PDT)
Subject: Re: [PATCH v3 15/16] kvm: x86: ioapic: Lazy update IOAPIC EOI
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
 <1568401242-260374-16-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3771e33d-365b-c214-3d40-bca67c2fa841@redhat.com>
Date:   Wed, 9 Oct 2019 11:21:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568401242-260374-16-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/19 21:01, Suthikulpanit, Suravee wrote:
>  	/*
> +	 * In case APICv accelerate EOI write and do not trap,
> +	 * in-kernel IOAPIC will not be able to receive the EOI.
> +	 * In this case, we do lazy update of the pending EOI when
> +	 * trying to set IOAPIC irq.
> +	 */
> +	if (kvm_apicv_eoi_accelerate(ioapic->kvm, edge))
> +		ioapic_lazy_update_eoi(ioapic, irq);
> +

This is okay for the RTC, and in fact I suggest that you make it work
like this even for Intel.  This will get rid of kvm_apicv_eoi_accelerate
and be nicer overall.

However, it cannot work for the in-kernel PIT, because it is currently
checking ps->irq_ack before kvm_set_irq.  Unfortunately, the in-kernel
PIT is relying on the ack notifier to timely queue the pt->worker work
item and reinject the missed tick.

Thus, you cannot enable APICv if ps->reinject is true.

Perhaps you can make kvm->arch.apicv_state a disabled counter?  Then
Hyper-V can increment it when enabled, PIT can increment it when
ps->reinject becomes true and decrement it when it becomes false;
finally, svm.c can increment it when an SVM guest is launched and
increment/decrement it around ExtINT handling?

(This conflicts with some of the suggestions I made earlier, which
implied the existence of apicv_state, but everything should if anything
become easier).

Paolo
