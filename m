Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB773C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9630621900
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ZmKTEAPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfCWDJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:09:50 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:54678 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfCWDJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:09:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4DD3FDB6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mcmLpo4mCtwg for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:09:48 -0500 (CDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 09B51AF4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:09:48 -0500 (CDT)
Received: by mail-pg1-f197.google.com with SMTP id 18so3831240pgx.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4r0NnVB585x+7OBsFXa3rKgKUPvaz82vD8mD199i5Lc=;
        b=ZmKTEAPrjC7Apy0UZJhfxCqciTU7W4W8838BFE/0FcPRg9yDfhmFW0NNZUob6QN7Uy
         U/kWEKB4Jtij1LdXET/VsV1bs38qVkt+danl/azIm36MN+WrtzJLJ4qAtC66Njibffqm
         prURqe+pRACqndLV7f30bj9QsZiEby9Csx5UWF9fIWQctt/J0JFxHmnA8kymfs0Cj/df
         lmzuZuIhr67gOBxHLUQVQRviKJ1CFUDcSvT8tuFdeNL6aV3WDfoj2uxorytlNigcFKuh
         2moKCLB3I5qt1dyk1O9jDFZDRVdM0v3z7vM+2rG6k95skVYgWQX0eMjfZ2MZqvpa/A1w
         lPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4r0NnVB585x+7OBsFXa3rKgKUPvaz82vD8mD199i5Lc=;
        b=Q94OuZcTdshoHRWr3ySB/mGol3DRdBYE6PNimbtQkgLM+RB3u1aUzKOrtN2+I2zjly
         5sb+UvPaNZYutavrwjWKEF80TpHuLa+zk+Ij2ZSOzvpoVHXuyBqy4E052QZsc0ssJ2/L
         mCSN4DP1jEsFQ2WlSxpWimFniah5ECun5scQ1aUTAgkogmRoT/rCET+cz4YyQo8sy982
         sAVQCCp1FW1uSarhBjntvayebYrORku5NEr1uwugM0t95kstFmhD9sS6Hx5p7Mn8ghmh
         PW+pqj+oqW6iEUgeZYpK0mEkeWu+SsrUbkJiAJO0EuGAhtzaPRqxNm0/IAucl1p6FTHF
         cvsg==
X-Gm-Message-State: APjAAAWLypXeajsVHCfidyEUIbe3vRU7iohbiNfC0Uu6XLHvB8Yyi/ar
        cCjgcRumIEbb0x6w32MPSNeC5lrWiSHeU06JOc0tDaC/XWOUYGI/hGgQog2mSOxutajDFNauziJ
        ZEq6qhL1F6R9tEn6H6XsZS2/B+gOa
X-Received: by 2002:a63:c505:: with SMTP id f5mr9335798pgd.87.1553310587469;
        Fri, 22 Mar 2019 20:09:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz5Nu+60rMu6cKUUqVWY2RqzNnYTtzj4SOp/Hp4XCdcnjRpPpTWTkCMvtvKMzI7b2c5S35dAw==
X-Received: by 2002:a63:c505:: with SMTP id f5mr9335783pgd.87.1553310587273;
        Fri, 22 Mar 2019 20:09:47 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id b8sm10222491pgq.33.2019.03.22.20.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:09:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mfd: fix a potential NULL pointer dereference
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190309080456.8579-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 22:09:47 -0500
Cc:     pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C71F9E7E-5EF8-4AE5-92D4-4596D25B1D9B@umn.edu>
References: <20190309080456.8579-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee Jones,

Can you review this patch?

Thanks.=20

> On Mar 9, 2019, at 2:04 AM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> In case devm_kzalloc fails, the fix does NULL check and returns
> -ENOMEM upon failure so as to avoid NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/mfd/sm501.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index a530972c5a7e..e0173bf4b0dc 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -1145,6 +1145,9 @@ static int =
sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
> 	lookup =3D devm_kzalloc(&pdev->dev,
> 			      sizeof(*lookup) + 3 * sizeof(struct =
gpiod_lookup),
> 			      GFP_KERNEL);
> +	if (!lookup)
> +		return -ENOMEM;
> +
> 	lookup->dev_id =3D "i2c-gpio";
> 	if (iic->pin_sda < 32)
> 		lookup->table[0].chip_label =3D "SM501-LOW";
> --=20
> 2.17.1
>=20

