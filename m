Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDCCCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F7920679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 09:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKBJ5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 05:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfKBJ5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 05:57:55 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95030882FF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2019 09:57:54 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id g17so2368954wru.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 02:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SnHbm5y0Oc/bW/z1BoC7Pi238VT3ZqMdoywC0g3dFqE=;
        b=dg7P3We6hGYJwugltIvnZKs8tlq4B002znv++46QsKGsNwz4VARUoLQtwqAEZvmbZM
         Pxy51QFnafvoKmIehACZk8sktmYFD7QQ7nzwKdfdRmYjPwFMLbq3OAq5Wldx7cvKsf+9
         gybY255rRfA6Ua0WM6dPCI7dBEi6M6GHhINdgCtJO17tN4ZADYPCLYVR1kfdq/bs348Z
         cb8xygC+E0L1HiTAUQB4jwC3+M+x0bSyRr+wXp3o3g/mBHL7lRXydFIC4WzghavGfMrV
         AOOP20V7gU9kOzBHrg8pdwy6wmOWLMITdwuFm8ka5vMlRNNG+DuNMS43XfB+isuqHKzC
         jv7Q==
X-Gm-Message-State: APjAAAWFO6IJalsbQsiyLySP3fgIZsygwPiUb7v5erX2k/msTSZ7ACUr
        iiKGLCxVSrmuQD+skthhCnHwN3qQ66vr24v+/MxqyVBQbZM4fGgIBGt/fcZpTXdmlzXB5Oufx28
        eHdP8uLH9xMXD4b+LhMAG9+2L
X-Received: by 2002:a1c:30b:: with SMTP id 11mr13328562wmd.171.1572688673229;
        Sat, 02 Nov 2019 02:57:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMtBcN4tvFrgKHDyWSQtioXzaXI4x0h0y0bnWOcsBB94u0qohWSD5sllxyRxSFBaO4a4+hVw==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr13328541wmd.171.1572688672941;
        Sat, 02 Nov 2019 02:57:52 -0700 (PDT)
Received: from [192.168.42.35] (mob-31-159-163-247.net.vodafone.it. [31.159.163.247])
        by smtp.gmail.com with ESMTPSA id l14sm10780581wrr.37.2019.11.02.02.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 02:57:52 -0700 (PDT)
Subject: Re: [PATCH v4 13/17] kvm: i8254: Deactivate APICv when using
 in-kernel PIT re-injection mode.
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rkagan@virtuozzo.com" <rkagan@virtuozzo.com>,
        "graf@amazon.com" <graf@amazon.com>,
        "jschoenh@amazon.de" <jschoenh@amazon.de>,
        "karahmed@amazon.de" <karahmed@amazon.de>,
        "rimasluk@amazon.com" <rimasluk@amazon.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
References: <1572648072-84536-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1572648072-84536-14-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <70fb2b49-2198-bde4-a38b-f37bc8bc9847@redhat.com>
Date:   Sat, 2 Nov 2019 10:57:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572648072-84536-14-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/19 23:41, Suthikulpanit, Suravee wrote:
> +	/*
> +	 * AMD SVM AVIC accelerates EOI write and does not trap.
> +	 * This cause in-kernel PIT re-inject mode to fail
> +	 * since it checks ps->irq_ack before kvm_set_irq()
> +	 * and relies on the ack notifier to timely queue
> +	 * the pt->worker work iterm and reinject the missed tick.
> +	 * So, deactivate APICv when PIT is in reinject mode.
> +	 */
>  	if (reinject) {
> +		kvm_request_apicv_update(kvm, false, APICV_DEACT_BIT_PIT_REINJ);
>  		/* The initial state is preserved while ps->reinject == 0. */
>  		kvm_pit_reset_reinject(pit);
>  		kvm_register_irq_ack_notifier(kvm, &ps->irq_ack_notifier);
>  		kvm_register_irq_mask_notifier(kvm, 0, &pit->mask_notifier);
>  	} else {
> +		kvm_request_apicv_update(kvm, true, APICV_DEACT_BIT_PIT_REINJ);
>  		kvm_unregister_irq_ack_notifier(kvm, &ps->irq_ack_notifier);
>  		kvm_unregister_irq_mask_notifier(kvm, 0, &pit->mask_notifier);

This is not too nice for Intel which does support (through the EOI exit
mask) APICv even if PIT reinjection active.

We can work around it by adding a global mask of inhibit reasons that
apply to the vendor, and initializing it as soon as possible in vmx.c/svm.c.

Then kvm_request_apicv_update can ignore reasons that the vendor doesn't
care about.

Paolo
