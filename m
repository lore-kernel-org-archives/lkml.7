Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE9218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aIZt6cCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfCWD0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:26:41 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49864 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfCWD0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:26:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 125F9B12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u_6PUlHBz7BQ for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:26:39 -0500 (CDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id C457FDEE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:26:39 -0500 (CDT)
Received: by mail-pg1-f197.google.com with SMTP id f12so3881228pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MV7uZ1/wJNhPo0dYvhWbEZ17J574Zn/SDlCTLXUM8PQ=;
        b=aIZt6cCNZOVM+yQ93vKc6fT2O+2ilQbnNaVFQ7UC1oxdOPqkGqPcEDjZB2qpFYvx+e
         qA+SJudIzpb3filgNmD/rb79THeAt8dxbU1Wcwt5uHJshLSnvW990s0QMTjY4z58lwYS
         NT1ibWs118iaQ9UctLuGJNeVrLxkrsfbhNk5S144oZ2TQZklVibAFhUDmXw2ioGXmEJH
         Nd70dHso+h7lNemmMLGcsXysD9VM8YsqG3J+onBQOddPpUQmMdZekivTDAUY38wnJpNg
         DIiJ+wDkHhYR+ACsVWRPDsfGRljvQzRbteB8k5gtZtxS0Czz9vp4r++0RJAU+UbCARVO
         GnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MV7uZ1/wJNhPo0dYvhWbEZ17J574Zn/SDlCTLXUM8PQ=;
        b=nq8lbYZtYlNR7QPjE8kFfI2ABIW8SFFa1tJREYzoyINff8tG3atmZGtk2hhjraOuKg
         1NkWZYhIwXeYwNe0scAgfxjkXS6a7jgZmbnSvcNiavSOuQ6h58NtnoZTmxcxSWbwHyvg
         M7cxBN8dKKQmtva6MkFBHJxjshWACVLnBicrRPoNNUqxOBLh+Knd9VSCjRcvcFxnviRZ
         fpzxUaRlbIiHE94x2g0qdT4OccM6PBVoejbaQ50i8q/vNdlbIaeFo+mdEVpDbLAq46m8
         dPGh/s+aR4c17MincfIN5/zwszRweOZUVichKjtucwTej1FL02uTf7zhEXkJlPMEY0vR
         ytNg==
X-Gm-Message-State: APjAAAWcRKOdkfY8aSC3+SLikMXiu4DSAHGVPyY1M3SCGRlHqw/fQHLk
        8hLp7/ixIVVq9RQc2gsLRv64IhVOUlqZYz0Q8kVRSQtZgWwguGNkUtKo60fERgIKp+RZxwkoPOW
        B5Fm2imWIDm4N89qqhuDwSAfe4umk
X-Received: by 2002:a17:902:9a83:: with SMTP id w3mr13031097plp.137.1553311598175;
        Fri, 22 Mar 2019 20:26:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQbpJV0/lqoW6xmZsDUvE2C+qXej/FkqSRhhO2iNIvsKrFarFNqtXvVzIuLK4XcNHt/+B8ew==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3mr13031083plp.137.1553311597976;
        Fri, 22 Mar 2019 20:26:37 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id e2sm14641876pfa.64.2019.03.22.20.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:26:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net: fm10k: fix a potential NULL pointer dereference
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190311061732.19064-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 22:26:37 -0500
Cc:     pakki001@umn.edu, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA2DD268-9578-49B5-8E9E-D3FA8C9AEDFC@umn.edu>
References: <20190311061732.19064-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2019, at 1:17 AM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> In case alloc_workqueue fails, the fix returns -ENOMEM to avoid
> potential NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c =
b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> index 5a0419421511..215f232674f1 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> @@ -41,6 +41,8 @@ static int __init fm10k_init_module(void)
> 	/* create driver workqueue */
> 	fm10k_workqueue =3D alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
> 					  fm10k_driver_name);
> +	if (unlikely(!fm10k_workqueue))
> +		return -ENOMEM;
>=20

Jeff, can you review this patch?

Thanks.

> 	fm10k_dbg_init();
>=20
> --=20
> 2.17.1
>=20

