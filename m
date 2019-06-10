Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D1CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C78520645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pp0WsTPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbfFJRMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:12:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41623 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388374AbfFJRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:12:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id 107so9022485otj.8;
        Mon, 10 Jun 2019 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JnaLJmHCQcBLWJZGsxiSkHwMrFrHuZm5L/F2rfhVWU=;
        b=pp0WsTPZ7OMTL/JJzGLjdzNV9I7yQgICLYWc/yOxPt9S7laf1uppD0WyctgGOvxrRz
         gq/z/PStMuv8OB7T/+MfqM0s8pWMz6luGy3OZtC9GU1IKuXLcosNdY/rfx1OMVMu7e4i
         oNz1VenR2sDfDASurROzhHyrYf5AFOiEvRM55CGFj8F9D3bQYguZQ/CB6s0hJT7lmLn+
         rTJ8ddzV1TJctXFt00xr5SWlGD9rVweyUH28ytqFAuzVpuuKguGSfULoOJpSIzMYdNY9
         W/U0VWyiy/FCEf52FVujCEo+nX3ucCFF9AnXAW1jjfTBzScc2rJND8azIIwaxBrV3gEU
         +fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JnaLJmHCQcBLWJZGsxiSkHwMrFrHuZm5L/F2rfhVWU=;
        b=G2BfV0xOOEpK8P8h0g3198HgkC/UgdkXaHMXoLbxvIV1SojUF1hZGYEtSbkwqudnXe
         FWQKxE1peO0tf3LTrJR6CZskwXhS4rtR/zq6gBbr9Tv0PjEEsskYST6+TYQlMG2LaIvY
         5WFyVGrXnUMLCDc/Y5THgGA6XgvrJ6hodQkaD/Lw7OV/Ov8acwoJ/EjMGqeUqnQZqLMu
         5BR/8mosChPQK9byqFLxOVkEquZvmIBrmRQtmn77tNLJlmg5BuDvzGCy/FbSVYnNOcew
         WGsIKYzrtZvo7JDSL9tfp0zFXR+NMp3Eh81hgygVnZjonoF+/C+OE85QxeIopSY6BhWu
         XhsQ==
X-Gm-Message-State: APjAAAV4lrXQGBosM9ds44gAIcwJBmMhAkXNH+b1D5Xd/i4rOGVT0lnK
        LKynH73jlC7lUF9TaFWwvmlQQDO2LF1aYmBHsvs=
X-Google-Smtp-Source: APXvYqzcpo4BpZAPqLLLpYSSE01zvU5EUgFlHr+Ht/clKAFUTErJOnLx9oCYmXCnhsHdXKqFqknUD8gL4WoFQP0RIMA=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr29361498otb.98.1560186757760;
 Mon, 10 Jun 2019 10:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190610163736.6187-1-martin.blumenstingl@googlemail.com>
 <20190610163736.6187-4-martin.blumenstingl@googlemail.com> <8075d0ee-36fa-c4f3-f640-98cf54aba87b@arm.com>
In-Reply-To: <8075d0ee-36fa-c4f3-f640-98cf54aba87b@arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 10 Jun 2019 19:12:26 +0200
Message-ID: <CAFBinCC8wGZX2B7hc=U7qCHGwQEt9khdTwNinNVYhH=sZtFCZg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: meson: use the generic Ethernet PHY reset
 GPIO bindings
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        andrew@lunn.ch, netdev@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Jun 10, 2019 at 6:54 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Martin,
>
> On 10/06/2019 17:37, Martin Blumenstingl wrote:
> > The snps,reset-gpio bindings are deprecated in favour of the generic
> > "Ethernet PHY reset" bindings.
> >
> > Replace snps,reset-gpio from the &ethmac node with reset-gpios in the
> > ethernet-phy node. The old snps,reset-active-low property is now encoded
> > directly as GPIO flag inside the reset-gpios property.
> >
> > snps,reset-delays-us is converted to reset-assert-us and
> > reset-deassert-us. reset-assert-us is the second cell from
> > snps,reset-delays-us while reset-deassert-us was the third cell.
> >
> > Instead of blindly copying the old values (which seems strange since
> > they gave the PHY one second to come out of reset) over this also
> > updates the delays based on the datasheets:
> > - the Realtek RTL8211F PHY needs a 10ms delay (this applies to the
> >    following boards: GXBB NanoPi K2, GXBB Odroid-C2, GXBB Vega S95
> >    variants, GXBB Wetek variants, GXL P230, GXM Khadas VIM2, GXM Nexbox
> >    A1, GXM Q200, GXM RBox Pro)
>
>  From the datasheets I've seen, RTL8211E/F specify an assert delay of
> 10ms, but a deassert delay of 30ms.
thank you for spotting this!

I don't have an RTL8211F datasheet, but I now see what you mean based
on the RTL8211E datasheet.

now that you pointed this out: it seems that I made a similar mistake
with the IP101GR PHY
The datasheet mentions: "Chip will be able to operate after 2.5ms
delay of the rising edge of RESET_N"
However, further down in the datasheet it states: "Set low to RESET_N
pin, for at least 10ms ..."

I'll wait a few days for more comments and then send a fixed version


Martin
