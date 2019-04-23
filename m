Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB679C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830EB21841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFzA507C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfDWOCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:02:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37764 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfDWOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:02:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so1057642ljk.4;
        Tue, 23 Apr 2019 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pybrby6/rD7GF7pdH4L1cyy/52GixRCOp4+ojtZQeCw=;
        b=IFzA507CZt1NZQKFjG39+cnPk4rM8q/n2onLd7Jv+BtEzi2HSlc+InI6RpV3qmwteP
         CqWOGsrTFx8MiiQ3CS3jYQvVLThq2yMoy1I+8TR2v8G+VsckVGDQukHVOCbOSdSBAt84
         cC3RQVe/lH51TAkXOVpOB6Wrtjpm7UOPtrVOptsFSTwzPBvR+y6pEr0AYXM3re3ZnfQU
         UYZSOjc5LJxjTX7JrNq/+p5NDK4sj6j+v1UkVz46hcekwb16uRsFX7xo2saNUyLhsJrx
         eE+nDW5KmX+dDhNAX8YrMINLvAeVW/N/SpIQiMDD6CBWfzLH/QHAsQoM0qqP5sBxrn/z
         yCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pybrby6/rD7GF7pdH4L1cyy/52GixRCOp4+ojtZQeCw=;
        b=eeFSGlyL8DmEAsUUPyimrosmkc6BbVWMuUkkn36UebSW0yHaXF/gf+2piOKkMbensI
         PcLF56p5y7BEZ0pJM/e7QuNVpQ4/9ZLskm/gRDRSVY/LTyHx6x9GcwS3cKeFYkFz77rR
         FCIJ6gJAOdOVUE53HWHr4HFF7Xt90kotBSL/RTO5iFDCHnxOTjggjLDoQ2olgZcmhUkL
         EvL8ollCV14uqVzNzKln3a1aNr/H8tKnhXTYs+nMwyOUSmuFbGVWEiLclrdZgCvxdI8K
         2P+AcEeMlKQfDrVNhksIC0X46aD+4WurEoa7n+iU0PwM0eiwymFDPB5LIgy66SUnjVaw
         HLZg==
X-Gm-Message-State: APjAAAWyHaPmNfgV4luASFJAS13+0jhE85xI4ZX1v9bNCDM60b3IPlQW
        EefzxDuxPvttk0VNa8ukgDgJa15VepB7mA81+X0=
X-Google-Smtp-Source: APXvYqw4e40Lb0ldN91KKckSt9NSYcSXCO6GyJik6TaDmkfOjHhs3wzZ452z6BKRGiu8B+VK++t7M4heVdgQeitP5Hc=
X-Received: by 2002:a2e:9812:: with SMTP id a18mr10015468ljj.146.1556028166951;
 Tue, 23 Apr 2019 07:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com> <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Apr 2019 11:02:44 -0300
Message-ID: <CAOMZO5C5Sc0=_Jsb_CW-Vf9_Zka7OaA66uo3OPB4NsHzo92T3A@mail.gmail.com>
Subject: Re: [PATCH v1 01/15] Revert "ARM: dts: imx6q: Use correct SDMA script
 for SPI5 core"
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

Hi Robin,

On Tue, Apr 23, 2019 at 10:50 AM Robin Gong <yibin.gong@nxp.com> wrote:
>
> This reverts commit df07101e1c4a29e820df02f9989a066988b160e6.

You need to provide a detailed explanation in the commit log as to why
the revert is needed.
