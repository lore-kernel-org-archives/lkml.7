Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C062BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E13021783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfJVOE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389077AbfJVOE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:04:26 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2099DC0568FD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 14:04:26 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k9so7551543wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3vKquIIhS417Xcv3ef04W52oBIikgSSCS3LfBkCoIDs=;
        b=bSVHUQ+4OWWLytRE59pGX09lnI4OujPrHNNSs8sivp1lfCJbTmRhD+e/rYMV+WVR9l
         ibvaTWmgn0yfg/PmHSTIndOroAutdpfjGcJQQxMBPrYwatrShyYLvgFG9kWnQ6hS24/w
         mI9GgWQk5u5uC1jnUu2tHXDqj2EhReRCo3OULYmLkWsMs1FHFltzPqDyBsi+iGrJX+0k
         ME6JV0fD16n+QEC9YQA7r242Y4zg42vqG/306jieLYotDdWMVC26tPQL0NzsDMZQVvZr
         2bdTR1uNdAqSC+QnG6bRfpvMg1F0KNB2JKC0xPz1h2HLWmMjy9OKr0NABXez2fYGViKJ
         4vfw==
X-Gm-Message-State: APjAAAW6n+xXTeWW10PZ8Pt6lZ5Ye9qlQaeJlstZkCYTkP0Dn8mR66gk
        pc76+8qNoBJbXu6hWJ21NeYVYgVGgKGZoQ5VHhSjuYOkbz16DMK0tk49o2WHeR+rw95fmINfDZu
        PBf36PSEN0WbVqKhhKTA/WoZx
X-Received: by 2002:a7b:c049:: with SMTP id u9mr3176830wmc.12.1571753064240;
        Tue, 22 Oct 2019 07:04:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxd12WGZ28CK/g1W21d1r/6V7p9tDfXwdcdM4EXY3TusWKTyDA7mRoL7a/JX5NzrrGKErwrww==
X-Received: by 2002:a7b:c049:: with SMTP id u9mr3176775wmc.12.1571753063926;
        Tue, 22 Oct 2019 07:04:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19? ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
        by smtp.gmail.com with ESMTPSA id n11sm903226wmd.26.2019.10.22.07.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:04:23 -0700 (PDT)
Subject: Re: [PATCH v2 15/15] KVM: Dynamically size memslot array based on
 number of used slots
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <20191022003537.13013-1-sean.j.christopherson@intel.com>
 <20191022003537.13013-16-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2609aedc-4fc9-ab92-8877-55c64cf19165@redhat.com>
Date:   Tue, 22 Oct 2019 16:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022003537.13013-16-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/19 02:35, Sean Christopherson wrote:
> +	struct kvm_memory_slot memslots[];
> +	/*
> +	 * WARNING: 'memslots' is dynamically-sized.  It *MUST* be at the end.
> +	 */

Isn't that obvious from the flexible array member?

Paolo
