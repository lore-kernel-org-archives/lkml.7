Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B2CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B5C222DD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPPhfX7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKRV1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:27:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49461 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbfKRV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574112429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2ueiIRt7fqjanQS0GX2y/MsXFCxWQAcy1vqFBO38zo=;
        b=iPPhfX7/B0l631f4r9r8IM87GpS7cu1pZZ5ZABmbTBwIaDHJYdtgUJMoSiyiZJP22PFLBy
        oRmLJq+V1ZJwW3x6C4UJF/xwwyQWPxZv6Q9bSWcwYL5J2Eg74mm2OzM3HNWkyZD5GpNXr2
        uYZ6upp+FIRvSmiDNCKosHOk0fZ1fBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-zMDzssdpODa4prXTJjAb8w-1; Mon, 18 Nov 2019 16:27:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EDD08E8046;
        Mon, 18 Nov 2019 21:27:04 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF63F6055C;
        Mon, 18 Nov 2019 21:27:01 +0000 (UTC)
Subject: Re: [PATCH v2 09/10] iommu/vt-d: Avoid sending invalid page response
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-10-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d412064b-8268-9085-81a7-4aed59ac88a2@redhat.com>
Date:   Mon, 18 Nov 2019 22:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574106153-45867-10-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zMDzssdpODa4prXTJjAb8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/18/19 8:42 PM, Jacob Pan wrote:
> Page responses should only be sent when last page in group (LPIG) or
> private data is present in the page request. This patch avoids sending
> invalid descriptors.
>=20
> Fixes: 5d308fc1ecf53 ("iommu/vt-d: Add 256-bit invalidation descriptor
> support")
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 26a2f57763ec..098c89246593 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -688,11 +688,10 @@ static irqreturn_t prq_event_thread(int irq, void *=
d)
>  =09=09=09if (req->priv_data_present)
>  =09=09=09=09memcpy(&resp.qw2, req->priv_data,
>  =09=09=09=09       sizeof(req->priv_data));
> +=09=09=09resp.qw2 =3D 0;
> +=09=09=09resp.qw3 =3D 0;
> +=09=09=09qi_submit_sync(&resp, iommu);
OK so now all the qwords are initialized ;-)
>  =09=09}
> -=09=09resp.qw2 =3D 0;
> -=09=09resp.qw3 =3D 0;
> -=09=09qi_submit_sync(&resp, iommu);
> -
>  =09=09head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
>  =09}
> =20
>=20
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

