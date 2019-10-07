Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C4EECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D56320867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpSrJL93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfJGMvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:51:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39430 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJGMvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:51:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so13513523ljj.6;
        Mon, 07 Oct 2019 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/stoexCazI9iuKLi8P8TUDyz6V2X8FtpeQI0qpKw/o=;
        b=YpSrJL93JFq5m0zDCpcoJisSR/M6+Dtbd66ZPS0jlGnfOQLbedc0qAN9KDvsv4nBWH
         PsaKYEvHVmUbtuPQBW1goArE0sfGTp3GnQE9mU9ogLtejBB65ln4iB7+p7kGUxN90hPD
         niKyPC/99OQjEgts3idB1sIcd6G1HC7PIyPi4FlFpFFpoSbc5pdiywNlB2P5LF6rp+WN
         LWoXrFqDn+HUtmyMPivBGRg4p8FiJ7WoPetvmzZvVO52gFAdiKTxuoKyB6GEqI+mWSME
         IrphxicraJ03ahzIx/21w2VJhBIdd/VK6VbvO7ahsCdTyt2zs6vZW38Gng5cFS5JHsLe
         DHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/stoexCazI9iuKLi8P8TUDyz6V2X8FtpeQI0qpKw/o=;
        b=aD7fXDJEERlW7WmXpMJWDZB133xgj6iN+14u4bdZwR1cIPpkHvRKtdUmfRukH+eHMD
         4Kt6kq9m/T+sJehnV5Kz2WwK0XBi/jfUOde+r8IXwgA6xGZptR/zFg4PggbYcEHiI8zX
         OQAUfhlQFTvkqoKCHq6wqrjBFlq2VdQP4/m88J1uGB2nU01XTYNphhC9kcFjRJWSBMfG
         s+f+6QYxKl82vbY/cHHQLlHuH8rJ2/e4ycAJHlFG6p2iMmc2C1zVHde+JjmJup2jGxft
         rmBdwPXWLPVHZ6A6Eyh6rkN1KPL9nnJHGbrSOZPAqz8xYtNbdlGnGnfHl/WjYkeVXwdF
         9dnA==
X-Gm-Message-State: APjAAAVB0zZspLV6vQzJf3J7DygSUgKBrOyAfCjKHusrFfDRb3pzjG3/
        qxIuDZqEfeKCgqAmwFmt5YrvyKXKDEQoZK8LD64=
X-Google-Smtp-Source: APXvYqzbIbzkdfmu0ZUuar7rTOgEP3mq4mYriuqCQEIx8rPeiuTn1IxwDyPOAxs6IhW57nHwifO8yPd/MQDSRrWaX3Y=
X-Received: by 2002:a2e:6a0f:: with SMTP id f15mr7917754ljc.17.1570452708750;
 Mon, 07 Oct 2019 05:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191007124607.20618-1-igor.opaniuk@gmail.com> <20191007124607.20618-3-igor.opaniuk@gmail.com>
In-Reply-To: <20191007124607.20618-3-igor.opaniuk@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 7 Oct 2019 09:52:14 -0300
Message-ID: <CAOMZO5B-XWxiu3iqc85UZT0c5WTHBx9on8x1Za_dS7Gj7h1K2w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] usb: phy: mxs: optimize disconnect line condition
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Li Jun <jun.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Mon, Oct 7, 2019 at 9:47 AM Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
>
> We only have below cases to disconnect line when suspend:
> 1. Device mode without connection to any host/charger(no vbus).
> 2. Device mode connect to a charger, usb suspend when
> system is entering suspend.
>
> This patch can fix cases, when usb phy wrongly does disconnect
> line in case usb host enters suspend but vbus is off.
>
> Signed-off-by: Li Jun <jun.li@nxp.com>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Who is the original author of this patch, is it you or Li Jun?

If it is Li Jun, then his name should appear in the From field.

Also, it seems a Fixes tag is needed here.
