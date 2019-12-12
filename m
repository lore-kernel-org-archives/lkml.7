Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDADC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5252253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGuFALjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfLLSXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:23:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730271AbfLLSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576175031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xkoB5cjmgUHQdkZ5cb+CrM+r0RqlkKkbDVU3rOPMZ8=;
        b=KGuFALjCm5agyZb0cP0y3uNsm4Zc+mcit9Azsp+owViUP3oh3+Rx9ntr/dUZJyFMrMYfPg
        6axo+J+r1GERlfyqr4svvOOyhGCnYFZ11S3R7gt1nW6c2FIdaW/4HK5KKybzVH/9SpAZ0U
        MdZ4Tw0aoBkkDNPoSiMiYqWZNk13rz0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89---VQmJs6POGHTRROy27BdA-1; Thu, 12 Dec 2019 13:23:50 -0500
X-MC-Unique: --VQmJs6POGHTRROy27BdA-1
Received: by mail-wr1-f71.google.com with SMTP id d8so1339285wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8xkoB5cjmgUHQdkZ5cb+CrM+r0RqlkKkbDVU3rOPMZ8=;
        b=laqddVo565OdPn82qmlbbYbdzHkkgHWjN4ZBTlPTUuqfN2g7VyFXmlLHuQcTY3//TP
         ScHuMEG+gMZQ1NvPgafIFjMENk2+M2JgOKnS0T0LflcWIfSvf2n3KQS2w8yW3uyLEyar
         CrDCyvL96Q4CI7mohvXiPKLcPPPopOQqDhqdfOtHDrFrmwFUBo4QwukJbxTqBL8woZzf
         nMgFfENh1ZYWLU3lQTCJHj9kGtV8s+yAlpaA26y34tFiguDRTBivS31V5kKOzE7JP1h7
         0Un9nOLxP/twCgX+I26wjU9uQpCJGiMeoqbyH9I2yURwHlKkrDQ37G1yBQJWe0r0tOA7
         mOdA==
X-Gm-Message-State: APjAAAV+7jWlsfDOf7AL/XpGp+9OsxRFm9el+PwsetetkJqc9rYP+IOe
        IyZ6an2eYLiNpXqBk3LRQ/UB1+xjgvqkRF6kUWE9agsKbYWjGisg7Sy6jXpBVaeJJFyMAh+x+PU
        LXh96k4pBjXptZQEZc+Kv0JHQ
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr1926356wml.110.1576175028875;
        Thu, 12 Dec 2019 10:23:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwd0K98LLLLMzVZpxkLM2pTQcUwdjipnXu8DaxkR8GuX/5jLVy+o+UUfsD7E3+5ZFzP6L279w==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr1926312wml.110.1576175028600;
        Thu, 12 Dec 2019 10:23:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id h2sm6896950wrv.66.2019.12.12.10.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 10:23:47 -0800 (PST)
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <20191212181802.GH3163@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d6c0344-ccfa-13fc-695b-1e69298507dc@redhat.com>
Date:   Thu, 12 Dec 2019 19:23:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212181802.GH3163@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 19:18, Sean Christopherson wrote:
> Using v<feature> across the board makes sense to keep things consistent,
> i.e. vnmi, vtpr, vapic, etc...
> 
> Anyone have thoughts on how to shorten "APIC-register virtualization"
> without colliding with vapic or apicv?  I currently have apic_reg_virt,
> which is a bit wordy.  apic_regv isn't awful, but I don't love it.

Perhaps vapic_access and vapic_register?

> 
> The other control that will be awkard is "Virtual Interrupt Delivery".
> vint_delivery?

We can just use vid I think.  And posted_intr.

>>> unrestricted_guest	-> unres_guest
>>
>> Full? Or just unrestricted
> 
> I prefer unrestricted_guest, a bare unrestricted just makes me wonder
> "unrestricted what?".   But I can live with "unrestricted" if that's the
> consensus.

I do prefer unrestricted_guest actually.

>> In general I would stick to the same names as kvm_intel module
>> parameters (sans "enable_" if applicable) and not even bother publishing
>> the others.  Some features are either not used by KVM or available on
>> all VMX processors.
> 
> IMO there's value in printing features that are not 1:1 with module params.
> 
> I also think it makes sense to print features of interest even if KVM
> doesn't (yet) support the feature, e.g. to allow a user/developer to check
> if they can use/test a KVM build with support for a new feature without
> having to build and install the new kernel.
> 
>> Paolo
>>
>>> and so on. Those are just my examples - I betcha the SDM is more
>>> creative here with abbreviations. But you guys are going to grep for
>>> them. If it were me, I'd save on typing. :-)
> 

