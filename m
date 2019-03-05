Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E2DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C872082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NiZXeTEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCELPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:15:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34171 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfCELPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:15:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id a16so6913830edn.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 03:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MUpC6SQ0LIVqs8hRm/Z88oOlGmVcnEBMtrIl1l/x8K0=;
        b=NiZXeTEGjkQIqarc5ofzN4lr+6ryle/EkNLNB1ryJ/71AI2sDunOa5Gu2oyeqOZxMx
         c6keviMx/VpUrkdWZbblxlyEp2TGUi12f9QOCBaF40WWDAqZ+707iwuwGy9C+HQa7yUQ
         WhtezUHuWk0vy3dXnm6w0n75ZOBEQa/6fzbfpafCe5tEnL7OQ5F36bCnsgT/FxXUkE8H
         Y9V1ftG2Pq2eI73dnvGfChWdfD+xEartgeVVg0ELp6KhJeS1aiet5YvqkAKv9+3TH0Mf
         tzUVd7Ci7HXUNvl9Iti7KwTyvILJRT0wsrsvBUI4f07HlF5PmLzojOYDY+5cCCbWPhHJ
         ZsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MUpC6SQ0LIVqs8hRm/Z88oOlGmVcnEBMtrIl1l/x8K0=;
        b=lXPtTIwBVd+0RznzR3fqQZZ+FYya0rGwpvEREfBpb6Ix0MQtaYalxlrezqBhWY4GT4
         RJQNAjHGT0izd7el8UXmRp+a4BtFplpxwU0rFNA+kMgRx+3Z698rrZ2CMN4HD1Gkffw1
         Y/URs/rhPqw+5DidUF1dnPFlsZkrwb58wF06pziqK1liAxTF+rxxaydo25jtaPISKA6J
         2aj2GE78xS/3xfdR3coSpC3dXCbJQBR6y4cDhkDn1OqpCRRHSrv9t6UmqrblLWDbzODY
         /joJk9Jg6iIy89MpgIl1BdSMxHJpaCEfnOqaecLMJTlOyxrpoPWqEbxv2V7It6gNOhZy
         eMxA==
X-Gm-Message-State: APjAAAUKfRVuxG6ul92/f30SgImvL2NqcNExdNEe8w3/lbkuOABFmK3F
        LUEfDu7rgTC1V1s8m3sgBQKoGw==
X-Google-Smtp-Source: APXvYqzf3iTCtFo45+ZbiNpQioucthuVkYlRXkpByu5OZYCtw2YAaTmau+yyJlfmCjo+ccUMBObqvQ==
X-Received: by 2002:a17:906:a456:: with SMTP id cb22mr15764095ejb.80.1551784528503;
        Tue, 05 Mar 2019 03:15:28 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c50sm2944822edc.81.2019.03.05.03.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 03:15:27 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 0/4] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <dfad72a1-ce47-35bd-d965-27ef2e8bd504@linux.intel.com>
Date:   Tue, 5 Mar 2019 11:14:27 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <855ED37F-2E4A-4BDD-9B09-64C41179C319@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <dfad72a1-ce47-35bd-d965-27ef2e8bd504@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

The motivation for this is buggy domain <-> IOMMU group relationship =
when=20
using find_or_alloc_domain. =46rom what I have read it should be the =
case=20
that an IOMMU domain is shared by all devices in the same group, thus =
the=20
same mappings. This is because the IOMMU group is determined by things=20=

like ACS settings on pci switches which determines whether devices can=20=

talk to each other.

In find_or_alloc_domain we only determine domain sharing based on =
devices=20
returned by pci_for_each_dma_alias, whereas there are many more checks =
in=20
pci_device_group(e.g. ACS settings of intermediary pci switches), which =
is=20
used for determining which IOMMU group a device is in. This =
discontinuity=20
means it can be the case that each device within an IOMMU group will =
have=20
different domains.

We see issues as it is supposed to be safe to assume that devices within =
a=20
group should be considered to be in the same address space, but if each=20=

device has its own domain then any mapping created won=E2=80=99t be =
valid for the=20
other devices, and even could be mapped differently for each device. =
This=20
also could cause issues with a device whose RMRR's are not applied to =
the=20
domains of other devices within its group, these regions could be =
remapped=20
for the other devices resulting in unexpected behaviour during=20
peer-to-peer transfers.

Cheers,
James


> On 5 Mar 2019, at 06:05, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> Very glad to see this. Thank you!
>=20
> On 3/4/19 11:41 PM, James Sewart wrote:
>> Hey,
>> This patchset moves IOMMU_DOMAIN_DMA iommu domain management to =
iommu.c.
>> This avoids the use of find_or_alloc_domain whose domain assignment =
is
>> inconsistent with the iommu grouping as determined by =
pci_device_group.
>=20
> Is this a bug fix or an improvement? What's the real issue will it =
cause
> if we go without this patch set?
>=20
> Best regards,
> Lu Baolu
>=20
>> Patch 3 permits domain type IOMMU_DOMAIN_DMA to be allocated via the
>> iommu_ops api, allowing the default_domain of an iommu group to be =
set in
>> iommu.c. This domain will be attached to every device that is brought =
up
>> with an iommu group, and the devices reserved regions will be mapped =
using
>> regions returned by get_resv_regions.
>> In intel_iommu_domain_alloc we don=E2=80=99t know the IOMMU this =
domain will be
>> associated with so we defer full initialisation until
>> intel_iommu_attach_device. Currently iommu.c:iommu_group_add_device =
will
>> try to map a devices reserved regions before attaching the domain =
which
>> would cause issue if the domain is not fully initialised. This is
>> addressed in patch 1 by moving the mapping to after attaching.
>> Patch 2 implements function apply_resv_region, used in
>> iommu_group_create_direct_mappings to mark the reserved regions as =
non
>> mappable for the dma_map_ops api.
>> Patch 4 removes the domain lazy allocation logic. Before this patch =
the
>> lazy allocation logic would not be used as any domain allocated using
>> these paths would be replaced when attaching the group default =
domain.
>> Default domain allocation has been tested with and without this patch =
on
>> 4.19.
>> Cheers,
>> James.
>> James Sewart (4):
>>   iommu: Move iommu_group_create_direct_mappings to after =
device_attach
>>   iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>>   iommu/vt-d: Allow IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY to be =
allocated
>>   iommu/vt-d: Remove lazy allocation of domains
>>  drivers/iommu/intel-iommu.c | 329 =
++++++++++++------------------------
>>  drivers/iommu/iommu.c       |   4 +-
>>  2 files changed, 108 insertions(+), 225 deletions(-)

