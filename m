Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49E3CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 09:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B050120679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 09:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfKBJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 05:52:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfKBJwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 05:52:25 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0297C057EC6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2019 09:52:24 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f16so6711517wrr.16
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 02:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/01Bc12yc4dFzpfMPeRY3Tp+1jvvcBFHG+c/3yZA0A=;
        b=lIxunjpIXSkYgwPC6vKGOr6XjkZkRZeLgE5qYO6LqWXxoP2MNFbwinKQK8dw8pImk5
         KFQf2xF/uw1iE/Sc7pNPnqzfTNM2hNLYdOvNpgpb3dIrx+9zYHqNBQxDhSC/nCCLvljq
         taWWL02bwvoBpfZRnyfJkjLc0OJBHoB8v0sR9FghfPFfqTqYdJrW0VotT+lJiVm451Y3
         CTghe1eihYMqTU1qFShR5xT+ZWNrtcYCPVWv7qbGnswERcFl9YDP1u01oD7h9YavGv+n
         5EmNEFjOkKUBFHFgyEYX3KkNGOjJ/H0dkcAwJQefnysYcGC08CBjyH4x5/D91v4Q63RM
         EOew==
X-Gm-Message-State: APjAAAVd5dOCWNg80EJFQZaqq2OczAGBi97gS8bHHdENQKXLn72W2504
        J2Z84T7WHZTWbJCJt4B4pRfml76WLyL1TDosTb1Wf3zrrF2eX4h4zild7+05277NMXjvveYBi0v
        JOCaRk1cWl3gYeAwOrd+uBstr
X-Received: by 2002:adf:e68d:: with SMTP id r13mr425101wrm.199.1572688343384;
        Sat, 02 Nov 2019 02:52:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3jFXU/yGP5yI10K0bB6F8iYk1FMrXQRZ/stfqg4P515gLuLmlCIWV4lGs39kqoD5VBL6RwA==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr425079wrm.199.1572688343050;
        Sat, 02 Nov 2019 02:52:23 -0700 (PDT)
Received: from [192.168.42.35] (mob-31-159-163-247.net.vodafone.it. [31.159.163.247])
        by smtp.gmail.com with ESMTPSA id y2sm10531537wmy.2.2019.11.02.02.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 02:52:22 -0700 (PDT)
Subject: Re: [PATCH v4 04/17] kvm: x86: Add support for activate/de-activate
 APICv at runtime
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
 <1572648072-84536-5-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c83eb23c-2d4f-fd22-ed9f-d4eeffa8bcd6@redhat.com>
Date:   Sat, 2 Nov 2019 10:52:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572648072-84536-5-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/19 23:41, Suthikulpanit, Suravee wrote:
> +void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
> +{
> +	if (activate) {
> +		if (!test_and_clear_bit(bit, &kvm->arch.apicv_deact_msk) ||
> +		    !kvm_apicv_activated(kvm))
> +			return;
> +	} else {
> +		if (test_and_set_bit(bit, &kvm->arch.apicv_deact_msk) ||
> +		    kvm_apicv_activated(kvm))
> +			return;
> +	}
> +
> +	kvm_make_all_cpus_request(kvm, KVM_REQ_APICV_UPDATE);
> +}
> +EXPORT_SYMBOL_GPL(kvm_request_apicv_update);
> +

It's worth documenting the locking requirements of
kvm_request_apicv_update (it can also be negative requirements, such as
"don't hold any lock"), because kvm_make_all_cpus_request is a somewhat
deadlock-prone API.

Again, something I'll check after a more thorough review.

Paolo
