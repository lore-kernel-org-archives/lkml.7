Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A5DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDA52083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfHNMuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:50:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35495 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfHNMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:50:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so4361035wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 05:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIdOkJj+NCHUIyznIs60RDyt0NVOMuTgVRbV4NbgyKw=;
        b=tgxE4k9lg/Zer3SBL23RdN/ky/KQVpaYv1IKO9T1Fx1ByDLJPMiD70BH86w9zNxU0h
         yv/1nc+ncMd3ghoVkp3i7Kw4kJX4AURVzL1kCn9PYx3s8HaMX6BTwxAtxsVECeZtBCFP
         1IVWYEqmKjZgdAGQ/k7ZVf/nTM+b0LTpBE9lT33ioBHX7gWjGWpkqG1NFUnEwvoDuOht
         wl8CCeHyNbg4ZEwFSLs4NrrsALvWzLLIDXfEMB41pEt6GSkMbRk7qxzukGojfgPNT7ve
         XbTeESwW/rh0j6J9i80QinWllGut2i+dSaeJ4qOdJwGrKkAnosUuLeVWFZ9pgaULTLdR
         8KrQ==
X-Gm-Message-State: APjAAAVFc+B6xBVX3VcyX0JW3qXNOWZzQ0WPEui6tbWj8pz1hWEEHzlo
        vYHTTuKQplJRYn2U9yLXl1L1Cw==
X-Google-Smtp-Source: APXvYqy8MiEEUjvq7rGAdJGFImOXcGnh48g6y3RN2Di3ehrfNAs3jeflNUzl79F84DuabN//PnQOaQ==
X-Received: by 2002:a7b:c8cb:: with SMTP id f11mr8440647wml.138.1565787002603;
        Wed, 14 Aug 2019 05:50:02 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f17sm4210265wmj.27.2019.08.14.05.50.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 05:50:02 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: Periodically revaluate appropriate
 lapic_timer_advance_ns
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1565329531-12327-1-git-send-email-wanpengli@tencent.com>
 <fad8ceed-8b98-8fc4-5b6a-63bbca4059a8@redhat.com>
 <CANRm+CwMMUEyZXmiUu5Y8GA=BEUYGLw31CRyZTc2uA+ct4Bamg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ba07fb02-9b55-15e4-d240-24da59e09369@redhat.com>
Date:   Wed, 14 Aug 2019 14:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CwMMUEyZXmiUu5Y8GA=BEUYGLw31CRyZTc2uA+ct4Bamg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/19 11:06, Wanpeng Li wrote:
> On Fri, 9 Aug 2019 at 18:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 09/08/19 07:45, Wanpeng Li wrote:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> Even if for realtime CPUs, cache line bounces, frequency scaling, presence
>>> of higher-priority RT tasks, etc can cause different response. These
>>> interferences should be considered and periodically revaluate whether
>>> or not the lapic_timer_advance_ns value is the best, do nothing if it is,
>>> otherwise recaluate again.
>>
>> How much fluctuation do you observe between different runs?
> 
> Sometimes can ~1000 cycles after converting to guest tsc freq.

Hmm, I wonder if we need some kind of continuous smoothing.  Something like

        if (abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_DONE) {
                /* no update for random fluctuations */
		return;
	}

        if (unlikely(timer_advance_ns > 5000))
                timer_advance_ns = LAPIC_TIMER_ADVANCE_ADJUST_INIT;
        apic->lapic_timer.timer_advance_ns = timer_advance_ns;

and removing all the timer_advance_adjust_done stuff.  What do you think?

Paolo
