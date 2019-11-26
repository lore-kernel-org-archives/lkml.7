Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D87C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86B620659
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6fAN8jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfKZRTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:19:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728114AbfKZRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574788748;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZMwHV3KrQEfrY5tMKLf1OtDElvXlEV64ghBrb4GlKA=;
        b=C6fAN8jtU+Id4em/X5JRjeqSrpd7/3cVOI/m1uC7yaaLcamJjZKk47I7HUult5eaMZi2jr
        ef7LYXBp2e2spq2k/5xxvVdk8xCuI/ylU/74F9UjPHjvvM0buTUpg8sPYZc1byc2dDmPW/
        zDegyFM9sWq0/nMHFlCWYBm4QuzWXE4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-csp62IwZO962c6CjeTcu-w-1; Tue, 26 Nov 2019 12:19:07 -0500
Received: by mail-pj1-f70.google.com with SMTP id u17so9538111pjy.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 09:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5wVzpglEIAjYehdG9sWNgS3uaz+PIjpeWL9/GEH0Tp4=;
        b=XWed2B24GyM+HZ3xGStGxN4gk6PDSsGUIe3CG3qHK+0sgAcGRlyKOtIKeQYzaOcWFW
         RmvhT37YnKdIoIUAMj4VblxY5qWibYoHv1votCpoH7fwpIbqP+zzdmdFao5aDNpkX+uT
         de6AwxVgACZE12NwrnjB5CT8D5i5DSZE5dyH4XWDLN0Y8p37Peq69Fkh6vQ2JO3WwZn3
         NeTn7bp9EGpf4nn44ekBTxj4C669bnMOTw2mQaLh9ffAxvO6vWeUI81UgR7ZwstEEPu6
         unwA/3kctqhLaF2axVHzTHbYX9ZSrg8JwuUFN8JlNfITA654a4Z5p43nQ6ei+HpYiFMx
         +p0g==
X-Gm-Message-State: APjAAAWk92/GMfR+UPDjfe0m7BGAtEWY41ctCEKC4CRDmTyq/0wS3IEQ
        bzxQU7A2iBBcJKs/t45RUilfTSHmNc4jcL43v9zP2ochF0L2p4BYAQlLdizl22D1nXTtsaHhNn8
        w71rvnQDYrnbk4WXH/0RGbxJ9
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr42634010pfr.23.1574788746765;
        Tue, 26 Nov 2019 09:19:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCm+jc/Xy/HZ1W4zmlXRfEuhPmaS7/3b4qGmZ2g5RVMrlhJaArpPToSqjkaru3MdpMy2wxVw==
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr42633987pfr.23.1574788746524;
        Tue, 26 Nov 2019 09:19:06 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g30sm12879606pgm.23.2019.11.26.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:19:05 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:19:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org, hch@lst.de, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu: fix KASAN use-after-free in
 iommu_insert_resv_region
Message-ID: <20191126171904.tnd27x3mjhdo4dy7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Eric Auger <eric.auger@redhat.com>,
        eric.auger.pro@gmail.com, joro@8bytes.org, hch@lst.de, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20191126102743.3269-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191126102743.3269-1-eric.auger@redhat.com>
X-MC-Unique: csp62IwZO962c6CjeTcu-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 26 19, Eric Auger wrote:
>In case the new region gets merged into another one, the nr
>list node is freed. Checking its type while completing the
>merge algorithm leads to a use-after-free. Use new->type
>instead.
>
>Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
>implementation")
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>Reported-by: Qian Cai <cai@lca.pw>
>Cc: Stable <stable@vger.kernel.org> #v5.3+
>

Minor nit, but should the comment above list_for_each_entry_safe get
updated as well? Other than that, lgtm.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
>
>v2 -> v3:
>- directly use new->type
>
>v1 -> v2:
>- remove spurious new line
>---
> drivers/iommu/iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index d658c7c6a2ab..285ad4a4c7f2 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -313,7 +313,7 @@ int iommu_insert_resv_region(struct iommu_resv_region =
*new,
> =09=09phys_addr_t top_end, iter_end =3D iter->start + iter->length - 1;
>
> =09=09/* no merge needed on elements of different types than @nr */
>-=09=09if (iter->type !=3D nr->type) {
>+=09=09if (iter->type !=3D new->type) {
> =09=09=09list_move_tail(&iter->list, &stack);
> =09=09=09continue;
> =09=09}
>--=20
>2.20.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

