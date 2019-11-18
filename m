Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC42C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E52A222C1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAT/N5vO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKRSlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:41:00 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33191 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfKRSlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:41:00 -0500
Received: by mail-il1-f193.google.com with SMTP id m5so16986410ilq.0;
        Mon, 18 Nov 2019 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b3hv6InacuRwktmW+EoXmlffmYdwIhzVHa7KvQHpf/k=;
        b=VAT/N5vOWN8d5YI/h51g0OFezrcoht7jZZc8sl9xFvbtM2C6MlrupQ/qvB5av3paIt
         z2KH0SNQWWLVa6215DSLIS9MMDSxCO2MWJZ+UeOeyLH0QmPkSS9O6m6Z9y/vjB+cog5m
         RUcNpSRD5+vfKV64YvzxnlYSvJixficmxMUgkxlQrWQEuMbq7KqP6kts0+WgLk1ldOC5
         0INAOKuIVgO3unxwEYBw5Ur04zLYbp/u4ivU+VrcCZ8vtXRYn32uyujMPzexx276QyE6
         dbPNtHI1jH6j5F5Llve4PnC0hSRk0j/9T5cG2pQF9zN7TDNiSTYunSnq/Nj3g+r+7NVf
         7pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b3hv6InacuRwktmW+EoXmlffmYdwIhzVHa7KvQHpf/k=;
        b=FQNUza1xIhy/yfNuc6obEafSGbgtoCPcZh+2K2A57py/vfNXJJ4RbUP7OswLMb1PU2
         1TZiT08wBp8JLKIPuMZeIx0TO3XGy5ggsk5aqCbjaN3STmCEu8WFooqlwNHRJzYqoq9R
         icVE//XnCy2BRvDjVM2PcxC9IishDdQfsBYwL7ZgjaUOXda81bT7ugRPsHWc7lnOqxZ6
         fEcF2xQC23LuSuJ3dLIbKoguZSnWTMj1UBgdXVU6g9hocTZnkay4/2l3f1EK7m/7/3DZ
         xdrdS8opb7drx0M3Mle/Q/y0G8DxqqHK2fj5RYajqy5TYteDJCbY78Z0QCAfKrvVHAxK
         J9nw==
X-Gm-Message-State: APjAAAVhdwgKQOMg7iojlc6FDbnsF8miCJuYND2qr9gVgETH/WYfstJw
        uR5wQMYfrwUw+TDon7/xUyZ52iyNRau+TfMf36nEoqgJFf6sAQ==
X-Google-Smtp-Source: APXvYqw0aClURjDebOhw3S+luQbOyqe0gZUeqf/5SEa4XVYWW4/OqDrSNeUcoVvMxuP/tAKPDr4jhrqcjaSbD+j6UyY=
X-Received: by 2002:a92:d58e:: with SMTP id a14mr17667877iln.4.1574102458952;
 Mon, 18 Nov 2019 10:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20191117101545.6406-1-matwey@sai.msu.ru> <1784520.t1z2W423De@phil>
In-Reply-To: <1784520.t1z2W423De@phil>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Mon, 18 Nov 2019 21:40:47 +0300
Message-ID: <CAJs94EZPLedH4w3+5vfJA+f+1+zLETBdETpqNPytp3LG63az9Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 board
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Akash Gajjar <akash@openedev.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2019 =D0=B3. =D0=B2 03:46, Heiko=
 Stuebner <heiko@sntech.de>:
>
> Hi Matwey,
>
> Am Sonntag, 17. November 2019, 11:15:37 CET schrieb Matwey V. Kornilov:
> > Radxa Rock Pi 4 is equipped with M.2 PCIe slot,
> > so enable PCIe for the board.
> >
> > The changes has been tested with Intel SSD 660p series device.
> >
> >     01:00.0 Class 0108: Device 8086:f1a8 (rev 03)
> >
> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>
> applied the patch, but you could do a follow-up that mimics
> https://lore.kernel.org/linux-arm-kernel/20191117140728.917-1-linux.amoon=
@gmail.com/
>
> aka find out from the schematics where the 0.9 and 1.8 supplies come from=
.

Current schematics
(https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf)
is controversial on 1.8 supply:

On sheet 15 it says that 1.8 is supplied by VCC_1V8
at the same time on sheet 3 it says that it is supplied by VCCA_1V8

>
> Thanks
> Heiko
>
>


--=20
With best regards,
Matwey V. Kornilov
