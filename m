Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E268C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECD92083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GQmHEr6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfCSNf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:35:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35379 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfCSNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:35:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id d6so16036819eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Td+wNAQjVZtFW6fd0nuXAsJh8GloC1tCyoatZSwG1GQ=;
        b=GQmHEr6fdvVwpZ+AqwB+SSCFEy5g2qB3cT4sgLjqaKweIXTYqNOCMKgaR3cmy72+wk
         wnU5g4tT0+S0YVLOC+hiMbI/0DBiekzc3iwrTu5AbiWRMM+ivKN7sBIjRyhuxmFe/OkD
         On1AKV6uMPWShjXIQWbXFyePVlpo2MYN4lo1feZqBg25m8332dsiuEUkD4AhFd2KcgmZ
         RvWsj7RiN8a4Lp+1htCcDqBxLBXYm0fNHFIj1bm3s3VPWSKH+oGIdnmhDXKVwnkn+fG/
         +fR9Fj9NIwKkzqeDU1IsaTfMptKZxcsL0BdINplp9IeJCRjcgPgNc1BTkYMBqBlNISFN
         TZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Td+wNAQjVZtFW6fd0nuXAsJh8GloC1tCyoatZSwG1GQ=;
        b=WLVoJEObvzEVSho2IBVrlbe4/8T3wnFt5EWTwmqC/HdVFXxgMyC0XzBs/K5F0FNo1r
         4n+t6RhWlefTSPh5xegkxQEYdZYxOA+kr/2+JDSjfV16tFndYlGqY4Un7VygMBhdmvgd
         qk2VzH0YCsdlb2esLK4wqocys0QMjrAgePhJ/cdQrATAdti8I92aUr+EebnPgjWj+oUh
         xmRqUpcevxVI+5udzRqWabhGUbQHsrATKXb6xOMfi31H2pbvbacHVQAZNbohbacgTw9r
         r3Y3ZlL5RO+AjNo9DrdID/2/kkNg2Uen4Xn2vm4HAaLuvk53CdwaqYaJ/FcLBaVB915S
         n9SA==
X-Gm-Message-State: APjAAAWmvgZgcKib+6FMvecK2Qslnk89zqyoSbqzvcJQhKseCI4jAGJp
        OgfBOeMRmeSnVYlGmVOgZ42xLQ==
X-Google-Smtp-Source: APXvYqxE2Hee+R9/4qo0Qw/F+5x3AJDBQ8+UbBfMRhezq0Kw62iKUbV6N0+rwTVZqpFbH5ZPEPNA7A==
X-Received: by 2002:a17:906:d69:: with SMTP id s9mr3769403ejh.205.1553002526453;
        Tue, 19 Mar 2019 06:35:26 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i1sm3190505edi.15.2019.03.19.06.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 06:35:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <0e74cc54-bb90-a620-5763-466cb11aaef7@linux.intel.com>
Date:   Tue, 19 Mar 2019 13:35:21 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <94706334-3DE4-4964-8FDD-125C58D493A0@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <0e74cc54-bb90-a620-5763-466cb11aaef7@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

> On 15 Mar 2019, at 03:13, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/14/19 7:56 PM, James Sewart wrote:
>> Patches 1 and 2 are the same as v1.
>> v1-v2:
>>   Refactored ISA direct mappings to be returned by =
iommu_get_resv_regions.
>>   Integrated patch by Lu to defer turning on DMAR until iommu.c has =
mapped
>> reserved regions.
>>   Integrated patches by Lu to remove more unused code in cleanup.
>> Lu: I didn't integrate your patch to set the default domain type as =
it
>> isn't directly related to the aim of this patchset. Instead patch 4
>=20
> Without those patches, user experience will be affected and some =
devices
> will not work on Intel platforms anymore.
>=20
> For a long time, Intel IOMMU driver has its own logic to determine
> whether a device requires an identity domain. For example, when user
> specifies "iommu=3Dpt" in kernel parameter, all device will be =
attached
> with the identity domain. Further more, some quirky devices require
> an identity domain to be used before enabling DMA remapping, =
otherwise,
> it will not work. This was done by adding quirk bits in Intel IOMMU
> driver.
>=20
> So from my point of view, one way is porting all those quirks and =
kernel
> parameters into IOMMU generic layer, or opening a door for vendor =
IOMMU
> driver to determine the default domain type by their own. I prefer the
> latter option since it will not impact any behaviors on other
> architectures.

I see your point. I=E2=80=99m not confident that using the proposed door =
to set a=20
groups default domain has the desired behaviour. As discussed before the=20=

default domain type will be set based on the desired type for only the=20=

first device attached to a group. I think to change the default domain=20=

type you would need a slightly different door that wasn=E2=80=99t =
conditioned on=20
device.

For situations where individual devices require an identity domain =
because=20
of quirks then maybe calling is_identity_map per device in=20
iommu_group_get_for_dev is a better solution than the one I proposed.

>=20
>> addresses the issue of a device requiring an identity domain by =
ignoring
>> the domain param in attach_device and printing a warning.
>=20
> This will not work as I commented in that thread.
>=20
>> I booted some of our devices with this patchset and haven't seen any
>> issues. It doesn't look like we have any devices with RMRR's though =
so
>> those codepaths aren't tested.
>> James Sewart (7):
>>   iommu: Move iommu_group_create_direct_mappings to after =
device_attach
>>   iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>>   iommu/vt-d: Expose ISA direct mapping region via
>>     iommu_get_resv_regions
>>   iommu/vt-d: Ignore domain parameter in attach_device if device
>>     requires identity map
>>   iommu/vt-d: Allow IOMMU_DOMAIN_DMA to be allocated by iommu_ops
>>   iommu/vt-d: Remove lazy allocation of domains
>> Lu Baolu (1):
>>   iommu/vt-d: Enable DMA remapping after rmrr mapped
>>  drivers/iommu/intel-iommu.c | 444 =
+++++++++++-------------------------
>>  drivers/iommu/iommu.c       |   4 +-
>>  2 files changed, 131 insertions(+), 317 deletions(-)
>=20
> Best regards,
> Lu Baolu

Cheers,
James.

