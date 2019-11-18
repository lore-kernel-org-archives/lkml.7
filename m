Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4322230D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVe7J2Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKRU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:59:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43599 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbfKRU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574110782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yx/yfRr9Z6ubMT2IdrghO1kMUZfetcG6t9Bfhknx2Vk=;
        b=JVe7J2UkLwkQ/Nh+Sn9iN1cCQc1nMY29iTBrsz44ZhpJGiYwYVv7JWtm4rVdXJrTf9Xotk
        DbR0Gw7kDZzl82wRG2jKe700sSHw8u5BAMcgSF1JMv8FloR3hlO8tRtcr0Dq1WL2ZYZBoI
        Pa1repnewo5iAyiKbkKhB4cnSUqMcVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-_j673H4MPgmEoMKWKdmOzg-1; Mon, 18 Nov 2019 15:59:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2CF518B87E5;
        Mon, 18 Nov 2019 20:59:37 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AD7A66D28;
        Mon, 18 Nov 2019 20:59:34 +0000 (UTC)
Subject: Re: [PATCH v2 05/10] iommu/vt-d: Avoid duplicated code for PASID
 setup
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <506fb71f-87f7-9b4a-8019-97afba135f7f@redhat.com>
Date:   Mon, 18 Nov 2019 21:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574106153-45867-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _j673H4MPgmEoMKWKdmOzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/18/19 8:42 PM, Jacob Pan wrote:
> After each setup for PASID entry, related translation caches must be
> flushed. We can combine duplicated code into one function which is less
> error prone.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 48 +++++++++++++++++----------------------=
------
>  1 file changed, 18 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index e7cb0b8a7332..732bfee228df 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -465,6 +465,21 @@ void intel_pasid_tear_down_entry(struct intel_iommu =
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
> @@ -518,16 +533,7 @@ int intel_pasid_setup_first_level(struct intel_iommu=
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
> @@ -591,16 +597,7 @@ int intel_pasid_setup_second_level(struct intel_iomm=
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
> @@ -634,16 +631,7 @@ int intel_pasid_setup_pass_through(struct intel_iomm=
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

