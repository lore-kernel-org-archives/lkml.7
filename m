Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B012C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CA0214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FpoVLMQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfDXXrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:47:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35129 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfDXXrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:47:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so7570699wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PAHlGIM7St+qsV1Ngem2RwsCdlI4NRZiuOUVgp1sGdk=;
        b=FpoVLMQK+VVllxzrjL9cEBeQvupZXpmhffXl1TpTughf8jhUJbo6rqD478eJ+/XCbQ
         FKzmOGPMHhzvXRV72838CDN1bbdcm6uS8xP23DWBLqODRbNJjae3x/ip2DaY1MWVL0ki
         48jER4l2UFSDVsbxb3Nlp/oMm8phIeddlNrg4917CjvuenN6DH1Q1B+f3LZV+7ja+iqm
         oOp5mImzFTMJIyVtrhnZMwRrNGM6lK9Pl01w6MCv9EtdAaMLYUFvexv1PeFHOB9YnWRL
         8sqYwZxfoBumyhN6csDPsR4sOpCzwFvtsDWvbTESLOBE3n746XlTRDmSUR2BYOZNxtqV
         0itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PAHlGIM7St+qsV1Ngem2RwsCdlI4NRZiuOUVgp1sGdk=;
        b=j6zrTtOf/qiZTKKlkiYtVijdW4LwchacbZ+MzEVdpWBX5IkbKrUBpjtidC7YVxokcW
         gKpTx03MMIznPrt2rozZsWFlb7vtMeKotpYAm1mAFLD/ftWMWEH4PDKFaJ+T4RbWm+u6
         CUOjm2B09Sk4UPlIV4ywuJueTOAQjbB0dVAf4hhBwNOO5kqNbYxQ1WR7qL6fwaW7Q1Vt
         prYwL5Yj04T7KzFRBjSzBrU53zVpD6vRRLHSY60kco6UA5W+SJOgSAS/+edJbI85pSiq
         cJJyxrkyVr38LEfPR76DyfubrNSLTgdFM0jMHCyPWYK859xfWzc6ACAZNrSkDG9n4mb9
         6CKQ==
X-Gm-Message-State: APjAAAWmcVnhls8p269ABA3fKmryBZaxDxfbKyFlNtxV1jJ169QdZ7rg
        SMaba0xkkNCC8KNF2a2/Ta7MlS8WIk87IqEhDPT+RA==
X-Google-Smtp-Source: APXvYqw1VPdNaBoCLhHvyqzKyGnZwK7uYkl26K02RGzlwxvdtdWo8AJCP8ROeaTfvaxvpZIHA/eqiLDJ54Z7MfZvXek=
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr1108963wmc.54.1556149664151;
 Wed, 24 Apr 2019 16:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com> <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com> <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com> <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com> <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
 <8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com> <ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
 <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com> <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
 <1D51CB31-089A-4D71-A9C1-E54E50A56C46@arista.com> <1b7d37da-5660-f635-cd2f-619e5573d35a@linux.intel.com>
In-Reply-To: <1b7d37da-5660-f635-cd2f-619e5573d35a@linux.intel.com>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Thu, 25 Apr 2019 00:47:32 +0100
Message-ID: <CAPL0++4w6TDf38fh6LwAADR1w3b+nO5G7rZFM3LjDE-B20zbow@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can see two potential problems with these patches that should be addresse=
d:

The default domain of a group can be changed to type
IOMMU_DOMAIN_IDENTITY via the command line. With these patches we are
returning the si_domain for type IOMMU_DOMAIN_IDENTITY. There's a
chance the shared si_domain could be freed while it is still being
used when a group is freed. For example here in the
iommu_group_release:
https://github.com/torvalds/linux/blob/cd8dead0c39457e58ec1d36db93aedca811d=
48f1/drivers/iommu/iommu.c#L376
"if (group->default_domain)
    iommu_domain_free(group->default_domain);"

Also now that a domain is attached to a device earlier we should
implement the is_attach_deferred call-back and use it to defer the
domain attach from iommu driver init to device driver init when iommu
is pre-enabled in kdump kernel. like in this commit:
https://github.com/torvalds/linux/commit/df3f7a6e8e855e4ff533508807cd7c3723=
faa51f


On Tue, Apr 16, 2019 at 3:24 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi James,
>
> On 4/15/19 10:16 PM, James Sewart wrote:
> > Hey Lu,
> >
> >> On 10 Apr 2019, at 06:22, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >>
> >> Hi James,
> >>
> >> On 4/6/19 2:02 AM, James Sewart wrote:
> >>> Hey Lu,
> >>> My bad, did some debugging on my end. The issue was swapping out
> >>> find_domain for iommu_get_domain_for_dev. It seems in some situations=
 the
> >>> domain is not attached to the group but the device is expected to hav=
e the
> >>> domain still stored in its archdata.
> >>> I=E2=80=99ve attached the final patch with find_domain unremoved whic=
h seems to
> >>> work in my testing.
> >>
> >> Just looked into your v3 patch set and some thoughts from my end poste=
d
> >> here just for your information.
> >>
> >> Let me post the problems we want to address.
> >>
> >> 1. When allocating a new group for a device, how should we determine t=
he
> >> type of the default domain?
> >>
> >> 2. If we need to put a device into an existing group which uses a
> >> different type of domain from what the device desires to use, we might
> >> break the functionality of the device.
> >>
> >> My new thought is letting the iommu generic code to determine the
> >> default domain type (hence my proposed vendor specific default domain
> >> type patches could be dropped).
> >>
> >> If the default domain type is dynamical mapping, and later in iommu_no=
_mapping(), we determines that we must use an identity domain,
> >> we then call iommu_request_dm_for_dev(dev).
> >>
> >> If the default domain type is identity mapping, and later in
> >> iommu_no_mapping(), we determined that we must use a dynamical domain,
> >> we then call iommu_request_dma_domain_for_dev(dev).
> >>
> >> We already have iommu_request_dm_for_dev() in iommu.c. We only need to
> >> implement iommu_request_dma_domain_for_dev().
> >>
> >> With this done, your patch titled "Create an IOMMU group for devices
> >> that require an identity map" could also be dropped.
> >>
> >> Any thoughts?
> >
> > Theres a couple issues I can think of. iommu_request_dm_for_dev changes
> > the domain for all devices within the devices group, if we may have
> > devices with different domain requirements in the same group then only =
the
> > last initialised device will get the domain it wants. If we want to add
> > iommu_request_dma_domain_for_dev then we would still need another IOMMU
> > group for identity domain devices.
>
> Current solution (a.k.a. v3) for this is to assign a new group to the
> device which requires an identity mapped domain. This will break the
> functionality of device direct pass-through (to user level). The iommu
> group represents the minimum granularity of iommu isolation and
> protection. The requirement of identity mapped domain should not be a
> factor for a new group.
>
> Both iomm_request_dma_domain_for_dev() or iommu_request_dm_for_dev()
> only support groups with a single device in it.
>
> The users could choose between domains of DMA type or IDENTITY type for
> a group. If multiple devices share a single group and both don't work
> for them, they have to disable the IOMMU. This isn't a valid
> configuration from IOMMU's point of view.
>
> >
> > Both with v3 and the proposed method here, iommu_should_identity_map is
> > determining whether the device requires an identity map. In v3 this is
> > called once up front by the generic code to determine for the IOMMU gro=
up
> > which domain type to use. In the proposed method I think this would hap=
pen
> > after initial domain allocation and would trigger the domain to be
> > replaced with a different domain.
> >
> > I prefer the solution in v3. What do you think?
>
> The only concern of solution in v3 from my point of view is some kind of
> duplication. Even we can ask the Intel IOMMU driver to tell the default
> domain type, we might change it after boot up. For example, for 32-bit
> pci devices, we don't know whether it's 64-bit or 32-bit capable during
> IOMMU initialization, so we might tell iommu.c to use identity mapped
> domain. After boot up, we check it again, and find out that it's only
> 32-bit capable (hence only can access physical memory below 4G) and the
> default identity domain doesn't work. And we have to change it to DMA
> domain via iommu_request_dma_domain_for_dev().
>
> So to make it simple and straight-forward, we can just let iommu.c to
> determine the default domain type and after that the Intel IOMMU driver
> could tweak it according to the quirk bits in the driver.
>
> Best regards,
> Lu Baolu
