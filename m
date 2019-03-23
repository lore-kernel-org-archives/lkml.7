Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C00C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D30B20823
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mhs5uUBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfCWDIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:08:40 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:57600 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfCWDIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:08:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id A2CB4E39
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:08:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bFU_bjfiqiSK for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:08:38 -0500 (CDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 6242FE35
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:08:38 -0500 (CDT)
Received: by mail-pf1-f200.google.com with SMTP id f67so4116245pfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gF4XNeMQXCXB1IihTPIeo8djj2LPioVwfyoU0tslKkA=;
        b=mhs5uUBKF7Sgm8GDtX7pUdcBMDjHR6G1VORFLLkb4rDlRIIK93T4o62Zr1Vr6UtzyC
         l8pinWxkoa1Y3SwOs2B/NoB+42ebUyEUFBoFKY9rnkvypXp/9lg1fp5gxI1UjPWSTzPz
         QvR8o+CkffaYGbVKvcXKQ941dvGi859i0rRkbIluJ4RZPGgejDhzccbjfENwJT9hSTCT
         L5652HJ87xAqBbNg4WM5izDLS+Iz/B5vKB71E7Uw8ujL/31tkpf6XRJvqY1a/wh8fLPc
         zOx/K64TqEvJAUCUH968OsPPUePt2x990zneoVTCHBouDjX59fdx4GnRg5hjH+Zx6ZPg
         En0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gF4XNeMQXCXB1IihTPIeo8djj2LPioVwfyoU0tslKkA=;
        b=hdfu5ZGtC537E2KAtNgJxC7DglS6GRo8yqm9agBFTFp+76j9qaMFKn1wwDC4x+oUJZ
         G3OowkTstmHO49UXa82uWe6Der2Pwk7gyjx5lCkSOZvJYxVGzzLikRRDQPlIe+Qz8szA
         rTl+6odRklLDfG8u0ybc6J0ftO3n05aSobTfnj0FgrwifKEJjDf2yFrua2Y4fGtJByG1
         RwNCxGe9+LY1KT9PYHjtDTn8VmGZXkHTFptF7PlQXJGHcPUm3Zp8m5oWvFDhLzslzceD
         zveXbv8ccWET+FRu1/I9+JnTYmaRog6xy5WTPTy6FNmoZJcaspakB9k8KCIuMBvwqZsP
         4fpg==
X-Gm-Message-State: APjAAAVkju/Fqfgplz4OOJ3+4ProoiWI8l6Me3uilf+/cX7JxnAeWPoO
        r2dLZJ2V28rNCYATMj3ZzP+sHZWb/tFkt6i7MC6rOzU3tTeujEfhC+0kazqKTmEY6ixwlG4KdnX
        cC1792w5dfEVi6WHml6QtrOleIcJf
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr13016479pla.139.1553310517830;
        Fri, 22 Mar 2019 20:08:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8z4n4R+pr5g0PSMnFk04R31AQe0W1t6vApiyCF336BP1+xxa7/1qbVMU7iXFmhDNmZSn5OA==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr13016465pla.139.1553310517633;
        Fri, 22 Mar 2019 20:08:37 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id d3sm12115526pfc.125.2019.03.22.20.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:08:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] memstick: fix a potential NULL pointer dereference
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190309075917.6791-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 22:08:37 -0500
Cc:     pakki001@umn.edu, Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <11B50B8B-7A27-4BFD-B0C6-669C74381B46@umn.edu>
References: <20190309075917.6791-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim,

Can you review this patch?=20

Thanks,

> On Mar 9, 2019, at 1:59 AM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> In case alloc_ordered_workqueue fails, the fix returns ENOMEM to
> avoid potential NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/memstick/core/ms_block.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/memstick/core/ms_block.c =
b/drivers/memstick/core/ms_block.c
> index 82daccc9ea62..8e00de414567 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2149,6 +2149,11 @@ static int msb_init_disk(struct memstick_dev =
*card)
>=20
> 	msb->usage_count =3D 1;
> 	msb->io_queue =3D alloc_ordered_workqueue("ms_block", =
WQ_MEM_RECLAIM);
> +	if (!msb->io_queue) {
> +		rc =3D -ENOMEM;
> +		goto out_put_disk;
> +	}
> +
> 	INIT_WORK(&msb->io_work, msb_io_work);
> 	sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
>=20
> --=20
> 2.17.1
>=20

