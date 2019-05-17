Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F74DC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDCD2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfEQKws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:52:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40518 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfEQKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:52:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so6628946wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=THITi5Ip2HZ6an/B3Z/ms2Jjg0WRC9J/sBGO0PYgdbc=;
        b=DRxPsaQY1nN+mTBphwBx+7BH14Re5dsEE5y/W01CNM47YRiqXKoIBNuSp02+2QzfzC
         LWS+yu1sySccVyMonxZ1wVWEeWJfBtc6BNz4DA3VeaZoTaFhM5aIEZ6a0Y9mDk54wRiL
         9+PGIEOZqW48KTjJF8Nor4vUZ3qL947z/Z0VLB9jPELEYY+0dc9zJ+gDnnqAmKdmED7L
         1NV6VPWBziRfxcsn4mJJOrLeeCu7nvy8S6rWoq8kJhFKAT8aiDlWm7K5U5ebr7vjzs0z
         vG/mICWSz8syoA5aMs3XN5rCgIs1AD9JX+lq4++aASdJlWNXzA82qed6BMnI0lF4Oeji
         uE3A==
X-Gm-Message-State: APjAAAVNr7TRcJ90xKUdNaJhDk1ghW69W3CcjrC1vWiPunhs/A78j4Lc
        qVkKGjLAQPC+LFctIOWV1kby6ZNnDrM=
X-Google-Smtp-Source: APXvYqzrLeyFl5EV/wWskuT411hf56OPfOJJunq74SqJHKK1uD/Uh8MkanrXrSd3sejTv6btaJBv6Q==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr19990925wrj.230.1558090366191;
        Fri, 17 May 2019 03:52:46 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z8sm7123481wrs.84.2019.05.17.03.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 03:52:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Compile code with warnings enabled
In-Reply-To: <1834df0f-b377-2231-0e5c-c5acd3298973@redhat.com>
References: <20190517090445.4502-1-thuth@redhat.com> <20190517093000.GO16681@xz-x1> <8736ldquyw.fsf@vitty.brq.redhat.com> <1834df0f-b377-2231-0e5c-c5acd3298973@redhat.com>
Date:   Fri, 17 May 2019 12:52:44 +0200
Message-ID: <87zhnlpd37.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Huth <thuth@redhat.com> writes:

>
> x86_64/vmx_set_nested_state_test.c: In function
> ‘set_revision_id_for_vmcs12’:
> x86_64/vmx_set_nested_state_test.c:78:2: warning: dereferencing
> type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>   *(u32 *)(state->data) = vmcs12_revision;
>
> ... how do we want to handle such spots in the kvm selftest code?
> Compile with -fno-strict-aliasing? Or fix it with type-punning through
> unions?

These are tests, let's keep code simple. Casting my vote for the former
option)

-- 
Vitaly
