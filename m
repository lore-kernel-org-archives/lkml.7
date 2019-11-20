Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB85DC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FCB2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi5K9wX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKTV2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:28:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46452 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:28:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so714483ljp.13;
        Wed, 20 Nov 2019 13:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AlBzJzPNV6WmO7BOKxphXcqJibhWddufaH3SnTFx3o=;
        b=Yi5K9wX2Ss3ZUwsOQnemA58PHSHXcA8FTp5TzY2SoDwVhmwn1yF7jx+ImGxOcfVvIs
         adaqnP6TqkySNuaEDsU0bMxMn0in274ozQZMQsAxFVzAVDTzSQglNhI8698GQhVCuOsF
         6bmrOttv+LfPdQj0E8CpQ0yypIssgv5Cg5GYYTCL7nl+/niFakDxkkBhbWZQIIvVCbyU
         hVdG7nWGbDIpeWThv1t9EJGIWifcZCaQvfE2Rc09K1hutStWpHsas/B8HMNK/oGi1F+O
         sDPVERP7HwBBkyCnXdJrlt6bYuHOifEofF9Qxh/2BzL6V31Gjdr1M6tFwBNFyrc9C+PV
         WctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AlBzJzPNV6WmO7BOKxphXcqJibhWddufaH3SnTFx3o=;
        b=tiq2f14vdb3Q5PoRuax6bpaHdPsiyF+itVnCNvZijt1QjTtx0ipv8H3RBzIF1CkChT
         wuhLbCxPtkLNmxIU6jUki0sZK0Pl2aOEoqEU1zhJ1ga9Ub4oczJ0ONKHGJS6UJan3d1R
         /1o8pLVkEvLfEb9lRhg+vln83QR/Ay+Q4YFrbkRR15aVaXp3U7AqzMItHt1Z/fHYIEam
         qGZCHhY9dw6eehWP/ax6lZs89CIDiKkd0SiBMK/LwzOIFq8lhnVB/8+npA7rTK0HR1lS
         jlKiW3W7bA6BI2EEdN1NF0TW0BVvxgapWTomqcyyYSJrNY039KjRV3bKu/tIdfobFlaY
         ymPw==
X-Gm-Message-State: APjAAAVJ5Ef96MpDszQHlda7MdHoKpvp6iLYNhOEj+wTV3iBWIe29ZRb
        sYQJSE9pgA/p9n0c6uf3xT1TLnm1087zmJdl4k9XfNx9
X-Google-Smtp-Source: APXvYqyivxCTlR69eJbUiJ3qNnphZIvKFLKcgP8DZeFvc7wwGrBx1ylG75AuaC6m+OdUbfw9EKwNXOBUS3uZNcyUz+A=
X-Received: by 2002:a2e:8e97:: with SMTP id z23mr4444619ljk.149.1574285298161;
 Wed, 20 Nov 2019 13:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20191120082955.3ovsoziurntmv7by@pengutronix.de>
 <20191120211334.5580-1-m.grzeschik@pengutronix.de> <20191120211334.5580-3-m.grzeschik@pengutronix.de>
In-Reply-To: <20191120211334.5580-3-m.grzeschik@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Nov 2019 18:28:18 -0300
Message-ID: <CAOMZO5Bs20c3_4rWS1n3h6sRyM2PBx1=B1sJhbkPWs_1xLUaVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx25: describe maximum speed of
 internal usbhost port1 phy
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
> The internal usbphy of usbhost port1 is only full-speed capable.
> We set this limitation in the dtsi.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
