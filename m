Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEACBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13FD2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAC6GoZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKTVAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:00:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56902 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725306AbfKTVAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574283600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NlNHoxzh1l8As3CKKs/t6/IS1n9wVtMRm+SZhfTiBk8=;
        b=VAC6GoZSCehUXhWOD/O7F6DslGno52TThF3Z/MbENNce2A/TyZI5VWzi4nSMBwtzNAnzvy
        8mZ3NkA/v0V7G6u6/52DKhkCM6BhkiaB+bTz6Xct579i6Kjbwbazw5i6c8xdcwyyCehkS+
        zLK/rbN/ctDFBCE4Q/d5YvW2cVoSvqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-3BpFWhJ1N0aFjaB3FwLznw-1; Wed, 20 Nov 2019 15:59:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B185800054;
        Wed, 20 Nov 2019 20:59:54 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A741F51B60;
        Wed, 20 Nov 2019 20:59:51 +0000 (UTC)
Subject: Re: [PATCH v3 3/8] iommu/vt-d: Reject SVM bind for failed capability
 check
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
 <1574186193-30457-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <f2a5ca6e-61f3-6814-8d58-81cb258b0882@redhat.com>
Date:   Wed, 20 Nov 2019 21:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3BpFWhJ1N0aFjaB3FwLznw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/19/19 6:56 PM, Jacob Pan wrote:
> Add a check during SVM bind to ensure CPU and IOMMU hardware capabilities
> are met.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
I sent my Rb on v2:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/intel-svm.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 716c543488f6..74df10a39dfc 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -238,6 +238,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid,=
 int flags, struct svm_dev_
>  =09if (!iommu || dmar_disabled)
>  =09=09return -EINVAL;
> =20
> +=09if (!intel_svm_capable(iommu))
> +=09=09return -ENOTSUPP;
> +
>  =09if (dev_is_pci(dev)) {
>  =09=09pasid_max =3D pci_max_pasids(to_pci_dev(dev));
>  =09=09if (pasid_max < 0)
>=20

