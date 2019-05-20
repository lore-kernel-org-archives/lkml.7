Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD3C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762A220656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbfETLdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:33:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41931 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbfETLdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:33:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so13904566wro.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7yhZpsDUhANl2Z2Dw10e3o+cyHg6NesHSnxHIjr6nRg=;
        b=BN3esJ4UnIoyuPJ7nUb9WA2DpcYbRHZczzhOM70YIz5ExdLBUUHwH2beUG3nl6sptS
         tk1K/hx7sopHwDrewrgH7pCHwYJZ61UOObsKw5BNznmymgG0Mfg5HwDKJXgpF3n2STSx
         Fo+i9gJEj77pRXSR8RE6s5rebxAHyabIxTMEzi3S+/BjnuprEwwJnoySP3q3vhMQjK/f
         hm/CT97pmSOegKf++Lh/wxAMHUZOqXsNUFZ6WGmr7ZYZKjurd/z7zM91CXGsAsgM665e
         SHqIkngdKGTC1S8d2N/LotlIdGtZkC+v9W8lbbNWtFJbC7WS/mNNAUjGh6Gk1Uq1hMsj
         WzSg==
X-Gm-Message-State: APjAAAUBZE/hnPGwbwCyC342tat28evfLvr8ltW7wvx5/a+FRLqHjwAQ
        X7lT/ws7QVnIWhDqTMCxjsx8+Q==
X-Google-Smtp-Source: APXvYqwvNe9RKnRbqyhGMHN2J8QriyDrZzVPw1rR8tiyL92RyU7WMYn5vjJxKdYvlKh9B9swK89fww==
X-Received: by 2002:adf:8306:: with SMTP id 6mr32920357wrd.155.1558352010019;
        Mon, 20 May 2019 04:33:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id z20sm20168646wmf.14.2019.05.20.04.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:33:29 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] KVM: LAPIC: Delay trace advance expire delta
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1558340289-6857-1-git-send-email-wanpengli@tencent.com>
 <1558340289-6857-5-git-send-email-wanpengli@tencent.com>
 <b80a0c3b-c5b1-bfd1-83d7-ace3436b230e@redhat.com>
 <CANRm+CyDpA-2j28soX9si5CX3vFadd4_BASFzt1f4FbNNNDzyw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd60e5c2-e3c5-80fc-3a1d-c75809573945@redhat.com>
Date:   Mon, 20 May 2019 13:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CyDpA-2j28soX9si5CX3vFadd4_BASFzt1f4FbNNNDzyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 13:22, Wanpeng Li wrote:
>>
>> We would like to move wait_lapic_expire() just before vmentry, which would
>> place wait_lapic_expire() again inside the extended quiescent state.  Drop
>> the tracepoint, but add instead another one that can be useful and where
>> we can check the status of the adaptive tuning procedure.
> https://lkml.org/lkml/2019/5/15/1435
> 
> Maybe Sean's comment is reasonable, per-vCPU debugfs entry for
> adaptive tuning and wait_lapic_expire() tracepoint for hand tuning.

Hmm, yeah, that makes sense.  The location of the tracepoint is a bit
weird, but I guess we can add a comment in the code.

Paolo
