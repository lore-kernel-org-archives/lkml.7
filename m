Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07884C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F1B20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ohP5ctvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfDOORg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:17:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35270 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:17:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id y67so1573668ede.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2RZaeAv+eqJ722KuXxMWvVJUMBptaLufbtc0h7dNhY4=;
        b=ohP5ctvwsWeO2EoS3ztuH2OLHRFqIhelMxBuN6GGyFYcrZ57Ub7yZnDd7jqQ+cMnNe
         y07a9VCTM67sfIK6JWjUhu10kjuGU9sIFk4angf0JSR2gor9wLJR1nhmaWBmtqC8/oN7
         up08qj6Mg3ER/Hy02Y/Aa6KA268D5kkRJ+QPHz7ZspDoXOn8Gt1T+S6NEN5RmUo4831f
         deJe/y3/M1E/I2ChIV3ls5u2cowgQA5grDeOEOZWoLIzTjjVs4dCeoeh+RaySkS8ifHr
         oRNnKNGYPweVQBQaXdcOuDUM/jTR4sH2XtCI35X1b6Wx298coCGcxQMfiCl6fy7Px8gi
         3//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2RZaeAv+eqJ722KuXxMWvVJUMBptaLufbtc0h7dNhY4=;
        b=ohQpnnZIACm6iXVKwfDmVLjcmyHFupSX3FRFjC38W5YVE+6wAZaenuo55v3H0XsJmh
         2mLSeurdPwEUOcr1jMB+Sc69LKdALrjhHrOALLw7iHs5Tw/aTKyc6H1UDvoh4GE5AVpH
         Mv2IYALrG9Bl4Lw4RS8N06GFs9CB10ylAVIZXlFFJn2QWx28rp44mnbefqZV4nDzs2Ie
         M4h4apwA6U5Uq2tMCl1DFWAcMvt0ObrVw/qCBBLe5WuJuk2MKxASGj9YjG617VP82eid
         sST9QQG/7V6fCKnJjoYZO8GANYMA78AnUnJRRvKkwBoFUNvqWgiX4ehKDLotwoWSebHV
         Np2w==
X-Gm-Message-State: APjAAAWBGHEwZqCYW+jTiiZpT3PZunh9hQaEtPz2Mkl0/w8RuQLPAjXc
        YArLv/e8/gP04424Af8C4/iJlA==
X-Google-Smtp-Source: APXvYqxwTCc+h0GnVrjXkxPREHIwykDrHaykShpxhVxLj2GzPIwHvzoE31mINAa3kg1KsjeRIBT2Kg==
X-Received: by 2002:a17:906:4d4e:: with SMTP id b14mr11641741ejv.68.1555337854494;
        Mon, 15 Apr 2019 07:17:34 -0700 (PDT)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s14sm4576593eda.26.2019.04.15.07.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:17:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
Date:   Mon, 15 Apr 2019 15:16:59 +0100
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D51CB31-089A-4D71-A9C1-E54E50A56C46@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
 <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
 <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
 <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
 <8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
 <ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
 <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
 <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

> On 10 Apr 2019, at 06:22, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 4/6/19 2:02 AM, James Sewart wrote:
>> Hey Lu,
>> My bad, did some debugging on my end. The issue was swapping out
>> find_domain for iommu_get_domain_for_dev. It seems in some situations =
the
>> domain is not attached to the group but the device is expected to =
have the
>> domain still stored in its archdata.
>> I=E2=80=99ve attached the final patch with find_domain unremoved =
which seems to
>> work in my testing.
>=20
> Just looked into your v3 patch set and some thoughts from my end =
posted
> here just for your information.
>=20
> Let me post the problems we want to address.
>=20
> 1. When allocating a new group for a device, how should we determine =
the
> type of the default domain?
>=20
> 2. If we need to put a device into an existing group which uses a
> different type of domain from what the device desires to use, we might
> break the functionality of the device.
>=20
> My new thought is letting the iommu generic code to determine the
> default domain type (hence my proposed vendor specific default domain
> type patches could be dropped).
>=20
> If the default domain type is dynamical mapping, and later in =
iommu_no_mapping(), we determines that we must use an identity domain,
> we then call iommu_request_dm_for_dev(dev).
>=20
> If the default domain type is identity mapping, and later in
> iommu_no_mapping(), we determined that we must use a dynamical domain,
> we then call iommu_request_dma_domain_for_dev(dev).
>=20
> We already have iommu_request_dm_for_dev() in iommu.c. We only need to
> implement iommu_request_dma_domain_for_dev().
>=20
> With this done, your patch titled "Create an IOMMU group for devices
> that require an identity map" could also be dropped.
>=20
> Any thoughts?

Theres a couple issues I can think of. iommu_request_dm_for_dev changes=20=

the domain for all devices within the devices group, if we may have=20
devices with different domain requirements in the same group then only =
the=20
last initialised device will get the domain it wants. If we want to add=20=

iommu_request_dma_domain_for_dev then we would still need another IOMMU=20=

group for identity domain devices.

Both with v3 and the proposed method here, iommu_should_identity_map is=20=

determining whether the device requires an identity map. In v3 this is=20=

called once up front by the generic code to determine for the IOMMU =
group=20
which domain type to use. In the proposed method I think this would =
happen=20
after initial domain allocation and would trigger the domain to be=20
replaced with a different domain.

I prefer the solution in v3. What do you think?

>=20
>> Cheers,
>> James.
>=20
> Best regards,
> Lu Baolu

Cheers,
James.

