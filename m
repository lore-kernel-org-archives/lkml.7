Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA47BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7520A2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OtUMXvdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfDESDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:03:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34627 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDESDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:03:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id x14so6302595eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=D7yEycA14pSmQC05y9PWONSA5dN5gAvQ0hjYoNFbaSU=;
        b=OtUMXvdtK5T6/2qorAFnq/qRDQnqAS6B5D6lPKHYgHjhFkTKpa865KhjWwQazrcqUd
         KFH+3VMmLrjjl8dLoxoyJmTBbjq1zqlgfaRKvnPmqVnh1cg+SCUBtcZ6vBIXX4rMBbWr
         7djfqF8bbjtzUn3xeTBBtwnzMxmXcJI7W0wBFXoXFTu9KaBqMnbzPR091Q91FK2Rfuel
         feAfWImhaf2RRGkBGHcxLn3caLMt4G1QeRXBC9uzHTToXn8lVW3GEk1Er8wIkUWh4nfI
         vtdJ+cMwxCWUeiKekO2bbmjOEmKJF5fIUsmuVUAUKgQ8l9WuuiDi9lkqI842/67viZzg
         j5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=D7yEycA14pSmQC05y9PWONSA5dN5gAvQ0hjYoNFbaSU=;
        b=N5VvycNQKtXifaGevhw9ZJA4ub98ic7/Sz7IQUoyDh+vZbfnsv9S1lVqZ0/8/tfNb7
         lgRqKTlxyxcDZvK/AxqhZ7NqGpZfzh2heN/fzdvFRN2/xnQ4k1LE83MW8DL6BzkwpzOi
         eW4GNEf5ncrA+cTjnB9B9BLByrJvgCyn6F8VkXyOJQjVQ7lEMNo6ed+vscjfw72/on4b
         dpr0StExCSj0RWiKjirPnUWnyaApW3+4mPi8UelxVtjpO+WLJYsV8DOUIHfldPKDnX/w
         abpEVOxsUszYQicTSSrpeBjjjU02tSL+OLLI/Zi+TlLoEwfBxrzKtA8wRG+V8BAXXKFt
         KugQ==
X-Gm-Message-State: APjAAAVkoHZwycji6ztRk4V/Nx7UrMpiVyYXgdp9yqVbRbtnbTt+ltcW
        878gQ9WqVgXY5RtYgrCoy0f7OQ==
X-Google-Smtp-Source: APXvYqyM5M9Ui61KhTAkTf8okPEJHcFuu2ZLY8nSgxqjLTVSWQwZ9eAEQdtgU+Dz+50gaFYM5K7e3g==
X-Received: by 2002:a17:906:278a:: with SMTP id j10mr8299298ejc.12.1554487380585;
        Fri, 05 Apr 2019 11:03:00 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y4sm6504438edq.53.2019.04.05.11.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 11:02:59 -0700 (PDT)
From:   James Sewart <jamessewart@arista.com>
Message-Id: <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_7C5E6792-50DC-4211-A848-5B8FC20072DB"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
Date:   Fri, 5 Apr 2019 19:02:34 +0100
In-Reply-To: <ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
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
 <8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
 <ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_7C5E6792-50DC-4211-A848-5B8FC20072DB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hey Lu,

My bad, did some debugging on my end. The issue was swapping out=20
find_domain for iommu_get_domain_for_dev. It seems in some situations =
the=20
domain is not attached to the group but the device is expected to have =
the=20
domain still stored in its archdata.

I=E2=80=99ve attached the final patch with find_domain unremoved which =
seems to=20
work in my testing.

Cheers,
James.


--Apple-Mail=_7C5E6792-50DC-4211-A848-5B8FC20072DB
Content-Disposition: attachment;
	filename=0009-iommu-vt-d-Remove-lazy-allocation-of-domains.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0009-iommu-vt-d-Remove-lazy-allocation-of-domains.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=207933b0778a217e15faee86f39b3628aa9c8407fc=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Sewart=20<jamessewart@arista.com>=0A=
Date:=20Mon,=2011=20Mar=202019=2014:55:01=20+0000=0ASubject:=20[PATCH=20=
9/9]=20iommu/vt-d:=20Remove=20lazy=20allocation=20of=20domains=0A=0AThe=20=
generic=20IOMMU=20code=20will=20allocate=20and=20attach=20a=20default=20=
domain=20to=20each=0Adevice=20that=20comes=20online.=20This=20patch=20=
removes=20the=20lazy=20domain=20allocation=0Aand=20early=20reserved=20=
region=20mapping=20that=20is=20now=20redundant.=0A=0ASigned-off-by:=20=
James=20Sewart=20<jamessewart@arista.com>=0A=0Adiff=20--git=20=
a/drivers/iommu/intel-iommu.c=20b/drivers/iommu/intel-iommu.c=0Aindex=20=
2055c11f5978..9e330e4a3ae3=20100644=0A---=20=
a/drivers/iommu/intel-iommu.c=0A+++=20b/drivers/iommu/intel-iommu.c=0A@@=20=
-2608,118=20+2608,6=20@@=20static=20struct=20dmar_domain=20=
*dmar_insert_one_dev_info(struct=20intel_iommu=20*iommu,=0A=20=09return=20=
domain;=0A=20}=0A=20=0A-static=20int=20get_last_alias(struct=20pci_dev=20=
*pdev,=20u16=20alias,=20void=20*opaque)=0A-{=0A-=09*(u16=20*)opaque=20=3D=20=
alias;=0A-=09return=200;=0A-}=0A-=0A-static=20struct=20dmar_domain=20=
*find_or_alloc_domain(struct=20device=20*dev,=20int=20gaw)=0A-{=0A-=09=
struct=20device_domain_info=20*info;=0A-=09struct=20dmar_domain=20=
*domain=20=3D=20NULL;=0A-=09struct=20intel_iommu=20*iommu;=0A-=09u16=20=
dma_alias;=0A-=09unsigned=20long=20flags;=0A-=09u8=20bus,=20devfn;=0A-=0A=
-=09iommu=20=3D=20device_to_iommu(dev,=20&bus,=20&devfn);=0A-=09if=20=
(!iommu)=0A-=09=09return=20NULL;=0A-=0A-=09if=20(dev_is_pci(dev))=20{=0A=
-=09=09struct=20pci_dev=20*pdev=20=3D=20to_pci_dev(dev);=0A-=0A-=09=09=
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
=20=20unsigned=20long=20long=20end)=0A@@=20-2745,72=20+2633,6=20@@=20=
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
@@=20-2821,29=20+2643,6=20@@=20static=20inline=20struct=20=
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
+2865,10=20@@=20static=20int=20__init=20=
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
i,=20dev)=20{=0A@@=20-3324,12=20+3115,9=20@@=20static=20int=20=
copy_translation_tables(struct=20intel_iommu=20*iommu)=0A=20static=20int=20=
__init=20init_dmars(void)=0A=20{=0A=20=09struct=20dmar_drhd_unit=20=
*drhd;=0A-=09struct=20dmar_rmrr_unit=20*rmrr;=0A=20=09bool=20=
copied_tables=20=3D=20false;=0A-=09struct=20device=20*dev;=0A-=09struct=20=
pci_dev=20*pdev;=0A=20=09struct=20intel_iommu=20*iommu;=0A-=09int=20i,=20=
ret;=0A+=09int=20ret;=0A=20=0A=20=09/*=0A=20=09=20*=20for=20each=20drhd=0A=
@@=20-3483,36=20+3271,6=20@@=20static=20int=20__init=20init_dmars(void)=0A=
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
-3595,53=20+3353,6=20@@=20static=20unsigned=20long=20=
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
int=20iommu_no_mapping(struct=20device=20*dev)=0A=20{=0A@@=20-3700,7=20=
+3411,7=20@@=20static=20dma_addr_t=20__intel_map_single(struct=20device=20=
*dev,=20phys_addr_t=20paddr,=0A=20=09if=20(iommu_no_mapping(dev))=0A=20=09=
=09return=20paddr;=0A=20=0A-=09domain=20=3D=20=
get_valid_domain_for_dev(dev);=0A+=09domain=20=3D=20find_domain(dev);=0A=20=
=09if=20(!domain)=0A=20=09=09return=20DMA_MAPPING_ERROR;=0A=20=0A@@=20=
-3918,7=20+3629,7=20@@=20static=20int=20intel_map_sg(struct=20device=20=
*dev,=20struct=20scatterlist=20*sglist,=20int=20nele=0A=20=09if=20=
(iommu_no_mapping(dev))=0A=20=09=09return=20=
intel_nontranslate_map_sg(dev,=20sglist,=20nelems,=20dir);=0A=20=0A-=09=
domain=20=3D=20get_valid_domain_for_dev(dev);=0A+=09domain=20=3D=20=
find_domain(dev);=0A=20=09if=20(!domain)=0A=20=09=09return=200;=0A=20=0A=
@@=20-5420,7=20+5131,7=20@@=20int=20intel_iommu_enable_pasid(struct=20=
intel_iommu=20*iommu,=20struct=20intel_svm_dev=20*sd=0A=20=09u64=20=
ctx_lo;=0A=20=09int=20ret;=0A=20=0A-=09domain=20=3D=20=
get_valid_domain_for_dev(sdev->dev);=0A+=09domain=20=3D=20=
find_domain(sdev->dev);=0A=20=09if=20(!domain)=0A=20=09=09return=20=
-EINVAL;=0A=20=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_7C5E6792-50DC-4211-A848-5B8FC20072DB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8




> On 4 Apr 2019, at 07:49, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> I did a sanity test from my end. The test machine fails to boot. I
> haven't seen any valuable kernel log. It results in a purple screen.
>=20
> Best regards,
> Lu Baolu
>=20
> On 3/29/19 11:26 PM, James Sewart wrote:
>> Hey Lu,
>> I=E2=80=99ve attached a preliminary v3, if you could take a look and =
run some tests
>> that would be great.
>> Since v2 i=E2=80=99ve added your default domain type patches, the new =
device_group
>> handler, and incorporated Jacob=E2=80=99s feedback.
>>> On 28 Mar 2019, at 18:37, James Sewart <jamessewart@arista.com> =
wrote:
>>>=20
>>> Hey Lu,
>>>=20
>>>> On 26 Mar 2019, at 01:24, Lu Baolu <baolu.lu@linux.intel.com> =
wrote:
>>>>=20
>>>> Hi James,
>>>>=20
>>>> On 3/25/19 8:57 PM, James Sewart wrote:
>>>>>>> Theres an issue that if we choose to alloc a new resv_region =
with type
>>>>>>> IOMMU_RESV_DIRECT, we will need to refactor =
intel_iommu_put_resv_regions
>>>>>>> to free this entry type which means refactoring the rmrr regions =
in
>>>>>>> get_resv_regions. Should this work be in this patchset?
>>>>>> Do you mean the rmrr regions are not allocated in =
get_resv_regions, but
>>>>>> are freed in put_resv_regions? I think we should fix this in this =
patch
>>>>>> set since this might impact the device passthrough if we don't do =
it.
>>>>> They=E2=80=99re not allocated and not freed currently, only type =
IOMMU_RESV_MSI is
>>>>> freed in put_resv_regions. If we allocate a new resv_region with =
type
>>>>> IOMMU_RESV_DIRECT for the isa region, then it won=E2=80=99t be =
freed. If we modify
>>>>> put_resv_regions to free type IOMMU_RESV_DIRECT, then we will try =
to free
>>>>> the static RMRR regions.
>>>>> Either the ISA region is static and not freed as with my =
implementation,
>>>>> or the RMRR regions are converted to be allocated on each call to
>>>>> get_resv_regions and freed in put_resv_regions.
>>>>=20
>>>> By the way, there's another way in my mind. Let's add a new region =
type
>>>> for LPC devices, e.x. IOMMU_RESV_LPC, and then handle it in the =
same way
>>>> as those MSI regions. Just FYI.
>>>=20
>>> This solution would require adding some extra code to
>>> iommu_group_create_direct_mappings as currently only type
>>> IOMMU_RESV_DIRECT is identity mapped, other types are only reserved.
>>>=20
>>>=20
>>>>=20
>>>> Best regards,
>>>> Lu Baolu
>>>=20
>>> Cheers,
>>> James.
>> Cheers,
>> James.


--Apple-Mail=_7C5E6792-50DC-4211-A848-5B8FC20072DB--
