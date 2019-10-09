Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC5ECE596
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0710F2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfJIIZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:25:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIIZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:25:06 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6100C3B717
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 08:25:06 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id y18so751464wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FGjIyp+V4zvVe8nGelmZ1TCF9IV0uDpPZ4FIyT58LwQ=;
        b=WR9I+inV5bNN4kwZQ7ADlHbpa5vXe5fjapBGsNmZ1VM2TMpIisdHA/MzUs04BbSWnk
         wyhXzzGJ1Uo7yCgXwkleTLrIZEifKGjpiIYrdeIrUxoEKqAjXfzNItnMvsTvPiE3zLEg
         /lTJLcjqgEv8FeLm5Ghpzb+3ENuvQ2ilfGUF7xwHebz7UYftXaQJ9uKqij7/PzVjvdcv
         ItxYBD9sPAWr5q3zxHCB/+soPHshgVq3RsMNAalKFcZQulydBCb1ZDfLhNbf0oHmYVEJ
         uBp2RyLBDe3NJk2vO6MOdKGU0AArGdUc9rtbEVDtzK2F54b+ZgSqdxn+lLHOHX7VyUqE
         Ytlw==
X-Gm-Message-State: APjAAAUVANizcYlYLjIGvHv7zFsbueb5UU9uLyvKVQEccYtIDk0VnIS+
        FRYQllr9c5R0EXyOSs7gnvv7GjOO+Uf+XlJEUEhOxEMeCZ5GH9rLC0CTxsavVDy9XGKuEc76fFE
        q+xkjD8yWKIUvPePNv7ytpYZn
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr1738598wmc.151.1570609505003;
        Wed, 09 Oct 2019 01:25:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy//6CNNk9hUQud3U2UoX3ktP6Hte2hMVzeCR9fMVrPj3cI2AfYDQdE2xyUu9Pm90qtjWUvFg==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr1738573wmc.151.1570609504741;
        Wed, 09 Oct 2019 01:25:04 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id b12sm1168930wrt.21.2019.10.09.01.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:25:04 -0700 (PDT)
Subject: Re: [PATCH v3 06/16] kvm: x86: svm: Add support to
 activate/deactivate posted interrupts
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
 <1568401242-260374-7-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f3fc86e3-e20f-e84c-237d-d1dbcb5d60a8@redhat.com>
Date:   Wed, 9 Oct 2019 10:25:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568401242-260374-7-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/19 21:00, Suthikulpanit, Suravee wrote:
> +++ b/arch/x86/kvm/x86.c
> @@ -7198,6 +7198,9 @@ void kvm_vcpu_activate_apicv(struct kvm_vcpu *vcpu)
>  	kvm_apic_update_apicv(vcpu);
>  
>  	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
> +
> +	if (kvm_x86_ops->activate_pi_irte)
> +		kvm_x86_ops->activate_pi_irte(vcpu);
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_activate_apicv);
>  
> @@ -7212,6 +7215,8 @@ void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
>  
>  	vcpu->arch.apicv_active = false;
>  	kvm_apic_update_apicv(vcpu);
> +	if (kvm_x86_ops->deactivate_pi_irte)
> +		kvm_x86_ops->deactivate_pi_irte(vcpu);
>  	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_deactivate_apicv);

This can be done in refresh_apicv_exec_ctrl.

Paolo
