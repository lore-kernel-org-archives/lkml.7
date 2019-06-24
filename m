Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB6CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A732083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFXIGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:06:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42761 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfFXIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:06:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so12782044wrl.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Z+yhWdRmZqWnOELelg1DvCmnthpSE9A/9kI1Cr9+74=;
        b=M2O7elA/qfUJTE6pHfL3FC+3gkTL7zd7n/mY5j0l9u61ooNIhMS3zombFSZucNpyGX
         sZme1WAb+HPMm4w62txTfbsfDUoODlXLtJ8VhEIN/B7Q8H5akwGff+vvWvMXOzMO5mAO
         dggWFzoLmfSJrXTQcsssuOOMNN8hWsSLj5AOyzAV5O6KTV2ESXiot8xtVdbBFRsA4mwQ
         JcNonkRUkRkvClkg1QKzfKiwHBl8tXFZa7bHi+htOLC305C/3sbmWnRHzbUFD5Dalhuk
         4vUgWYIjRDLfy6lyPXQebVr1SNiQFN7jkkshsd8iUqSXxLYmXIrN8LTF4RLm5VbB+e2i
         Rp6Q==
X-Gm-Message-State: APjAAAXd1gltzq6NN37A0pAY0oyS9Ka4TDCFoxzkoIe4VYVkwENnJEWQ
        m3Pa12hXSZ1sUIg0+xW8bdrmjw==
X-Google-Smtp-Source: APXvYqx2FV3+jDNBq4KGmS+pdk7ijeIAX6U+n6wy9UHW8Vgwf3IvAqW+lcidi+weRL/KtUDmo8IS4Q==
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr29464510wrx.82.1561363579441;
        Mon, 24 Jun 2019 01:06:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab? ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
        by smtp.gmail.com with ESMTPSA id n14sm23395174wra.75.2019.06.24.01.06.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 01:06:18 -0700 (PDT)
Subject: Re: [RFC] perf/x86/intel: Disable check_msr for real hw
To:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tom Vaden <tom.vaden@hpe.com>, Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>
References: <20190614112853.GC4325@krava>
 <20190621174825.GA31027@tassilo.jf.intel.com> <20190623224031.GB5471@krava>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34c248fd-fb34-e2ae-01ae-7576694a2eff@redhat.com>
Date:   Mon, 24 Jun 2019 10:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190623224031.GB5471@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/19 00:40, Jiri Olsa wrote:
> On Fri, Jun 21, 2019 at 10:48:25AM -0700, Andi Kleen wrote:
>> On Fri, Jun 14, 2019 at 01:28:53PM +0200, Jiri Olsa wrote:
>>> hi,
>>> the HPE server can do POST tracing and have enabled LBR
>>> tracing during the boot, which makes check_msr fail falsly.
>>>
>>> It looks like check_msr code was added only to check on guests
>>> MSR access, would it be then ok to disable check_msr for real
>>> hardware? (as in patch below)
>>>
>>> We could also check if LBR tracing is enabled and make
>>> appropriate checks, but this change is simpler ;-)
>>>
>>> ideas? thanks,
>>> jirka
>>
>> Sorry for the late comment. I see this patch has been merged now.
>>
>> Unfortunately I don't think it's a good idea. The problem 
>> is that the hypervisor flags are only set for a few hypervisors
>> that Linux knows about. But in practice there are many more
>> Hypervisors around that will not cause these flags to be set.
>> But these are still likely to miss MSRs.
>>
>> The other hypervisors are relatively obscure, but eventually
>> someone will hit problems.
> 
> any idea if there's any other flag/way we could use to detect those?

There's no silver bullet, the best is boot_cpu_has(X86_FEATURE_HYPERVISOR).

Paolo
