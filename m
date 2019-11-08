Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D88FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E8A20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhuzaXhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfKHDwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:52:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36739 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfKHDwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:52:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id f10so4070365oto.3;
        Thu, 07 Nov 2019 19:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aivP/GpZ1KGYpMt8cndt6JZJWRBCraXZuvgFzKajp8o=;
        b=UhuzaXhwh4V4OtCNmi00QRY7QIuJNsZY7XkdW++ynVvUV5ipDE+Txo4OVE1lAYeXVp
         HFYurymY/b4axShJS4pi96a4cDFg4XsaEAZuzSDazYZ+xkUuSVfOz7gDMMS5FuNx1I52
         4pYCYZIKgFb3PDPoZZoQCegxROP3vtLnD5FWU6EWJ4Ay3Fb9bzqhklkrt9EDA4BgpJSL
         c3X+TIxl0VX21P7JcSN9qfbQ/2nYxRjh79ikAkYQdFlM/5vRUJdU+SDSV4Ga1sN6DW1w
         InJb+twr0pq9RiCBWOzBp65fPHyJ4wySAymr2YrkSBU1ZtY0cqzuqo6sAfLmA3aY/keC
         89EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aivP/GpZ1KGYpMt8cndt6JZJWRBCraXZuvgFzKajp8o=;
        b=nAaV0g10CaQfo9GeVc1AFHv63etf3orQFykrwanD+UuJQkkc/hmi3/yV0Eto8nIevk
         em6OSxsxvJ/0p5xc9sTIMYSW5cZmDy4WR16SpINoFAe9bmkdZgaRVfNcW+cJ7PN8uYNI
         MeOcNK776GUGeRe/gODmI97gkTakGZp7PnhQFyayW7d1dEZ+EYqpeYotT4keuScQesZE
         Kjh4Nlgg2NTDfn8vK+m4xoBdZhgRV9mAtB4o2LtOhx4c8zE/RPjefDDN2f0xg0PkM3F1
         N9734Cw89jQ1itrCvQn1WF563f1wtfTTC865IpJHYLHT5wxFhDPpmOm3hzwk81We3ba2
         voUw==
X-Gm-Message-State: APjAAAVetQz8ybsqOZnSyaw96pH0aoLQkwGUNMmEg8ZSE/udFY10fVPg
        jSg40GlLgNp3Ql8gDvJ5XFjhs6RZ2iwCtrpZc20=
X-Google-Smtp-Source: APXvYqy5Nze/GU5XzkqvIJ38bkcAHVp1VfCQNvotnh9iz5Pbk2Lxb4Ftks1yabXMhPm4deuUl636X1OlG99R3qAShFU=
X-Received: by 2002:a9d:39c8:: with SMTP id y66mr6154192otb.181.1573185138031;
 Thu, 07 Nov 2019 19:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20191106140748.13100-1-gch981213@gmail.com> <20191106140748.13100-2-gch981213@gmail.com>
In-Reply-To: <20191106140748.13100-2-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 8 Nov 2019 11:52:06 +0800
Message-ID: <CAJsYDVK7E-LMyA2eH5VhFu9EQWur_BLRNRg0-YTsOiJ+GyEF4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: mtk-quadspi: add support for memory-mapped flash reading
To:     linux-mtd@lists.infradead.org,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Wed, Nov 6, 2019 at 10:08 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> PIO reading mode on this controller is ridiculously inefficient
> (one cmd+addr+dummy sequence reads only one byte)
> This patch adds support for reading from memory-mapped flash area
> which increases reading speed from 1MB/s to 5.6MB/s
>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  drivers/mtd/spi-nor/mtk-quadspi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>

I'll abandon this patchset and implement DMA reading instead.

Regards,
Chuanhong Guo
