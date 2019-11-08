Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB5DFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCD221848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcenVrjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfKHKdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:33:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46996 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731656AbfKHKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573209182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJIemJ28V7SlVdwM6PWNhep+T2p/t4Izn4GDnmEe/tw=;
        b=UcenVrjzlY4xcfplDTmN7ODuVN19AxU1j5VE2fUWjxQ6NsLYvClZjurgVbxjNf2e1uvFoa
        N8ZlV2HtqXN3Xb5bSHK8knHGLWsgBwVh2zsx72FsiC9gnIMzbS6on9UHDDVnJoAr6WMaJ7
        YCRk/qDhG52F6UQW+qpeUHObadf+Cp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-aPiaQ9JyNAWA4YQ0AdCh0w-1; Fri, 08 Nov 2019 05:32:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4195D800C72;
        Fri,  8 Nov 2019 10:32:56 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F2931A8D8;
        Fri,  8 Nov 2019 10:32:53 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 01/11] iommu/vt-d: Cache virtual command capability
 register
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
 <1571946904-86776-2-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <bd0db993-b29d-4a5a-56d4-c2af699eadfd@redhat.com>
Date:   Fri, 8 Nov 2019 11:32:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: aPiaQ9JyNAWA4YQ0AdCh0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 10/24/19 9:54 PM, Jacob Pan wrote:
> Virtual command registers are used in the guest only, to prevent
> vmexit cost, we cache the capability and store it during initialization.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        | 1 +
>  include/linux/intel-iommu.h | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index eecd6a421667..49bb7d76e646 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -950,6 +950,7 @@ static int map_iommu(struct intel_iommu *iommu, u64 p=
hys_addr)
>  =09=09warn_invalid_dmar(phys_addr, " returns all ones");
>  =09=09goto unmap;
>  =09}
> +=09iommu->vccap =3D dmar_readq(iommu->reg + DMAR_VCCAP_REG);
> =20
>  =09/* the registers might be more than one page */
>  =09map_size =3D max_t(int, ecap_max_iotlb_offset(iommu->ecap),
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ed11ef594378..2e1bed9b7eef 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -186,6 +186,9 @@
>  #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
>  #define ecap_sc_support(e)=09((e >> 7) & 0x1) /* Snooping Control */
> =20
> +/* Virtual command interface capabilities */
> +#define vccap_pasid(v)=09=09((v & DMA_VCS_PAS)) /* PASID allocation */
> +
>  /* IOTLB_REG */
>  #define DMA_TLB_FLUSH_GRANU_OFFSET  60
>  #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
> @@ -520,6 +523,7 @@ struct intel_iommu {
>  =09u64=09=09reg_size; /* size of hw register set */
>  =09u64=09=09cap;
>  =09u64=09=09ecap;
> +=09u64=09=09vccap;
>  =09u32=09=09gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
>  =09raw_spinlock_t=09register_lock; /* protect register handling */
>  =09int=09=09seq_id;=09/* sequence id of the iommu */
>=20

with DMA_VCS_PAS's move in this patch as pointed out by Kevin or
vccap_pasid() move to patch 3, feel free to add

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

