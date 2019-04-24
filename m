Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09937C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBACF2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FWABCsfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfDXTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:54:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46327 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbfDXTyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:54:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so17011162edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoQw6rZ1McAuWA48g8wjk6m9xf3EqIUgssJwMcJF7eQ=;
        b=FWABCsfcDUGiyw2AJKt7/tqGtquTmKrMJwtTDm1UIkIn8sIiysQkYo7zN6jnpoWRJu
         n8Epr+xkic8xVfW6yServfaij14CAu17uMVbu7rd2T7Vvbprewku9FXUATHZnBIVdbY7
         45QxR360C3F9+Ll07NAgZN33BbNEPdTtrzen1OEp9crUlA0msc8afRtjDxrK7nKLmdOK
         bUiuaaAovpjYhEllJzUhXyfQKylPL4N42gNnURUhDynBR3JpC+Rv9eTXRWEp4eZSXHeL
         4c0w7t8Io4Lqq7Ip/pH4e98jRSL8a0IXICT1C8XkWF01hWJej9QkvoWCQ57PBfig9XLC
         Dh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoQw6rZ1McAuWA48g8wjk6m9xf3EqIUgssJwMcJF7eQ=;
        b=CBmB488phimThpJDRMrmdlnmHTqb64x6qKLd11KwV4samG+3fVDpZEeAlPsdRoAwN+
         q8BfHT1f9tYCjCK0ikbiyOBnPzIeerJrBMNg8xcBiJeSiPYPTgcYPBLluAv9eXe1tnQT
         9n5QkVG1m+y7cfH2zZq3RzKWK8Soi/TbySG/fmsTKttEyiR+80zttzBp5NHhMFFd/rye
         Nr1Wackit41lJ9RDc1iDBF8yys2WuvDz2R0pUtpiXo4LlifJqV63cnd0d/67w2hNfniQ
         yqeCgp2OrWZrbbHI0RwZvu9CffGVrNfyFhpqt13Qe50rBeG/Utfq0/YrMUOI4HuTppC/
         0FEA==
X-Gm-Message-State: APjAAAVzUSlFurjhmyEoYZi5FDlF/KAcXfdFG/6GfN7jC3KLD3xmZ6DM
        Q7tHphiKD3XrvwAh2mx9pJAOeex38OewLYEXJVtIsw==
X-Google-Smtp-Source: APXvYqwIKfB190CTRW4eiQZHchohbyuWQ9ao6ccKR/jzQFiEa1MtpZ8e5nsTiBNSRhDrst2+6ow+bgf4eCZZRpTH1gk=
X-Received: by 2002:aa7:cf8f:: with SMTP id z15mr18858819edx.190.1556135677145;
 Wed, 24 Apr 2019 12:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190423203843.2898-1-pasha.tatashin@soleen.com>
 <7f7499bd-8d48-945b-6d69-60685a02c8da@arm.com> <CA+CK2bCD11x64pJj5gSnsu5jsUqJyU6o+=J4K8oYAsHqz9ULqQ@mail.gmail.com>
In-Reply-To: <CA+CK2bCD11x64pJj5gSnsu5jsUqJyU6o+=J4K8oYAsHqz9ULqQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 24 Apr 2019 15:54:26 -0400
Message-ID: <CA+CK2bB5ahqLrekkTUSdzTE2BPSPbB9nk6nKs+LjTap2oF8X-w@mail.gmail.com>
Subject: Re: [PATCH] arm64: configurable sparsemem section size
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
        rppt@linux.vnet.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        andrew.murray@arm.com, james.morse@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<resending> from original email

On Wed, Apr 24, 2019 at 3:48 PM Pavel Tatashin
<patatash@linux.microsoft.com> wrote:
>
> On Wed, Apr 24, 2019 at 5:07 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> > On 04/24/2019 02:08 AM, Pavel Tatashin wrote:
> > > sparsemem section size determines the maximum size and alignment that
> > > is allowed to offline/online memory block. The bigger the size the less
> > > the clutter in /sys/devices/system/memory/*. On the other hand, however,
> > > there is less flexability in what granules of memory can be added and
> > > removed.
> >
> > Is there any scenario where less than a 1GB needs to be added on arm64 ?
>
> Yes, DAX hotplug loses 1G of memory without allowing smaller sections.
> Machines on which we are going to be using this functionality have 8G
> of System RAM, therefore losing 1G is a big problem.
>
> For details about using scenario see this cover letter:
> https://lore.kernel.org/lkml/20190421014429.31206-1-pasha.tatashin@soleen.com/
>
> >
> > >
> > > Recently, it was enabled in Linux to hotadd persistent memory that
> > > can be either real NV device, or reserved from regular System RAM
> > > and has identity of devdax.
> >
> > devdax (even ZONE_DEVICE) support has not been enabled on arm64 yet.
>
> Correct, I use your patches to enable ZONE_DEVICE, and  thus devdax on ARM64:
> https://lore.kernel.org/lkml/1554265806-11501-1-git-send-email-anshuman.khandual@arm.com/
>
> >
> > >
> > > The problem is that because ARM64's section size is 1G, and devdax must
> > > have 2M label section, the first 1G is always missed when device is
> > > attached, because it is not 1G aligned.
> >
> > devdax has to be 2M aligned ? Does Linux enforce that right now ?
>
> Unfortunately, there is no way around this. Part of the memory can be
> reserved as persistent memory via device tree.
>         memory@40000000 {
>                 device_type = "memory";
>                 reg = < 0x00000000 0x40000000
>                         0x00000002 0x00000000 >;
>         };
>
>         pmem@1c0000000 {
>                 compatible = "pmem-region";
>                 reg = <0x00000001 0xc0000000
>                        0x00000000 0x80000000>;
>                 volatile;
>                 numa-node-id = <0>;
>         };
>
> So, while pmem is section aligned, as it should be, the dax device is
> going to be pmem start address + label size, which is 2M. The actual
> DAX device starts at:
> 0x1c0000000 + 2M.
>
> Because section size is 1G, the hotplug will able to add only memory
> starting from
> 0x1c0000000 + 1G
>
> > 27 and 28 do not even compile for ARM64_64_PAGES because of MAX_ORDER and
> > SECTION_SIZE mismatch.
>
> Can you please elaborate what configs are you using? I have no
> problems compiling with 27 and 28 bit.
>
> Thank you,
> Pasha
