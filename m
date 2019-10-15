Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3EAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90422064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfJOO1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732050AbfJOO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:27:24 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D887B757CC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:27:23 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m6so5593512wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QdGQKq4j2J4HVHgLgc43dwZcILHDKYNfi5yiCbiqwN0=;
        b=GDK01c261m+CwzRG+bBnfyhWRTRJV6xFOW00ncaClNvrPMpjcwo/jn5LMkZN71DDPe
         APKOHLtw15uumc0ZIw1SYlDGp+Fv6wb8iJdMTi2SZRquuWysFGUQqlhf+2GOTAteNKOf
         ciNQpwbCY7nymkOBNV7eSkVfWjj0hxJnCnsa4pAbWWlKwnt/bHT5gI2ctdXOMsm9g3Cp
         iDcS9PuBjwnJdWn8cprwjIPs9Xpa4lqHFPfw6slejY/E30M1HLdK9y5Nmz1d2A2DAiCX
         iaYA1uJbSlFDaD9zh8wiStOcacUHuDvnM1Q14mx7xOl9uviAflWDSFK6O1brv5POqEzZ
         6Msw==
X-Gm-Message-State: APjAAAVL9fJfosqvc++anonpsJFfdJMKLRgo+BTZ1mux3SLMQnskH4eP
        TLeRgP6qzscORnaLzJkhIvklmDV6iipwDW45Pt64jkNCNW7KezdMf9rMK2gFjQy96DpzWLt0fhP
        4uDXPGXFRBH+VV1NKYMA6KKZc
X-Received: by 2002:adf:fa86:: with SMTP id h6mr30701791wrr.186.1571149642550;
        Tue, 15 Oct 2019 07:27:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyxR2drPlU+4UbM98K0Mkcvm4IK51SwQIPHgB8VmmCK6vK7rKqTG2D0ygR9QlSmvURfqJfnSQ==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr30701773wrr.186.1571149642269;
        Tue, 15 Oct 2019 07:27:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id r7sm20483281wrt.28.2019.10.15.07.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 07:27:20 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Make fpu allocation a common function
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>
References: <20191014162247.61461-1-xiaoyao.li@intel.com>
 <87y2xn462e.fsf@vitty.brq.redhat.com>
 <20191014183723.GE22962@linux.intel.com>
 <87v9sq46vz.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <97255084-7b10-73a5-bfb4-fdc1d5cc0f6e@redhat.com>
Date:   Tue, 15 Oct 2019 16:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87v9sq46vz.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 12:53, Vitaly Kuznetsov wrote:
> A very theoretical question: why do we have 'struct vcpu' embedded in
> vcpu_vmx/vcpu_svm and not the other way around (e.g. in a union)? That
> would've allowed us to allocate memory in common code and then fill in
> vendor-specific details in .create_vcpu().

Probably "because it's always been like that" is the most accurate answer.

Paolo
