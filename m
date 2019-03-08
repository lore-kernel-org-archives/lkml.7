Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8362085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bwIyArRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCHQ6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:58:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34689 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfCHQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:58:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id a16so16975597edn.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yf11JY4QW5DYIgcSOJXbLDEFlf/lVTxt6UlHCia5XY0=;
        b=bwIyArRYqixgIvVQ7TJAPLeD+w+Bt3Nleit1iINymcs70Q9HLXzZitRrWktO0WXF9B
         kbHAdKKFMj5gisUiPoaMPMeKJHXZx8RJZhsJz0CheRVi5CeEKLhQJ4o+UzUwxVi8V784
         +gsexLFarTOIl5faiLmrO3yuaEQPIYSRxox88IgeHOXQOHt+3FYBZduk7g83qg4UvYKs
         7TqkrWJq9txulO64nLs+A8A7K4nBlZUU+hc+nCqC17+I+As3iyIQORlfAXBMDUthYH2h
         Dm+EEGjDdH4BOR+OnUIre23paFIsJiNMKs6AkplfH3Tk/mBqVxm/VF0b+Lae8rNrqM1v
         N5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yf11JY4QW5DYIgcSOJXbLDEFlf/lVTxt6UlHCia5XY0=;
        b=igV3mTNfa7WMiXmENaqDjR+6DN7Emz24TA4+SVjRvFGmcPOYxGHLG6ibyAYJsLQB7l
         02hnnIIVFjhYJ5CI6yZDUbAX6IF8OCUNThEhYPsoor76xKCFc4MT8YkyIcYi84nJ41j1
         7qyy0Wf7KQkmMpLp6ehBsRO55Fwk8G9ApPdgMrZ6cmK+Ys4Vzb88im0+QPmHjN0vGLaq
         dyCmVIyFTSA1jGB8KJEEsHrntDEtz2LizGcWd8Pa/oEncxN1zkDQ6lArsEUUuiCl4KM6
         9ArCZnA91Az9slP2pTt8fc5Pud9E5m+ZYtF6DGBvmvqW6AwZt5zaEtRx8JUdtnlnsx5c
         2+4g==
X-Gm-Message-State: APjAAAWi/2z1t24vL8OofNsaMmqRmF4aqBUrdADdUQO2U3eTl1HAn74l
        kjqgQR+CrZq9tLEn4dKokKoubMMA1Cw=
X-Google-Smtp-Source: APXvYqw+ucFa281PRVFoVi3tbL8h5oYOYU2/PCtUDpfrHrLvNTlEbws5VX3Lm6PS4UfA20dzhPkFcw==
X-Received: by 2002:a17:906:1e0f:: with SMTP id g15mr12179568ejj.166.1552064286392;
        Fri, 08 Mar 2019 08:58:06 -0800 (PST)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b10sm2263067edy.80.2019.03.08.08.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 08:58:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <bb9c941b-05b6-27aa-d0ca-1d9c56f8f277@linux.intel.com>
Date:   Fri, 8 Mar 2019 16:57:03 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5E61244-386C-4FD8-AAF8-3135F471B92E@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
 <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
 <4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
 <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
 <A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
 <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
 <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
 <bb9c941b-05b6-27aa-d0ca-1d9c56f8f277@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

> On 8 Mar 2019, at 03:09, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/7/19 6:21 PM, James Sewart wrote:
>> Hey Lu,
>>> On 7 Mar 2019, at 06:31, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>=20
>>> Hi James,
>>>=20
>>> On 3/7/19 2:08 AM, James Sewart wrote:
>>>>>>>> -	/*
>>>>>>>> -	 * For each rmrr
>>>>>>>> -	 *   for each dev attached to rmrr
>>>>>>>> -	 *   do
>>>>>>>> -	 *     locate drhd for dev, alloc domain for dev
>>>>>>>> -	 *     allocate free domain
>>>>>>>> -	 *     allocate page table entries for rmrr
>>>>>>>> -	 *     if context not allocated for bus
>>>>>>>> -	 *           allocate and init context
>>>>>>>> -	 *           set present in root table for this bus
>>>>>>>> -	 *     init context with domain, translation etc
>>>>>>>> -	 *    endfor
>>>>>>>> -	 * endfor
>>>>>>>> -	 */
>>>>>>>> -	pr_info("Setting RMRR:\n");
>>>>>>>> -	for_each_rmrr_units(rmrr) {
>>>>>>>> -		/* some BIOS lists non-exist devices in DMAR =
table. */
>>>>>>>> -		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
>>>>>>>> -					  i, dev) {
>>>>>>>> -			ret =3D iommu_prepare_rmrr_dev(rmrr, =
dev);
>>>>>>>> -			if (ret)
>>>>>>>> -				pr_err("Mapping reserved region =
failed\n");
>>>>>>>> -		}
>>>>>>>> -	}
>>>>>>>> -
>>>>>>>> -	iommu_prepare_isa();
>>>>>>> Why do you want to remove this segment of code?
>>>>>> This will only work if the lazy allocation of domains exists, =
these
>>>>>> mappings will disappear once a default domain is attached to a =
device and
>>>>>> then remade by iommu_group_create_direct_mappings. This code is =
redundant
>>>>>> and removing it allows us to remove all the lazy allocation =
logic.
>>>>> No exactly.
>>>>>=20
>>>>> We need to setup the rmrr mapping before enabling dma remapping,
>>>>> otherwise, there will be a window after dma remapping enabling and
>>>>> rmrr getting mapped, during which people might see dma faults.
>>>> Do you think this patch instead should be a refactoring to simplify =
this initial domain setup before the default domain takes over? It seems =
like duplicated effort to have both lazy allocated domains and =
externally managed domains. We could allocate a domain here for any =
devices with RMRR and call get_resv_regions to avoid duplicating RMRR =
loop.
>>>=20
>>> Agree. We should replace the lazy allocated domains with default =
domain
>>> in a clean way. Actually, your patches look great to me. But I do =
think
>>> we need further cleanups. The rmrr code is one example, and the =
identity
>>> domain (si_domain) is another.
>>>=20
>>> Do you mind if I work on top of your patches for further cleanups =
and
>>> sign off a v2 together with you?
>> Sure, sounds good. I=E2=80=99ll fixup patch 3 and have a go at =
integrating
>> iommu_prepare_isa into get_resv_regions. This should make the initial
>> domain logic here quite concise.
>=20
> Here attached three extra patches which I think should be added before
> PATCH 3/4, and some further cleanup changes which you can merge with
> PATCH 4/4.
>=20
> ----------------
>=20
> 0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch
> 0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch
>=20
> These two patches aim to add a generic method for vendor specific =
iommu
> drivers to specify the type of the default domain for a device. Intel
> iommu driver will register an ops for this since it already has its =
own
> identity map adjudicator for a long time.

This seems like a good idea, but as domain alloc is only called for the=20=

default domain on first device attached to a group, we may miss checking=20=

whether a device added later should have an identity domain. Should =
there=20
be paths to downgrade a groups domain if one of the devices requires =
one?

>=20
> ----------------
>=20
> 0008-iommu-vt-d-Enable-DMA-remapping-after-rmrr-mapped.patch
>=20
> This aims to address the requirement of rmrr identity map before
> enabling DMA remapping. With default domain mechanism, the default
> domain will be allocated and attached to the device in bus_set_iommu()
> during boot. Move enabling DMA remapping engines after bus_set_iommu()
> will fix the rmrr issue.

Thats pretty neat, avoids any temporary domain allocation, nice!

>=20
> ----------------
>=20
> 0009-return-si_domain-directly.patch
>=20
> I suggest that we should keep current si_domain implementation since
> changing si_domain is not the purpose of this patch set. Please merge
> this with PATCH 3/4 if you like it.

Seems reasonable.

>=20
> ----------------
>=20
> 0010-iommu-vt-d-remove-floopy-workaround.patch
> 0011-iommu-vt-d-remove-prepare-rmrr-helpers.patch
> 0012-iommu-vt-d-remove-prepare-identity-map-during-boot.patch
>=20
> Above patches are further cleanups as the result of switching to =
default
> domain. Please consider to merge them with PATCH 4/4.

Nice, good catch.

>=20
> ----------------
>=20
> I have done some sanity checks on my local machine against all =
patches.
> I can do more tests after you submit a v2.
>=20
>=20
> Best regards,
> Lu Baolu
>=20
>=20
> =
<0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch><0007-iom=
mu-vt-d-Add-is_identity_map-ops-entry.patch><0008-iommu-vt-d-Enable-DMA-re=
mapping-after-rmrr-mapped.patch><0009-return-si_domain-directly.patch><001=
0-iommu-vt-d-remove-floopy-workaround.patch><0011-iommu-vt-d-remove-prepar=
e-rmrr-helpers.patch><0012-iommu-vt-d-remove-prepare-identity-map-during-b=
oot.patch>

I have revised my patches and hope to do some testing before reposting.

Cheers,
James.

