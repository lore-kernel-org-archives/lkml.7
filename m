Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 14:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B512920717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 14:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbfINOBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 10:01:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35283 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbfINOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 10:01:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so9631240plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 07:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=SXwC5T6wCRhaSBRQu04uBARGF1aDUDc2HyVfMMcCfp8=;
        b=SCVHZIrywLbmty/LMXdlXjKcx/2ZcrhFdFrRSVBT93CPCrqzmkKmHJ7RDpe0OLnwUf
         M2M7XvfPUhs67MWCsdeh30GZVgtDANGYByqdW4xyxvfgwMvre8wfSAWbj9jg0wfXR9lJ
         CJQLP53nW6Kz+yD0iZq1pmeEATQUsJwgazrxXLwqdTCDn+SPG4X8iucXH+kl+shqdsqQ
         m+aEjn1Jrh4FFSmfWF2Iq19tAecTmtnDB5OP0cc6cXrHHLf1wNjHDrxttTSb3XlRVw15
         XdCpsfMukpJVW4XdQNfnED+y5eeqEHgS5M2UZ2FQGqA8H0mhEmzYOWcduoUmODe4HWA9
         9TFA==
X-Gm-Message-State: APjAAAWB6NxGVATDfF5vrr7JXd7E6rt7lVsd8bxzNHg1a5bd5z/bDZtK
        LpBf/8frY3QwsS2VIlJtPTDDvw==
X-Google-Smtp-Source: APXvYqwLzMQI8pZxkVqd8/Fy8A16315KeB9n6NzIBBSxCASBhPGKSRyvm9h7GHG8COZItU0wdTcuOQ==
X-Received: by 2002:a17:902:d685:: with SMTP id v5mr16361073ply.15.1568469690307;
        Sat, 14 Sep 2019 07:01:30 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id u17sm6671227pgf.8.2019.09.14.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 07:01:29 -0700 (PDT)
Date:   Sat, 14 Sep 2019 07:01:29 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 07:00:16 PDT (-0700)
Subject:     Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a separate file
In-Reply-To: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
CC:     guoren@kernel.org, Will Deacon <will.deacon@arm.com>,
        julien.thierry@arm.com, aou@eecs.berkeley.edu, james.morse@arm.com,
        Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>, julien.grall@arm.com,
        gary@garyguo.net, Paul Walmsley <paul.walmsley@sifive.com>,
        christoffer.dall@arm.com, linux-riscv@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     will@kernel.org
Message-ID: <mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019 07:02:56 PDT (-0700), will@kernel.org wrote:
> On Sun, Sep 08, 2019 at 07:52:55AM +0800, Guo Ren wrote:
>> On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
>> > > I'll keep my system use the same ASID for SMP + IOMMU :P
>> >
>> > You will want a separate allocator for that:
>> >
>> > https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.brucker@arm.com
>>
>> Yes, it is hard to maintain ASID between IOMMU and CPUMMU or different
>> system, because it's difficult to synchronize the IO_ASID when the CPU
>> ASID is rollover.
>> But we could still use hardware broadcast TLB invalidation instruction
>> to uniformly manage the ASID and IO_ASID, or OTHER_ASID in our IOMMU.
>
> That's probably a bad idea, because you'll likely stall execution on the
> CPU until the IOTLB has completed invalidation. In the case of ATS, I think
> an endpoint ATC is permitted to take over a minute to respond. In reality, I
> suspect the worst you'll ever see would be in the msec range, but that's
> still an unacceptable period of time to hold a CPU.
>
>> Welcome to join our disscusion:
>> "Introduce an implementation of IOMMU in linux-riscv"
>> 9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V MC
>
> I attended this session, but it unfortunately raised many more questions
> than it answered.

Ya, we're a long way from figuring this out.
