Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35265C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018222054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfGJGUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:20:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42300 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJGUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:20:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id v15so930391eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 23:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OCbt8NMT/t7R6kfvNLimxFCsLyfy0iic4GSSQ/N6KvU=;
        b=mDGrk4gChxjRQnFWUYxN7ep3qYhTCdjq6Qiv0Oo769qTD+smhDwGaHqQDHK2lfSE70
         /kmD/r+BDHDKI9CXOymg30ZiVpGOut3LiK4JMc6EZxV1mOjrRY40a5DusXZlqe6Rp6QO
         Z+6kSNYVPkUaDkpRg1RDMTWEbnOJui3JZXxZkheT3s4rUpZz1+QQf+fpiC1TmpAsGisD
         bgZqdQ6RSXPs8Gt0yx9kWwrVWG/Dcfgg3T2Fm5i900UrTPd0uUkSvsJA0/2E/iQYTyM9
         Ep3UvtrvZWnpdiXBLKvRw4b+S8ym7QAT+zuKSuCCxnintTeEUJMNExwE1JLhqS0r2E6k
         DJSQ==
X-Gm-Message-State: APjAAAX9c4PXxktHOAGtB+TNAz5IZzWFuEmrVCCaZxw/QZUfPNmpA8bM
        jtCym47BBArVZE2k+FjblGagKA==
X-Google-Smtp-Source: APXvYqxkN9dHXefZERuD5bLK8SGMMlwY90+yq4ilhOu3Q/nF/K+Quq3Y6EozLJvP683WAaYA99tCCA==
X-Received: by 2002:a50:9489:: with SMTP id s9mr23062595eda.86.1562739638294;
        Tue, 09 Jul 2019 23:20:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423? ([2001:b07:6468:f312:19db:ad53:90ea:9423])
        by smtp.gmail.com with ESMTPSA id n1sm910730wrx.39.2019.07.09.23.20.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 23:20:37 -0700 (PDT)
Subject: Re: [RFC PATCH] x86: Remove X86_FEATURE_MFENCE_RDTSC
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>, Pu Wen <puwen@hygon.cn>,
        Borislav Petkov <bp@alien8.de>
References: <d990aa51e40063acb9888e8c1b688e41355a9588.1562255067.git.jpoimboe@redhat.com>
 <45f247d2-80f5-6c8c-d11e-965a3da8a88f@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a13c6a3-a13e-d3e5-0008-41a6d47a6eff@redhat.com>
Date:   Wed, 10 Jul 2019 08:20:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <45f247d2-80f5-6c8c-d11e-965a3da8a88f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/19 21:32, Lendacky, Thomas wrote:
>> AMD and Intel both have serializing lfence (X86_FEATURE_LFENCE_RDTSC).
>> They've both had it for a long time, and AMD has had it enabled in Linux
>> since Spectre v1 was announced.
>>
>> Back then, there was a proposal to remove the serializing mfence feature
>> bit (X86_FEATURE_MFENCE_RDTSC), since both AMD and Intel have
>> serializing lfence.  At the time, it was (ahem) speculated that some
>> hypervisors might not yet support its removal, so it remained for the
>> time being.
>>
>> Now a year-and-a-half later, it should be safe to remove.
>
> I vaguely remember a concern from a migration point of view, maybe? Adding
> Paolo to see if he has any concerns.

It would be a problem to remove the conditional "if
(boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))" from svm_get_msr_feature.  But
removing support for X86_FEATURE_MFENCE_RDTSC essentially amounts to
removing support for hypervisors that haven't been updated pre-Spectre.
 That's fair enough, I think.

Paolo
