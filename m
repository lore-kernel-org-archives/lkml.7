Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1650C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A62218C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfGENma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:42:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51715 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfGENma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:42:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so8936442wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4iYb0bYihJJMXivPTPv/aHyJFdI8X6+6Oc7sOAPuN1M=;
        b=R/MF727vANL29lZIbalPtecrV9Yi2/Ez9Yyak6KGyXOoeuVS1Wn2q9FB23TY5FZwYH
         o5bUe6i22Tn9xuo2Wus6+mNTkb1/XLP+M5jys9xWB7vBgey7ClfNKBGmw06+6MtEx3rI
         2k4GXLdONzwzm4D6Qvsp/owDdwb4hmYFxM0bIi+WloSFYGjITo1dScYTjndurBv1QxyZ
         GuL4jkvQ048K4cpyyLOVxD5BgRxqYXolJ/iltHrdj+rMP9LpzwVGkFcavoYyHMRHNo8O
         hKOHqIa5XSliHWbFMgAtWW1Goj5LoINTM42gVeLRrUptFJizQT0N724hC/iQGQUZGGEh
         3cbA==
X-Gm-Message-State: APjAAAU9JCXycG3XDHjKM+YeNzGZt9R7s8SyC5mKqR2FXCFo1QZUxZYS
        pWtnee+kG+CO13qAKTdXdzUasQ==
X-Google-Smtp-Source: APXvYqwByfMM85jOStUZAupRZVHqj/o4S1sAo5LiNDj2LzVzhMiMpbI+BtNslxzqagrl2r99Avs0hQ==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr3748628wmg.86.1562334147882;
        Fri, 05 Jul 2019 06:42:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id j189sm8346421wmb.48.2019.07.05.06.42.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:42:26 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] KVM: LAPIC: Inject timer interrupt via posted
 interrupt
To:     Wanpeng Li <wanpeng.li@hotmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <1561110002-4438-1-git-send-email-wanpengli@tencent.com>
 <1561110002-4438-3-git-send-email-wanpengli@tencent.com>
 <587f329a-4920-fcbf-b2b1-9265a1d6d364@redhat.com>
 <HK2PR02MB4145BBA5B72DD70AC622FD0E80F50@HK2PR02MB4145.apcprd02.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7614bc43-d9b1-7287-deef-1494f61d0b58@redhat.com>
Date:   Fri, 5 Jul 2019 15:42:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <HK2PR02MB4145BBA5B72DD70AC622FD0E80F50@HK2PR02MB4145.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 15:32, Wanpeng Li wrote:
> -bool __read_mostly pi_inject_timer = 0;
> -module_param(pi_inject_timer, bool, S_IRUGO | S_IWUSR);
> +int __read_mostly pi_inject_timer = -1;
> +module_param(pi_inject_timer, int, S_IRUGO | S_IWUSR);

Use "bint" instead of "int" please, so that it accepts 0/1 only and
prints as Y/N.

Paolo
