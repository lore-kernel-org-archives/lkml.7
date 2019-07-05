Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBEBC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD0E20828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfGENAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:00:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGENAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:00:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so8802435wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkjJN9pn3JzWHjcbg2XmZ5SMAe2wfwVxdSS9lT7yctY=;
        b=Tp4yauVQsJw3MR51+tyMY1d1RDA46X5Qn43nnhBuzPgYPKymN1Tt3BWELZGV6dMXsS
         iZ5A825w2o6xM/mbhT2svWkVZ0NwySwUMAyCQdVSPROTli11xYDkbx9zRr02XcfJwCvK
         oEkKiRDwqs2W0IYv3mSiEEu+U5N0+k4+8cuL2m5i7n+vT4vrHOaZATadFcW2eIyDA0yl
         s0xR896BMxoiJRFTUowtFVJI1kN7LJmOxHsTMpxp3POUicT1NVFfDLCVD7Z5MIfO0R5P
         xZeWchhEM+zg7YTmSJgW/xM9Vupqdnhgw8P8+Xwa6QHyN+g5/YC9QnZ/cWYEOlJOTsHP
         x1WA==
X-Gm-Message-State: APjAAAUFIJaPDt6s5BHW0AnjM1Rk6Vz3mY1ZyvTzZpOEb58iYYaRPtSY
        V52yHv4nHMZAv4DNdqEUjQiyvA==
X-Google-Smtp-Source: APXvYqy0PtZB/6YxP9lkmvnMNPYrehBnhSukC5m5JWWRYdRBvtZJYSigB53fBVEQSPMi4BkFUu/fIA==
X-Received: by 2002:a1c:4803:: with SMTP id v3mr3562900wma.49.1562331644991;
        Fri, 05 Jul 2019 06:00:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id m24sm7280293wmi.39.2019.07.05.06.00.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:00:44 -0700 (PDT)
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
 <HK2PR02MB4145E122DC5AC2445137A10F80F50@HK2PR02MB4145.apcprd02.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e57b9a2-28e3-13b9-969a-ef1e3f55067e@redhat.com>
Date:   Fri, 5 Jul 2019 15:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <HK2PR02MB4145E122DC5AC2445137A10F80F50@HK2PR02MB4145.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 14:52, Wanpeng Li wrote:
>> Also, do you want to disable the preemption timer if pi_inject_timer and
>> enable_apicv are both true?
> 
> I have already done this in vmx_set_hv_timer().

Right, sorry!

Paolo
