Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A68F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfHZIS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:18:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfHZIS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:18:58 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2BD3C028320
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:18:57 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id w30so11703749pfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 01:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cGw1QOvAWWRWVuj0lRT4bdgXpIN7Y746gADKiInC19M=;
        b=qzNMMzz8DCVuxZPbQGZaYuy6X3+a/1bEdPlSOzEaIyPyGSyruKSsKRh8rYq/dOAgQN
         B8Z5pZEu8ASy0SAZAiIHPlC3rC4JmY9R2qHAM5PgJP3btT6/KfcZJE+80+fvGqA7j+LY
         wTq+BRE59TmEz/M38sz1uDdKWAg3LX14REdNpFQhhusqYK33dQJpBbNLgufTHEebIVNQ
         S/QWUPtVJxzVLl4ISvv66Ne2mu6Fl/eIf+om54MGx247ymaSIBrp/SX+o1CmDOJwBoXd
         /o5xP5KSkyFbk/68ywC8GvU3ZWp9iKeCBjR93JwDUK+BhRCdeUhzxmHpgUNTTH/gsKll
         C9BQ==
X-Gm-Message-State: APjAAAVrtXED98wcyyM4MvTwopOXlJ9HV1AdlzleNEVeiHirepQamo4/
        95wcQroIpY8MObbycQ4wSY/Z3aMZ2gn1ZwhT2KYKH4IgMQ6OAuQq/AlD51d1SHl7m5ip9IcKKjK
        XFM5+Mt86g+rQdgViXX+h3qZZ
X-Received: by 2002:a62:e401:: with SMTP id r1mr19422801pfh.193.1566807537452;
        Mon, 26 Aug 2019 01:18:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWAprroueNItrwfSiofRmqFj877bf2csmLQNwgiA8R9NNLITxbw7s1DN/MGKT6MZzTE1+TKg==
X-Received: by 2002:a62:e401:: with SMTP id r1mr19422783pfh.193.1566807537229;
        Mon, 26 Aug 2019 01:18:57 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p8sm21990998pfq.129.2019.08.26.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 01:18:56 -0700 (PDT)
Date:   Mon, 26 Aug 2019 16:18:47 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: selftests: Detect max PA width from cpuid
Message-ID: <20190826081847.GB1785@xz-x1>
References: <20190826075728.21646-1-peterx@redhat.com>
 <00533992-f6e9-3c06-3342-b2b8a95b61d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00533992-f6e9-3c06-3342-b2b8a95b61d7@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 10:11:34AM +0200, Thomas Huth wrote:
> On 26/08/2019 09.57, Peter Xu wrote:
> > The dirty_log_test is failing on some old machines like Xeon E3-1220
> > with tripple faults when writting to the tracked memory region:
> > 
> >   Test iterations: 32, interval: 10 (ms)
> >   Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
> >   guest physical test memory offset: 0x7fbffef000
> >   ==== Test Assertion Failure ====
> >   dirty_log_test.c:138: false
> >   pid=6137 tid=6139 - Success
> >      1  0x0000000000401ca1: vcpu_worker at dirty_log_test.c:138
> >      2  0x00007f3dd9e392dd: ?? ??:0
> >      3  0x00007f3dd9b6a132: ?? ??:0
> >   Invalid guest sync status: exit_reason=SHUTDOWN
> > 
> > It's because previously we moved the testing memory region from a
> > static place (1G) to the top of the system's physical address space,
> > meanwhile we stick to 39 bits PA for all the x86_64 machines.  That's
> > not true for machines like Xeon E3-1220 where it only supports 36.
> > 
> > Let's unbreak this test by dynamically detect PA width from CPUID
> > 0x80000008.  Meanwhile, even allow kvm_get_supported_cpuid_index() to
> > fail.  I don't know whether that could be useful because I think
> > 0x80000008 should be there for all x86_64 hosts, but I also think it's
> > not really helpful to assert in the kvm_get_supported_cpuid_index().
> [...]
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > index 6cb34a0fa200..9de2fd310ac8 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -760,9 +760,6 @@ kvm_get_supported_cpuid_index(uint32_t function, uint32_t index)
> >  			break;
> >  		}
> >  	}
> > -
> > -	TEST_ASSERT(entry, "Guest CPUID entry not found: (EAX=%x, ECX=%x).",
> > -		    function, index);
> >  	return entry;
> >  }
> 
> You should also adjust the comment of the function. It currently says
> "Never returns NULL". Not it can return NULL.

Yeh that's better.

> 
> And maybe add a TEST_ASSERT() to the other callers instead, which do not
> expect a NULL to be returned?

I think it's fine because it's the same as moving the assert from here
to the callers because when the caller uses entry->xxx it'll assert. :)

Thanks,

-- 
Peter Xu
