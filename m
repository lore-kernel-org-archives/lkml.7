Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB2EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FF1218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="e2HYgg0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfCWCUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:20:36 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:42166 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfCWCUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:20:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 22A2AE04
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 02:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lqa80upYIwBG for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 21:20:34 -0500 (CDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id E7255D9C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 21:20:33 -0500 (CDT)
Received: by mail-pf1-f199.google.com with SMTP id i23so4073163pfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 19:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BWZZUaKtReGroxkl9MY5j63B/LwjEoKhQZNNmn9Fkpc=;
        b=e2HYgg0dlNOnJjfZSUWe0M0fRG6xXzSfAJ6YJiYgAZeA8PrW5RGu7bk6dLPmjxTE9e
         kEUw5mdczce2cLTOqQLiO8TB9gzf+LOzw4a4Gk8RDul2CcSXnVqLZqywYuA8UgvWb+Ph
         XcAJJ6j29x/3XO/j6eBPf1iX8AQaTWl8krZ71Pdqb2UgosMSm3+em1VAhrzmNDcZZK61
         ba6VxCJLVt1JUOFXPo573yL4su5uN9zPkwTdsPaWUN+cpux0p/3paQwcy1/J0YP0MC5n
         vytYumm8YZKuybXzpphVL8zbw1rBRam2ICgjxak6OY13E9SK6AJChFIKwNzNyLSMUuz7
         tg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BWZZUaKtReGroxkl9MY5j63B/LwjEoKhQZNNmn9Fkpc=;
        b=WIlFKc2OVuAu+QqW87J19GiHbbHFp+KiFRZrYS7tAXnxFtoBajLwp43SU9Cl4s71xA
         wl23hHQg+jqhdERwoYZq0EhGq4OQT+KFNeSwNGzdX0l0yIalu17t4wVsmbSW40DNtke/
         V1TMgPwS11ihhJBHhFaOKPVafOu21o4cggCH6Ban7u6Sp5kktvTsIG+4nJADLzVpMwXI
         arbx7/qx/c0eyBa484/d0SY1ieLrhomms1NvDnucRvCiZrfJ1RXENwkdQlJLlcHDUjSf
         2Z8IsPD8XN08bqJ6CtkbXr7xbiWeFzrOPXYMiPtwBX6CXeGdkfkJlf0SC2sroE2aCCIc
         CgbQ==
X-Gm-Message-State: APjAAAVOPaZv8wBJ75i4aHQ23QZoB5E6LPxGmf7isl//Iqy8G7hcOZVR
        ZWC1J4Y+ClZb3A7ZwFEDmN6cQTiHd9mEclQCX2k1zhvFpib5+mzl8sMV6GWA1BoFEnV4PTnfV3i
        NU0eHw4F/renK+VtvJdK9nUC52Je3
X-Received: by 2002:a17:902:123:: with SMTP id 32mr12718452plb.187.1553307632273;
        Fri, 22 Mar 2019 19:20:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDK15Ufm3NgeoI2w6ahwHXZh9mhkwfRAoLsiNb7o1z5lD2XAQl15rbJ2lRlgMm95auiTHj2A==
X-Received: by 2002:a17:902:123:: with SMTP id 32mr12718438plb.187.1553307632076;
        Fri, 22 Mar 2019 19:20:32 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id u62sm26052006pfa.124.2019.03.22.19.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 19:20:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] gpu: amdkfd: fix a missing check of kmemdup
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190309041949.3176-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 21:20:31 -0500
Cc:     pakki001@umn.edu, Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <71B1FB5B-DB3A-4E23-A62B-3ACC63D83319@umn.edu>
References: <20190309041949.3176-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 8, 2019, at 10:19 PM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> kmemdup could fail and return NULL. To avoid null pointer
> dereference, the fix checkes its return value and returns
> ENOMEM upon failures.

This is a NULL-pointer dereference issue.
Can someone review this patch? Thanks.

>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 2e7c44955f43..7ef62d4e7598 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -404,6 +404,9 @@ static int kfd_parse_subtype_iolink(struct =
crat_subtype_iolink *iolink,
> 			return -ENODEV;
> 		/* same everything but the other direction */
> 		props2 =3D kmemdup(props, sizeof(*props2), GFP_KERNEL);
> +		if (!props2)
> +			return -ENOMEM;
> +
> 		props2->node_from =3D id_to;
> 		props2->node_to =3D id_from;
> 		props2->kobj =3D NULL;
> --=20
> 2.17.1
>=20

