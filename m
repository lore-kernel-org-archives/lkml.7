Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080CEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A56206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i/W8KYSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfC2P1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:27:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40022 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbfC2P1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:27:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so2365370edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=4Aurdh1TDFEeWICmxiZsefrFLJS/6VqSlYa1tBu1qvc=;
        b=i/W8KYSXaTR7hRiay1aXYVcIP3M7n/eljvSDcJcho8dxBmMlWLD/b4mS6+SqRgfKGp
         scB2uylpjT4yYHVCkquo3iuK3EZtnscFl+9dvwWAz/vRIrCksqhYYTv65sAuQ1qI+RHv
         V897OjXwpfZNa2yT7rtw4ogWKUmeQdaUQ049MXZs+B/+0rKCdCLpf3jWZj4O9SnSoTJC
         5ALKUoYV19Evjb9+iaCXwrs9pSkGhS+ikXKxo4nhCMOFL35lhEaAvEa0nfiUj2dP4TD9
         +V/uL3G7zYk6yU7FllptB442WjmBs10DuERA8UufohFNUN8agvD2Y2TfIUdTspbLGwiv
         YnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=4Aurdh1TDFEeWICmxiZsefrFLJS/6VqSlYa1tBu1qvc=;
        b=U6lR/0TQ4kubsmIVzWgWfv241EIJFq9lxvJCID0TNbnzCc4rqKGpQCI4bAdfQr4VfX
         3yYCN2cMq8QeZUbwZCKxKLPWioQP8SikiiHiH54wm0uTfwE10IbUpSiTj05GL9BKtRxZ
         Dp+LknrSNuGCbj+I21WcsDjwJBP8E8p7StIRlSvSF4QF7i9PkMVcGxKBfrvKBK3sE4WV
         8OIpbrdk/mv49ZcuhJdNsgkclBJk4iMfWZN0lzW4PJ8WNr17EpAbF/4t+81Z6dKr0BCl
         rhaZse4JpvH6zD7/KpG/SIccE9zQ+T3Q9nm50Hs1UNswq6Oc3RRhfXuYViwJ65LwXx6V
         0hlQ==
X-Gm-Message-State: APjAAAUwpflLj+1YjmAqlnynwtFxClBGjD/wDCBSnvKoG9kx7YHOsvSM
        C/SuwHUr2Ahp8L5OauSayuHP2+ViB6yZtULX
X-Google-Smtp-Source: APXvYqymlciO2Ohlm00SITQUNuytgEXSv/Ibrf/5OFiBP7PuyiwjXXaKnNgCwbLxEXLgf/OI+jSoSw==
X-Received: by 2002:a17:906:1103:: with SMTP id h3mr28072847eja.41.1553873224544;
        Fri, 29 Mar 2019 08:27:04 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h50sm729071edh.47.2019.03.29.08.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:27:03 -0700 (PDT)
From:   James Sewart <jamessewart@arista.com>
Message-Id: <8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
Date:   Fri, 29 Mar 2019 15:26:46 +0000
In-Reply-To: <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
To:     Lu Baolu <baolu.lu@linux.intel.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
 <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
 <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
 <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hey Lu,

I=E2=80=99ve attached a preliminary v3, if you could take a look and run =
some tests=20
that would be great.

Since v2 i=E2=80=99ve added your default domain type patches, the new =
device_group=20
handler, and incorporated Jacob=E2=80=99s feedback.

> On 28 Mar 2019, at 18:37, James Sewart <jamessewart@arista.com> wrote:
>=20
> Hey Lu,
>=20
>> On 26 Mar 2019, at 01:24, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>=20
>> Hi James,
>>=20
>> On 3/25/19 8:57 PM, James Sewart wrote:
>>>>> Theres an issue that if we choose to alloc a new resv_region with =
type
>>>>> IOMMU_RESV_DIRECT, we will need to refactor =
intel_iommu_put_resv_regions
>>>>> to free this entry type which means refactoring the rmrr regions =
in
>>>>> get_resv_regions. Should this work be in this patchset?
>>>> Do you mean the rmrr regions are not allocated in get_resv_regions, =
but
>>>> are freed in put_resv_regions? I think we should fix this in this =
patch
>>>> set since this might impact the device passthrough if we don't do =
it.
>>> They=E2=80=99re not allocated and not freed currently, only type =
IOMMU_RESV_MSI is
>>> freed in put_resv_regions. If we allocate a new resv_region with =
type
>>> IOMMU_RESV_DIRECT for the isa region, then it won=E2=80=99t be =
freed. If we modify
>>> put_resv_regions to free type IOMMU_RESV_DIRECT, then we will try to =
free
>>> the static RMRR regions.
>>> Either the ISA region is static and not freed as with my =
implementation,
>>> or the RMRR regions are converted to be allocated on each call to
>>> get_resv_regions and freed in put_resv_regions.
>>=20
>> By the way, there's another way in my mind. Let's add a new region =
type
>> for LPC devices, e.x. IOMMU_RESV_LPC, and then handle it in the same =
way
>> as those MSI regions. Just FYI.
>=20
> This solution would require adding some extra code to=20
> iommu_group_create_direct_mappings as currently only type=20
> IOMMU_RESV_DIRECT is identity mapped, other types are only reserved.
>=20
>=20
>>=20
>> Best regards,
>> Lu Baolu
>=20
> Cheers,
> James.

Cheers,
James.


--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0001-iommu-Move-iommu_group_create_direct_mappings-to-aft.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-iommu-Move-iommu_group_create_direct_mappings-to-aft.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20798311d11929d45432641f20f2b869b112e8c956=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Fri,=201=20Mar=202019=2016:03:40=20+0000=0ASubject:=20[PATCH=20=
1/9]=20iommu:=20Move=20iommu_group_create_direct_mappings=20to=20after=0A=
=20device_attach=0A=0AIf=20an=20IOMMU=20driver=20requires=20to=20know=20=
which=20IOMMU=20a=20domain=20is=20associated=0Ato=20initialise=20a=20=
domain=20then=20it=20will=20do=20so=20in=20device_attach,=20before=20=
which=0Ait=20is=20not=20safe=20to=20call=20iommu_ops.=0A=0A=
Signed-off-by:=20James=20Sewart=20<jamessewart@arista.com>=0A=0Adiff=20=
--git=20a/drivers/iommu/iommu.c=20b/drivers/iommu/iommu.c=0Aindex=20=
33a982e33716..88d589d56ded=20100644=0A---=20a/drivers/iommu/iommu.c=0A=
+++=20b/drivers/iommu/iommu.c=0A@@=20-652,8=20+652,6=20@@=20int=20=
iommu_group_add_device(struct=20iommu_group=20*group,=20struct=20device=20=
*dev)=0A=20=0A=20=09dev->iommu_group=20=3D=20group;=0A=20=0A-=09=
iommu_group_create_direct_mappings(group,=20dev);=0A-=0A=20=09=
mutex_lock(&group->mutex);=0A=20=09list_add_tail(&device->list,=20=
&group->devices);=0A=20=09if=20(group->domain)=0A@@=20-662,6=20+660,8=20=
@@=20int=20iommu_group_add_device(struct=20iommu_group=20*group,=20=
struct=20device=20*dev)=0A=20=09if=20(ret)=0A=20=09=09goto=20=
err_put_group;=0A=20=0A+=09iommu_group_create_direct_mappings(group,=20=
dev);=0A+=0A=20=09/*=20Notify=20any=20listeners=20about=20change=20to=20=
group.=20*/=0A=20=09blocking_notifier_call_chain(&group->notifier,=0A=20=09=
=09=09=09=20=20=20=20=20IOMMU_GROUP_NOTIFY_ADD_DEVICE,=20dev);=0A--=20=0A=
2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0002-iommu-vt-d-Implement-apply_resv_region-for-reserving.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0002-iommu-vt-d-Implement-apply_resv_region-for-reserving.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=203bf87fef92f632b1bf789fcd2966d3f9bf707c43=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Fri,=201=20Mar=202019=2016:24:59=20+0000=0ASubject:=20[PATCH=20=
2/9]=20iommu/vt-d:=20Implement=20apply_resv_region=20for=20reserving=0A=20=
IOVA=20ranges=0A=0AUsed=20by=20iommu.c=20before=20creating=20identity=20=
mappings=20for=20reserved=20ranges=20to=0Aensure=20dma-ops=20won't=20=
ever=20remap=20these=20ranges=0A=0ASigned-off-by:=20James=20Sewart=20=
<jamessewart@arista.com>=0A=0Adiff=20--git=20=
a/drivers/iommu/intel-iommu.c=20b/drivers/iommu/intel-iommu.c=0Aindex=20=
28cb713d728c..3caa7b6fcdde=20100644=0A---=20=
a/drivers/iommu/intel-iommu.c=0A+++=20b/drivers/iommu/intel-iommu.c=0A@@=20=
-5307,6=20+5307,19=20@@=20static=20void=20=
intel_iommu_put_resv_regions(struct=20device=20*dev,=0A=20=09}=0A=20}=0A=20=
=0A+static=20void=20intel_iommu_apply_resv_region(struct=20device=20=
*dev,=0A+=09=09struct=20iommu_domain=20*domain,=0A+=09=09struct=20=
iommu_resv_region=20*region)=0A+{=0A+=09struct=20dmar_domain=20=
*dmar_domain=20=3D=20to_dmar_domain(domain);=0A+=09unsigned=20long=20=
start,=20end;=0A+=0A+=09start=20=3D=20IOVA_PFN(region->start);=0A+=09end=20=
=20=20=3D=20IOVA_PFN(region->start=20+=20region->length=20-=201);=0A+=0A=
+=09WARN_ON_ONCE(reserve_iova(&dmar_domain->iovad,=20start,=20end)=20=3D=3D=
=20NULL);=0A+}=0A+=0A=20#ifdef=20CONFIG_INTEL_IOMMU_SVM=0A=20int=20=
intel_iommu_enable_pasid(struct=20intel_iommu=20*iommu,=20struct=20=
intel_svm_dev=20*sdev)=0A=20{=0A@@=20-5400,6=20+5413,7=20@@=20const=20=
struct=20iommu_ops=20intel_iommu_ops=20=3D=20{=0A=20=09.remove_device=09=09=
=3D=20intel_iommu_remove_device,=0A=20=09.get_resv_regions=09=3D=20=
intel_iommu_get_resv_regions,=0A=20=09.put_resv_regions=09=3D=20=
intel_iommu_put_resv_regions,=0A+=09.apply_resv_region=09=3D=20=
intel_iommu_apply_resv_region,=0A=20=09.device_group=09=09=3D=20=
pci_device_group,=0A=20=09.pgsize_bitmap=09=09=3D=20INTEL_IOMMU_PGSIZES,=0A=
=20};=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0003-iommu-vt-d-Expose-ISA-direct-mapping-region-via-iomm.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0003-iommu-vt-d-Expose-ISA-direct-mapping-region-via-iomm.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20d7ccfb5297261d2781b3e29c2636ac94e9194569=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Thu,=207=20Mar=202019=2017:57:15=20+0000=0ASubject:=20[PATCH=20=
3/9]=20iommu/vt-d:=20Expose=20ISA=20direct=20mapping=20region=20via=0A=20=
iommu_get_resv_regions=0A=0ATo=20support=20mapping=20ISA=20region=20via=20=
iommu_group_create_direct_mappings,=0Amake=20sure=20its=20exposed=20by=20=
iommu_get_resv_regions.=20This=20allows=0Adeduplication=20of=20reserved=20=
region=20mappings=0A=0ASigned-off-by:=20James=20Sewart=20=
<jamessewart@arista.com>=0A=0Adiff=20--git=20=
a/drivers/iommu/intel-iommu.c=20b/drivers/iommu/intel-iommu.c=0Aindex=20=
3caa7b6fcdde..1075a7c74507=20100644=0A---=20=
a/drivers/iommu/intel-iommu.c=0A+++=20b/drivers/iommu/intel-iommu.c=0A@@=20=
-339,6=20+339,8=20@@=20static=20LIST_HEAD(dmar_rmrr_units);=0A=20#define=20=
for_each_rmrr_units(rmrr)=20\=0A=20=09list_for_each_entry(rmrr,=20=
&dmar_rmrr_units,=20list)=0A=20=0A+static=20struct=20iommu_resv_region=20=
*isa_resv_region;=0A+=0A=20/*=20bitmap=20for=20indexing=20intel_iommus=20=
*/=0A=20static=20int=20g_num_of_iommus;=0A=20=0A@@=20-2782,26=20+2784,34=20=
@@=20static=20inline=20int=20iommu_prepare_rmrr_dev(struct=20=
dmar_rmrr_unit=20*rmrr,=0A=20=09=09=09=09=09=20=20rmrr->end_address);=0A=20=
}=0A=20=0A+static=20inline=20struct=20iommu_resv_region=20=
*iommu_get_isa_resv_region(void)=0A+{=0A+=09if=20(!isa_resv_region)=0A+=09=
=09isa_resv_region=20=3D=20iommu_alloc_resv_region(0,=0A+=09=09=09=09=
16*1024*1024,=0A+=09=09=09=090,=20IOMMU_RESV_DIRECT);=0A+=0A+=09return=20=
isa_resv_region;=0A+}=0A+=0A=20#ifdef=20CONFIG_INTEL_IOMMU_FLOPPY_WA=0A=
-static=20inline=20void=20iommu_prepare_isa(void)=0A+static=20inline=20=
void=20iommu_prepare_isa(struct=20pci_dev=20*pdev)=0A=20{=0A-=09struct=20=
pci_dev=20*pdev;=0A=20=09int=20ret;=0A+=09struct=20iommu_resv_region=20=
*reg=20=3D=20iommu_get_isa_resv_region();=0A=20=0A-=09pdev=20=3D=20=
pci_get_class(PCI_CLASS_BRIDGE_ISA=20<<=208,=20NULL);=0A-=09if=20(!pdev)=0A=
+=09if=20(!reg)=0A=20=09=09return;=0A=20=0A=20=09pr_info("Prepare=20=
0-16MiB=20unity=20mapping=20for=20LPC\n");=0A-=09ret=20=3D=20=
iommu_prepare_identity_map(&pdev->dev,=200,=2016*1024*1024=20-=201);=0A+=09=
ret=20=3D=20iommu_prepare_identity_map(&pdev->dev,=20reg->start,=0A+=09=09=
=09reg->start=20+=20reg->length=20-=201);=0A=20=0A=20=09if=20(ret)=0A=20=09=
=09pr_err("Failed=20to=20create=200-16MiB=20identity=20map=20-=20floppy=20=
might=20not=20work\n");=0A-=0A-=09pci_dev_put(pdev);=0A=20}=0A=20#else=0A=
-static=20inline=20void=20iommu_prepare_isa(void)=0A+static=20inline=20=
void=20iommu_prepare_isa(struct=20pci_dev=20*pdev)=0A=20{=0A=20=09=
return;=0A=20}=0A@@=20-3290,6=20+3300,7=20@@=20static=20int=20__init=20=
init_dmars(void)=0A=20=09struct=20dmar_rmrr_unit=20*rmrr;=0A=20=09bool=20=
copied_tables=20=3D=20false;=0A=20=09struct=20device=20*dev;=0A+=09=
struct=20pci_dev=20*pdev;=0A=20=09struct=20intel_iommu=20*iommu;=0A=20=09=
int=20i,=20ret;=0A=20=0A@@=20-3470,7=20+3481,11=20@@=20static=20int=20=
__init=20init_dmars(void)=0A=20=09=09}=0A=20=09}=0A=20=0A-=09=
iommu_prepare_isa();=0A+=09pdev=20=3D=20=
pci_get_class(PCI_CLASS_BRIDGE_ISA=20<<=208,=20NULL);=0A+=09if=20(pdev)=20=
{=0A+=09=09iommu_prepare_isa(pdev);=0A+=09=09pci_dev_put(pdev);=0A+=09}=0A=
=20=0A=20domains_done:=0A=20=0A@@=20-5274,6=20+5289,7=20@@=20static=20=
void=20intel_iommu_get_resv_regions(struct=20device=20*device,=0A=20=09=
struct=20iommu_resv_region=20*reg;=0A=20=09struct=20dmar_rmrr_unit=20=
*rmrr;=0A=20=09struct=20device=20*i_dev;=0A+=09struct=20pci_dev=20*pdev;=0A=
=20=09int=20i;=0A=20=0A=20=09rcu_read_lock();=0A@@=20-5288,6=20+5304,14=20=
@@=20static=20void=20intel_iommu_get_resv_regions(struct=20device=20=
*device,=0A=20=09}=0A=20=09rcu_read_unlock();=0A=20=0A+=09if=20=
(dev_is_pci(device))=20{=0A+=09=09pdev=20=3D=20to_pci_dev(device);=0A+=09=
=09if=20((pdev->class=20>>=208)=20=3D=3D=20PCI_CLASS_BRIDGE_ISA)=20{=0A+=09=
=09=09reg=20=3D=20iommu_get_isa_resv_region();=0A+=09=09=09=
list_add_tail(&reg->list,=20head);=0A+=09=09}=0A+=09}=0A+=0A=20=09reg=20=
=3D=20iommu_alloc_resv_region(IOAPIC_RANGE_START,=0A=20=09=09=09=09=20=20=
=20=20=20=20IOAPIC_RANGE_END=20-=20IOAPIC_RANGE_START=20+=201,=0A=20=09=09=
=09=09=20=20=20=20=20=200,=20IOMMU_RESV_MSI);=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0004-iommu-vt-d-Create-an-IOMMU-group-for-devices-that-re.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0004-iommu-vt-d-Create-an-IOMMU-group-for-devices-that-re.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20f282a75bf3ed393e9eed57c0aa34a93097022e76=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Sat,=209=20Mar=202019=2018:05:53=20+0000=0ASubject:=20[PATCH=20=
4/9]=20iommu/vt-d:=20Create=20an=20IOMMU=20group=20for=20devices=20that=0A=
=20require=20an=20idenity=20map=0A=0ADevices=20that=20require=20an=20=
identity=20map=20because=20of=20quirks=20or=20other=20reasons=0Ashould=20=
be=20put=20in=20their=20own=20IOMMU=20group=20so=20as=20to=20not=20end=20=
up=20with=20multiple=0Adifferent=20domains=20per=20group.=0A=0A=
Signed-off-by:=20James=20Sewart=20<jamessewart@arista.com>=0A=0Adiff=20=
--git=20a/drivers/iommu/intel-iommu.c=20b/drivers/iommu/intel-iommu.c=0A=
index=201075a7c74507..1db0ceb33020=20100644=0A---=20=
a/drivers/iommu/intel-iommu.c=0A+++=20b/drivers/iommu/intel-iommu.c=0A@@=20=
-5424,6=20+5424,22=20@@=20struct=20intel_iommu=20=
*intel_svm_device_to_iommu(struct=20device=20*dev)=0A=20}=0A=20#endif=20=
/*=20CONFIG_INTEL_IOMMU_SVM=20*/=0A=20=0A+static=20struct=20iommu_group=20=
*intel_identity_group;=0A+=0A+struct=20iommu_group=20=
*intel_iommu_pci_device_group(struct=20device=20*dev)=0A+{=0A+=09if=20=
(iommu_no_mapping(dev))=20{=0A+=09=09if=20(!intel_identity_group)=20{=0A=
+=09=09=09intel_identity_group=20=3D=20iommu_group_alloc();=0A+=09=09=09=
if=20(IS_ERR(intel_identity_group))=0A+=09=09=09=09return=20NULL;=0A+=09=09=
}=0A+=09=09return=20intel_identity_group;=0A+=09}=0A+=0A+=09return=20=
pci_device_group(dev);=0A+}=0A+=0A=20const=20struct=20iommu_ops=20=
intel_iommu_ops=20=3D=20{=0A=20=09.capable=09=09=3D=20=
intel_iommu_capable,=0A=20=09.domain_alloc=09=09=3D=20=
intel_iommu_domain_alloc,=0A@@=20-5438,7=20+5454,7=20@@=20const=20struct=20=
iommu_ops=20intel_iommu_ops=20=3D=20{=0A=20=09.get_resv_regions=09=3D=20=
intel_iommu_get_resv_regions,=0A=20=09.put_resv_regions=09=3D=20=
intel_iommu_put_resv_regions,=0A=20=09.apply_resv_region=09=3D=20=
intel_iommu_apply_resv_region,=0A-=09.device_group=09=09=3D=20=
pci_device_group,=0A+=09.device_group=09=09=3D=20=
intel_iommu_pci_device_group,=0A=20=09.pgsize_bitmap=09=09=3D=20=
INTEL_IOMMU_PGSIZES,=0A=20};=0A=20=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0005-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0005-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=205210d963c9dde1d6bae95f0d338360d7eb92ce5a=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Thu,=2021=20Mar=202019=2011:31:44=20+0000=0ASubject:=20[PATCH=20=
5/9]=20iommu:=20Add=20ops=20entry=20for=20vendor=20specific=20default=20=
domain=0A=20type=0A=0AThis=20adds=20an=20iommu=20ops=20entry=20for=20=
iommu=20vendor=20driver=20to=20specify=0Athe=20type=20of=20the=20default=20=
domain=20for=20each=20device.=20This=20is=20needed=0Afor=20the=20vendor=20=
driver,=20which=20already=20has=20its=20own=20logic=20to=0Adetermine=20=
the=20use=20of=20identity=20domain=20for=20a=20long=20time,=20when=20it=0A=
switches=20to=20apply=20default=20domain.=0A=0ASigned-off-by:=20Lu=20=
Baolu=20<baolu.lu@linux.intel.com>=0A=0Adiff=20--git=20=
a/drivers/iommu/iommu.c=20b/drivers/iommu/iommu.c=0Aindex=20=
88d589d56ded..516e4d8995c2=20100644=0A---=20a/drivers/iommu/iommu.c=0A=
+++=20b/drivers/iommu/iommu.c=0A@@=20-1102,12=20+1102,18=20@@=20struct=20=
iommu_group=20*iommu_group_get_for_dev(struct=20device=20*dev)=0A=20=09=20=
*/=0A=20=09if=20(!group->default_domain)=20{=0A=20=09=09struct=20=
iommu_domain=20*dom;=0A+=09=09int=20domain_type=20=3D=20=
iommu_def_domain_type;=0A=20=0A-=09=09dom=20=3D=20=
__iommu_domain_alloc(dev->bus,=20iommu_def_domain_type);=0A-=09=09if=20=
(!dom=20&&=20iommu_def_domain_type=20!=3D=20IOMMU_DOMAIN_DMA)=20{=0A+=09=09=
if=20(ops->is_identity_map)=0A+=09=09=09domain_type=20=3D=20=
ops->is_identity_map(dev)=20?=0A+=09=09=09=09=20=20=20=20=20=20=
IOMMU_DOMAIN_IDENTITY=20:=0A+=09=09=09=09=20=20=20=20=20=20=
IOMMU_DOMAIN_DMA;=0A+=0A+=09=09dom=20=3D=20=
__iommu_domain_alloc(dev->bus,=20domain_type);=0A+=09=09if=20(!dom=20&&=20=
domain_type=20!=3D=20IOMMU_DOMAIN_DMA)=20{=0A=20=09=09=09dev_warn(dev,=0A=
=20=09=09=09=09=20"failed=20to=20allocate=20default=20IOMMU=20domain=20=
of=20type=20%u;=20falling=20back=20to=20IOMMU_DOMAIN_DMA",=0A-=09=09=09=09=
=20iommu_def_domain_type);=0A+=09=09=09=09=20domain_type);=0A=20=09=09=09=
dom=20=3D=20__iommu_domain_alloc(dev->bus,=20IOMMU_DOMAIN_DMA);=0A=20=09=09=
}=0A=20=0Adiff=20--git=20a/include/linux/iommu.h=20=
b/include/linux/iommu.h=0Aindex=20ffbbc7e39cee..a5007d035218=20100644=0A=
---=20a/include/linux/iommu.h=0A+++=20b/include/linux/iommu.h=0A@@=20=
-186,6=20+186,7=20@@=20struct=20iommu_resv_region=20{=0A=20=20*=20=
@of_xlate:=20add=20OF=20master=20IDs=20to=20iommu=20grouping=0A=20=20*=20=
@is_attach_deferred:=20Check=20if=20domain=20attach=20should=20be=20=
deferred=20from=20iommu=0A=20=20*=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20driver=20init=20to=20device=20driver=20init=20=
(default=20no)=0A+=20*=20@is_identity_map:=20vendor=20customized=20=
identity=20map=20adjudicator=0A=20=20*=20@pgsize_bitmap:=20bitmap=20of=20=
all=20possible=20supported=20page=20sizes=0A=20=20*/=0A=20struct=20=
iommu_ops=20{=0A@@=20-230,6=20+231,9=20@@=20struct=20iommu_ops=20{=0A=20=09=
int=20(*of_xlate)(struct=20device=20*dev,=20struct=20of_phandle_args=20=
*args);=0A=20=09bool=20(*is_attach_deferred)(struct=20iommu_domain=20=
*domain,=20struct=20device=20*dev);=0A=20=0A+=09/*=20Vendor=20customized=20=
identity=20map=20adjudicator=20*/=0A+=09bool=20(*is_identity_map)(struct=20=
device=20*dev);=0A+=0A=20=09unsigned=20long=20pgsize_bitmap;=0A=20};=0A=20=
=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0006-iommu-vt-d-Add-is_identity_map-ops-entry.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0006-iommu-vt-d-Add-is_identity_map-ops-entry.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2055d091d75abc677438feef803fa88b1facdc7cb2=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Lu=20Baolu=20<baolu.lu@linux.intel.com>=0A=
Date:=20Thu,=207=20Mar=202019=2012:53:12=20+0800=0ASubject:=20[PATCH=20=
6/9]=20iommu/vt-d:=20Add=20is_identity_map=20ops=20entry=0A=0AThis=20=
adds=20the=20is_identity_map=20ops=20entry=20for=20Intel=20IOMMU=20=
driver.=0A=0ASigned-off-by:=20Lu=20Baolu=20<baolu.lu@linux.intel.com>=0A=0A=
diff=20--git=20a/drivers/iommu/intel-iommu.c=20=
b/drivers/iommu/intel-iommu.c=0Aindex=201db0ceb33020..e79df3cf548c=20=
100644=0A---=20a/drivers/iommu/intel-iommu.c=0A+++=20=
b/drivers/iommu/intel-iommu.c=0A@@=20-5344,6=20+5344,11=20@@=20static=20=
void=20intel_iommu_apply_resv_region(struct=20device=20*dev,=0A=20=09=
WARN_ON_ONCE(reserve_iova(&dmar_domain->iovad,=20start,=20end)=20=3D=3D=20=
NULL);=0A=20}=0A=20=0A+static=20bool=20=
intel_iommu_is_identity_map(struct=20device=20*dev)=0A+{=0A+=09return=20=
iommu_should_identity_map(dev,=201);=0A+}=0A+=0A=20#ifdef=20=
CONFIG_INTEL_IOMMU_SVM=0A=20int=20intel_iommu_enable_pasid(struct=20=
intel_iommu=20*iommu,=20struct=20intel_svm_dev=20*sdev)=0A=20{=0A@@=20=
-5455,6=20+5460,7=20@@=20const=20struct=20iommu_ops=20intel_iommu_ops=20=
=3D=20{=0A=20=09.put_resv_regions=09=3D=20intel_iommu_put_resv_regions,=0A=
=20=09.apply_resv_region=09=3D=20intel_iommu_apply_resv_region,=0A=20=09=
.device_group=09=09=3D=20intel_iommu_pci_device_group,=0A+=09=
.is_identity_map=09=3D=20intel_iommu_is_identity_map,=0A=20=09=
.pgsize_bitmap=09=09=3D=20INTEL_IOMMU_PGSIZES,=0A=20};=0A=20=0A--=20=0A=
2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0007-iommu-vt-d-Enable-DMA-remapping-after-rmrr-mapped.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0007-iommu-vt-d-Enable-DMA-remapping-after-rmrr-mapped.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2006cabc10e1728142650e545b0038ffb512b45aff=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Fri,=208=20Mar=202019=2016:12:34=20+0000=0ASubject:=20[PATCH=20=
7/9]=20iommu/vt-d:=20Enable=20DMA=20remapping=20after=20rmrr=20mapped=0A=0A=
The=20rmrr=20devices=20require=20identity=20map=20of=20the=20rmrr=20=
regions=20before=0Aenabling=20DMA=20remapping.=20Otherwise,=20there=20=
will=20be=20a=20window=20during=0Awhich=20DMA=20from/to=20the=20rmrr=20=
regions=20will=20be=20blocked.=20In=20order=20to=0Aalleviate=20this,=20=
we=20move=20enabling=20DMA=20remapping=20after=20all=20rmrr=0Aregions=20=
get=20mapped.=0A=0ASigned-off-by:=20Lu=20Baolu=20=
<baolu.lu@linux.intel.com>=0A=0Adiff=20--git=20=
a/drivers/iommu/intel-iommu.c=20b/drivers/iommu/intel-iommu.c=0Aindex=20=
e79df3cf548c..3a06e8804b6e=20100644=0A---=20=
a/drivers/iommu/intel-iommu.c=0A+++=20b/drivers/iommu/intel-iommu.c=0A@@=20=
-3519,11=20+3519,6=20@@=20static=20int=20__init=20init_dmars(void)=0A=20=09=
=09ret=20=3D=20dmar_set_interrupt(iommu);=0A=20=09=09if=20(ret)=0A=20=09=09=
=09goto=20free_iommu;=0A-=0A-=09=09if=20=
(!translation_pre_enabled(iommu))=0A-=09=09=09=
iommu_enable_translation(iommu);=0A-=0A-=09=09=
iommu_disable_protect_mem_regions(iommu);=0A=20=09}=0A=20=0A=20=09return=20=
0;=0A@@=20-4921,7=20+4916,6=20@@=20int=20__init=20intel_iommu_init(void)=0A=
=20=09=09goto=20out_free_reserved_range;=0A=20=09}=0A=20=09=
up_write(&dmar_global_lock);=0A-=09pr_info("Intel(R)=20Virtualization=20=
Technology=20for=20Directed=20I/O\n");=0A=20=0A=20#if=20=
defined(CONFIG_X86)=20&&=20defined(CONFIG_SWIOTLB)=0A=20=09swiotlb=20=3D=20=
0;=0A@@=20-4944,6=20+4938,16=20@@=20int=20__init=20=
intel_iommu_init(void)=0A=20=09=09=
register_memory_notifier(&intel_iommu_memory_nb);=0A=20=09=
cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD,=20"iommu/intel:dead",=20NULL,=0A=
=20=09=09=09=20=20intel_iommu_cpu_dead);=0A+=0A+=09/*=20Finally,=20we=20=
enable=20the=20DMA=20remapping=20hardware.=20*/=0A+=09=
for_each_iommu(iommu,=20drhd)=20{=0A+=09=09if=20=
(!translation_pre_enabled(iommu))=0A+=09=09=09=
iommu_enable_translation(iommu);=0A+=0A+=09=09=
iommu_disable_protect_mem_regions(iommu);=0A+=09}=0A+=09=
pr_info("Intel(R)=20Virtualization=20Technology=20for=20Directed=20=
I/O\n");=0A+=0A=20=09intel_iommu_enabled=20=3D=201;=0A=20=09=
intel_iommu_debugfs_init();=0A=20=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0008-iommu-vt-d-Allow-IOMMU_DOMAIN_DMA-to-be-allocated-by.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0008-iommu-vt-d-Allow-IOMMU_DOMAIN_DMA-to-be-allocated-by.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20a2b312c445ac6f683167d903d93b374441f1018a=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Mon,=2011=20Mar=202019=2014:53:47=20+0000=0ASubject:=20[PATCH=20=
8/9]=20iommu/vt-d:=20Allow=20IOMMU_DOMAIN_DMA=20to=20be=20allocated=20by=0A=
=20iommu_ops=0A=0AAllowing=20IOMMU_DOMAIN_DMA=20type=20IOMMU=20domain=20=
to=20be=20allocated=20allows=20the=0Adefault_domain=20of=20an=20=
iommu_group=20to=20be=20set.=20This=20delegates=20device-domain=0A=
relationships=20to=20the=20generic=20IOMMU=20code.=0A=0ASigned-off-by:=20=
James=20Sewart=20<jamessewart@arista.com>=0A=0Adiff=20--git=20=
a/drivers/iommu/intel-iommu.c=20b/drivers/iommu/intel-iommu.c=0Aindex=20=
3a06e8804b6e..2055c11f5978=20100644=0A---=20=
a/drivers/iommu/intel-iommu.c=0A+++=20b/drivers/iommu/intel-iommu.c=0A@@=20=
-311,6=20+311,18=20@@=20static=20int=20hw_pass_through=20=3D=201;=0A=20=
/*=20si_domain=20contains=20mulitple=20devices=20*/=0A=20#define=20=
DOMAIN_FLAG_STATIC_IDENTITY=09(1=20<<=201)=0A=20=0A+/*=0A+=20*=20Domain=20=
managed=20externally,=20don't=20cleanup=20if=20it=20isn't=20attached=0A+=20=
*=20to=20any=20devices.=0A+=20*/=0A+#define=20=
DOMAIN_FLAG_MANAGED_EXTERNALLY=09(1=20<<=202)=0A+=0A+/*=0A+=20*=20Set=20=
after=20domain=20initialisation.=20Used=20when=20allocating=20dma=20=
domains=20to=0A+=20*=20defer=20domain=20initialisation=20until=20it=20is=20=
attached=20to=20a=20device=0A+=20*/=0A+#define=20DOMAIN_FLAG_INITIALISED=09=
(1=20<<=203)=0A+=0A=20#define=20for_each_domain_iommu(idx,=20domain)=09=09=
=09\=0A=20=09for=20(idx=20=3D=200;=20idx=20<=20g_num_of_iommus;=20idx++)=09=
=09\=0A=20=09=09if=20(domain->iommu_refcnt[idx])=0A@@=20-561,6=20+573,16=20=
@@=20static=20inline=20int=20domain_type_is_vm_or_si(struct=20=
dmar_domain=20*domain)=0A=20=09=09=09=09DOMAIN_FLAG_STATIC_IDENTITY);=0A=20=
}=0A=20=0A+static=20inline=20int=20domain_managed_externally(struct=20=
dmar_domain=20*domain)=0A+{=0A+=09return=20domain->flags=20&=20=
DOMAIN_FLAG_MANAGED_EXTERNALLY;=0A+}=0A+=0A+static=20inline=20int=20=
domain_is_initialised(struct=20dmar_domain=20*domain)=0A+{=0A+=09return=20=
domain->flags=20&=20DOMAIN_FLAG_INITIALISED;=0A+}=0A+=0A=20static=20=
inline=20int=20domain_pfn_supported(struct=20dmar_domain=20*domain,=0A=20=
=09=09=09=09=20=20=20=20=20=20=20unsigned=20long=20pfn)=0A=20{=0A@@=20=
-1671,7=20+1693,7=20@@=20static=20void=20disable_dmar_iommu(struct=20=
intel_iommu=20*iommu)=0A=20=0A=20=09=09__dmar_remove_one_dev_info(info);=0A=
=20=0A-=09=09if=20(!domain_type_is_vm_or_si(domain))=20{=0A+=09=09if=20=
(!domain_managed_externally(domain))=20{=0A=20=09=09=09/*=0A=20=09=09=09=20=
*=20The=20domain_exit()=20function=20=20can't=20be=20called=20under=0A=20=
=09=09=09=20*=20device_domain_lock,=20as=20it=20takes=20this=20lock=20=
itself.=0A@@=20-1904,6=20+1926,7=20@@=20static=20int=20=
domain_init(struct=20dmar_domain=20*domain,=20struct=20intel_iommu=20=
*iommu,=0A=20=09domain->pgd=20=3D=20(struct=20dma_pte=20=
*)alloc_pgtable_page(domain->nid);=0A=20=09if=20(!domain->pgd)=0A=20=09=09=
return=20-ENOMEM;=0A+=09domain->flags=20|=3D=20DOMAIN_FLAG_INITIALISED;=0A=
=20=09__iommu_flush_cache(iommu,=20domain->pgd,=20PAGE_SIZE);=0A=20=09=
return=200;=0A=20}=0A@@=20-1912,6=20+1935,9=20@@=20static=20void=20=
domain_exit(struct=20dmar_domain=20*domain)=0A=20{=0A=20=09struct=20page=20=
*freelist;=0A=20=0A+=09if=20(!domain_is_initialised(domain))=0A+=09=09=
goto=20free_mem;=0A+=0A=20=09/*=20Remove=20associated=20devices=20and=20=
clear=20attached=20or=20cached=20domains=20*/=0A=20=09rcu_read_lock();=0A=
=20=09domain_remove_dev_info(domain);=0A@@=20-1924,6=20+1950,7=20@@=20=
static=20void=20domain_exit(struct=20dmar_domain=20*domain)=0A=20=0A=20=09=
dma_free_pagelist(freelist);=0A=20=0A+free_mem:=0A=20=09=
free_domain_mem(domain);=0A=20}=0A=20=0A@@=20-4589,7=20+4616,7=20@@=20=
static=20int=20device_notifier(struct=20notifier_block=20*nb,=0A=20=09=09=
=09return=200;=0A=20=0A=20=09=09dmar_remove_one_dev_info(dev);=0A-=09=09=
if=20(!domain_type_is_vm_or_si(domain)=20&&=0A+=09=09if=20=
(!domain_managed_externally(domain)=20&&=0A=20=09=09=20=20=20=20=
list_empty(&domain->devices))=0A=20=09=09=09domain_exit(domain);=0A=20=09=
}=20else=20if=20(action=20=3D=3D=20BUS_NOTIFY_ADD_DEVICE)=20{=0A@@=20=
-5047,6=20+5074,7=20@@=20static=20int=20md_domain_init(struct=20=
dmar_domain=20*domain,=20int=20guest_width)=0A=20=09domain->pgd=20=3D=20=
(struct=20dma_pte=20*)alloc_pgtable_page(domain->nid);=0A=20=09if=20=
(!domain->pgd)=0A=20=09=09return=20-ENOMEM;=0A+=09domain->flags=20|=3D=20=
DOMAIN_FLAG_INITIALISED;=0A=20=09domain_flush_cache(domain,=20=
domain->pgd,=20PAGE_SIZE);=0A=20=09return=200;=0A=20}=0A@@=20-5055,28=20=
+5083,43=20@@=20static=20struct=20iommu_domain=20=
*intel_iommu_domain_alloc(unsigned=20type)=0A=20{=0A=20=09struct=20=
dmar_domain=20*dmar_domain;=0A=20=09struct=20iommu_domain=20*domain;=0A+=09=
int=20flags=20=3D=20DOMAIN_FLAG_MANAGED_EXTERNALLY;=0A=20=0A-=09if=20=
(type=20!=3D=20IOMMU_DOMAIN_UNMANAGED)=0A-=09=09return=20NULL;=0A+=09=
switch=20(type)=20{=0A+=09case=20IOMMU_DOMAIN_UNMANAGED:=0A+=09=09flags=20=
|=3D=20DOMAIN_FLAG_VIRTUAL_MACHINE=20|=20DOMAIN_FLAG_INITIALISED;=0A+=09=09=
dmar_domain=20=3D=20alloc_domain(flags);=0A+=09=09if=20(!dmar_domain)=0A=
+=09=09=09return=20NULL;=0A=20=0A-=09dmar_domain=20=3D=20=
alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);=0A-=09if=20(!dmar_domain)=20{=0A=
-=09=09pr_err("Can't=20allocate=20dmar_domain\n");=0A-=09=09return=20=
NULL;=0A-=09}=0A-=09if=20(md_domain_init(dmar_domain,=20=
DEFAULT_DOMAIN_ADDRESS_WIDTH))=20{=0A-=09=09pr_err("Domain=20=
initialization=20failed\n");=0A-=09=09domain_exit(dmar_domain);=0A+=09=09=
if=20(md_domain_init(dmar_domain,=20DEFAULT_DOMAIN_ADDRESS_WIDTH))=20{=0A=
+=09=09=09pr_err("Domain=20initialization=20failed\n");=0A+=09=09=09=
domain_exit(dmar_domain);=0A+=09=09=09return=20NULL;=0A+=09=09}=0A+=09=09=
domain_update_iommu_cap(dmar_domain);=0A+=09=09domain=20=3D=20=
&dmar_domain->domain;=0A+=09=09domain->geometry.aperture_start=20=3D=20=
0;=0A+=09=09domain->geometry.aperture_end=20=3D=0A+=09=09=09=
__DOMAIN_MAX_ADDR(dmar_domain->gaw);=0A+=09=09=
domain->geometry.force_aperture=20=3D=20true;=0A+=09=09break;=0A+=09case=20=
IOMMU_DOMAIN_DMA:=0A+=09=09dmar_domain=20=3D=20alloc_domain(flags);=0A+=09=
=09if=20(!dmar_domain)=0A+=09=09=09return=20NULL;=0A+=09=09/*=0A+=09=09=20=
*=20init=20domain=20in=20device=20attach=20when=20we=20know=20IOMMU=0A+=09=
=09=20*=20capabilities=0A+=09=09=20*/=0A+=09=09break;=0A+=09case=20=
IOMMU_DOMAIN_IDENTITY:=0A+=09=09return=20&si_domain->domain;=0A+=09=
default:=0A=20=09=09return=20NULL;=0A=20=09}=0A-=09=
domain_update_iommu_cap(dmar_domain);=0A-=0A-=09domain=20=3D=20=
&dmar_domain->domain;=0A-=09domain->geometry.aperture_start=20=3D=200;=0A=
-=09domain->geometry.aperture_end=20=20=20=3D=20=
__DOMAIN_MAX_ADDR(dmar_domain->gaw);=0A-=09=
domain->geometry.force_aperture=20=3D=20true;=0A=20=0A-=09return=20=
domain;=0A+=09return=20&dmar_domain->domain;=0A=20}=0A=20=0A=20static=20=
void=20intel_iommu_domain_free(struct=20iommu_domain=20*domain)=0A@@=20=
-5107,7=20+5150,7=20@@=20static=20int=20intel_iommu_attach_device(struct=20=
iommu_domain=20*domain,=0A=20=09=09=09dmar_remove_one_dev_info(dev);=0A=20=
=09=09=09rcu_read_unlock();=0A=20=0A-=09=09=09if=20=
(!domain_type_is_vm_or_si(old_domain)=20&&=0A+=09=09=09if=20=
(!domain_managed_externally(old_domain)=20&&=0A=20=09=09=09=20=20=20=20=20=
list_empty(&old_domain->devices))=0A=20=09=09=09=09=
domain_exit(old_domain);=0A=20=09=09}=0A@@=20-5117,6=20+5160,16=20@@=20=
static=20int=20intel_iommu_attach_device(struct=20iommu_domain=20=
*domain,=0A=20=09if=20(!iommu)=0A=20=09=09return=20-ENODEV;=0A=20=0A+=09=
/*=0A+=09=20*=20Initialise=20domain=20with=20IOMMU=20capabilities=20if=20=
it=20isn't=20already=0A+=09=20*=20initialised=0A+=09=20*/=0A+=09if=20=
(!domain_is_initialised(dmar_domain))=20{=0A+=09=09if=20=
(domain_init(dmar_domain,=20iommu,=0A+=09=09=09=09=
DEFAULT_DOMAIN_ADDRESS_WIDTH))=0A+=09=09=09return=20-ENOMEM;=0A+=09}=0A+=0A=
=20=09/*=20check=20if=20this=20iommu=20agaw=20is=20sufficient=20for=20=
max=20mapped=20address=20*/=0A=20=09addr_width=20=3D=20=
agaw_to_width(iommu->agaw);=0A=20=09if=20(addr_width=20>=20=
cap_mgaw(iommu->cap))=0A@@=20-5163,6=20+5216,10=20@@=20static=20int=20=
intel_iommu_map(struct=20iommu_domain=20*domain,=0A=20=09int=20prot=20=3D=20=
0;=0A=20=09int=20ret;=0A=20=0A+=09/*=20Don't=20bother=20if=20hardware=20=
passthrough=20used.=20*/=0A+=09if=20(dmar_domain=20=3D=3D=20si_domain=20=
&&=20hw_pass_through)=0A+=09=09return=200;=0A+=0A=20=09if=20(iommu_prot=20=
&=20IOMMU_READ)=0A=20=09=09prot=20|=3D=20DMA_PTE_READ;=0A=20=09if=20=
(iommu_prot=20&=20IOMMU_WRITE)=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5
Content-Disposition: attachment;
	filename=0009-iommu-vt-d-Remove-lazy-allocation-of-domains.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0009-iommu-vt-d-Remove-lazy-allocation-of-domains.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2044a879dae8c246cd52fa754e99a1d43bc019c757=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Mon,=2011=20Mar=202019=2014:55:01=20+0000=0ASubject:=20[PATCH=20=
9/9]=20iommu/vt-d:=20Remove=20lazy=20allocation=20of=20domains=0A=0AThe=20=
generic=20IOMMU=20code=20will=20allocate=20and=20attach=20a=20default=20=
domain=20to=20each=0Adevice=20that=20comes=20online.=20This=20patch=20=
removes=20the=20lazy=20domain=20allocation=0Aand=20early=20reserved=20=
region=20mapping=20that=20is=20now=20redundant.=0A=0ASigned-off-by:=20=
James=20Sewart=20<jamessewart@arista.com>=0A=0Adiff=20--git=20=
a/drivers/iommu/intel-iommu.c=20b/drivers/iommu/intel-iommu.c=0Aindex=20=
2055c11f5978..4bf719a82b64=20100644=0A---=20=
a/drivers/iommu/intel-iommu.c=0A+++=20b/drivers/iommu/intel-iommu.c=0A@@=20=
-2463,21=20+2463,6=20@@=20static=20void=20domain_remove_dev_info(struct=20=
dmar_domain=20*domain)=0A=20=09=
spin_unlock_irqrestore(&device_domain_lock,=20flags);=0A=20}=0A=20=0A-/*=0A=
-=20*=20find_domain=0A-=20*=20Note:=20we=20use=20struct=20=
device->archdata.iommu=20stores=20the=20info=0A-=20*/=0A-static=20struct=20=
dmar_domain=20*find_domain(struct=20device=20*dev)=0A-{=0A-=09struct=20=
device_domain_info=20*info;=0A-=0A-=09/*=20No=20lock=20here,=20assumes=20=
no=20domain=20exit=20in=20normal=20case=20*/=0A-=09info=20=3D=20=
dev->archdata.iommu;=0A-=09if=20(likely(info))=0A-=09=09return=20=
info->domain;=0A-=09return=20NULL;=0A-}=0A-=0A=20static=20inline=20=
struct=20device_domain_info=20*=0A=20dmar_search_domain_by_dev_info(int=20=
segment,=20int=20bus,=20int=20devfn)=0A=20{=0A@@=20-2539,8=20+2524,11=20=
@@=20static=20struct=20dmar_domain=20*dmar_insert_one_dev_info(struct=20=
intel_iommu=20*iommu,=0A=20=09}=0A=20=0A=20=09=
spin_lock_irqsave(&device_domain_lock,=20flags);=0A-=09if=20(dev)=0A-=09=09=
found=20=3D=20find_domain(dev);=0A+=09if=20(dev)=20{=0A+=09=09struct=20=
iommu_domain=20*io_domain=20=3D=20iommu_get_domain_for_dev(dev);=0A+=09=09=
if=20(io_domain)=0A+=09=09=09found=20=3D=20to_dmar_domain(io_domain);=0A=
+=09}=0A=20=0A=20=09if=20(!found)=20{=0A=20=09=09struct=20=
device_domain_info=20*info2;=0A@@=20-2608,118=20+2596,6=20@@=20static=20=
struct=20dmar_domain=20*dmar_insert_one_dev_info(struct=20intel_iommu=20=
*iommu,=0A=20=09return=20domain;=0A=20}=0A=20=0A-static=20int=20=
get_last_alias(struct=20pci_dev=20*pdev,=20u16=20alias,=20void=20=
*opaque)=0A-{=0A-=09*(u16=20*)opaque=20=3D=20alias;=0A-=09return=200;=0A=
-}=0A-=0A-static=20struct=20dmar_domain=20*find_or_alloc_domain(struct=20=
device=20*dev,=20int=20gaw)=0A-{=0A-=09struct=20device_domain_info=20=
*info;=0A-=09struct=20dmar_domain=20*domain=20=3D=20NULL;=0A-=09struct=20=
intel_iommu=20*iommu;=0A-=09u16=20dma_alias;=0A-=09unsigned=20long=20=
flags;=0A-=09u8=20bus,=20devfn;=0A-=0A-=09iommu=20=3D=20=
device_to_iommu(dev,=20&bus,=20&devfn);=0A-=09if=20(!iommu)=0A-=09=09=
return=20NULL;=0A-=0A-=09if=20(dev_is_pci(dev))=20{=0A-=09=09struct=20=
pci_dev=20*pdev=20=3D=20to_pci_dev(dev);=0A-=0A-=09=09=
pci_for_each_dma_alias(pdev,=20get_last_alias,=20&dma_alias);=0A-=0A-=09=09=
spin_lock_irqsave(&device_domain_lock,=20flags);=0A-=09=09info=20=3D=20=
dmar_search_domain_by_dev_info(pci_domain_nr(pdev->bus),=0A-=09=09=09=09=09=
=09=20=20=20=20=20=20PCI_BUS_NUM(dma_alias),=0A-=09=09=09=09=09=09=20=20=20=
=20=20=20dma_alias=20&=200xff);=0A-=09=09if=20(info)=20{=0A-=09=09=09=
iommu=20=3D=20info->iommu;=0A-=09=09=09domain=20=3D=20info->domain;=0A-=09=
=09}=0A-=09=09spin_unlock_irqrestore(&device_domain_lock,=20flags);=0A-=0A=
-=09=09/*=20DMA=20alias=20already=20has=20a=20domain,=20use=20it=20*/=0A=
-=09=09if=20(info)=0A-=09=09=09goto=20out;=0A-=09}=0A-=0A-=09/*=20=
Allocate=20and=20initialize=20new=20domain=20for=20the=20device=20*/=0A-=09=
domain=20=3D=20alloc_domain(0);=0A-=09if=20(!domain)=0A-=09=09return=20=
NULL;=0A-=09if=20(domain_init(domain,=20iommu,=20gaw))=20{=0A-=09=09=
domain_exit(domain);=0A-=09=09return=20NULL;=0A-=09}=0A-=0A-out:=0A-=0A-=09=
return=20domain;=0A-}=0A-=0A-static=20struct=20dmar_domain=20=
*set_domain_for_dev(struct=20device=20*dev,=0A-=09=09=09=09=09=20=20=20=20=
=20=20struct=20dmar_domain=20*domain)=0A-{=0A-=09struct=20intel_iommu=20=
*iommu;=0A-=09struct=20dmar_domain=20*tmp;=0A-=09u16=20req_id,=20=
dma_alias;=0A-=09u8=20bus,=20devfn;=0A-=0A-=09iommu=20=3D=20=
device_to_iommu(dev,=20&bus,=20&devfn);=0A-=09if=20(!iommu)=0A-=09=09=
return=20NULL;=0A-=0A-=09req_id=20=3D=20((u16)bus=20<<=208)=20|=20devfn;=0A=
-=0A-=09if=20(dev_is_pci(dev))=20{=0A-=09=09struct=20pci_dev=20*pdev=20=3D=
=20to_pci_dev(dev);=0A-=0A-=09=09pci_for_each_dma_alias(pdev,=20=
get_last_alias,=20&dma_alias);=0A-=0A-=09=09/*=20register=20PCI=20DMA=20=
alias=20device=20*/=0A-=09=09if=20(req_id=20!=3D=20dma_alias)=20{=0A-=09=09=
=09tmp=20=3D=20dmar_insert_one_dev_info(iommu,=20PCI_BUS_NUM(dma_alias),=0A=
-=09=09=09=09=09dma_alias=20&=200xff,=20NULL,=20domain);=0A-=0A-=09=09=09=
if=20(!tmp=20||=20tmp=20!=3D=20domain)=0A-=09=09=09=09return=20tmp;=0A-=09=
=09}=0A-=09}=0A-=0A-=09tmp=20=3D=20dmar_insert_one_dev_info(iommu,=20=
bus,=20devfn,=20dev,=20domain);=0A-=09if=20(!tmp=20||=20tmp=20!=3D=20=
domain)=0A-=09=09return=20tmp;=0A-=0A-=09return=20domain;=0A-}=0A-=0A=
-static=20struct=20dmar_domain=20*get_domain_for_dev(struct=20device=20=
*dev,=20int=20gaw)=0A-{=0A-=09struct=20dmar_domain=20*domain,=20*tmp;=0A=
-=0A-=09domain=20=3D=20find_domain(dev);=0A-=09if=20(domain)=0A-=09=09=
goto=20out;=0A-=0A-=09domain=20=3D=20find_or_alloc_domain(dev,=20gaw);=0A=
-=09if=20(!domain)=0A-=09=09goto=20out;=0A-=0A-=09tmp=20=3D=20=
set_domain_for_dev(dev,=20domain);=0A-=09if=20(!tmp=20||=20domain=20!=3D=20=
tmp)=20{=0A-=09=09domain_exit(domain);=0A-=09=09domain=20=3D=20tmp;=0A-=09=
}=0A-=0A-out:=0A-=0A-=09return=20domain;=0A-}=0A-=0A=20static=20int=20=
iommu_domain_identity_map(struct=20dmar_domain=20*domain,=0A=20=09=09=09=09=
=20=20=20=20=20unsigned=20long=20long=20start,=0A=20=09=09=09=09=20=20=20=
=20=20unsigned=20long=20long=20end)=0A@@=20-2745,72=20+2621,6=20@@=20=
static=20int=20iommu_domain_identity_map(struct=20dmar_domain=20*domain,=0A=
=20=09=09=09=09DMA_PTE_READ|DMA_PTE_WRITE);=0A=20}=0A=20=0A-static=20int=20=
domain_prepare_identity_map(struct=20device=20*dev,=0A-=09=09=09=09=20=20=
=20=20=20=20=20struct=20dmar_domain=20*domain,=0A-=09=09=09=09=20=20=20=20=
=20=20=20unsigned=20long=20long=20start,=0A-=09=09=09=09=20=20=20=20=20=20=
=20unsigned=20long=20long=20end)=0A-{=0A-=09/*=20For=20_hardware_=20=
passthrough,=20don't=20bother.=20But=20for=20software=0A-=09=20=20=20=
passthrough,=20we=20do=20it=20anyway=20--=20it=20may=20indicate=20a=20=
memory=0A-=09=20=20=20range=20which=20is=20reserved=20in=20E820,=20so=20=
which=20didn't=20get=20set=0A-=09=20=20=20up=20to=20start=20with=20in=20=
si_domain=20*/=0A-=09if=20(domain=20=3D=3D=20si_domain=20&&=20=
hw_pass_through)=20{=0A-=09=09dev_warn(dev,=20"Ignoring=20identity=20map=20=
for=20HW=20passthrough=20[0x%Lx=20-=200x%Lx]\n",=0A-=09=09=09=20start,=20=
end);=0A-=09=09return=200;=0A-=09}=0A-=0A-=09dev_info(dev,=20"Setting=20=
identity=20map=20[0x%Lx=20-=200x%Lx]\n",=20start,=20end);=0A-=0A-=09if=20=
(end=20<=20start)=20{=0A-=09=09WARN(1,=20"Your=20BIOS=20is=20broken;=20=
RMRR=20ends=20before=20it=20starts!\n"=0A-=09=09=09"BIOS=20vendor:=20%s;=20=
Ver:=20%s;=20Product=20Version:=20%s\n",=0A-=09=09=09=
dmi_get_system_info(DMI_BIOS_VENDOR),=0A-=09=09=09=
dmi_get_system_info(DMI_BIOS_VERSION),=0A-=09=09=20=20=20=20=20=
dmi_get_system_info(DMI_PRODUCT_VERSION));=0A-=09=09return=20-EIO;=0A-=09=
}=0A-=0A-=09if=20(end=20>>=20agaw_to_width(domain->agaw))=20{=0A-=09=09=
WARN(1,=20"Your=20BIOS=20is=20broken;=20RMRR=20exceeds=20permitted=20=
address=20width=20(%d=20bits)\n"=0A-=09=09=20=20=20=20=20"BIOS=20vendor:=20=
%s;=20Ver:=20%s;=20Product=20Version:=20%s\n",=0A-=09=09=20=20=20=20=20=
agaw_to_width(domain->agaw),=0A-=09=09=20=20=20=20=20=
dmi_get_system_info(DMI_BIOS_VENDOR),=0A-=09=09=20=20=20=20=20=
dmi_get_system_info(DMI_BIOS_VERSION),=0A-=09=09=20=20=20=20=20=
dmi_get_system_info(DMI_PRODUCT_VERSION));=0A-=09=09return=20-EIO;=0A-=09=
}=0A-=0A-=09return=20iommu_domain_identity_map(domain,=20start,=20end);=0A=
-}=0A-=0A-static=20int=20iommu_prepare_identity_map(struct=20device=20=
*dev,=0A-=09=09=09=09=20=20=20=20=20=20unsigned=20long=20long=20start,=0A=
-=09=09=09=09=20=20=20=20=20=20unsigned=20long=20long=20end)=0A-{=0A-=09=
struct=20dmar_domain=20*domain;=0A-=09int=20ret;=0A-=0A-=09domain=20=3D=20=
get_domain_for_dev(dev,=20DEFAULT_DOMAIN_ADDRESS_WIDTH);=0A-=09if=20=
(!domain)=0A-=09=09return=20-ENOMEM;=0A-=0A-=09ret=20=3D=20=
domain_prepare_identity_map(dev,=20domain,=20start,=20end);=0A-=09if=20=
(ret)=0A-=09=09domain_exit(domain);=0A-=0A-=09return=20ret;=0A-}=0A-=0A=
-static=20inline=20int=20iommu_prepare_rmrr_dev(struct=20dmar_rmrr_unit=20=
*rmrr,=0A-=09=09=09=09=09=20struct=20device=20*dev)=0A-{=0A-=09if=20=
(dev->archdata.iommu=20=3D=3D=20DUMMY_DEVICE_DOMAIN_INFO)=0A-=09=09=
return=200;=0A-=09return=20iommu_prepare_identity_map(dev,=20=
rmrr->base_address,=0A-=09=09=09=09=09=20=20rmrr->end_address);=0A-}=0A-=0A=
=20static=20inline=20struct=20iommu_resv_region=20=
*iommu_get_isa_resv_region(void)=0A=20{=0A=20=09if=20(!isa_resv_region)=0A=
@@=20-2821,29=20+2631,6=20@@=20static=20inline=20struct=20=
iommu_resv_region=20*iommu_get_isa_resv_region(void)=0A=20=09return=20=
isa_resv_region;=0A=20}=0A=20=0A-#ifdef=20CONFIG_INTEL_IOMMU_FLOPPY_WA=0A=
-static=20inline=20void=20iommu_prepare_isa(struct=20pci_dev=20*pdev)=0A=
-{=0A-=09int=20ret;=0A-=09struct=20iommu_resv_region=20*reg=20=3D=20=
iommu_get_isa_resv_region();=0A-=0A-=09if=20(!reg)=0A-=09=09return;=0A-=0A=
-=09pr_info("Prepare=200-16MiB=20unity=20mapping=20for=20LPC\n");=0A-=09=
ret=20=3D=20iommu_prepare_identity_map(&pdev->dev,=20reg->start,=0A-=09=09=
=09reg->start=20+=20reg->length=20-=201);=0A-=0A-=09if=20(ret)=0A-=09=09=
pr_err("Failed=20to=20create=200-16MiB=20identity=20map=20-=20floppy=20=
might=20not=20work\n");=0A-}=0A-#else=0A-static=20inline=20void=20=
iommu_prepare_isa(struct=20pci_dev=20*pdev)=0A-{=0A-=09return;=0A-}=0A=
-#endif=20/*=20!CONFIG_INTEL_IOMMU_FLPY_WA=20*/=0A-=0A=20static=20int=20=
md_domain_init(struct=20dmar_domain=20*domain,=20int=20guest_width);=0A=20=
=0A=20static=20int=20__init=20si_domain_init(int=20hw)=0A@@=20-3066,18=20=
+2853,10=20@@=20static=20int=20__init=20=
dev_prepare_static_identity_mapping(struct=20device=20*dev,=20int=20hw=0A=
=20=0A=20static=20int=20__init=20=
iommu_prepare_static_identity_mapping(int=20hw)=0A=20{=0A-=09struct=20=
pci_dev=20*pdev=20=3D=20NULL;=0A=20=09struct=20dmar_drhd_unit=20*drhd;=0A=
=20=09struct=20intel_iommu=20*iommu;=0A=20=09struct=20device=20*dev;=0A-=09=
int=20i;=0A-=09int=20ret=20=3D=200;=0A-=0A-=09for_each_pci_dev(pdev)=20{=0A=
-=09=09ret=20=3D=20dev_prepare_static_identity_mapping(&pdev->dev,=20=
hw);=0A-=09=09if=20(ret)=0A-=09=09=09return=20ret;=0A-=09}=0A+=09int=20=
i,=20ret=20=3D=200;=0A=20=0A=20=09for_each_active_iommu(iommu,=20drhd)=0A=
=20=09=09for_each_active_dev_scope(drhd->devices,=20drhd->devices_cnt,=20=
i,=20dev)=20{=0A@@=20-3324,12=20+3103,9=20@@=20static=20int=20=
copy_translation_tables(struct=20intel_iommu=20*iommu)=0A=20static=20int=20=
__init=20init_dmars(void)=0A=20{=0A=20=09struct=20dmar_drhd_unit=20=
*drhd;=0A-=09struct=20dmar_rmrr_unit=20*rmrr;=0A=20=09bool=20=
copied_tables=20=3D=20false;=0A-=09struct=20device=20*dev;=0A-=09struct=20=
pci_dev=20*pdev;=0A=20=09struct=20intel_iommu=20*iommu;=0A-=09int=20i,=20=
ret;=0A+=09int=20ret;=0A=20=0A=20=09/*=0A=20=09=20*=20for=20each=20drhd=0A=
@@=20-3483,36=20+3259,6=20@@=20static=20int=20__init=20init_dmars(void)=0A=
=20=09=09=09goto=20free_iommu;=0A=20=09=09}=0A=20=09}=0A-=09/*=0A-=09=20=
*=20For=20each=20rmrr=0A-=09=20*=20=20=20for=20each=20dev=20attached=20=
to=20rmrr=0A-=09=20*=20=20=20do=0A-=09=20*=20=20=20=20=20locate=20drhd=20=
for=20dev,=20alloc=20domain=20for=20dev=0A-=09=20*=20=20=20=20=20=
allocate=20free=20domain=0A-=09=20*=20=20=20=20=20allocate=20page=20=
table=20entries=20for=20rmrr=0A-=09=20*=20=20=20=20=20if=20context=20not=20=
allocated=20for=20bus=0A-=09=20*=20=20=20=20=20=20=20=20=20=20=20=
allocate=20and=20init=20context=0A-=09=20*=20=20=20=20=20=20=20=20=20=20=20=
set=20present=20in=20root=20table=20for=20this=20bus=0A-=09=20*=20=20=20=20=
=20init=20context=20with=20domain,=20translation=20etc=0A-=09=20*=20=20=20=
=20endfor=0A-=09=20*=20endfor=0A-=09=20*/=0A-=09pr_info("Setting=20=
RMRR:\n");=0A-=09for_each_rmrr_units(rmrr)=20{=0A-=09=09/*=20some=20BIOS=20=
lists=20non-exist=20devices=20in=20DMAR=20table.=20*/=0A-=09=09=
for_each_active_dev_scope(rmrr->devices,=20rmrr->devices_cnt,=0A-=09=09=09=
=09=09=20=20i,=20dev)=20{=0A-=09=09=09ret=20=3D=20=
iommu_prepare_rmrr_dev(rmrr,=20dev);=0A-=09=09=09if=20(ret)=0A-=09=09=09=09=
pr_err("Mapping=20reserved=20region=20failed\n");=0A-=09=09}=0A-=09}=0A-=0A=
-=09pdev=20=3D=20pci_get_class(PCI_CLASS_BRIDGE_ISA=20<<=208,=20NULL);=0A=
-=09if=20(pdev)=20{=0A-=09=09iommu_prepare_isa(pdev);=0A-=09=09=
pci_dev_put(pdev);=0A-=09}=0A=20=0A=20domains_done:=0A=20=0A@@=20=
-3595,53=20+3341,6=20@@=20static=20unsigned=20long=20=
intel_alloc_iova(struct=20device=20*dev,=0A=20=09return=20iova_pfn;=0A=20=
}=0A=20=0A-struct=20dmar_domain=20*get_valid_domain_for_dev(struct=20=
device=20*dev)=0A-{=0A-=09struct=20dmar_domain=20*domain,=20*tmp;=0A-=09=
struct=20dmar_rmrr_unit=20*rmrr;=0A-=09struct=20device=20*i_dev;=0A-=09=
int=20i,=20ret;=0A-=0A-=09domain=20=3D=20find_domain(dev);=0A-=09if=20=
(domain)=0A-=09=09goto=20out;=0A-=0A-=09domain=20=3D=20=
find_or_alloc_domain(dev,=20DEFAULT_DOMAIN_ADDRESS_WIDTH);=0A-=09if=20=
(!domain)=0A-=09=09goto=20out;=0A-=0A-=09/*=20We=20have=20a=20new=20=
domain=20-=20setup=20possible=20RMRRs=20for=20the=20device=20*/=0A-=09=
rcu_read_lock();=0A-=09for_each_rmrr_units(rmrr)=20{=0A-=09=09=
for_each_active_dev_scope(rmrr->devices,=20rmrr->devices_cnt,=0A-=09=09=09=
=09=09=20=20i,=20i_dev)=20{=0A-=09=09=09if=20(i_dev=20!=3D=20dev)=0A-=09=09=
=09=09continue;=0A-=0A-=09=09=09ret=20=3D=20=
domain_prepare_identity_map(dev,=20domain,=0A-=09=09=09=09=09=09=09=20=20=
rmrr->base_address,=0A-=09=09=09=09=09=09=09=20=20rmrr->end_address);=0A=
-=09=09=09if=20(ret)=0A-=09=09=09=09dev_err(dev,=20"Mapping=20reserved=20=
region=20failed\n");=0A-=09=09}=0A-=09}=0A-=09rcu_read_unlock();=0A-=0A-=09=
tmp=20=3D=20set_domain_for_dev(dev,=20domain);=0A-=09if=20(!tmp=20||=20=
domain=20!=3D=20tmp)=20{=0A-=09=09domain_exit(domain);=0A-=09=09domain=20=
=3D=20tmp;=0A-=09}=0A-=0A-out:=0A-=0A-=09if=20(!domain)=0A-=09=09=
dev_err(dev,=20"Allocating=20domain=20failed\n");=0A-=0A-=0A-=09return=20=
domain;=0A-}=0A-=0A=20/*=20Check=20if=20the=20dev=20needs=20to=20go=20=
through=20non-identity=20map=20and=20unmap=20process.*/=0A=20static=20=
int=20iommu_no_mapping(struct=20device=20*dev)=0A=20{=0A@@=20-3688,6=20=
+3387,7=20@@=20static=20dma_addr_t=20__intel_map_single(struct=20device=20=
*dev,=20phys_addr_t=20paddr,=0A=20=09=09=09=09=20=20=20=20=20size_t=20=
size,=20int=20dir,=20u64=20dma_mask)=0A=20{=0A=20=09struct=20dmar_domain=20=
*domain;=0A+=09struct=20iommu_domain=20*io_domain;=0A=20=09phys_addr_t=20=
start_paddr;=0A=20=09unsigned=20long=20iova_pfn;=0A=20=09int=20prot=20=3D=20=
0;=0A@@=20-3700,9=20+3400,10=20@@=20static=20dma_addr_t=20=
__intel_map_single(struct=20device=20*dev,=20phys_addr_t=20paddr,=0A=20=09=
if=20(iommu_no_mapping(dev))=0A=20=09=09return=20paddr;=0A=20=0A-=09=
domain=20=3D=20get_valid_domain_for_dev(dev);=0A-=09if=20(!domain)=0A+=09=
io_domain=20=3D=20iommu_get_domain_for_dev(dev);=0A+=09if=20(!io_domain)=0A=
=20=09=09return=20DMA_MAPPING_ERROR;=0A+=09domain=20=3D=20=
to_dmar_domain(io_domain);=0A=20=0A=20=09iommu=20=3D=20=
domain_get_iommu(domain);=0A=20=09size=20=3D=20aligned_nrpages(paddr,=20=
size);=0A@@=20-3762,6=20+3463,7=20@@=20static=20dma_addr_t=20=
intel_map_resource(struct=20device=20*dev,=20phys_addr_t=20phys_addr,=0A=20=
static=20void=20intel_unmap(struct=20device=20*dev,=20dma_addr_t=20=
dev_addr,=20size_t=20size)=0A=20{=0A=20=09struct=20dmar_domain=20=
*domain;=0A+=09struct=20iommu_domain=20*io_domain;=0A=20=09unsigned=20=
long=20start_pfn,=20last_pfn;=0A=20=09unsigned=20long=20nrpages;=0A=20=09=
unsigned=20long=20iova_pfn;=0A@@=20-3771,8=20+3473,9=20@@=20static=20=
void=20intel_unmap(struct=20device=20*dev,=20dma_addr_t=20dev_addr,=20=
size_t=20size)=0A=20=09if=20(iommu_no_mapping(dev))=0A=20=09=09return;=0A=
=20=0A-=09domain=20=3D=20find_domain(dev);=0A-=09BUG_ON(!domain);=0A+=09=
io_domain=20=3D=20iommu_get_domain_for_dev(dev);=0A+=09=
BUG_ON(!io_domain);=0A+=09domain=20=3D=20to_dmar_domain(io_domain);=0A=20=
=0A=20=09iommu=20=3D=20domain_get_iommu(domain);=0A=20=0A@@=20-3906,6=20=
+3609,7=20@@=20static=20int=20intel_map_sg(struct=20device=20*dev,=20=
struct=20scatterlist=20*sglist,=20int=20nele=0A=20{=0A=20=09int=20i;=0A=20=
=09struct=20dmar_domain=20*domain;=0A+=09struct=20iommu_domain=20=
*io_domain;=0A=20=09size_t=20size=20=3D=200;=0A=20=09int=20prot=20=3D=20=
0;=0A=20=09unsigned=20long=20iova_pfn;=0A@@=20-3918,9=20+3622,10=20@@=20=
static=20int=20intel_map_sg(struct=20device=20*dev,=20struct=20=
scatterlist=20*sglist,=20int=20nele=0A=20=09if=20(iommu_no_mapping(dev))=0A=
=20=09=09return=20intel_nontranslate_map_sg(dev,=20sglist,=20nelems,=20=
dir);=0A=20=0A-=09domain=20=3D=20get_valid_domain_for_dev(dev);=0A-=09if=20=
(!domain)=0A+=09io_domain=20=3D=20iommu_get_domain_for_dev(dev);=0A+=09=
if=20(!io_domain)=0A=20=09=09return=200;=0A+=09domain=20=3D=20=
to_dmar_domain(io_domain);=0A=20=0A=20=09iommu=20=3D=20=
domain_get_iommu(domain);=0A=20=0A@@=20-4611,9=20+4316,11=20@@=20static=20=
int=20device_notifier(struct=20notifier_block=20*nb,=0A=20=09=09return=20=
0;=0A=20=0A=20=09if=20(action=20=3D=3D=20BUS_NOTIFY_REMOVED_DEVICE)=20{=0A=
-=09=09domain=20=3D=20find_domain(dev);=0A-=09=09if=20(!domain)=0A+=09=09=
struct=20iommu_domain=20*io_domain;=0A+=09=09io_domain=20=3D=20=
iommu_get_domain_for_dev(dev);=0A+=09=09if=20(!io_domain)=0A=20=09=09=09=
return=200;=0A+=09=09domain=20=3D=20to_dmar_domain(io_domain);=0A=20=0A=20=
=09=09dmar_remove_one_dev_info(dev);=0A=20=09=09if=20=
(!domain_managed_externally(domain)=20&&=0A@@=20-5143,9=20+4850,11=20@@=20=
static=20int=20intel_iommu_attach_device(struct=20iommu_domain=20=
*domain,=0A=20=09/*=20normally=20dev=20is=20not=20mapped=20*/=0A=20=09if=20=
(unlikely(domain_context_mapped(dev)))=20{=0A=20=09=09struct=20=
dmar_domain=20*old_domain;=0A+=09=09struct=20iommu_domain=20=
*old_io_domain;=0A=20=0A-=09=09old_domain=20=3D=20find_domain(dev);=0A-=09=
=09if=20(old_domain)=20{=0A+=09=09old_io_domain=20=3D=20=
iommu_get_domain_for_dev(dev);=0A+=09=09if=20(old_io_domain)=20{=0A+=09=09=
=09old_domain=20=3D=20to_dmar_domain(old_io_domain);=0A=20=09=09=09=
rcu_read_lock();=0A=20=09=09=09dmar_remove_one_dev_info(dev);=0A=20=09=09=
=09rcu_read_unlock();=0A@@=20-5416,13=20+5125,15=20@@=20int=20=
intel_iommu_enable_pasid(struct=20intel_iommu=20*iommu,=20struct=20=
intel_svm_dev=20*sd=0A=20=09struct=20device_domain_info=20*info;=0A=20=09=
struct=20context_entry=20*context;=0A=20=09struct=20dmar_domain=20=
*domain;=0A+=09struct=20iommu_domain=20*io_domain;=0A=20=09unsigned=20=
long=20flags;=0A=20=09u64=20ctx_lo;=0A=20=09int=20ret;=0A=20=0A-=09=
domain=20=3D=20get_valid_domain_for_dev(sdev->dev);=0A-=09if=20(!domain)=0A=
+=09io_domain=20=3D=20iommu_get_domain_for_dev(sdev->dev);=0A+=09if=20=
(!io_domain)=0A=20=09=09return=20-EINVAL;=0A+=09domain=20=3D=20=
to_dmar_domain(io_domain);=0A=20=0A=20=09=
spin_lock_irqsave(&device_domain_lock,=20flags);=0A=20=09=
spin_lock(&iommu->lock);=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_D0F74EE9-0484-4D96-85AE-EB4A82B709F5--
