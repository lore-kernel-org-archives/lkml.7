Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B892071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjKsKehq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKTU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:59:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25245 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725306AbfKTU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574283581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wo+ZIg72qV+TilQzP5gFEMlESnLx+bJGy+3blH5Vk/c=;
        b=XjKsKehqABQJ4N8ZHpfjInvI5bd2yEBb2o6cagLoB6xX+Pq4CpNyak+PvbubsnC8VLDqdt
        YiR9OazINkbDryZWYmrNpxkrRFCH1kS9u9+opNG/45Vgjd8+nhguJwiA0UUiJR+A3q+4es
        ke8iPX/SETg+SGbrQboHO/tLnM++bAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-hW26wTJ7NGaCdR8H60wEuA-1; Wed, 20 Nov 2019 15:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C2EF1883521;
        Wed, 20 Nov 2019 20:59:36 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FEA175E3B;
        Wed, 20 Nov 2019 20:59:32 +0000 (UTC)
Subject: Re: [PATCH v3 1/8] iommu/vt-d: Fix CPU and IOMMU SVM feature matching
 checks
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574186193-30457-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <de4820e4-fd3f-d3fe-d133-4c83e2b1312b@redhat.com>
Date:   Wed, 20 Nov 2019 21:59:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: hW26wTJ7NGaCdR8H60wEuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/19/19 6:56 PM, Jacob Pan wrote:
> Shared Virtual Memory(SVM) is based on a collective set of hardware
> features detected at runtime. There are requirements for matching CPU
> and IOMMU capabilities.
>=20
> The current code checks CPU and IOMMU feature set for SVM support but
> the result is never stored nor used. Therefore, SVM can still be used
> even when these checks failed. The consequences can be:
> 1. CPU uses 5-level paging mode for virtual address of 57 bits, but
> IOMMU can only support 4-level paging mode with 48 bits address for DMA.
> 2. 1GB page size is used by CPU but IOMMU does not support it. VT-d
> unrecoverable faults may be generated.
>=20
> The best solution to fix these problems is to prevent them in the first
> place.
>=20
> This patch consolidates code for checking PASID, CPU vs. IOMMU paging
> mode compatibility, as well as provides specific error messages for
> each failed checks. On sane hardware configurations, these error message
> shall never appear in kernel log.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/intel-iommu.c | 10 ++--------
>  drivers/iommu/intel-svm.c   | 40 +++++++++++++++++++++++++++------------=
-
>  include/linux/intel-iommu.h |  5 ++++-
>  3 files changed, 33 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3f974919d3bd..d598168e410d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3289,10 +3289,7 @@ static int __init init_dmars(void)
> =20
>  =09=09if (!ecap_pass_through(iommu->ecap))
>  =09=09=09hw_pass_through =3D 0;
> -#ifdef CONFIG_INTEL_IOMMU_SVM
> -=09=09if (pasid_supported(iommu))
> -=09=09=09intel_svm_init(iommu);
> -#endif
> +=09=09intel_svm_check(iommu);
>  =09}
> =20
>  =09/*
> @@ -4471,10 +4468,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *=
dmaru)
>  =09if (ret)
>  =09=09goto out;
> =20
> -#ifdef CONFIG_INTEL_IOMMU_SVM
> -=09if (pasid_supported(iommu))
> -=09=09intel_svm_init(iommu);
> -#endif
> +=09intel_svm_check(iommu);
> =20
>  =09if (dmaru->ignored) {
>  =09=09/*
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 9b159132405d..716c543488f6 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -23,19 +23,6 @@
> =20
>  static irqreturn_t prq_event_thread(int irq, void *d);
> =20
> -int intel_svm_init(struct intel_iommu *iommu)
> -{
> -=09if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
> -=09=09=09!cap_fl1gp_support(iommu->cap))
> -=09=09return -EINVAL;
> -
> -=09if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> -=09=09=09!cap_5lp_support(iommu->cap))
> -=09=09return -EINVAL;
> -
> -=09return 0;
> -}
> -
>  #define PRQ_ORDER 0
> =20
>  int intel_svm_enable_prq(struct intel_iommu *iommu)
> @@ -99,6 +86,33 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
>  =09return 0;
>  }
> =20
> +static inline bool intel_svm_capable(struct intel_iommu *iommu)
> +{
> +=09return iommu->flags & VTD_FLAG_SVM_CAPABLE;
> +}
> +
> +void intel_svm_check(struct intel_iommu *iommu)
> +{
> +=09if (!pasid_supported(iommu))
> +=09=09return;
> +
> +=09if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
> +=09    !cap_fl1gp_support(iommu->cap)) {
> +=09=09pr_err("%s SVM disabled, incompatible 1GB page capability\n",
> +=09=09       iommu->name);
> +=09=09return;
> +=09}
> +
> +=09if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> +=09    !cap_5lp_support(iommu->cap)) {
> +=09=09pr_err("%s SVM disabled, incompatible paging mode\n",
> +=09=09       iommu->name);
> +=09=09return;
> +=09}
> +
> +=09iommu->flags |=3D VTD_FLAG_SVM_CAPABLE;
> +}
> +
>  static void intel_flush_svm_range_dev (struct intel_svm *svm, struct int=
el_svm_dev *sdev,
>  =09=09=09=09unsigned long address, unsigned long pages, int ih)
>  {
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ed11ef594378..7dcfa1c4a844 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -433,6 +433,7 @@ enum {
> =20
>  #define VTD_FLAG_TRANS_PRE_ENABLED=09(1 << 0)
>  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED=09(1 << 1)
> +#define VTD_FLAG_SVM_CAPABLE=09=09(1 << 2)
> =20
>  extern int intel_iommu_sm;
> =20
> @@ -656,7 +657,7 @@ void iommu_flush_write_buffer(struct intel_iommu *iom=
mu);
>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *d=
ev);
> =20
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> -int intel_svm_init(struct intel_iommu *iommu);
> +extern void intel_svm_check(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> =20
> @@ -684,6 +685,8 @@ struct intel_svm {
>  };
> =20
>  extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)=
;
> +#else
> +static inline void intel_svm_check(struct intel_iommu *iommu) {}
>  #endif
> =20
>  #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
>=20

