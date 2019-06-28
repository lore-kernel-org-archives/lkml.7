Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1907214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF1IRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:17:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53320 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfF1IRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:17:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so8156966wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jT2kRINveHvJwFXNM/R+VqTRF8bwTgG9CgHFi5dSiyg=;
        b=GFGjypZSEYzOOiaNNWN0wi/5QiIH4VShg+Ts+VnEaeZjCvkAiYZwh+aKS86kt3Ffxa
         HLc3zn+q57DQHMcG3dpJkZbPCLV5ORY8bDrvVDdG+QgraxOYGEUgnGqhZL/9+BZQf9T2
         Bqr0LSHrFuiwNqFMWLj/0BxbDHMcFG5XJwL4N9Sckv6Y44/ze9P1ELsJhVQkMcg/z7Dd
         nQ9s8Z8THlZSpDBH2eoEF2Hx2s13Hpaa9lCuSq8wSqse6o+Waa6jLXBRm+TON2EkZPnM
         SlzUOfJfvw29vwLMmQtXO8tulnKFDLCtDWGr8nlVd0gR8At7h6iv2fBZ2C5t6fDuDf/c
         wt1g==
X-Gm-Message-State: APjAAAXKjHYVeysnHRL3lFxT+F/cgqDnfM/kh522rSapRM+Pw27w/bCP
        zmgOGp8Hmk7kuehEGH8QiKoh7gDTedg=
X-Google-Smtp-Source: APXvYqw59G5uN7cW7umBoHRBzrVy3zRiztgqyJ+OtIc5pkdubtFVLy2FJKEDgpWAzk61v+TSzJlOUg==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr6317819wmj.65.1561709853044;
        Fri, 28 Jun 2019 01:17:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:702d:1924:42db:99ec? ([2001:b07:6468:f312:702d:1924:42db:99ec])
        by smtp.gmail.com with ESMTPSA id u1sm1364461wml.14.2019.06.28.01.17.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 01:17:32 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] Added build and install scripts
To:     samcacc@amazon.com, Alexander Graf <graf@amazon.com>,
        Sam Caccavale <samcacc@amazon.de>
Cc:     samcaccavale@gmail.com, nmanthey@amazon.de, wipawel@amazon.de,
        dwmw@amazon.co.uk, mpohlack@amazon.de, karahmed@amazon.de,
        andrew.cooper3@citrix.com, JBeulich@suse.com, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        paullangton4@gmail.com, anirudhkaushik@google.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190624142414.22096-1-samcacc@amazon.de>
 <20190624142414.22096-5-samcacc@amazon.de>
 <e0b29f4d-7471-c5d8-c9d4-2a352831a4bd@amazon.com>
 <6fa5e9de-7b66-76ba-0b98-e11f890e076a@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4438c94e-a0ed-0e5c-0a74-02aed8949b24@redhat.com>
Date:   Fri, 28 Jun 2019 10:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6fa5e9de-7b66-76ba-0b98-e11f890e076a@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/19 09:59, samcacc@amazon.com wrote:
>> Surely if it's important to generate core dumps, it's not only important
>> during installation, no?
> Yep... missed this.  I'll move it to run.sh right before alf-many is
> invoked.  It would be nice to not have to sudo but it seems the only
> alternative is an envvar AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES which
> just ignores AFL's warning if your system isn't going to produce core
> dumps (which will cause AFL to miss some crashes, as the name suggests).

Can you do this only if /proc/sys/kernel/core_pattern starts with a pipe
sign?

Thanks,

Paolo
