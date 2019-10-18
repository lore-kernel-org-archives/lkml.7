Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3615CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F3121897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4/Ih84F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409669AbfJRJUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:20:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390499AbfJRJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571390409;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqNjg+EaGLj4NJ+f3f6IUdn2NqQIeIPYBk4IKGTbgOg=;
        b=R4/Ih84FKt7lli57JnZjHf+PvNHaIqny3n7y9OnfhSsLdLQI9/UBVbJ5/flDX/9prz0ahM
        ipTw0EXV1MsgT+GwaHKuaoEdl8RRLmqIjMYL9dECLuHyATxcirv3xO/E6jUKkK92iyklmk
        XdC+OH2ia7IoaUjxpX5qNXIsQiAQJww=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-RuTZFAEQP36o0U1mzFLIvQ-1; Fri, 18 Oct 2019 05:20:05 -0400
Received: by mail-io1-f72.google.com with SMTP id r5so7814316iop.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=RHTr/G3jxXej8cUMFfKi+HcWzJkXtd79itVbm58x3Nc=;
        b=O+z8DNpBh99caZkjVEnMfY3chq6nRrbUr3Dx1f0hR76WtQkDd4FmbPIhvlheuxiNO3
         b6M2wWiEXOSDnfaH3k628PHYyQycm+ks19GXuktviPc2bsg3bL+PHXZ2XD+Xdk8qFrkZ
         xY1ewceZBFhKVDILwTJ3af+MpHQTSVFLrDmjDpTEOWM/EzJAohShGGC0R1LCtihMZ70A
         WkukmQDxql5ZH8Y/Nb04zm6FHiqCIdtAnTvXEwowUfspbGRwq9Y4k7qAroraMtAOrNV9
         X06vakw4BkvO2bi8OIV9p9LeHfRj5CaOTs4zaYyu5hBdn96pggTfDsYe+gINTvQFBMvx
         wGMA==
X-Gm-Message-State: APjAAAUjhTRQaNowYSIWP1qJyoYaZ/MCVDOcQ/BtrEt1DiAF/2LxLILn
        JuycfS2EeHXyGopC1LHzVgY6GXF33fAeacsAydfd4WN5MWRrzJ9n3xNIZN9I0FexqYz+REPbFSQ
        Ri+idyxAklodM63uOQtoD0ser
X-Received: by 2002:a05:6638:3a6:: with SMTP id z6mr8060189jap.33.1571390404917;
        Fri, 18 Oct 2019 02:20:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyeKV0GqHl8jqRB2FJYh+++6hNUR6kyjWJgdRjbQacCDJrFh4dUI6qLBvlkxQiaCvoFXgmjew==
X-Received: by 2002:a05:6638:3a6:: with SMTP id z6mr8060170jap.33.1571390404644;
        Fri, 18 Oct 2019 02:20:04 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n26sm2180447ili.8.2019.10.18.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:20:03 -0700 (PDT)
Date:   Fri, 18 Oct 2019 02:20:02 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iommu/amd: Pass gfp flags to iommu_map_page() in
 amd_iommu_map()
Message-ID: <20191018092002.wmgjhfit56ezkyu6@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20191018090736.18819-1-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20191018090736.18819-1-joro@8bytes.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: RuTZFAEQP36o0U1mzFLIvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 18 19, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>A recent commit added a gfp parameter to amd_iommu_map() to make it
>callable from atomic context, but forgot to pass it down to
>iommu_map_page() and left GFP_KERNEL there. This caused
>sleep-while-atomic warnings and needs to be fixed.
>
>Reported-by: Qian Cai <cai@lca.pw>
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Fixes: 781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>---
> drivers/iommu/amd_iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 0d2479546b77..fb54df5c2e11 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -2561,7 +2561,7 @@ static int amd_iommu_map(struct iommu_domain *dom, u=
nsigned long iova,
> =09if (iommu_prot & IOMMU_WRITE)
> =09=09prot |=3D IOMMU_PROT_IW;
>
>-=09ret =3D iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNE=
L);
>+=09ret =3D iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
>
> =09domain_flush_np_cache(domain, iova, page_size);
>
>--=20
>2.16.4
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

