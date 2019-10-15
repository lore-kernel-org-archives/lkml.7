Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A1ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BAA2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfJOIWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfJOIWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:22:01 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B163C049E36
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:22:01 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n3so8286287wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 01:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4XCdYGBXgpm0bocpCasqCHuINSD48ZL6bGb+DpNrsjk=;
        b=LtZWgmkI+n0r30xmlZyacaNgNA5AISLEQhiZ9wPx+3lfhEYGP5cbxjyEpq3SUyozVQ
         29qiochNZ6Pgk+jGA8XPrx5COp4arGPvHXWDX/0xBJiXR5k/WzPlHnqjlZGx7kv06N3R
         p8zdkyaQR6nj2kI6eA+PexREO0Ked5yEmzrjNao+olQSsb10VBZQfDi6ngnlNidGRxXW
         u3BFJEOK7YBFAqMWdCoXTHb5A3+kO7YyuwISIRlp+Xn6HZEL7PXyvtvdpWVWjG6Qsp/w
         ABqc/YfyjMuVKfRoeYSQOxDlw3QhPWNSTX1ysLzNhMJUTZeARdHX6ROzSbFKnhHOIFn/
         AlZg==
X-Gm-Message-State: APjAAAX88Z7im3sB/wSlBgcjdEWgHSunokjdVoSBJNyj1885Yt5CQcDx
        McE6EJxhlvGSD/yZVNOGP6ewYfIEXOusAV+CRp+zlWWorT6WCUpr+l3etG0yvZqeQJei1vhTxWW
        LDTTUE9CpLKc+RBWZGYGtTgGo
X-Received: by 2002:a1c:1a4c:: with SMTP id a73mr18125845wma.124.1571127719712;
        Tue, 15 Oct 2019 01:21:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKc8Jm/JgcHD/AD/1dyiUKrdBMoPSwMtLcSNr+lQLEPVUUfQPP0WRLafdscfoBCDPfVMeRYA==
X-Received: by 2002:a1c:1a4c:: with SMTP id a73mr18125819wma.124.1571127719363;
        Tue, 15 Oct 2019 01:21:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id n1sm26097437wrg.67.2019.10.15.01.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 01:21:58 -0700 (PDT)
Subject: Re: [PATCH 02/14] KVM: monolithic: x86: disable linking vmx and svm
 at the same time into the kernel
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20190928172323.14663-1-aarcange@redhat.com>
 <20190928172323.14663-3-aarcange@redhat.com>
 <20191015031619.GD24895@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <94f1e36e-90b8-8b7d-57a5-031c65e415c4@redhat.com>
Date:   Tue, 15 Oct 2019 10:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015031619.GD24895@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 05:16, Sean Christopherson wrote:
> I think short and sweet is enough for the prompt, with the details of how
> build both buried in the help text.
> 
> choice
> 	prompt "KVM built-in support"
> 	help
> 	  Here be a long and detailed help text.
> 
> config KVM_AMD_STATIC
> 	select KVM_AMD
> 	bool "KVM AMD"
> 
> config KVM_INTEL_STATIC
> 	select KVM_INTEL
> 	bool "KVM Intel"

Or even just

	bool "AMD"
	...
	bool "Intel"

> endchoice
> 
> The ends up looking like:
> 
>    <*>   Kernel-based Virtual Machine (KVM) support
>            KVM built-in support (KVM Intel)  --->
>    -*-   KVM for Intel processors support

On top of this, it's also nice to hide the KVM_INTEL/KVM_AMD prompts if
linking statically.  You can achieve that with

config KVM_INTEL
    tristate
    prompt "KVM for Intel processors support" if KVM=m
    depends on (KVM=m && m) || KVM_INTEL_STATIC

config KVM_AMD
    tristate
    prompt "KVM for AMD processors support" if KVM=m
    depends on (KVM=m && m) || KVM_AMD_STATIC

The left side of the "||" ensures that, if KVM=m, you can only choose
module build for both KVM_INTEL and KVM_AMD.  Having just "depends on
KVM" would allow a pre-existing .config to choose the now-invalid
combination

	CONFIG_KVM=y
	CONFIG_KVM_INTEL=y
	CONFIG_KVM_AMD=y

The right side of the "||" part is just for documentation, to avoid that
a selected symbol does not satisfy its dependencies.

Thanks,

Paolo
