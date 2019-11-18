Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704712230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLarcYDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKRUzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:55:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26658 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726475AbfKRUzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574110513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UQoYSs+chOIknCdsFKJnw/uGlMJeS7VGsHkHwdERAg=;
        b=gLarcYDQGMWGCj1KWp3oC9b8g9a7WIGWGn9d9p1ndzh//rn5FC/nbAK5S4bTcmVd0DUxR2
        Iy4rUOUNjohs0sRMRDaSDkMR/YDXfNOcS4MGEwbaBCJYw0goNUg9tQVtKakOk+eaxGvkx8
        a2g37ERA5+U/ImW1kcWexODKWUEu83U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-eKOyIbOCMlWV8mABDQ5qAw-1; Mon, 18 Nov 2019 15:55:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D02A107ACC6;
        Mon, 18 Nov 2019 20:55:08 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAA0C1B079;
        Mon, 18 Nov 2019 20:55:05 +0000 (UTC)
Subject: Re: [PATCH v2 04/10] iommu/vt-d: Match CPU and IOMMU paging mode
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <601ca9c3-9f83-3d95-8d26-d4f46eee82ba@redhat.com>
Date:   Mon, 18 Nov 2019 21:55:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574106153-45867-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: eKOyIbOCMlWV8mABDQ5qAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/18/19 8:42 PM, Jacob Pan wrote:
> When setting up first level page tables for sharing with CPU, we need
> to ensure IOMMU can support no less than the levels supported by the
> CPU.
> It is not adequate, as in the current code, to set up 5-level paging
> in PASID entry First Level Paging Mode(FLPM) solely based on CPU.
>=20
> Fixes: 437f35e1cd4c8 ("iommu/vt-d: Add first level page table
> interface")
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 040a445be300..e7cb0b8a7332 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -499,8 +499,16 @@ int intel_pasid_setup_first_level(struct intel_iommu=
 *iommu,
>  =09}
> =20
>  #ifdef CONFIG_X86
> -=09if (cpu_feature_enabled(X86_FEATURE_LA57))
> -=09=09pasid_set_flpm(pte, 1);
> +=09/* Both CPU and IOMMU paging mode need to match */
> +=09if (cpu_feature_enabled(X86_FEATURE_LA57)) {
> +=09=09if (cap_5lp_support(iommu->cap)) {
> +=09=09=09pasid_set_flpm(pte, 1);
> +=09=09} else {
> +=09=09=09pr_err("VT-d has no 5-level paging support for CPU\n");
> +=09=09=09pasid_clear_entry(pte);
> +=09=09=09return -EINVAL;
Can it happen? If I am not wrong intel_pasid_setup_first_level() only
seems to be called from intel_svm_bind_mm which now checks the
SVM_CAPABLE flag.

Thanks

Eric
> +=09=09}
> +=09}
>  #endif /* CONFIG_X86 */
> =20
>  =09pasid_set_domain_id(pte, did);
>=20

