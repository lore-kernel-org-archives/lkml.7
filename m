Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B34C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D903206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbfKEKly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:41:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388374AbfKEKlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:41:53 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3254EC04BD48
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 10:41:53 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k10so12100043wrl.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3vylQMkUJh1NXv5AFs3p/CsrpHsIgE1o4KfqJUtKnnU=;
        b=WMchjW9Wv4Cfv0ybs8ATdAtSbq4s5za856aUr8EjISC2cLfIeFg+GqZudiUuzFd5WF
         S4gisQd8bCtSXRnvYPZJa7ReD/9ouNgMbUumPHmZdjOFGg1I245G5GcwMeTTMQF8VHQA
         kN8gyZDzizAWtqs6TmZ0982GeEoB0JZ+j0r9kD+Zo5zAJhdXUD2Wxqvr4kVvqaOkU/IT
         m+AldaeXyvPZ7Xh4MljyvOic0/O8Kt91/s4rZuwZ+XAKUI4AVLPKwh1asYxsbOTYJ+KL
         SEp/Jy1moPF3taLqXIwfTkvFMugGbaIypmodYpC26pYeaKPp4E9466Qu+1xLftSYF2ef
         UJPA==
X-Gm-Message-State: APjAAAU+xQmAK+G1Eb/qoK4/XLDbxA98GUSY76y7t3Hwwxly/RgSZp+/
        +S0IcGf4MlTwPgJEEFyonnkdEbBlODc4Wixr75zM4V1+B2jhX7AP8vptFklEwt4b48KNORO8q6A
        EXPznnbp5//y737q+VimZOXp9
X-Received: by 2002:a5d:5262:: with SMTP id l2mr25986583wrc.113.1572950511841;
        Tue, 05 Nov 2019 02:41:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfoLKwc5pAWdk0OCSA0xTHrEjoP5MvmPQspAvCPnkr63IGdyS+ZblecRis4POVc+BNXaFJWQ==
X-Received: by 2002:a5d:5262:: with SMTP id l2mr25986564wrc.113.1572950511557;
        Tue, 05 Nov 2019 02:41:51 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id o18sm22977007wrm.11.2019.11.05.02.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:41:50 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: Dynamically allocating MSR number
 lists(msrs_to_save[], emulated_msrs[], msr_based_features[])
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20191105092031.8064-1-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8ab7565c-df06-b5a5-d02d-899ba976414b@redhat.com>
Date:   Tue, 5 Nov 2019 11:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191105092031.8064-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/19 10:20, Chenyi Qiang wrote:
> The three msr number lists(msrs_to_save[], emulated_msrs[] and
> msr_based_features[]) are global arrays of kvm.ko, which are
> initialized/adjusted (copy supported MSRs forward to override the
> unsupported MSRs) when installing kvm-{intel,amd}.ko, but it doesn't
> reset these three arrays to their initial value when uninstalling
> kvm-{intel,amd}.ko. Thus, at the next installation, kvm-{intel,amd}.ko
> will initialize the modified arrays with some MSRs lost and some MSRs
> duplicated.
> 
> So allocate and initialize these three MSR number lists dynamically when
> installing kvm-{intel,amd}.ko and free them when uninstalling.

I don't understand.  Do you mean insmod/rmmod when you say
installing/uninstalling? Global data must be reloaded from the ELF file
when insmod is executed.

How is the bug reproducible?

Paolo
