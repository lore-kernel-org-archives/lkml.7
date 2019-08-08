Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C31C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5023D2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfHHIyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:54:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54711 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbfHHIyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:54:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so1565435wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JAn+ykN3unM/kToCkFC1Tvb8JYP1HBbyyihRZZ3yBqQ=;
        b=CWydY864glS1a1u3KqPQKmUSm+nAtwCQezCp3wmN62oIYkhTnTsXkbkaV+lYqFGoIi
         VqXYJh1dVHjjaSPw7UhTTsun3La7VIDyNoAKdGHsC4niEfMA7CuLUzkDvQ+WzKA7FY21
         hUAkgOF3Vq+aRJ0aQKzgaJ4gjD8zcCqZfDcpgUN6CpYWTgLtp7nP/Ur4mHbkGHn8WPkv
         uuUmyCuCiY8lwfgq2SM2PF4zgRzxN1qzYxQgmPOhqCUSXRFgBcSmTnn7LmHh1ZNOMmid
         Lp4+7PZ9555B5bUngopkuhSPIUMuTedHFy9SGeuXYhB6yW9HvZhMNn4gKnt1G0aPDOVp
         klIw==
X-Gm-Message-State: APjAAAWzhD+2nVb6LKyej6WDgNCNHNEFH3YqeGin4k1qs6uqP0HrTGoH
        5cAFOEQnQeC3OODu8iDQlzCteinEkHydAQ==
X-Google-Smtp-Source: APXvYqy+/8dJb7VrhwMfhRjrQU4n2YvttWFHTmu72C0vK873zAhbFw4cxB+jQKcpkaP1SGPLf1vp5w==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr3050248wmj.152.1565254484135;
        Thu, 08 Aug 2019 01:54:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b42d:b492:69df:ed61? ([2001:b07:6468:f312:b42d:b492:69df:ed61])
        by smtp.gmail.com with ESMTPSA id j9sm105900449wrn.81.2019.08.08.01.54.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 01:54:43 -0700 (PDT)
Subject: Re: [PATCH v4 00/20] KVM RISC-V Support
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190807122726.81544-1-anup.patel@wdc.com>
 <4a991aa3-154a-40b2-a37d-9ee4a4c7a2ca@redhat.com>
 <alpine.DEB.2.21.9999.1908071606560.13971@viisi.sifive.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <df0638d9-e2f4-30f5-5400-9078bf9d1f99@redhat.com>
Date:   Thu, 8 Aug 2019 10:54:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1908071606560.13971@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/19 01:15, Paul Walmsley wrote:
> On Wed, 7 Aug 2019, Paolo Bonzini wrote:
> 
>> On 07/08/19 14:27, Anup Patel wrote:
>>> This series adds initial KVM RISC-V support. Currently, we are able to boot
>>> RISC-V 64bit Linux Guests with multiple VCPUs.
>>
>> Looks good to me!  Still need an Acked-by from arch/riscv folks if I
>> have to merge it, otherwise they can take care of the initial merge.
> 
> Since almost all of the patches touch arch/riscv files, we'll plan to 
> merge them through the RISC-V tree.  Care to ack patch one, and send tags 
> for any other patches as you think might be appropriate?

Patch 1, 3-20:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

In your 5.4 pull requests, it's best if you add a note that all RISC-V
KVM patches were acked and reviewed by me.  I'll also include a shoutout
about RISC-V KVM in my own pull request.

However, for Linux releases after 5.4 I would rather get pull requests
for arch/riscv/kvm from Anup and Atish without involving the RISC-V
tree.  Of course, they or I will ask for your ack, or for a topic
branch, on the occasion that something touches files outside their
maintainership area.  This is how things are already being handled for
ARM, POWER and s390 and it allows me to handle conflicts in common KVM
files before they reach Linus; these are more common than conflicts in
arch files.  If you have further questions on git and maintenance
workflows, just ask!

Paolo
