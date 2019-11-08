Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC8FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9291C21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSJpS9p3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbfKHKdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:33:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54012 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727016AbfKHKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573209211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4r0wQhpw9SDwOQ7j/frTg7qzc15zybFcGHHQbMOXvtA=;
        b=HSJpS9p3ACTjtnkkcyjWObvwBxHoxDa992Mrgx7OmrVvOt/UFce4B+mnaB/BNG5EAf90vp
        JTXvlQ5eSwWU9qpwoWp3RBYLrA07YJXCs7JaAJDhzsCdebLH0hceQnOj8RTHySWYaAwSov
        BK8jPo1uE+8O09wBonrTo/pLoJrYTqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-OwoZSOGpOMWYysl8qOa9lg-1; Fri, 08 Nov 2019 05:33:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9829107ACC3;
        Fri,  8 Nov 2019 10:33:26 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 925F95D6D8;
        Fri,  8 Nov 2019 10:33:23 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 02/11] iommu/vt-d: Enlightened PASID allocation
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-3-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <79e3f867-8892-2314-e6f6-eac7d9b4f15b@redhat.com>
Date:   Fri, 8 Nov 2019 11:33:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: OwoZSOGpOMWYysl8qOa9lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,
On 10/24/19 9:54 PM, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Enabling IOMMU in a guest requires communication with the host
> driver for certain aspects. Use of PASID ID to enable Shared Virtual
> Addressing (SVA) requires managing PASID's in the host. VT-d 3.0 spec
> provides a Virtual Command Register (VCMD) to facilitate this.
> Writes to this register in the guest are trapped by QEMU which
> proxies the call to the host driver.
>=20
> This virtual command interface consists of a capability register,
> a virtual command register, and a virtual response register. Refer
> to section 10.4.42, 10.4.43, 10.4.44 for more information.
>=20
> This patch adds the enlightened PASID allocation/free interfaces
> via the virtual command interface.
>=20
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-pasid.c | 56 +++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/iommu/intel-pasid.h | 13 ++++++++++-
>  include/linux/intel-iommu.h |  2 ++
>  3 files changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 040a445be300..d81e857d2b25 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -63,6 +63,62 @@ void *intel_pasid_lookup_id(int pasid)
>  =09return p;
>  }
> =20
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
> +{
> +=09unsigned long flags;
> +=09u8 status_code;
> +=09int ret =3D 0;
> +=09u64 res;
> +
> +=09raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +=09dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
> +=09IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +=09=09      !(res & VCMD_VRSP_IP), res);
> +=09raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +=09status_code =3D VCMD_VRSP_SC(res);
> +=09switch (status_code) {
> +=09case VCMD_VRSP_SC_SUCCESS:
> +=09=09*pasid =3D VCMD_VRSP_RESULT(res);
> +=09=09break;
> +=09case VCMD_VRSP_SC_NO_PASID_AVAIL:
> +=09=09pr_info("IOMMU: %s: No PASID available\n", iommu->name);
> +=09=09ret =3D -ENOMEM;
> +=09=09break;
> +=09default:
> +=09=09ret =3D -ENODEV;
> +=09=09pr_warn("IOMMU: %s: Unexpected error code %d\n",
> +=09=09=09iommu->name, status_code);
> +=09}
> +
> +=09return ret;
> +}
> +
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> +{
> +=09unsigned long flags;
> +=09u8 status_code;
> +=09u64 res;
> +
> +=09raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +=09dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) | VCMD_CMD_FREE)=
;
> +=09IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +=09=09      !(res & VCMD_VRSP_IP), res);
> +=09raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +=09status_code =3D VCMD_VRSP_SC(res);
> +=09switch (status_code) {
> +=09case VCMD_VRSP_SC_SUCCESS:
> +=09=09break;
> +=09case VCMD_VRSP_SC_INVALID_PASID:
> +=09=09pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
> +=09=09break;
> +=09default:
> +=09=09pr_warn("IOMMU: %s: Unexpected error code %d\n",
> +=09=09=09iommu->name, status_code);
> +=09}
> +}
> +
>  /*
>   * Per device pasid table management:
>   */
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index fc8cd8f17de1..e413e884e685 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -23,6 +23,16 @@
>  #define is_pasid_enabled(entry)=09=09(((entry)->lo >> 3) & 0x1)
>  #define get_pasid_dir_size(entry)=09(1 << ((((entry)->lo >> 9) & 0x7) + =
7))
> =20
> +/* Virtual command interface for enlightened pasid management. */
> +#define VCMD_CMD_ALLOC=09=09=090x1
> +#define VCMD_CMD_FREE=09=09=090x2
> +#define VCMD_VRSP_IP=09=09=090x1
> +#define VCMD_VRSP_SC(e)=09=09=09(((e) >> 1) & 0x3)
> +#define VCMD_VRSP_SC_SUCCESS=09=090
> +#define VCMD_VRSP_SC_NO_PASID_AVAIL=091
> +#define VCMD_VRSP_SC_INVALID_PASID=091
> +#define VCMD_VRSP_RESULT(e)=09=09(((e) >> 8) & 0xfffff)
nit: pasid is 20b but result field is 56b large
Just in case a new command were to be added later on.
> +
>  /*
>   * Domain ID reserved for pasid entries programmed for first-level
>   * only and pass-through transfer modes.
> @@ -95,5 +105,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu =
*iommu,
>  =09=09=09=09   struct device *dev, int pasid);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  =09=09=09=09 struct device *dev, int pasid);
> -
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2e1bed9b7eef..1d4b8dcdc5d8 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -161,6 +161,7 @@
>  #define ecap_smpwc(e)=09=09(((e) >> 48) & 0x1)
>  #define ecap_flts(e)=09=09(((e) >> 47) & 0x1)
>  #define ecap_slts(e)=09=09(((e) >> 46) & 0x1)
> +#define ecap_vcs(e)=09=09(((e) >> 44) & 0x1)
nit: this addition is not related to this patch
may be moved to [3] as vccap_pasid
>  #define ecap_smts(e)=09=09(((e) >> 43) & 0x1)
>  #define ecap_dit(e)=09=09((e >> 41) & 0x1)
>  #define ecap_pasid(e)=09=09((e >> 40) & 0x1)
> @@ -282,6 +283,7 @@
> =20
>  /* PRS_REG */
>  #define DMA_PRS_PPR=09((u32)1)
> +#define DMA_VCS_PAS=09((u64)1)
> =20
>  #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)=09=09=09\
>  do {=09=09=09=09=09=09=09=09=09\
>=20
Otherwise looks good to me

Thanks

Eric

