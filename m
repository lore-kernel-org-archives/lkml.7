Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F146CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84092071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emTOLPZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKTVIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:08:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53765 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbfKTVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574284129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJ75uiFKE/vrS49xMrG/E26ErD3qo0pj2vUxc1owOuY=;
        b=emTOLPZLN5pkA6VyWslcRK/EGULGMYn2MJ1XXEHrZX9+mQKH+28JIwOGCl7KkWvKT95Puh
        3ksKix7Wsp6kCX6skep/9hYY20ZznAE9VnKRwwImZsO6BDMmxh5W5VbRaJ6Gz5UeZfy1GL
        Wjefa544xVANgSeR5VEN8Dl+ibCD17Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-FfsjWtENNTS3u6KdzdVaig-1; Wed, 20 Nov 2019 16:08:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A630BDB22;
        Wed, 20 Nov 2019 21:08:44 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBA00348A2;
        Wed, 20 Nov 2019 21:08:41 +0000 (UTC)
Subject: Re: [PATCH v3 2/8] iommu/vt-d: Match CPU and IOMMU paging mode
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
 <1574186193-30457-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c77782e3-fafa-6397-94e0-e0be8572acd3@redhat.com>
Date:   Wed, 20 Nov 2019 22:08:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FfsjWtENNTS3u6KdzdVaig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,
On 11/19/19 6:56 PM, Jacob Pan wrote:
> When setting up first level page tables for sharing with CPU, we need
> to ensure IOMMU can support no less than the levels supported by the
> CPU.
>=20
> It is not adequate, as in the current code, to set up 5-level paging
> in PASID entry First Level Paging Mode(FLPM) solely based on CPU.
>=20
> Currently, intel_pasid_setup_first_level() is only used by native SVM
> code which already checks paging mode matches. However, future use of
> this helper function may not be limited to native SVM.
> https://lkml.org/lkml/2019/11/18/1037
>=20
> Fixes: 437f35e1cd4c8 ("iommu/vt-d: Add first level page table
> interface")
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
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
> +=09=09}
> +=09}
>  #endif /* CONFIG_X86 */
> =20
>  =09pasid_set_domain_id(pte, did);
>=20

