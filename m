Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6FAC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B36206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWWjxU+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLWWHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 17:07:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42672 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:07:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so13695352lfl.9;
        Mon, 23 Dec 2019 14:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmTdxucpbmcUC1/HgsgMrwttzt2udxIVlgF0GEdd2ms=;
        b=NWWjxU+JXWlYNpDZQIWeoSFGLBhiBVu5VbrOeJ/oDPQxDx9uWLW6+0NVgeW3HSfQdp
         B24WwHikl+IfInCl/Szc+mBMU7IIjy65tNEElwsOeG54wdw7Ahn+xqi0q2ZknxXpl42Z
         J+ZRoC+DrYhX3fU+MD9TkhxaIj47OZPV2N0OhXcaEkoWiGHWgDWMXmNiB6sMpv863JCp
         MaGSGu8oy24i4ihktleGN065EKRTm3dSr+ZrjcYFG/kuHxTh9ybhnzVUUoA2jPsiJmmy
         9On+fD6g25TIlf3DrkTWAdbyViANUY2NzmibXnZjDSeSif+TTkx7Fa2euSi5bJjWxXUQ
         QM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmTdxucpbmcUC1/HgsgMrwttzt2udxIVlgF0GEdd2ms=;
        b=jowJdiGBsyQp7lUIXJBi2TDeVUfxp4WWCKp/4KTJ5tuGFpn8h03W5UXoSFrYs2l202
         BRxD/lCHEFU4C5LqKvpslsMY5ig+09EFEz3pq4IQKTbSiCXDlzkuXDim9OZOGT4Q4JDz
         Z1aB3rawTASS4DgLQAn62FbUFE82PHLTPEQmDW0ydPICfLiqXT7mT9BX0CiPGH8lb5r3
         L9IJZgkSXlSEBQBzplDpHQtXUkPztgJ05yIO1OsW2SFuWo7GX10h6BToDY2FWZmbQFBW
         F51m8ZvUU/5aCLLfJcCUIUgmeOItgn9LgRqBQ6G2qG5XWEydt3mfvP11CvSPqHNEXKjr
         d9xw==
X-Gm-Message-State: APjAAAWPKfN+xCOuSLYaeWlms/nbMigZNsYWiRJxVu1T/5txn9nXDwfk
        uc02AQddYidwg/HtQLV+v5OEkGQ4FCsBbNnWC58=
X-Google-Smtp-Source: APXvYqyPGBGJdbyAReF1wKA5YkURhfw98cKXEjCntRVnT39Q/KOHRPTlCAOlz1gex7/ZBZVylxHkr/0wV5tMrKX5SSY=
X-Received: by 2002:a19:c648:: with SMTP id w69mr17843677lff.44.1577138834702;
 Mon, 23 Dec 2019 14:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20191223214412.12259-1-rjones@gateworks.com> <20191223214412.12259-3-rjones@gateworks.com>
In-Reply-To: <20191223214412.12259-3-rjones@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Dec 2019 19:07:01 -0300
Message-ID: <CAOMZO5CkfTM04GQVZbz6K7WSCmmCWb=OAvcUqDjW3zVkyiqx3g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: imx: Add GW5910 board support
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 6:44 PM Robert Jones <rjones@gateworks.com> wrote:
>
> From: Tim Harvey <tharvey@gateworks.com>
>
> The Gateworks GW5910 is an IMX6 SoC based single board computer with:
>  - IMX6Q or IMX6DL
>  - 32bit DDR3 DRAM
>  - FEC GbE RJ45 front-panel
>  - 1x miniPCIe socket with PCI Gen2, USB2
>  - 1x miniPCIe socket with PCI Gen2, USB2, nanoSIM
>  - 5V to 60V DC input barrel jack
>  - 3axis accelerometer (lis2de12)
>  - GPS (ublox ZOE-M8Q)
>  - bi-color front-panel LED
>  - 256MB NAND boot device
>  - microSD socket (with UHS-I support)
>  - user pushbutton
>  - Gateworks System Controller (hwmon, pushbutton controller, EEPROM)
>  - Dual-Band Wireless MCU (CC1352, UART/I2S interrconnect to IMX6)
>  - WiFi/Bluetooth/BLE module (Sterling-LSW, SDIO/UART interconnect to IMX6)
>  - RS232 transceiver (1x UART with flow-control or 2x UART (build option)
>  - off-board SPI connector (1x chip-select)
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Ok, this one has Tim as the author, but since you are submitting it,
you should also add your Signed-off-by below Tim's.
