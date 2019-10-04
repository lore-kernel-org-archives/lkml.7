Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD6CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DD3215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="gfxGPVaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbfJDUiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:38:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38404 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbfJDUiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:38:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so7072410wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skAE0yv65FpnWYSKjnu1eueJHObmclgqdYS8Pf8+I/s=;
        b=gfxGPVaWQe4goiBs+/E81XZaApl2EOVwJZVFW021/Z0udRY8gYnAiMT47APmQ+ypoZ
         IaHDVawvA33wl/OE7Oyyuv3bieyok7kGpMfrsNyR58ZOHm9UvTxf8gsh81crMR/mwsE+
         DKnX0OtqPf21vwGbMLrCsCUZHFqgbP+g5IeOXBU2G/Z2opKGc6zOfvSke1ox688ZE6cA
         6o0HWgxJD9NLUOaS0B6BbgTEgCjLl6V+D89tvk9OXeJQI3nJq/81A1bEVP3zzUgONVqd
         WMcnHkQ3GwVm4H5Ot5sm2V7AhTxH1Pffg9lMGoHWKnoYu4f8JbcqfO+RAu142sdDIlj7
         JQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skAE0yv65FpnWYSKjnu1eueJHObmclgqdYS8Pf8+I/s=;
        b=pCg26y/LOYfkHmPFZhBCFQUwovYlFwIsAp8blkFQsmpsw2vpDwBsGIvK0v8hRJP4Rl
         6BWJ+ERlUbGQePDF1CbJpmAN4XR3neYTgjOl1D8E92iwZZG8gnoqu9it+sF4PjNlCN6n
         LaYo2DUjNUHg5wmsB2J8enLK8dw9gVYdu3VeO0PEa5fo0lqH5qMR+n1xWi/Y9uS0ghGo
         ms1oOqBiGeq5iKd+iplcPZi2Ng/VBb1SAkyAIL+ZmvD2LYvK/RhZ3jXdUE1u1XbRChhI
         pozKRjT71xrhbpNYqS6zx9i0zzW2rrZAY0VhgYgbV+p/VAk3IPVGGdrluxJOR2ak21bi
         EOHQ==
X-Gm-Message-State: APjAAAXqAoh0aZftGgvS6KQ+fB3nnePuCFukvTwISf+eo3/1+KPcoTkg
        fx8NtZPdslriMIvgObLbwzvVi38PDhdSbQTLSynKcg==
X-Google-Smtp-Source: APXvYqzyMV9MupndO2O27UkHRxd6bN6vFHp8NNFlCcPiqfGOEpWYt1tSEzWQHCwIs1Xos3TV8BZ1f4zz8N/5gxBVL1U=
X-Received: by 2002:a1c:2bc7:: with SMTP id r190mr12951679wmr.143.1570221481014;
 Fri, 04 Oct 2019 13:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190301192017.39770-1-dianders@chromium.org> <CAJ+vNU0Ma5nG9_ThLO4cdO+=ivf7rmXiHZonF0HY0xx6X3R6Hw@mail.gmail.com>
 <5dce2964-8761-e7d0-8963-f0f5cb2feb02@arm.com> <CAJ+vNU0Q1-d7YDbAAEMqEcWnniqo6jLdKBbcUTar5=hJ+AC8vQ@mail.gmail.com>
 <1f6f7eb0-e1dc-d5a8-fb38-44c5bd839894@arm.com> <CAJ+vNU1Nd2p-ot2Qkj6vD9yD6gcYM-vm+snNWyt0ChgSqe4tBg@mail.gmail.com>
 <5cf9ec03-f6fb-8227-4ec5-62445038f283@arm.com> <CAJ+vNU28LrroW-XC4X2g3bdN171j0ieZenhYE1TrEM8yvKi=cQ@mail.gmail.com>
 <cb6392ff-fac6-300b-2e04-b34df8c42f28@arm.com>
In-Reply-To: <cb6392ff-fac6-300b-2e04-b34df8c42f28@arm.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 4 Oct 2019 13:37:49 -0700
Message-ID: <CAJ+vNU0kDseyqAMKAv+9+aw6wVKjBQcHcGD_8XgCy_KzZTM4Gg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling
 bypass by default
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>,
        Douglas Anderson <dianders@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm@vger.kernel.org, evgreen@chromium.org,
        tfiga@chromium.org, Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 11:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 04/10/2019 18:13, Tim Harvey wrote:
> [...]
> >>> No difference... still need 'arm-smmu.disable_bypass=n' to boot. Are
> >>> all four iommu-map props above supposed to be the same? Seems to me
> >>> they all point to the same thing which looks wrong.
> >>
> >> Hmm... :/
> >>
> >> Those mappings just set Stream ID == PCI RID (strictly each one should
> >> only need to cover the bus range assigned to that bridge, but it's not
> >> crucial) which is the same thing the driver assumes for the mmu-masters
> >> property, so either that's wrong and never could have worked anyway -
> >> have you tried VFIO on this platform? - or there are other devices also
> >> mastering through the SMMU that aren't described at all. Are you able to
> >> capture a boot log? The SMMU faults do encode information about the
> >> offending ID, and you can typically correlate their appearance
> >> reasonably well with endpoint drivers probing.
> >>
> >
> > Robin,
> >
> > VFIO is enabled in the kernel but I don't know anything about how to
> > test/use it:
> > $ grep VFIO .config
> > CONFIG_KVM_VFIO=y
> > CONFIG_VFIO_IOMMU_TYPE1=y
> > CONFIG_VFIO_VIRQFD=y
> > CONFIG_VFIO=y
> > # CONFIG_VFIO_NOIOMMU is not set
> > CONFIG_VFIO_PCI=y
> > CONFIG_VFIO_PCI_MMAP=y
> > CONFIG_VFIO_PCI_INTX=y
> > # CONFIG_VFIO_PLATFORM is not set
> > # CONFIG_VFIO_MDEV is not set
>
> No worries - since it's a networking-focused SoC I figured there was a
> chance you might be using DPDK or similar userspace drivers with the NIC
> VFs, but I was just casting around for a quick and easy baseline of
> whether the SMMU works at all (another way would be using Qemu to run a
> VM with one or more PCI devices assigned).
>
> > I do have a boot console yet I'm not seeing any smmu faults at all.
> > Perhaps I've mis-diagnosed the issue completely. To be clear when I
> > boot with arm-smmu.disable_bypass=y the serial console appears to not
> > accept input in userspace and with arm-smmu.disable_bypass=n I'm fine.
> > I'm using a buildroot initramfs rootfs for simplicity. The system
> > isn't hung as I originally expected as the LED heartbeat trigger
> > continues blinking... I just can't get console to accept input.
>
> Curiouser and curiouser... I'm inclined to suspect that the interrupt
> configuration might also be messed up, such that the SMMU is blocking
> traffic and jammed up due to pending faults, but you're not getting the
> IRQ delivered to find out. Does this patch help reveal anything?
>
> http://linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=29ac3648b580920692c9b417b2fc606995826517
>
> (untested, but it's a direct port of the one I've used for SMMUv3 to
> diagnose something similar)

This shows:
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000140, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
...
arm-smmu 830000000000.smmu0: Unexpected global fault, this could be serious
arm-smmu 830000000000.smmu0:     GFSR 0x80000002, GFSYNR0 0x00000002,
GFSYNR1 0x00000010, GFSYNR2 0x00000000
^^^ these two repeat over and over

>
> That said, it's also puzzling that no other drivers are reporting DMA
> errors or timeouts either - is there any chance that some device is set
> running by the firmware/bootloader and not taken over by a kernel driver?
>

anything is possible - I'm using the Cavium 'BDK' as boot firmware to
configure the board which sits in from of arm trusted firmare and
bootloader.

Tim
