Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263F2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AA122302
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efDuKRZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKRUeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:34:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21989 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbfKRUeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574109242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7Ut5u5BkynozWLWUQUIPMSDJX5+3da6yjRKIKCNCEQ=;
        b=efDuKRZHkyaIsOHnSkxZNiSGPs7NfBotbVWMfxCvtJmQ0rFLdfkZtaRAila5rx3Hj1mMjW
        hBasif2jJZgBZXBOzn7zDdMuy66XZWc3LgyFLwkgLHrcexL9/y2GjL2dKK/3sxO/OZfnUA
        Ba06iKaxLNPWmt8/Ld1u1Tg2P3WH7PA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-glOV4wuXM2GWm_MZ_FV-2g-1; Mon, 18 Nov 2019 15:33:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABECD1085982;
        Mon, 18 Nov 2019 20:33:57 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6D655E25A;
        Mon, 18 Nov 2019 20:33:54 +0000 (UTC)
Subject: Re: [PATCH v2 01/10] iommu/vt-d: Introduce native SVM capable flag
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <cb44724d-a396-0291-63c4-0039788fd26b@redhat.com>
Date:   Mon, 18 Nov 2019 21:33:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574106153-45867-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: glOV4wuXM2GWm_MZ_FV-2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/18/19 8:42 PM, Jacob Pan wrote:
> Shared Virtual Memory(SVM) is based on a collective set of hardware
> features detected at runtime. There are requirements for matching CPU
> and IOMMU capabilities.
>=20
> This patch introduces a flag which will be used to mark and test the
> capability of SVM.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/intel-iommu.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ed11ef594378..63118991824c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -433,6 +433,7 @@ enum {
> =20
>  #define VTD_FLAG_TRANS_PRE_ENABLED=09(1 << 0)
>  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED=09(1 << 1)
> +#define VTD_FLAG_SVM_CAPABLE=09=09(1 << 2)

I think I would rather squash this into the next patch as there is no
user here.

Thanks

Eric
> =20
>  extern int intel_iommu_sm;
> =20
>=20

