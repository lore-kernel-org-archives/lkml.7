Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08936C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D339720B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="qqDM406y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406228AbfITSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:05:43 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:64243 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404970AbfITSFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1569002741; x=1600538741;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding;
  bh=Qq57UcILh1SOhghoKSNgSrtELHXK6g2x+TAUQTtaa60=;
  b=qqDM406ye9YVw0/2rYZVowJfSuAevB1rhtpKaC3991Qqxtf/kUH0fp40
   zpjJn/P0s22YyNKoXUNQ9I5nhQubqXlq6MaU6QrZsEgF5z6xq/R7PYuR0
   eogucPZ5HAiJI4F8fHUMZr6efUZaogYCFR9ueZMLG2JJxyrLu+CooYeO3
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,529,1559520000"; 
   d="scan'208";a="786106812"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 20 Sep 2019 18:05:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id CA506A268C;
        Fri, 20 Sep 2019 18:05:39 +0000 (UTC)
Received: from EX13D02EUC003.ant.amazon.com (10.43.164.10) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Sep 2019 18:05:39 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC003.ant.amazon.com (10.43.164.10) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Sep 2019 18:05:38 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1367.000;
 Fri, 20 Sep 2019 18:05:38 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     "Sironi, Filippo" <sironi@amazon.de>,
        Joerg Roedel <joro@8bytes.org>,
        Filippo Sironi via iommu <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] iommu/amd: Hold the domain lock when calling
 iommu_map_page
Thread-Topic: [PATCH 4/5] iommu/amd: Hold the domain lock when calling
 iommu_map_page
Thread-Index: AQHVaAAkrSYS8OYDhkK75ZlIzD8IKKc07AAA
Date:   Fri, 20 Sep 2019 18:05:37 +0000
Message-ID: <AC63DCD0-5322-4ECB-AB42-829AD4FBDFB9@amazon.de>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
 <1568137765-20278-5-git-send-email-sironi@amazon.de>
In-Reply-To: <1568137765-20278-5-git-send-email-sironi@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.48]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AFDF0C4A8542241AC6C8B225DF8D1A1@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 10. Sep 2019, at 19:49, Filippo Sironi <sironi@amazon.de> wrote:
> =

> iommu_map_page calls into __domain_flush_pages, which requires the
> domain lock since it traverses the device list, which the lock protects.
> =

> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> ---
> drivers/iommu/amd_iommu.c | 5 +++++
> 1 file changed, 5 insertions(+)
> =

> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index d4f25767622e..3714ae5ded31 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2562,6 +2562,7 @@ static int map_sg(struct device *dev, struct scatte=
rlist *sglist,
> 	unsigned long address;
> 	u64 dma_mask;
> 	int ret;
> +	unsigned long flags;
> =

> 	domain =3D get_domain(dev);
> 	if (IS_ERR(domain))
> @@ -2587,7 +2588,9 @@ static int map_sg(struct device *dev, struct scatte=
rlist *sglist,
> =

> 			bus_addr  =3D address + s->dma_address + (j << PAGE_SHIFT);
> 			phys_addr =3D (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
> +			spin_lock_irqsave(&domain->lock, flags);
> 			ret =3D iommu_map_page(domain, bus_addr, phys_addr, PAGE_SIZE, prot, G=
FP_ATOMIC);
> +			spin_unlock_irqrestore(&domain->lock, flags);
> 			if (ret)
> 				goto out_unmap;
> =

> @@ -3095,7 +3098,9 @@ static int amd_iommu_map(struct iommu_domain *dom, =
unsigned long iova,
> 		prot |=3D IOMMU_PROT_IW;
> =

> 	mutex_lock(&domain->api_lock);
> +	spin_lock(&domain->lock);
> 	ret =3D iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
> +	spin_unlock(&domain->lock);
> 	mutex_unlock(&domain->api_lock);

The spin_lock/spin_unlock aren't the correct choice.
These should be spin_lock_irqsave and spin_unlock_irqrestore.
Of course, with the variant Joerg suggested, this isn't a
problem anymore.

> 	domain_flush_np_cache(domain, iova, page_size);
> -- =

> 2.7.4
> =





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



