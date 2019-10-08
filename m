Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70BECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD7E206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfJHGzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:55:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730054AbfJHGzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:55:50 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79892C057F31
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 06:55:49 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id y18so6528588wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 23:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/ItjmkVOcQL88GynACehBavUW7puGFoZ3r/yGzUFjs=;
        b=qdLRrjCACHeFXa6XiXkkf+x6nDCWikFN9z5Oc1LXfl9anhxAgdERNNUkngxAHYvo5f
         XxC2RKq9KHCfvtZXX79PrtTT+H923lK+D4rVs1VioRtsuH65248nywpc5Vp5fQc2X8lR
         Ev3dNgjtGH5gYbbl2ygJMuCcYG3ykUYfpttBKoHjK72J+uoBjDEJiHnVBilU0wBovBEC
         NxmweN7AMxB/w/XJ1b1RW8t3lshwqUQKtOua9bOo/WR4Y9oF4Sd5l7MO5JoRjFyOX9K2
         DVJ/5JrBHGQ1XcSESQYQpmZKPQcGYN8TaNyx0uus+dP+YrmZ9x9LGCEMK8GAXBFkpg0/
         sqkg==
X-Gm-Message-State: APjAAAWT+t1rl+5QjlkAD7prrd6FuKcv0AyNw4WYTAidXxA/e3ER0JBi
        YSRkk75n2oQesB2Y5M9j86BwF8v0TvrdtsEdCxXrDTxrYTyVoajoZ8S8YWfH0vY4dAJU+lD9myo
        yinYFvbs7+AM4B+C8ZX3Xw6II
X-Received: by 2002:a05:600c:2286:: with SMTP id 6mr2348800wmf.63.1570517748032;
        Mon, 07 Oct 2019 23:55:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwH9MkZmXD47S5F//rWIgZ/EkzjEhx/7PbXXdAGQj1IvfEw48+T3GYvi15dchDS6kgF6aiLPw==
X-Received: by 2002:a05:600c:2286:: with SMTP id 6mr2348779wmf.63.1570517747694;
        Mon, 07 Oct 2019 23:55:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e876:e214:dc8e:2846? ([2001:b07:6468:f312:e876:e214:dc8e:2846])
        by smtp.gmail.com with ESMTPSA id a14sm1603922wmm.44.2019.10.07.23.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 23:55:47 -0700 (PDT)
Subject: Re: [PATCH 10/16] x86/cpu: Detect VMX features on Intel, Centaur and
 Zhaoxin CPUs
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20191004215615.5479-1-sean.j.christopherson@intel.com>
 <20191004215615.5479-11-sean.j.christopherson@intel.com>
 <f26580de-d423-3369-42f4-682824dd592d@redhat.com>
 <20191007195422.GF18016@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8b44345d-7bc0-b8f2-0ee4-3e7f3c8bd994@redhat.com>
Date:   Tue, 8 Oct 2019 08:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007195422.GF18016@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/19 21:54, Sean Christopherson wrote:
>> For QEMU, we're defining a feature as supported if a feature can be
>> turned both on and off.  Since msr_low and msr_high can be defined
>> respectively as must-be-one and can-be-one, the features become
>> "msr_high & ~msr_low".
> 
> That makes sense for Qemu, but I don't think it's appropriate for this
> type of reporting.  E.g. if EPT and Unrestricted Guest are must-be-one on
> a hypothetical (virtual) CPU, it'd be odd to not list them as a supported
> feature.
> 
> For actual hardware (well, Intel hardware), as proposed it's a moot point.
> The only features that are must-be-one (even without "true" MSRs) and are
> documented in the SDM are CR3_LOAD_EXITING, CR3_STORE_EXITING,
> SAVE_DEBUG_CONTROLS, and LOAD_DEBUG_CONTROLS, none of which are reported
> in /proc/cpuinfo.
> 
>> Also, shouldn't this use the "true" feature availability MSRs if available?
> 
> Only if incorporating the "& ~msr_low" can-be-one logic.  If a feature is
> considered supported if it must-be-one or can-be-one then the true MSR and
> vanilla MSR will yield the same feature set.

Ok, that all makes sense.

Paolo
