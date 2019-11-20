Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D2AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4A82088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ/11xgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKTVBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:01:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47840 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbfKTVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574283692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHfOkzYmphsv7O0VujwlKSrRods/3Ya90uExlJYvTgY=;
        b=eJ/11xgfSVxTPf8HDaLTz63wO7oIQ5qlyPAKoNlpLFWjaN+yJFDm9eAQNe3IkA6mk7RC85
        2qcJVI+tcL6BEaoBtGtaGYsq+EidzhQWEz1RCSQGlBmiaIQQFPxhrohWqQ+8yciKuH3AG7
        UFiJqajcYthszalhl0lEMnWusJlI18w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-uoBUK3bnPKqGeAeim8uDnA-1; Wed, 20 Nov 2019 16:01:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 997D38024C2;
        Wed, 20 Nov 2019 21:01:26 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBB756B8FB;
        Wed, 20 Nov 2019 21:01:23 +0000 (UTC)
Subject: Re: [PATCH v3 4/8] iommu/vt-d: Avoid duplicated code for PASID setup
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
 <1574186193-30457-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <e39924ae-4b47-a449-f029-a83bd0e31459@redhat.com>
Date:   Wed, 20 Nov 2019 22:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: uoBUK3bnPKqGeAeim8uDnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/19/19 6:56 PM, Jacob Pan wrote:
> After each setup for PASID entry, related translation caches must be
> flushed. We can combine duplicated code into one function which is less
> error prone.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
I sent my R-b already on v2:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
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

