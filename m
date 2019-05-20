Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A785220862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbfETKfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:35:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40524 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731376AbfETKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:35:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id 15so8423954wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TDeq1R0ZlxS3eYDtruCGOeX8Ha3Jxa2VQZkw5KkPaxY=;
        b=BRZpdPbCwDQ2OqC+pdmDexHkdOLyTpjhaJ9i/JvF3rLkiusfyWNZgNVksRxyYAxLqa
         k+D6LMqxXei4AYUNP4yNqpvihY8KQPOFo18oQwcfADnVxFBOUUyAeTesCw+EDfAIUmGT
         9XmmLMssjerUAcEJ5IhzDtcc4sqqGhqCBpA8QkZ7XtZX0nGtDtwtjhE4brjBoTFqCi9V
         L7QALMORJv12avOlEKHW5/ZnNE8R00ehSrsPTa7d+F2XVRxLorZuxHGTwn38KhvDiSE6
         81i5Bt6epnjNxvI1xSwC2LrKvbWeyL9fJKFLI8wW2rDzh5dDwUaBwF7pY4H/8aJQAGpU
         R55w==
X-Gm-Message-State: APjAAAUlvk1JIaEqRWcjjCs+VMu0nylbgJnkDprWSuR3SZpFQWSJgYr5
        lghc0GiBx36bZsbkNeDVe3J0+LXGg5Y=
X-Google-Smtp-Source: APXvYqwn/wTJt8p+PuqGYx7YYCzZyxsT5ZwMQNjlbn4FMnuwgXauUwZBRMlrQ25Gm7MW5C+8kJe+sQ==
X-Received: by 2002:a1c:a904:: with SMTP id s4mr16653129wme.92.1558348498438;
        Mon, 20 May 2019 03:34:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id x6sm25589007wru.36.2019.05.20.03.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:34:57 -0700 (PDT)
Subject: Re: [PATCH RESEND 2/4] KVM: X86: Emulate MSR_IA32_MISC_ENABLE MWAIT
 bit
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <1558082990-7822-1-git-send-email-wanpengli@tencent.com>
 <1558082990-7822-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e96eecd6-7095-58b3-32a7-2cfde2f2ebcc@redhat.com>
Date:   Mon, 20 May 2019 12:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558082990-7822-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/19 10:49, Wanpeng Li wrote:
> MSR IA32_MSIC_ENABLE bit 18, according to SDM:
> 
> | When this bit is set to 0, the MONITOR feature flag is not set (CPUID.01H:ECX[bit 3] = 0).
> | This indicates that MONITOR/MWAIT are not supported.
> |
> | Software attempts to execute MONITOR/MWAIT will cause #UD when this bit is 0.
> |
> | When this bit is set to 1 (default), MONITOR/MWAIT are supported (CPUID.01H:ECX[bit 3] = 1).
> 
> The CPUID.01H:ECX[bit 3] ought to mirror the value of the MSR bit,
> CPUID.01H:ECX[bit 3] is a better guard than kvm_mwait_in_guest().
> kvm_mwait_in_guest() affects the behavior of MONITOR/MWAIT, not its
> guest visibility.
> 
> This patch implements toggling of the CPUID bit based on guest writes
> to the MSR.

Won't this disable mwait after migration, unless IA32_MISC_ENABLE is set
correctly by firmware or userspace?  I think you need to hide this
behind KVM_CAP_DISABLE_QUIRKS.  (Also, what is the reason for this
change in general besides making behavior closer to real hardware?)

Thanks,

Paolo
