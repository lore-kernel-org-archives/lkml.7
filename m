Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79479C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CE6217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfHZLes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:34:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfHZLes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:34:48 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FFBEC055673
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:34:47 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t9so9600939wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 04:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5a3vSStb7ftKwA4utZbsdS+A5/09h8anZ9iE0vcfgVg=;
        b=WDGqPV3GT7ieFb+WesShUPpOL1CK+xsPq6oBU+ZxCxMtXMDnyw89fXrSgLgT8Dr1aa
         XZXEMzhf5Jk5EFXKzstqMKRLeQjuJQwecVrtxgZXWdhJ34mZSFRhnM1AOLxzXetEoMQh
         2sdgWvSONfvpvX1qTpe6KqMQGkpFeWL5yKJzh37p81dE9lasz+zoiZ8MpyGnnTN5LS3D
         l8kCu5tUoO2y4/St7pUm+HSs7LNmEnvAAj6vZiVpjBqCP3v6wQm/mEIgSAcfaErkdRNC
         An/FOw2G9UckcsMUhCQS3NkNViLbD9KNmiz+AkJ3kWKkhoMwSSa80jkoZPG8D3jlZXB9
         a4Iw==
X-Gm-Message-State: APjAAAXBk4tcnNHu+uipOGe+WICBAdknQEuJdV+4OvnN3UibSdAy+fQm
        AaWUjtK2b4yEJshMKLjAIVe7OBCnLC9evtwuHewMNVzEa64D6ekzU0Val5Shl1db7bhp1Dq4csq
        zSJJzrfWjwufPaTce3RiIb3eQ
X-Received: by 2002:a7b:c753:: with SMTP id w19mr20762651wmk.91.1566819286069;
        Mon, 26 Aug 2019 04:34:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzC1LCPXBt8nuvA/86wEzBtpk/eUBu9wiT4maZQHMDpgfojfdfHRxz+0uH2fRwkODsIUHpa/Q==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr20762626wmk.91.1566819285841;
        Mon, 26 Aug 2019 04:34:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t14sm11572383wrv.12.2019.08.26.04.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 04:34:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Detect max PA width from cpuid
In-Reply-To: <20190826104757.GD1785@xz-x1>
References: <20190826075728.21646-1-peterx@redhat.com> <874l24nxik.fsf@vitty.brq.redhat.com> <20190826104757.GD1785@xz-x1>
Date:   Mon, 26 Aug 2019 13:34:44 +0200
Message-ID: <87tva4ma7f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Mon, Aug 26, 2019 at 10:25:55AM +0200, Vitaly Kuznetsov wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > The dirty_log_test is failing on some old machines like Xeon E3-1220
>> > with tripple faults when writting to the tracked memory region:
>> 
>> s,writting,writing,
>> 
>> >
>> >   Test iterations: 32, interval: 10 (ms)
>> >   Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
>> >   guest physical test memory offset: 0x7fbffef000
>> >   ==== Test Assertion Failure ====
>> >   dirty_log_test.c:138: false
>> >   pid=6137 tid=6139 - Success
>> >      1  0x0000000000401ca1: vcpu_worker at dirty_log_test.c:138
>> >      2  0x00007f3dd9e392dd: ?? ??:0
>> >      3  0x00007f3dd9b6a132: ?? ??:0
>> >   Invalid guest sync status: exit_reason=SHUTDOWN
>> >
>> 
>> This patch breaks on my AMD machine with
>> 
>> # cpuid -1 -l 0x80000008
>> CPU:
>>    Physical Address and Linear Address Size (0x80000008/eax):
>>       maximum physical address bits         = 0x30 (48)
>>       maximum linear (virtual) address bits = 0x30 (48)
>>       maximum guest physical address bits   = 0x0 (0)
>> 
>> 
>> Pre-patch:
>> 
>> # ./dirty_log_test 
>> Test iterations: 32, interval: 10 (ms)
>> Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
>> guest physical test memory offset: 0x7fbffef000
>> Dirtied 139264 pages
>> Total bits checked: dirty (135251), clear (7991709), track_next (29789)
>> 
>> Post-patch:
>> 
>> # ./dirty_log_test 
>> Test iterations: 32, interval: 10 (ms)
>> Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
>> Supported guest physical address width: 48
>> guest physical test memory offset: 0xffffbffef000
>> ==== Test Assertion Failure ====
>>   dirty_log_test.c:141: false
>>   pid=77983 tid=77985 - Success
>>      1	0x0000000000401d12: vcpu_worker at dirty_log_test.c:138
>>      2	0x00007f636374358d: ?? ??:0
>>      3	0x00007f63636726a2: ?? ??:0
>>   Invalid guest sync status: exit_reason=SHUTDOWN
>
> Vitaly,
>
> Are you using shadow paging?  If so, could you try NPT=off?
>

Yep,

test passes with shadow paging, fails when NPT is enabled.


> I finally found a AMD host and I also found that it's passing with
> shadow MMU mode which is strange.  If so I would suspect it's a real
> bug in AMD NTP path but I'd like to see whether it's also happening on
> your side.

Sounds like a bug indeed.

-- 
Vitaly
