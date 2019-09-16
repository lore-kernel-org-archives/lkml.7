Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F8BC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345682171F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzM0Z5Yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfIPM5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:57:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44845 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfIPM5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:57:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id p2so31779570edx.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aFLGIENEDQOBhys1thGsZ6higxQQlTaU+TMP6ccyh4Y=;
        b=PzM0Z5Yud8yQir7fH+iLf2GzB7onVdqE8GWsCpjrxxFYJxBz3iPT9RXPYlL5+7RLKJ
         B0eJPkBkayQnWh9BdA7YkAvCr7tdmd6rOOEtLgtzWV8Pj6mjjXMcN4xlDHCRcKOL9wsm
         CmHmGhktWLbIIAqF7npC02At32NC2WzAiBKxehoKv7M3d/Ngb4l237APpecOgFuQHl3A
         zqjX0k9imB+4Mk2R26QUJvtTO5yQoAQA9z9KE8XMmSJtv7CQ5cJwTbd+M9q8IMsO93EV
         9TnImA4fHSr00QdYOeuKatwfMrLxAwJC7oWye16o/qyVuO53YJGcy0GpivWpe1E24y+F
         sHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aFLGIENEDQOBhys1thGsZ6higxQQlTaU+TMP6ccyh4Y=;
        b=cRV/Z860RpPXh5mg5o6jXMHLJWe5Iz9+HS5n44GAxwp+ZiBNoueMh2zAFSEdqk95TX
         T2sYSWpGq5TiYTSE7G5lPozOyl6t2p7eWA8RGXFN+8eyXCkVHJgA7yIk+Fk1L8OV2WwF
         61+Y09qojxOv9gddo31PO52BQf1B0j7l/3xVqTThOonVk3AZwBYKT8xqERAqHHmdZyjP
         vEMEfkj8lMQlKeeb9L8WY5xMhJR6yo3cM4UJsdPpLadUko5lC+rz7KIrOGovI7mI15XE
         GnJrueI8Sk+vl5084jNG9hU8wU6rahkBjNmV66bdwi8viL8/iRqt//nN1ZfadhFTMOOt
         LaTg==
X-Gm-Message-State: APjAAAWk56Xw5aS23ATNdpIzEsdDoteWee7UbNurbBx5ZdcnTGrrZOmQ
        +NvgTzjp4v7dH9o0JKTe9Tgdzg==
X-Google-Smtp-Source: APXvYqx1oWgsSbWM8oAM35XecbDYmxBGz5TMfGulCgFf1MxD+hF1N4mXSrJxaw49dBgzMpBbsX+l6w==
X-Received: by 2002:aa7:c154:: with SMTP id r20mr40727034edp.268.1568638638822;
        Mon, 16 Sep 2019 05:57:18 -0700 (PDT)
Received: from [10.10.2.67] ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id o26sm1526150edi.23.2019.09.16.05.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 05:57:18 -0700 (PDT)
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Guo Ren <guoren@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, christoffer.dall@arm.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Julien Grall <julien.grall@arm.com>, gary@garyguo.net,
        linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Mike Rapoport <rppt@linux.ibm.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup.Patel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, james.morse@arm.com
References: <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <20190619091219.GB7767@fuggles.cambridge.arm.com>
 <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
 <20190619123939.GF7767@fuggles.cambridge.arm.com>
 <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
 <20190624104006.lvm32nahemaqklxc@willie-the-truck>
 <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
 <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
 <CAJF2gTT2c45HRfATF+=zs-HNToFAKgq1inKRmJMV3uPYBo4iVg@mail.gmail.com>
 <CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
Autocrypt: addr=jean-philippe@linaro.org; keydata=
 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
Message-ID: <057a0af3-93f7-271c-170e-4b31e6894c3c@linaro.org>
Date:   Mon, 16 Sep 2019 14:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/09/2019 09:13, Guo Ren wrote:
> Another idea is seperate remote TLB invalidate into two instructions:
> 
>  - sfence.vma.b.asyc
>  - sfence.vma.b.barrier // wait all async TLB invalidate operations
> finished for all harts.

It's not clear to me how this helps, but I probably don't have the whole
picture. If you have a place where it is safe to wait for the barrier to
complete, why not do the whole invalidate there?

> (I remember who mentioned me separate them into two instructions after
> session. Anup? Is the idea right ?) 
> 
> Actually, I never consider asyc TLB invalidate before, because current our
> light iommu did not need it.
> 
> Thx all people attend the session :) Let's continue the talk. 
> 
> 
> Guo Ren <guoren@kernel.org <mailto:guoren@kernel.org>> 于 2019年9月12日周
> 四 22:59写道：
> 
>     Thx Will for reply.
> 
>     On Thu, Sep 12, 2019 at 3:03 PM Will Deacon <will@kernel.org
>     <mailto:will@kernel.org>> wrote:
>     >
>     > On Sun, Sep 08, 2019 at 07:52:55AM +0800, Guo Ren wrote:
>     > > On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org
>     <mailto:will@kernel.org>> wrote:
>     > > > > I'll keep my system use the same ASID for SMP + IOMMU :P
>     > > >
>     > > > You will want a separate allocator for that:
>     > > >
>     > > >
>     https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.brucker@arm.com
>     > >
>     > > Yes, it is hard to maintain ASID between IOMMU and CPUMMU or different
>     > > system, because it's difficult to synchronize the IO_ASID when the CPU
>     > > ASID is rollover.
>     > > But we could still use hardware broadcast TLB invalidation instruction
>     > > to uniformly manage the ASID and IO_ASID, or OTHER_ASID in our IOMMU.
>     >
>     > That's probably a bad idea, because you'll likely stall execution on the
>     > CPU until the IOTLB has completed invalidation. In the case of ATS,
>     I think
>     > an endpoint ATC is permitted to take over a minute to respond. In
>     reality, I
>     > suspect the worst you'll ever see would be in the msec range, but that's
>     > still an unacceptable period of time to hold a CPU.
>     Just as I've said in the session that IOTLB invalidate delay is
>     another topic, My main proposal is to introduce stage1.pgd and
>     stage2.pgd as address space identifiers between different TLB systems
>     based on vmid, asid. My last part of sildes will show you how to
>     translate stage1/2.pgd to as/vmid in PCI ATS system and the method
>     could work with SMMU-v3 and intel Vt-d. (It's regret for me there is
>     no time to show you the whole slides.)
> 
>     In our light IOMMU implementation, there's no IOTLB invalidate delay
>     problem. Becasue IOMMU is very close to CPU MMU and interconnect's
>     delay is the same with SMP CPUs MMU (no PCI, VM supported).
> 
>     To solve the problem, we could define a async mode in sfence.vma.b to
>     slove the problem and finished with per_cpu_irq/exception.

The solution I had to this problem is pinning the ASID [1] used by the
IOMMU, to prevent the CPU from recycling the ASID on rollover. This way
the CPU doesn't have to wait for IOMMU invalidations to complete, when
scheduling a task that might not even have anything to do with the IOMMU.

In the Arm SMMU, ASID and IOASID (PASID) are separate identifiers. IOASID
indexes an entry in the context descriptor table, which contains the ASID.
So with unpinned shared ASID you don't need to invalidate the ATC on
rollover, since the IOASID doesn't change, but you do need to modify the
context descriptor and invalidate cached versions of it.

Once you have pinned ASIDs, you could also declare that IOASID = ASID. I
don't remember finding an argument to strictly forbid it, even though ASID
and IOASID have different sizes on Arm (respectively 8/16 and 20 bits).

Thanks,
Jean

[1]
https://lore.kernel.org/linux-iommu/20180511190641.23008-17-jean-philippe.brucker@arm.com/
