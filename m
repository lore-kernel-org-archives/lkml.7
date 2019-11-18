Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E518C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132722230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKNy6Etl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKRUzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:55:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39385 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726475AbfKRUzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574110539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0VTPYLDkVIgquZihOZDiuVZWPSC4PnJRIoop9yQxqM=;
        b=HKNy6Etl9LhFMCFCLo2Zzj34OiRaai5JhowjNppDTepW2r/PdGTkxw67DM+GP/8i7W+jxP
        +Tsih2zo+jqT0E84FBtnhgsNxf9biwQF2Vjomp9/0v1HBebVOdo7btRDSH7Txx4spJoo8b
        NLt+wsZJUp70DSeLxnpZsnBb5d85sDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-p4DIraRiNg6RfOQTH1u2MQ-1; Mon, 18 Nov 2019 15:55:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4FBA801E5B;
        Mon, 18 Nov 2019 20:55:34 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BD4260E3E;
        Mon, 18 Nov 2019 20:55:32 +0000 (UTC)
Subject: Re: [PATCH v2 03/10] iommu/vt-d: Reject SVM bind for failed
 capability check
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5ecbea4b-4418-32e4-9b3d-49447e4bf420@redhat.com>
Date:   Mon, 18 Nov 2019 21:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574106153-45867-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: p4DIraRiNg6RfOQTH1u2MQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/18/19 8:42 PM, Jacob Pan wrote:
> Add a check during SVM bind to ensure CPU and IOMMU hardware capabilities
> are met.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Thanks

Eric

