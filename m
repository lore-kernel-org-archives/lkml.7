Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC905C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985BE20855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRXRNY80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKTV1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:27:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45663 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:27:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so719268lfa.12;
        Wed, 20 Nov 2019 13:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qp3wqZnERgahc4/j3UaMttRmXNfWZ10Hcph0ci1u6c=;
        b=rRXRNY80I7ALa2kx4T0RfT2uUiBApG1viLOC7JlZkW+L2kbTqOZlkMLS/hXurbMo6v
         4Iq8ZjTZ3hdLRjgscqK51Kc2sfiXwxMCaFHYscC0W9hOTmMgFx/Hvly1Xfu1HzQ+KELz
         ahnkfzzy/wIF3SdKBefmsseYzwJSyqDtQQHd5mBVKXxdHu/ZMh/E1QAlP9LzBOo9DWYg
         LUd0mOTZoC2xyoypO/dOhPaMeDjGGy8jrYTETUbJA+LRu2RB/1k9g4GuF1LT2LOL0YbK
         eE5n4Jf9/0dw1/3QTwZ0JYmQf4dTdbF7MxzcQpCycB0hGfMVzpyNl5eLU5ORa0DpNs7i
         ZXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qp3wqZnERgahc4/j3UaMttRmXNfWZ10Hcph0ci1u6c=;
        b=p8V87j8yYuQaU8GgsYv4FElNgBo1gwrrbKbEc4dBOwDO6J4REOVMfa8q8c80xhYoIK
         Cgd0u1rVxprIiJTMo8nUiS5PzA3PZipRdqhlr9ZLtgzgL7X3IA+dlw9M3SJaNlkrMqMi
         PZO/EW5UF/ggjsDCmcoqP6uwHSVBdtfqP9i3htzQLaF7ofoBVYGuKkzAaWow0bNTGX38
         XRpNL/Rl58V65FpK8vr6YD4rsl14yqznuoOXruUzG9gb7OysR5Nv0lHQjwQ+ngPJHa7l
         6Z/o+74XLOiSESVOi1TB4x5Dtty64ug+7q9RwN58dX6zdt1zECBkIT083GfLLCd3z0l/
         LoIQ==
X-Gm-Message-State: APjAAAULO9K9f38a0GI/uNCWRGuB6ZoW+wwFfKH4hHN8RIgWcbGsl2ZM
        kSNsTJufn/cNWfPmelConqZKR2PstHJkPHkPiWM=
X-Google-Smtp-Source: APXvYqw1Mw2ql/sLIwwEbm33HOuERPGZBkNXPALJtaLRCm7RMoBF0wq9ZUM/gNNZJvvK54NtyY9exRM/sabQ9R8NhaU=
X-Received: by 2002:a19:c143:: with SMTP id r64mr4656279lff.90.1574285265239;
 Wed, 20 Nov 2019 13:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20191120082955.3ovsoziurntmv7by@pengutronix.de>
 <20191120211334.5580-1-m.grzeschik@pengutronix.de> <20191120211334.5580-2-m.grzeschik@pengutronix.de>
In-Reply-To: <20191120211334.5580-2-m.grzeschik@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Nov 2019 18:27:45 -0300
Message-ID: <CAOMZO5A9dhEBF-uC39nbg6E2hcd5LukNXK2V7TmPrfAbWJOCCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: dts: imx25: consolidate properties of
 usbhost1 in dtsi file
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 6:14 PM Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
>
> The usb port represented by &usbhost1 uses an USB phy internal to the
> SoC. We add the phy_type to the base dtsi so the board dts only have to
> overwrite it if they use a different configuration. While at it we also
> pin the usbhost port to host mode.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
