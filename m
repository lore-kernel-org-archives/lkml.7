Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C40FC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE9520685
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lQE2W46i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCRTlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:41:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34838 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfCRTlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:41:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id j132so11076533oib.2;
        Mon, 18 Mar 2019 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M139LBtlkNrQR6u9V/xwOU9GjCtoAeXlSSkK8+ntcTE=;
        b=lQE2W46iJf0QnJmPvkcAeS0bcn8HU/eQoU1uYCSye2F1xkagCnvS/qmLd1nUPmUjx1
         f28ns82LbDnNl8T/l/tw/UbWhHr0oSQpfTGjFm5CZvUWt9mkvpYIvFSDsxPBO8ug82jl
         4f9+C7uMOawkm4xGdgyjgDF8ZAUlA+vRRpGPz52n7+/CbmWQPCEJvnaxsA7MbfpeuHFk
         2+mDVMA6ugFYOGrxcF0jWmKz5h2MkD4Nif1zdoB79reTVDvfIEGYnCCP45M+rySGSvXI
         qAMOH7V6imNTVxhjJj9vHtin+jMWEVeh/Z90FcxfIY8GbTA8Q2GA7L2rcJktZ8uVn/Kd
         Uh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M139LBtlkNrQR6u9V/xwOU9GjCtoAeXlSSkK8+ntcTE=;
        b=iTIKb8wqzGNtSaa7tR+IBy8txkecgCKUgR9fJSD1xDQsqjRHcv4+MBkr+pgR4X80Zx
         G5/0mBmPG8frvmelJof077HAXe865aisxpn8hKJGwGkbgkPGx6BwYrE4FQ+fQ2ndoKg5
         XXiSDwQGtZn/kAfb6HgZgI5CYDtJNiIPnvwo/ezwIMwvgs42nubcYTKXdYNAUTwAXF7s
         ZAqUuX2st9eCoNzFO4krhbwjvYJCGn3GuWFkjIwreFWxxZsoeS1vw529XHnzO+J30fDG
         /d+LOVf3PC1mo7VVspLJIFy3SfolFo85rvnq4eimqnKAWGXcVtKTLN2kFmrA03F8bQrT
         JdYw==
X-Gm-Message-State: APjAAAUccM/JNe2UcEwiGtb/GyQRUztSvk+zOzv9lYFAfhkfMB0o9Bwi
        CVL548BREDF4RsRiISOEu+sZY8OFoUGuL1W6KyA=
X-Google-Smtp-Source: APXvYqzPsZ08jUobF4l6lHBcenCpjNvX5aFGpPo6j6bHgO/RsRvZ7GknFMisfezHgYoA2gNtyKtHGyoGo5PQ9cl5U9g=
X-Received: by 2002:aca:a9ce:: with SMTP id s197mr361423oie.129.1552938108945;
 Mon, 18 Mar 2019 12:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190318101153.7531-1-narmstrong@baylibre.com> <bb77c909-c19c-00e5-c5e1-25215b5a4c3a@baylibre.com>
In-Reply-To: <bb77c909-c19c-00e5-c5e1-25215b5a4c3a@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 20:41:38 +0100
Message-ID: <CAFBinCB-pLk+U1EWJ0PpdJTRteHQvrRVDpNY+QZ+2N72kKVKGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] arm64: meson: Add support for USB on Amlogic G12A
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 18, 2019 at 2:29 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 18/03/2019 11:11, Neil Armstrong wrote:
> > This patchset adds support for USB on Amlogic G12A SoCs.
> >
> > This patchset is composed with :
> > - bindings of the PHYs
> > - bindings of the USB Control Glue
> > - PHY Drivers
> > - USB Control Glue driver
> >
> > Device Tree nodes will be added in a separate patchset.
> >
> > The Amlogic G12A USB Complex is composed of :
> > - 2 USB Controllers :
> >  * DWC3 for USB2 and USB3 Host functionality
> >  * DWC2 for USB2 Peripheral functionality
> > - 2 USB2 OTG PHYs, only a single one will be routed to either DWC2 to DWC3
> > - 1 USB3 PHY shared with PCIE funcionnality
> > - A Glue to control PHY routing, setup and OTG detection
> >
> > The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> > routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> > setups the on-chip OTG mode selection for this PHY.
> >
> > This drivers supports the on-probe setup of the OTG mode, and manually
> > via the USB Role interface. The IRQ mode change detect is yet to be added
> > in a future patchset, mainly due to lack of hardware to validate on.
> >
>
> Resent with USB2 PHY registers documented
awesome, thank you very much for this!


Regards
Martin
