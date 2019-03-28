Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1BF20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="SePLX0XN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfC1Shu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:37:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46990 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfC1Shu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:37:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so18109505edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=64oALEV1vlrauCd7QyZHoABet+8wuT9mjdQ6KJvfUo8=;
        b=SePLX0XNb0ipsvv+LFjYy1MeRM9kK5pi6TUQL8mr1rrDUhh1uqpanhAftDwFkp0gQG
         ayaa2qX6kZ1hZ5Lg8ZHveGaPKOPwhuK1QWL+Z6atQAYvkR/69G0H9BUXZj8GfEXDEA6t
         2KeXb/t40OvHMqYB5i4xuA67/tunXuZiiHQVikwBAyNZe16XncRg8XfSlU33Sf9ab8Va
         2+g5oXN0LUcJLfLCXf5ZJJtUJdO/UomV48ddoE5rDmgokAgJ+KplyGuUOsKyTDbNydQy
         Jw4gqjnBJ8YaIwNjp0bPv+dPr7cNcb4pXXpWWEzoQNZ3BUWn/KAqR1Aze02FMY+HGiAE
         uKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=64oALEV1vlrauCd7QyZHoABet+8wuT9mjdQ6KJvfUo8=;
        b=BwzSBiS8BKBRpeRwVqle7USt9YZjMA5O37sqL3EB/Hruh1yXuw5tKoJW43hFkL5w2G
         Xdz+AnykzdAfB2I3HsX/xwL8ItudctyHlbbgqiwTDNY3SYmh+DwcLiiY69LvqeLacjMs
         9oF462NOYVB6xOjZJZHCSKOubBgbjabAFq+eXa1kXDx+tQIp2MrFxQXttMU9KE9dHfCA
         n2IxBeOSVG/Ttz+tE3xJ0MJKMh2ulu20W0294l/AOUgRpo+lm8CpmHF2aSdymL3RfaVb
         5TiqbWXJlV4jdghR/Tk9ByA1hlRyil4rSat5tLXCGJkQMmUm26qAv/PuT9GOhIhKMWTy
         29tw==
X-Gm-Message-State: APjAAAUOXRG/5ywygJc2l5Z65Rnwnql5zI9ElFMUZCGx8IR+iSk9cdAl
        6g258KP2SJwmiyIHc2RkqE57IQx9m3zBPcM3
X-Google-Smtp-Source: APXvYqz0mFw/r7Qo1GDDnNraZBF128WEIA3iY5+o1ZC1CTaE+ncfBDqRPWojdfB27qfPkHVuOsHLZQ==
X-Received: by 2002:a50:e78a:: with SMTP id b10mr29869042edn.45.1553798268994;
        Thu, 28 Mar 2019 11:37:48 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o1sm5324391eja.18.2019.03.28.11.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 11:37:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
Date:   Thu, 28 Mar 2019 18:37:31 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
 <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
 <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

> On 26 Mar 2019, at 01:24, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/25/19 8:57 PM, James Sewart wrote:
>>>> Theres an issue that if we choose to alloc a new resv_region with =
type
>>>> IOMMU_RESV_DIRECT, we will need to refactor =
intel_iommu_put_resv_regions
>>>> to free this entry type which means refactoring the rmrr regions in
>>>> get_resv_regions. Should this work be in this patchset?
>>> Do you mean the rmrr regions are not allocated in get_resv_regions, =
but
>>> are freed in put_resv_regions? I think we should fix this in this =
patch
>>> set since this might impact the device passthrough if we don't do =
it.
>> They=E2=80=99re not allocated and not freed currently, only type =
IOMMU_RESV_MSI is
>> freed in put_resv_regions. If we allocate a new resv_region with type
>> IOMMU_RESV_DIRECT for the isa region, then it won=E2=80=99t be freed. =
If we modify
>> put_resv_regions to free type IOMMU_RESV_DIRECT, then we will try to =
free
>> the static RMRR regions.
>> Either the ISA region is static and not freed as with my =
implementation,
>> or the RMRR regions are converted to be allocated on each call to
>> get_resv_regions and freed in put_resv_regions.
>=20
> By the way, there's another way in my mind. Let's add a new region =
type
> for LPC devices, e.x. IOMMU_RESV_LPC, and then handle it in the same =
way
> as those MSI regions. Just FYI.

This solution would require adding some extra code to=20
iommu_group_create_direct_mappings as currently only type=20
IOMMU_RESV_DIRECT is identity mapped, other types are only reserved.


>=20
> Best regards,
> Lu Baolu

Cheers,
James.=
