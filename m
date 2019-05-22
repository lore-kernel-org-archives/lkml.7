Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44061C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174ED217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfEVK1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:27:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52348 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfEVK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:27:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so1646416wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 03:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YxQpOSS3n4cm4WBavduVAfTQcURqnSOE6/a2H2tAcYc=;
        b=LRifgHeR+AG2ix2aOBfWAcl2Hsh1ObjDsLTMoipImDknE6PZAz8e4FYrfGj0EQLwR/
         nH/1K/VCNOHUCgCba7Ad9c54ThSGA0lNAqiCrizWu9ZCGh9AbKMm8BUpgd19fCD0fJF1
         +1TMoJNlpzUdcLF5qDl0Zw32tqiqeLZGmi3XmQPret+XSx0Dz65W9L2vA89yh24rxsnd
         1XccOsB4gcK0HjddmlBjdV/tW256PDja3muxaOlEiufceszuHjY6QR/d4Kr2LUhQSTgk
         i923liQOgDMNzVgN2BS0nuWlR6Mbe5al6PC1c2ABjOR8NegvRvmE2puPkxIEegtop8j+
         pbGA==
X-Gm-Message-State: APjAAAVi9EPWUeRi8ji7qOiA9Eke+sowVWWPQGA39+U7k5ZJCSVyfphA
        ixIQz45uzZZyWtPpJ1iCxQFgadTeK/w=
X-Google-Smtp-Source: APXvYqxzpKYu4eisAOH6Jw4h/EAZeV7uDO25xNniPd/davQJ6YKI9kVcvW4y6Ds9KvF3c6X1jSOIgA==
X-Received: by 2002:a1c:6783:: with SMTP id b125mr6806916wmc.41.1558520828809;
        Wed, 22 May 2019 03:27:08 -0700 (PDT)
Received: from [10.32.181.147] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id i25sm6813421wmb.46.2019.05.22.03.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 03:27:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86/pmu: do not mask the value that is written
 to fixed PMUs
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1558366951-19259-1-git-send-email-pbonzini@redhat.com>
 <1558366951-19259-3-git-send-email-pbonzini@redhat.com>
 <20190520190158.GE28482@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c0db3010-96a7-c58e-ee08-a5703e40b3f4@redhat.com>
Date:   Wed, 22 May 2019 12:27:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520190158.GE28482@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 21:01, Sean Christopherson wrote:
> Would it make sense to inject a #GP if the guest attempts to set bits that
> are reserved to be zero, e.g. based on guest CPUID?

Yes, though it was not clear from the SDM quote that hardware enforces
that (I guess the hint is that they "must" be written as zero rather
than "should").

I'll include this patch in my next pull request with fixed commit
message, and do the #GP change separately.

Paolo
