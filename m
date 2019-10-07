Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8FEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F910206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfJGRLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGRLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:11:24 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57D382A09D7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 17:11:24 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id k2so7830175wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLYqevL9PdywyJeqkvnwbJNWCTwp+vmfpCLSwv3bSmE=;
        b=oQlHPAKGYJ7PeBB9bzRjx5rJsQb2BgM0NILHCxn6k1yVboMwUpBorrQ5a9eLDSbunX
         z1U9l1YvMNdDFqP9HtErVrj7o3aOiWuKow26YBi7VHOJV9Eyk6FGtl87OxBlB3bNI1iN
         yClS+G7TAyC1LV6TUIuru428IG7zFWOkEDZ8Ow+bl2L/0WAvHb2Ysq2KJ3rCtuayV7Ty
         VScEHBD7gpfC4hM5SLD2fhcVAqCx6m/Q7sR2xwV1z7XjTrh7XMKf75ZdyLKLCra93lYr
         IeiUTEW0Ma6a9dgEBfd1HADts99jmZQU9MDLo8AYPGhZy41eDS8gH1BE3XImGrXDb3Jt
         mcAA==
X-Gm-Message-State: APjAAAVyZ//+Ko98e5trnB7Aoz5e98statzDUYwfKdxuaSART3DAAflz
        OA+c0GBO6SNEVos4cZdHWUMhRt08rS6qdgnm6f4nqqPYjRsh54Rc1mPWCrxjsDee8OH+Fyo2ZCx
        lixhP5dkJARn9/5tc2CsmHpsk
X-Received: by 2002:a1c:dfc4:: with SMTP id w187mr212752wmg.107.1570468282980;
        Mon, 07 Oct 2019 10:11:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1x9jK5iGjhn2UKiyqBvzJiOdXgI8Lounm92w3dtdmgh+zFpbdqLV1jAS7OA22NvBTOkz9Ew==
X-Received: by 2002:a1c:dfc4:: with SMTP id w187mr212734wmg.107.1570468282725;
        Mon, 07 Oct 2019 10:11:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2? ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
        by smtp.gmail.com with ESMTPSA id n17sm13127190wrp.37.2019.10.07.10.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:11:22 -0700 (PDT)
Subject: Re: [PATCH 10/16] x86/cpu: Detect VMX features on Intel, Centaur and
 Zhaoxin CPUs
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f26580de-d423-3369-42f4-682824dd592d@redhat.com>
Date:   Mon, 7 Oct 2019 19:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004215615.5479-11-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/19 23:56, Sean Christopherson wrote:
> +	/*
> +	 * The high bits contain the allowed-1 settings, i.e. features that can
> +	 * be turned on.  The low bits contain the allowed-0 settings, i.e.
> +	 * features that can be turned off.  Ignore the allowed-0 settings,
> +	 * if a feature can be turned on then it's supported.
> +	 */
> +	rdmsr(MSR_IA32_VMX_PINBASED_CTLS, ign, supported);

For QEMU, we're defining a feature as supported if a feature can be
turned both on and off.  Since msr_low and msr_high can be defined
respectively as must-be-one and can-be-one, the features become
"msr_high & ~msr_low".

Also, shouldn't this use the "true" feature availability MSRs if available?

Paolo
