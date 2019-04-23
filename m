Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69897C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3593620645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE/mFnYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfDWODP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:03:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45185 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfDWODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:03:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so13597454ljd.12;
        Tue, 23 Apr 2019 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGkNuRNuxBeRsGy1fEj5VB+ONzAFUAwbvCm6eF3BuPY=;
        b=kE/mFnYtvhdrjWmUwU6k8KGrxOZ+jesTFj2ppo635Hdad4Yg24FGRCCUgl+vl713S8
         9g2UnbIhkO1+se00U32kHC+pgnbbYrz8eqv9819LHjSgZ5zKRgab3ME88CAzrFyS6Cle
         dsTld8rMIFwtvkehd8fEU7S0Api3c9+Lw444AipAD5cSDpE+Y6Vs2WOkou6IdaKICfqt
         wUTRdWSw1gbW9LySfYMca+kbj3bBzbFf9OrC0GNqVmwOJn0CqxuIKSV3TiDRYX2I0L3w
         bsD82JTGBN8FYnSuRnl9ncxu9zCN5qsCeDnklk6MEiTh8AtwgYNKQhOOw7Ja5qP0pfxk
         I+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGkNuRNuxBeRsGy1fEj5VB+ONzAFUAwbvCm6eF3BuPY=;
        b=rmjlu/rPFXauMHpRrE+Y5hV3jxqAPNHSOs4geGakLS0WCJXEFhHIEXFzqjGauNlPEZ
         HsHTTD8hcwoD+lZgnIcETqhwnjz4EGk893WeYAM43/QzPLWpvrNOn2Sz8d+9I3+Ublbh
         ppz9Qmphxj+NRlaKePvLUEUqGLvFnVeNEWas32tB77GtFsCr0CZZWNgvyx7kxu12nDpg
         sGCDJs9JfZXCDkwyc7L9LkMvSxeMJLl/izSPNQwRu+jo6Z94E2GXcEkzbp6nRmSjeE8P
         v8XzrZ1QNvcnP7CAoiICFtPFy2EZRfU/0oCx4HFqVlrnLncHjHQ3MKbpRMK2SNJkFT44
         6G3A==
X-Gm-Message-State: APjAAAUKanm4mOHg6R73iAsQMz8S38bH8vr06EBZxtpKS+uj52xAfXxz
        WW/cEPTTCtQ+tHoAHEZSKYv8qmXyV89tKWK+YmU=
X-Google-Smtp-Source: APXvYqzfVIIXeW0EpURCDADiHEpD2XLTnpM5PvAdDF91uWIjUSG5yt9b9KNSV8eaaj+RI3ajpNFnpEV1RFNWvxU3ndg=
X-Received: by 2002:a2e:8184:: with SMTP id e4mr52524ljg.100.1556028192280;
 Tue, 23 Apr 2019 07:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com> <1556027045-5269-3-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-3-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Apr 2019 11:03:10 -0300
Message-ID: <CAOMZO5D-ucR6hiYRkSJh+es+KkBFrxqmR0jJrJa=eeQXohFEFA@mail.gmail.com>
Subject: Re: [PATCH v1 02/15] Revert "ARM: dts: imx6: Use correct SDMA script
 for SPI cores"
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:50 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> This reverts commit dd4b487b32a3571fdcc66062e661e3a3e360e35b.

Same here.
