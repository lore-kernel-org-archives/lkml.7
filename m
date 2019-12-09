Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB25AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABF02072D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExJDK+V5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLIJPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:15:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726377AbfLIJPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575882910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfELO45T0KxxEI+GHyVFfpIjRmClA+hBogWql5/W6SQ=;
        b=ExJDK+V5n1so0L7bLDJGhk1EQYKtBcYFy3CoOOhBRRi+2k8Gcx4m18YW24jjz36kcjPT3R
        aVC9xcjNmSFPAoBv4nTu+tbtf0sMFacn2c7AhFdUCu4Oz5PzJ/VecuCL2CV1G7o9DDU89T
        9CEuF2pRwK6xteu3sNQoNkFHv18KZCA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-WrN5INItPUa1VT1J9QIr-A-1; Mon, 09 Dec 2019 04:15:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id f17so7247207wrt.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YfELO45T0KxxEI+GHyVFfpIjRmClA+hBogWql5/W6SQ=;
        b=SS6BC0iFIbYh7OhhZVW8NZpFy3d3U9EJ4eQPygnWB6I2V5gVKyBK4xFTpR7a26tohL
         jArWipDluTL+RovlakRNnJweWS+Of2UWkUoa9DNDe5kXJUP1Hj5Ws/kjdDI/SOPJiHyw
         f+dp/kS8clvlwkcRvQdOarcIUUSyHCQe91nrPa1+GPAmO363a7dGmT+XU/Evt02cz0RV
         GkBeOmZqsdHkBqq5y3NW4XWaAibSp5oaTMizg0USMueFGxXZjrFNzTJ5/emneX6ckNgi
         gE5nSGxLpWnqkIix6QYCmCEPrUZH4fEJVPuAex1mdw1dXfJhhKv0jVhRIed3N9GfHVgG
         7xlw==
X-Gm-Message-State: APjAAAUm/rhQcYRIMADCff9VveHF2d64+VmMQqgLzknoJbJ/AM+Q6Wlg
        xZdCeeDPRvQVEDVgWwSrKuo/bWO8MgwvhKYltYTl0B8u8R19Hx8IQwP+waqwSjavsNAynm9KGPp
        M2vOWNzWUL5P797/mcMpRpUhM
X-Received: by 2002:adf:df8e:: with SMTP id z14mr906550wrl.190.1575882908454;
        Mon, 09 Dec 2019 01:15:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzx+0F73j75Sg0V4zv67J/A/gwFnTAMcfnz17PTb7O/+EUxA4H0I9/yLw8pcSUGf1X5vymqMA==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr906513wrl.190.1575882908118;
        Mon, 09 Dec 2019 01:15:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id t81sm13500137wmg.6.2019.12.09.01.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 01:15:07 -0800 (PST)
Subject: Re: [PATCH RFC] KVM: x86: tell guests if the exposed SMT topology is
 trustworthy
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        kvm@vger.kernel.org
References: <20191105161737.21395-1-vkuznets@redhat.com>
 <de3cade3-c069-dc6b-1d2d-aa10abe365b8@redhat.com>
 <4f835a11-1528-a04e-9e06-1b8cdb97a04d@oracle.com>
 <87wob9d0t3.fsf@vitty.brq.redhat.com>
 <2e16b707-f020-22a3-a618-4960db917dfa@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8e0cd22-f61f-88e4-1594-6784fb39e41f@redhat.com>
Date:   Mon, 9 Dec 2019 10:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2e16b707-f020-22a3-a618-4960db917dfa@oracle.com>
Content-Language: en-US
X-MC-Unique: WrN5INItPUa1VT1J9QIr-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/19 21:31, Ankur Arora wrote:
>> If we, however, discuss other hints such 'pre-ACK' mechanism may make
>> sense, however, I'd make it an option to a 'challenge/response'
>> protocol: if host wants to change a hint it notifies the guest and waits
>> for an ACK from it (e.g. a pair of MSRs + an interrupt). I, however,
>
> My main reason for this 'pre-ACK' approach is some discomfort with
> changing the CPUID edx from under the guest.

Changing the CPUID is fine, if we document which CPUID can change.
There are CPUID leaves that change at runtime, for example in leaf 0Dh
(though in that case it's based on XCR0 and not on external circumstances).

> As we've discussed offlist, the particular hint I'm interested in is
> KVM_HINT_REALTIME. That's not a particularly good candidate though
> because there's no correctness problem if the host does switch it
> off suddenly. 

Or perhaps it's a good candidate, exactly because there's no correctness
problem.  For SMT topology, there are security issues if the host
doesn't respect it anymore, so making it changeable is of limited utility.

Paolo

