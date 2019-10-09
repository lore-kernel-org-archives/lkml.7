Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E54218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJIHPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:15:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJIHPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:15:08 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36F632A09AA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 07:15:08 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n18so668185wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=beb9HIPPbmhFYNfmtVdjyRkfC7WTvuQw9rrgx9e5c6M=;
        b=uAvIleTZN6NqrH3rE4tqhvJ//quiXSqlBi3Gb8ziTYcHmMRldn3TXB0PhVzlRIwfEH
         NMWQL2An07Tf/x3R61T4JH+FqhyosvE9t2xyLfJOHgDr7GeZW5A/fE3Qtp+adXMdwKA+
         83x/lmDUKsEsf/1Vnoei1SVvYMnYIpbJa6A6yo8RJyvYsNFFyhQWV4kJYwZLAuKUaVG4
         iB0ezdKP8ZJwUAiFG3JwYCQdCJp/JT5iY49wtcLtG6rei84jQ4By34Jv/ZPij3qUiA7a
         zYT+du5Y9a1jtUld7vYvFMd07GZmIn8QxKWFGCn2ikdDLRyJJqobQI8olYzzHBeHCmDC
         2TaQ==
X-Gm-Message-State: APjAAAXhGeBpH+XdsqB0R13QZGVABoUobl6XcNCSa6JBkFNNmJ7EFgZd
        M6qFr54kf+IYiAjb+stmllKfnfZaCCy3DjUgoYfcvsQbFiBdb4dmVGAGC9aeJGuonwS7Lh8oIhj
        ss83d4cw2nbe8IW/jPzr4Kedh
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr1575143wrw.66.1570605306444;
        Wed, 09 Oct 2019 00:15:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPFUqVF+FuXSVZebBE01RgJNMCK667U9tuBkMMoSGONMCEMKv2PzRhAgecz0WXe0Zf1FUUMg==
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr1575084wrw.66.1570605305611;
        Wed, 09 Oct 2019 00:15:05 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id h14sm1686671wro.44.2019.10.09.00.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 00:15:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] KVM: x86/vPMU: Add lazy mechanism to release
 perf_event per vPMC
To:     Like Xu <like.xu@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kvm@vger.kernel.org, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ak@linux.intel.com, wei.w.wang@intel.com, kan.liang@intel.com,
        like.xu@intel.com, ehankland@google.com, arbel.moshe@oracle.com,
        linux-kernel@vger.kernel.org
References: <20190930072257.43352-1-like.xu@linux.intel.com>
 <20190930072257.43352-4-like.xu@linux.intel.com>
 <20191001082321.GL4519@hirez.programming.kicks-ass.net>
 <e77fe471-1c65-571d-2b9e-d97c2ee0706f@linux.intel.com>
 <20191008121140.GN2294@hirez.programming.kicks-ass.net>
 <d492e08e-bf14-0a8b-bc8c-397f8893ddb5@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bfd23868-064e-4bf5-4dfb-211d36c409c1@redhat.com>
Date:   Wed, 9 Oct 2019 09:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d492e08e-bf14-0a8b-bc8c-397f8893ddb5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 05:14, Like Xu wrote:
>>
>>
>>> I'm not sure is this your personal preference or is there a technical
>>> reason such as this usage is not incompatible with union syntax?
>>
>> Apparently it 'works', so there is no hard technical reason, but
>> consider that _Bool is specified as an integer type large enough to
>> store the values 0 and 1, then consider it as a base type for a
>> bitfield. That's just disguisting.
> 
> It's reasonable. Thanks.

/me chimes in since this is KVM code after all...

For stuff like hardware registers, bitfields are probably a bad idea
anyway, so let's only consider the case of space optimization.

bool:2 would definitely cause an eyebrow raise, but I don't see why
bool:1 bitfields are a problem.  An integer type large enough to store
the values 0 and 1 can be of any size bigger than one bit.

bool bitfields preserve the magic behavior where something like this:

  foo->x = y;

(x is a bool bitfield) would be compiled as

  foo->x = (y != 0);

which can be a plus or a minus depending on the point of view. :)
Either way, bool bitfields are useful if you are using bitfields for
space optimization, especially if you have existing code using bool and
it might rely on the idiom above.

However, in this patch bitfields are unnecessary and they result in
worse code from the compiler.  There is plenty of padding in struct
kvm_pmu, with or without bitfields, so I'd go with "u8 event_count; bool
enable_cleanup;" (or better "need_cleanup").

Thanks,

Paolo
