Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39707C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F8E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5o8ET4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKTVCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:02:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725819AbfKTVCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574283732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOrvXvluHE3iSsyI4T3cknsOlbzrHrOQA3zBzSTxvuA=;
        b=I5o8ET4sDzMZo0HpaPkEItFtbbQK8jRfKunaEvEXEm0IQANbRrbzwpdniEgG84+Zg0aYoW
        JA/0cBa3daF5gy93zEUB1Oj1M4Y8sHNpxBTxfhz+PwywfRxdgHkCmzRHemjHMo8TPkHHZS
        2yqrYDLGTzk9MSYLoekrT9fIVYCepLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-ab41IDNWMgG7HyiGvFLoKw-1; Wed, 20 Nov 2019 16:02:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BC7118C35A8;
        Wed, 20 Nov 2019 21:02:07 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E25166D4E;
        Wed, 20 Nov 2019 21:02:04 +0000 (UTC)
Subject: Re: [PATCH v3 5/8] iommu/vt-d: Fix off-by-one in PASID allocation
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
 <1574186193-30457-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ac6270f0-3283-2473-267a-cea9b68a0296@redhat.com>
Date:   Wed, 20 Nov 2019 22:02:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ab41IDNWMgG7HyiGvFLoKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 11/19/19 6:56 PM, Jacob Pan wrote:
> PASID allocator uses IDR which is exclusive for the end of the
> allocation range. There is no need to decrement pasid_max.
>=20
> Fixes: af39507305fb ("iommu/vt-d: Apply global PASID in SVA")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
same (v2)
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/intel-svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 74df10a39dfc..e90d0b914afe 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -338,7 +338,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid,=
 int flags, struct svm_dev_
>  =09=09/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
>  =09=09ret =3D intel_pasid_alloc_id(svm,
>  =09=09=09=09=09   !!cap_caching_mode(iommu->cap),
> -=09=09=09=09=09   pasid_max - 1, GFP_KERNEL);
> +=09=09=09=09=09   pasid_max, GFP_KERNEL);
>  =09=09if (ret < 0) {
>  =09=09=09kfree(svm);
>  =09=09=09kfree(sdev);
>=20

