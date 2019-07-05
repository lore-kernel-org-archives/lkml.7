Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FDCC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BC2218C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfGENnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:43:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41372 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfGENnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:43:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so9985501wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z4BuVK5MHJZKRznczRER/njh+cqjMTnj6tQCtgEvnIM=;
        b=i/bm7U/czJuWyAQ0HerCi3ZFLN2K5175wxzd6MJH6jzH5izXyEiNLSbMi+e8ZU9f5F
         S3VhNGgrzmv1loX4EvzkRSwO4fCJdfGOThzpw8Qr2E0lXS7h4pqn+4xhREMoVG979pze
         jIWk3DIWFe7EegaEZ+Suze/DLQYaGRtlcY5ms+Qt+joCL6VRizcvDmdxP7303ypQ7p1Q
         jWzVj1vqj/KprjVFBSdPWiYmH9jfTE7EBirxWIWPsKigLvn9Q1cs8+qc1FD+mHKYwVoz
         a7cO3+CJvZsISjKFHjuQQoAA6q0LreBRGNowIqvSH3SjGfD+FHzjD17mgVPwr262j7Mf
         tK8g==
X-Gm-Message-State: APjAAAUFeO8D9WCzJCPvGJEeB/fHJnZiL7rYyLAYcDChsxvzEdGOgnHi
        +ovFUZ8Y9HI60xQAoz8FKC2ymg==
X-Google-Smtp-Source: APXvYqySB4V1DmbZ4ga2+U+9TKqDiRiwvoE7ChTFqhHXu+z7B/U2VlmAyeKhxAoUqMj8/okKLw99Jw==
X-Received: by 2002:adf:979a:: with SMTP id s26mr4242906wrb.13.1562334190153;
        Fri, 05 Jul 2019 06:43:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id c65sm8593960wma.44.2019.07.05.06.43.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:43:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: ARBPRI is a reserved register for x2APIC
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
References: <1562328872-27659-1-git-send-email-pbonzini@redhat.com>
 <2624F5BF-1601-4A7B-8CA2-7D3328184E46@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7335396e-d82f-456f-b086-3e8d613186b6@redhat.com>
Date:   Fri, 5 Jul 2019 15:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2624F5BF-1601-4A7B-8CA2-7D3328184E46@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 15:37, Nadav Amit wrote:
>> On Jul 5, 2019, at 5:14 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> kvm-unit-tests were adjusted to match bare metal behavior, but KVM
>> itself was not doing what bare metal does; fix that.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reported-by ?

I found it myself while running the tests, was there a report too?

Paolo
