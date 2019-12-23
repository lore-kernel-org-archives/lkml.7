Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5162DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D48D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCmUkhYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLWRJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:09:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48161 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726718AbfLWRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577120967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdGWVlIuDUVd73iaM6l6M5W4eKbIMhKZ4IFEX++PL4k=;
        b=PCmUkhYfq8P4P4nIIYZjUt+dvmvFeJdVq6QL6NLIOQB5KVI9YB7p/l0+iw1s4hSL9rcgOR
        42n5jCh84Spbqd0i/7UANz00RWtHUxyDNtkg8HB93SrS1tbeANxFOwMo+GBTaWWVZVsaAP
        JJwWGV95wtpPa3LetGw/nnD/L807soc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Mr-KwgBDMiKudJaWd8o_Xg-1; Mon, 23 Dec 2019 12:09:26 -0500
X-MC-Unique: Mr-KwgBDMiKudJaWd8o_Xg-1
Received: by mail-wr1-f71.google.com with SMTP id k18so7216965wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EdGWVlIuDUVd73iaM6l6M5W4eKbIMhKZ4IFEX++PL4k=;
        b=lqWwofJYBgIRIY3uiC8nxxgrf10FDjzvfIcCkZdWQU2M1bsQMG88wJFeb4J3rli0+d
         W44tb4t70K1mzwuel3lfb0H20HRt0erk4/AuNZ6ZoTNvdU2/I2ucMrjsIb0JYDnXXKzE
         IyqZ1uHQ1Q3fOHH6K/ngGmHnUvbGu8KcSbGieCRTjkB+FUW2V0g/FcvzORupZlJO7bjA
         fv138l7iycCrEDwRBftbPJNwSpfBiDJVJTfL4Y3vPUfq+8k7LvTMG3SEti/CxiqI4mxd
         pC4cPxwtfuqqtgryyvan6DWMw6XMcSIuQOJCP6nQ0V8EgdU5d/MfI+E2VZuJ5cAaA7gc
         eEng==
X-Gm-Message-State: APjAAAXtHrgx8ckcq/j+93oDfbK+rR3k4WrommWHQ6EsriQ20OAXflI5
        9Wmr0uCGaLNsg/Bw2MsRMppjHbKb/9oHznTfDcOmPwIq/mEUXGaIXFQcsFlCbdxUelf19cj75iw
        ZOq28oZuNQp6HRtjzILWjP2I8
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr32226457wrm.262.1577120965617;
        Mon, 23 Dec 2019 09:09:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNQPfEA2sNTGfQFSEHBoWItWIFd4rul0NNEzD8hlA+lN7HwX5wQlhvAll+fQlF/OOeNqywhw==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr32226438wrm.262.1577120965441;
        Mon, 23 Dec 2019 09:09:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c? ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
        by smtp.gmail.com with ESMTPSA id p18sm52547wmg.4.2019.12.23.09.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 09:09:24 -0800 (PST)
Subject: Re: [RESEND RFC 0/2] Paravirtualized Control Register pinning
To:     Liran Alon <liran.alon@oracle.com>,
        John Andersen <john.s.andersen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20191220192701.23415-1-john.s.andersen@intel.com>
 <1EBCD42E-9109-47A1-B959-6363A509D48D@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15b57d6b-0f46-01f5-1f75-b9b55db0611a@redhat.com>
Date:   Mon, 23 Dec 2019 18:09:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1EBCD42E-9109-47A1-B959-6363A509D48D@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/19 15:48, Liran Alon wrote:
>> Should userspace expose the CR pining CPUID feature bit, it must zero CR
>> pinned MSRs on reboot. If it does not, it runs the risk of having the
>> guest enable pinning and subsequently cause general protection faults on
>> next boot due to early boot code setting control registers to values
>> which do not contain the pinned bits.
> 
> Why reset CR pinned MSRs by userspace instead of KVM INIT handling?

Most MSRs are not reset by INIT, are they?

Paolo

