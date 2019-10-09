Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6745CC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F3821721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfJIM3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfJIM3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:29:48 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9061434CC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 12:29:48 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 190so991985wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xvThJK+yx5Ccn9NmhrAQG/4aOZL4annIFveYbxX7LRY=;
        b=PiY62UuC9RHHxnofqDuidHBZE10TMkZfMKaxrLNBwLqReKlDLMhTfHoPbCCvr9B9Rm
         4NxwoZ/ISrFDknyXxvmc5FvkxW4R2f7TpC9hCnQu7f/t3qHjRjpTpG/WXHu9psbAy8pD
         p/tPdNl6ZTGhKaxeg/w98lDF9gLKqtMqGFgc1vcmZXqXwkRH6PbkwqgkJmvQr7uiIELX
         /UtZkn59GPZBFyPsE227yx/Ap0koDZBxgCxnY6RHNKe1FFgCxKn47nkEgCwFMCqxrHb2
         GQFotuwAKOGEyJeZ5/FloR9SZxId84pC0EgXpLHfmPxpjvByYpgHgIZKDKU31/Dnc19d
         eFaA==
X-Gm-Message-State: APjAAAWrQ2C3MuExIX14dPg5M2BZuzgq1abTsPUEqeZEAbjWkl5dERz7
        bkn1b4Gzyt6T21tPtLBGkGUfm0PjlrU1G+Y35U4OXe3HP33Vy5i49CX7D6vih2n/2VOI3n3DVzb
        OH0aoyyTawMWeZy0jKoK1+Nao
X-Received: by 2002:a1c:6389:: with SMTP id x131mr2379539wmb.77.1570624187334;
        Wed, 09 Oct 2019 05:29:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmSCLkj57Flq62wjjdik+sMsp+Gw9vcplMUYMGct4y5MTaJRpQ2Q5fyhVBXbKv5lQZ0l/Y2A==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr2379523wmb.77.1570624187133;
        Wed, 09 Oct 2019 05:29:47 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 59sm3512855wrc.23.2019.10.09.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 05:29:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] selftests: kvm: fix sync_regs_test with newer gccs
In-Reply-To: <5b1b95e5-4836-ab55-fe4d-e9cc78a7a95e@redhat.com>
References: <20191008180808.14181-1-vkuznets@redhat.com> <20191008183634.GF14020@linux.intel.com> <b7d20806-4e88-91af-31c1-8cbb0a8a330b@redhat.com> <87d0f6yzd3.fsf@vitty.brq.redhat.com> <5b1b95e5-4836-ab55-fe4d-e9cc78a7a95e@redhat.com>
Date:   Wed, 09 Oct 2019 14:29:45 +0200
Message-ID: <874l0iyudi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/10/19 12:42, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>> There is no practical difference with Vitaly's patch.  The first
>>> _vcpu_run has no pre-/post-conditions on the value of %rbx:
>> 
>> I think what Sean was suggesting is to prevent GCC from inserting
>> anything (and thus clobbering RBX) between the call to guest_call() and
>> the beginning of 'asm volatile' block by calling *inside* 'asm volatile'
>> block instead.
>
> Yes, but there is no way that clobbering RBX will break the test,
> because RBX is not initialized until after the first _vcpu_run succeeds.
>

Right, we're always resuming after so potential clobbering doesn't
matter. Thanks!

-- 
Vitaly
