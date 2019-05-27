Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C2DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E11D20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfE0LyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:54:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36800 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfE0LyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:54:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id v22so8315505wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 04:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5EOrlyjnRiB+y/WPq9w3g8tKXEcoSy+dzLfiTqoBtI=;
        b=UMinhSBQx1G26e6WT/gYwoMMJTV04LKtrNc+ZelA7KI5MBIBbNH+V+qWBwLj0mNnLd
         pDi1LnLQ2Vhk/7eYL6MnV55ue2wIRNYq19g9BbZrRvIATWCvihrvR7UaB7ixi1H5ZJD/
         yGUiMx0U854rlVmeU2tCv8lV17ntpxmTj9y0wvnIJal/fyrTMYwrVbbCF2E2pSx9M808
         cHB4T6Fd9kolRRQovkw9qurC4fxcuOPo9UPrAI3j1fqo5rNRl1eKdLUXtiMtFwtiufat
         koENfqdQpTH3/ZQ2dRdOOeIbS626q4+yQhGZELizGd2ajkjgyTR02T8WhkUKSKz26HBD
         bkwg==
X-Gm-Message-State: APjAAAU8IxrKRZM+UZyaUJcaEQXkN5SpHxTNnonZGOMGHbaImTd7eOAA
        L8wSl3Rsp9mpaN1jECuhFAQiqA==
X-Google-Smtp-Source: APXvYqxzDiEzyVy1UAaifd36atFjeFl7M914KMNNS1XYii7hm0Pb5j9z4gdY0m8pSq5ybhyLSkyCVA==
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr8825437wmh.148.1558958041069;
        Mon, 27 May 2019 04:54:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c43e:46a8:e962:cee8? ([2001:b07:6468:f312:c43e:46a8:e962:cee8])
        by smtp.gmail.com with ESMTPSA id 16sm9799263wmx.45.2019.05.27.04.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 04:54:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] KVM: X86: Implement PV sched yield hypercall
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1558953255-9432-1-git-send-email-wanpengli@tencent.com>
 <1558953255-9432-3-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b8525d8-e26b-e4df-508d-b6a4d9c06a76@redhat.com>
Date:   Mon, 27 May 2019 13:53:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558953255-9432-3-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/19 12:34, Wanpeng Li wrote:
> +	rcu_read_lock();
> +	map = rcu_dereference(kvm->arch.apic_map);
> +	target = map->phys_map[dest_id]->vcpu;
> +	rcu_read_unlock();
> +
> +	kvm_vcpu_yield_to(target);

This needs to check that map->phys_map[dest_id] is not NULL.

Paolo
