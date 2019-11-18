Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD0422302
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djzjn2YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKRUdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:33:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726536AbfKRUds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574109226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7A620e2V87Dcox9x/agD1hQIWlCTI5J8kBb4YHw7B0=;
        b=djzjn2YColvSLgQRiyorxWjeKFX55wOh1KopJGolpOQa63C2617Z0XMSNZgztOt38fqyX5
        2YkS8rdLnsGLi5h/xOdniK84Al+/G9qIpf+rNVAl/v7K5UFiCEI+NJKUkl+0uIrzZ1MLD5
        wCu2M/OFeCauvkt66uTmcgipwXQU88k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-9tR7LdLwNEODmJavXkYHDA-1; Mon, 18 Nov 2019 15:33:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 078D21802CE3;
        Mon, 18 Nov 2019 20:33:41 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0025519C4F;
        Mon, 18 Nov 2019 20:33:36 +0000 (UTC)
Subject: Re: [PATCH v2 02/10] iommu/vt-d: Fix CPU and IOMMU SVM feature
 matching checks
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <26d1e79b-3a16-0a8f-895e-e2c41c8d3b28@redhat.com>
Date:   Mon, 18 Nov 2019 21:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574106153-45867-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9tR7LdLwNEODmJavXkYHDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/18/19 8:42 PM, Jacob Pan wrote:
> The current code checks CPU and IOMMU feature set for SVM support but
> the result is never stored nor used. Therefore, SVM can still be used
> even when these checks failed.
"SVM can still be used even when these checks failed". What were the
consequences if it happened? Does it fix this cleanly now.
>=20
> This patch consolidates code for checking PASID, CPU vs. IOMMU paging
> mode compatibility, as well as provides specific error messages for
> each failed checks.>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 10 ++--------
>  drivers/iommu/intel-svm.c   | 40 +++++++++++++++++++++++++++------------=
-
>  include/linux/intel-iommu.h |  4 +++-
>  3 files changed, 32 insertions(+), 22 deletions(-)
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
nit: is it really an error or just a warning?
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
> index 63118991824c..7dcfa1c4a844 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -657,7 +657,7 @@ void iommu_flush_write_buffer(struct intel_iommu *iom=
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
> @@ -685,6 +685,8 @@ struct intel_svm {
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
Besides,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

