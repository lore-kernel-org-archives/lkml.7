Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA05CC5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A0D214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbfKEPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:10:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389505AbfKEPKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:10:51 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DF65859FC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 15:10:50 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f2so7767287wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZVrAMio36Q6kKW94w/mV9hSJkALDbxmAtiCfECylkvk=;
        b=ob7ZPd1biWXmWRMUBtw+N50OQT85avlgzgcx7SXns8AFm+W4yzIEhc20uYg6SHp14r
         akw/pqedZFBo/tImeN+gJ9owrAmutfgy4bOZlIG5AwbhmFTQLKvZ2rB5Nhrgi/FffkHE
         GmQm9b3QYpEcOQG5m8C5f+8G3uwaPUc90vK0Zmqr6a0T7kPZLQ1Zsl3xmdPXn/nfTRux
         FIGGSVIUjh5Eh2jNURNREQT6tKkhSjMczapoqTxjLciPQyIc/3BBc86agKGNNmTDMr3G
         URFhsda3sKLsNEbapltIR/D91QpILv/P194hj2rKH7YsGoruKV3sNfdn4EgaKGpC/oIB
         0H+A==
X-Gm-Message-State: APjAAAU/6UaToa71VjHfOsfnfod6i3ABXuGDEkqp9AGENEPcaPD8XijG
        b/xNa9dsAGP6SesCoFi821glDt+DWVfClV462nEyoHvp/J/wn4ayGCgNbhn+ceo4fCGljNomzkm
        eYWGwbOTF+HY4eo/kgUjnNxvr
X-Received: by 2002:a1c:67d7:: with SMTP id b206mr4554599wmc.68.1572966649246;
        Tue, 05 Nov 2019 07:10:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4i4e/q0Sa4nnexI0PLDlDkB5K02RJOOefw63TuKDz9JzNgSQf8/7dd6FWjGMKPDiJFaP+8Q==
X-Received: by 2002:a1c:67d7:: with SMTP id b206mr4554564wmc.68.1572966648914;
        Tue, 05 Nov 2019 07:10:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id s21sm1905806wmh.28.2019.11.05.07.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:10:48 -0800 (PST)
Subject: Re: [PATCH 03/13] kvm: monolithic: fixup x86-32 build
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>,
        Matthias Maennich <maennich@google.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-4-aarcange@redhat.com>
 <6ed4a5cd-38b1-04f8-e3d5-3327a1bd5d87@redhat.com>
 <678358c1-0621-3d2a-186e-b60742b2a286@redhat.com>
 <20191105135414.GA30717@redhat.com>
 <330acce5-a527-543b-84c0-f3d8d277a0e2@redhat.com>
 <20191105145651.GD30717@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ab18744b-afc7-75d4-b5f3-e77e9aae41a6@redhat.com>
Date:   Tue, 5 Nov 2019 16:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191105145651.GD30717@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/19 15:56, Andrea Arcangeli wrote:
>>> I think we should:
>>>
>>> 1) whitelist to shut off the warnings on demand
>>
>> Do you mean adding a whitelist to modpost?  That would work, though I am
>> not sure if the module maintainer (Jessica Yu) would accept that.
> 
> Yes that's exactly what I meant.

Ok, thanks.  Jessica, the issue here is that we have two (mutually
exclusive) modules providing the same interface to a third module.

Andrea will check that, when the same symbol is exported by two modules,
the second-loaded module correctly fails insmod.  If that is okay, we
will also need modpost not to warn for these symbols in sym_add_exported.

>> The answer is maintainability.  My suggestion is that we start looking
>> into removing all assignments and tests of kvm_x86_ops, one step at a
>> time.  Until this is done, unfortunately we won't be able to reap the
>> performance benefit.  But the advantage is that this can be done in many
> 
> There's not much performance benefit left from the removal
> kvm_x86_ops.

Indeed; what I mean is that until then we will have to keep the
retpolines.  Not removing kvm_x86_ops leaves an unsustainable mess in
terms of maintainability, therefore we will need to first refactor the
code.  Once the refactoring is over, kvm_x86_ops can be dropped easily,
just like kvm_pmu_ops in this version of the series.

The good thing is that the modpost discussion can proceed in parallel.

> The removal of kvm_x86_ops is just a badly needed code cleanup and of
> course I agree it must happen sooner than later. I'm just trying to
> avoid running into rejects on those further commit cleanups too.

>> That is good enough to prove the feasibility of the idea, so I agree
>> that was a good plan.
> 
> All right, so I'm not exactly sure what's the plan and if it's ok to
> do it over time or if I should go ahead doing all logic changes while
> the big patch remains out of tree.

Yes, the changes to remove tests and assignments to kvm_x86_ops must
happen first.  I understand that the big patch is a conflict magnet, but
once all the refactoring is done it will be very easy to review and it
will get in quickly.

Paolo
