Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C775F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKnWSFjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKLJzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:55:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35783 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbfKLJzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573552502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AdBHFyhioxfCvrwsJAry/REnsYtBUierHYY+S1ZJ0LQ=;
        b=hKnWSFjvFfwUKEK3kqcI+JI4VUA9duvYB4BV1ZHDPXA3bdqZ9S8RaWVseLw72QJRSESHpA
        8hedksMnD8C7OpkpCeYyb8c9baRP/KFje1iut0MuNFAjdH5S2uqrt2tKQMV7cjUdtNOODD
        AQgaBjKNaEShebVf+F6Ot+KAFezfTuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-lS6wqL5ROSi5zE9pjn3Wyg-1; Tue, 12 Nov 2019 04:55:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A36B91800D63;
        Tue, 12 Nov 2019 09:54:59 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B35E061F58;
        Tue, 12 Nov 2019 09:54:53 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 06/11] iommu/vt-d: Avoid duplicated code for PASID
 setup
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
 <1571946904-86776-7-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <552c55f3-a8d6-10aa-5dbc-5b2c45ad90d0@redhat.com>
Date:   Tue, 12 Nov 2019 10:54:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: lS6wqL5ROSi5zE9pjn3Wyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 10/24/19 9:54 PM, Jacob Pan wrote:
> After each setup for PASID entry, related translation caches must be flus=
hed.
> We can combine duplicated code into one function which is less error pron=
e.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 48 +++++++++++++++++----------------------=
------
>  1 file changed, 18 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index e79d680fe300..ffbd416ed3b8 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -485,6 +485,21 @@ void intel_pasid_tear_down_entry(struct intel_iommu =
*iommu,
>  =09=09devtlb_invalidation_with_pasid(iommu, dev, pasid);
>  }
> =20
> +static void pasid_flush_caches(struct intel_iommu *iommu,
> +=09=09=09=09struct pasid_entry *pte,
> +=09=09=09=09int pasid, u16 did)
> +{
> +=09if (!ecap_coherent(iommu->ecap))
> +=09=09clflush_cache_range(pte, sizeof(*pte));
> +
> +=09if (cap_caching_mode(iommu->cap)) {
> +=09=09pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> +=09=09iotlb_invalidation_with_pasid(iommu, did, pasid);
> +=09} else {
> +=09=09iommu_flush_write_buffer(iommu);
> +=09}
> +}
> +
>  /*
>   * Set up the scalable mode pasid table entry for first only
>   * translation type.
> @@ -530,16 +545,7 @@ int intel_pasid_setup_first_level(struct intel_iommu=
 *iommu,
>  =09/* Setup Present and PASID Granular Transfer Type: */
>  =09pasid_set_translation_type(pte, 1);
>  =09pasid_set_present(pte);
> -
> -=09if (!ecap_coherent(iommu->ecap))
> -=09=09clflush_cache_range(pte, sizeof(*pte));
> -
> -=09if (cap_caching_mode(iommu->cap)) {
> -=09=09pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> -=09=09iotlb_invalidation_with_pasid(iommu, did, pasid);
> -=09} else {
> -=09=09iommu_flush_write_buffer(iommu);
> -=09}
> +=09pasid_flush_caches(iommu, pte, pasid, did);
> =20
>  =09return 0;
>  }
> @@ -603,16 +609,7 @@ int intel_pasid_setup_second_level(struct intel_iomm=
u *iommu,
>  =09 */
>  =09pasid_set_sre(pte);
>  =09pasid_set_present(pte);
> -
> -=09if (!ecap_coherent(iommu->ecap))
> -=09=09clflush_cache_range(pte, sizeof(*pte));
> -
> -=09if (cap_caching_mode(iommu->cap)) {
> -=09=09pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> -=09=09iotlb_invalidation_with_pasid(iommu, did, pasid);
> -=09} else {
> -=09=09iommu_flush_write_buffer(iommu);
> -=09}
> +=09pasid_flush_caches(iommu, pte, pasid, did);
> =20
>  =09return 0;
>  }
> @@ -646,16 +643,7 @@ int intel_pasid_setup_pass_through(struct intel_iomm=
u *iommu,
>  =09 */
>  =09pasid_set_sre(pte);
>  =09pasid_set_present(pte);
> -
> -=09if (!ecap_coherent(iommu->ecap))
> -=09=09clflush_cache_range(pte, sizeof(*pte));
> -
> -=09if (cap_caching_mode(iommu->cap)) {
> -=09=09pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> -=09=09iotlb_invalidation_with_pasid(iommu, did, pasid);
> -=09} else {
> -=09=09iommu_flush_write_buffer(iommu);
> -=09}
> +=09pasid_flush_caches(iommu, pte, pasid, did);
> =20
>  =09return 0;
>  }
>=20
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

