Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6094C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3190218C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfGEMqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:46:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44124 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfGEMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:46:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so8583805wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+rUgDFc8Xj3OzxPRTReIh2TVRm86cFh+ybCvMQ5Hic=;
        b=os9KWC5kyC9si7+qqUNr4ehybHU8+frhGN/MZ1hBp9XEEE9u3rYEY33j5Q2hklh+6j
         1bUmHOEsviDiz1Z/Hy95gWbjAj1strBcOg3W0zhO45lxd1LBe6Zc5uBuip+vJVI+tWk5
         Dw8h21ceIVAgUhXwfzvwc/CwAccsV5lVhX0lDgwnHA2UvTPB7dr21TScOH/Q4zwlXJmx
         jv5YDVz94eDBRuCBNRTsnMEFpci59b2trL2AsbGwXo41KN9MuZ16+vSAyH/MCaaoy0rg
         tpvLUqIOVgENOn/8P5LbkRPxyAOYzect4+gMk7Url21zq1XNGG1Em1OZmXe+eAkRj8G8
         NNyQ==
X-Gm-Message-State: APjAAAX9K6mNPKEuFOI1Avixj9DArUgHoP5DZrEx71faSrkvumTiVIWu
        gcXJ/Li2n8F2AeUfofROm/HWGA==
X-Google-Smtp-Source: APXvYqyqp47fm5Ov3nASK6uQBAIXIoVpy72iyvaVIJ7JLTUX/Dy715g93EFgYnDXLc0la/0pbC5toA==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr4271400wri.334.1562330771790;
        Fri, 05 Jul 2019 05:46:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id t140sm9922367wmt.0.2019.07.05.05.46.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 05:46:11 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: ARBPRI is a reserved register for x2APIC
To:     Liran Alon <liran.alon@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1562328872-27659-1-git-send-email-pbonzini@redhat.com>
 <D76638DF-1934-4B1C-84CD-FFCE11AA175F@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8926d53-173b-c525-1c6e-36df9315337a@redhat.com>
Date:   Fri, 5 Jul 2019 14:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <D76638DF-1934-4B1C-84CD-FFCE11AA175F@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 14:37, Liran Alon wrote:
>> +	u64 rmask = 0x43ff01ffffffe70cULL;
> Why not rename this to “used_bits_mask” and calculate it properly by macros?
> It seems a lot nicer than having a pre-calculated magic.

Yes, I wanted to do the same but I didn't have time right now.  I am
planning to cleanup after the merge window, but if a patch comes soon I
can apply it instead of course. :)

Something like

#define APIC_VALID_REG_MASK(reg)	(1ull << ((reg) >> 4))
#define APIC_VALID_REGS_MASK(first, count) \
	(APIC_VALID_REG_MASK(first) * (1ull << ((count) - 1)))

followed by

	if (offset > 0x3f0 ||
	    !(valid_regs_mask & APIC_VALID_REG_MASK(offset))

Paolo

> -Liran
> 

