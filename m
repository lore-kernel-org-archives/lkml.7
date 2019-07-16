Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40262C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036D22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PlABOLtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfGPWfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:35:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37573 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfGPWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:35:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so9801092pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=oNKadd/WVCq81IXvSQ0j30TJwkdvFHc6RdF6/To6EAw=;
        b=PlABOLtxKdt3umkPxr+wy+2HNHScTBvq6WU86sEkXCwrWTcMh0G2g2T6kpThh1kisk
         7+nncEAlMbqlIRE+f5E+sF92Q0u5QKmJL+9gu+Yup77IlPkp5l7EGMufIUtzof7o8WDP
         mfFHDWW31G2ojtBEgGD5JV3pdae3gUzylfInc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=oNKadd/WVCq81IXvSQ0j30TJwkdvFHc6RdF6/To6EAw=;
        b=C1s/+8Jodf8extAftgtXZ6igAdPocbq9nhrAMhWf5oJYBzh/sUJXgxO/lJKuXE0flu
         4CsQWyHCPsNNATMNF4OECap8QXgczkQg6uvCL19CWQfUkz/j/ktzsmqj0ADzNVxg4hh6
         P9BeD/sISaHklQKv72JLIhzhvUtGJKtBuDfsSWGIwsDNQRR2lT6/n/l/YMiMOOuFVPFQ
         RjaLjZtWv9M19AwB1ufougx6nHKtuF2ZPytg4+cacOOPG7GEFpI29DGsYD7guBxW+YPW
         fO4puClOGENL/UWxkIOY+B2QlyjrnFax8+dzH40suuCbM2S1qbXdSchm6MvYx12tD93w
         XhVw==
X-Gm-Message-State: APjAAAURqefxTPicDgSshjGEE/OUJ9uov2ZqIWemdGD7BtDxZFHP12k/
        HUmbaqWUxsR6Ap9oV5r4MfhhUA==
X-Google-Smtp-Source: APXvYqxyF6nAHD345G30UUWPahYhM5UqsashUW9Kco4ExdxioImxVm1Ea4YO4E3PAj4jjVj1VYJ7lw==
X-Received: by 2002:a63:f959:: with SMTP id q25mr36666426pgk.357.1563316546155;
        Tue, 16 Jul 2019 15:35:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w18sm28050816pfj.37.2019.07.16.15.35.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:35:45 -0700 (PDT)
Message-ID: <5d2e5141.1c69fb81.ef731.8450@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190703050827.173284-1-drinkcat@chromium.org>
References: <20190703050827.173284-1-drinkcat@chromium.org>
Subject: Re: [PATCH] of/fdt: Make sure no-map does not remove already reserved regions
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ian Campbell <ian.campbell@citrix.com>,
        Grant Likely <grant.likely@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 16 Jul 2019 15:35:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Boichat (2019-07-02 22:08:27)
> If the device tree is incorrectly configured, and attempts to
> define a "no-map" reserved memory that overlaps with the kernel
> data/code, the kernel would crash quickly after boot, with no
> obvious clue about the nature of the issue.
>=20
> For example, this would happen if we have the kernel mapped at
> these addresses (from /proc/iomem):
> 40000000-41ffffff : System RAM
>   40080000-40dfffff : Kernel code
>   40e00000-411fffff : reserved
>   41200000-413e0fff : Kernel data
>=20
> And we declare a no-map shared-dma-pool region at a fixed address
> within that range:
> mem_reserved: mem_region {
>         compatible =3D "shared-dma-pool";
>         reg =3D <0 0x40000000 0 0x01A00000>;
>         no-map;
> };
>=20
> To fix this, when removing memory regions at early boot (which is
> what "no-map" regions do), we need to make sure that the memory
> is not already reserved. If we do, __reserved_mem_reserve_reg
> will throw an error:
> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory
>    for node 'mem_region': base 0x0000000040000000, size 26 MiB
> and the code that will try to use the region should also fail,
> later on.
>=20
> We do not do anything for non-"no-map" regions, as memblock
> explicitly allows reserved regions to overlap, and the commit
> that this fixes removed the check for that precise reason.
>=20
> Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/ regions in=
 the case of partial overlap")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

