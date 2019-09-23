Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79329C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B44020B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxgUpwh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502225AbfIWRxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:53:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33149 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502187AbfIWRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:53:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so10862849lfc.0;
        Mon, 23 Sep 2019 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nETwLTcSQNmZKDmVi3TZpXZbExngQu+m9w5qr6AGgs=;
        b=HxgUpwh1K4Osq1CBS6h200IBzNKMlXxZJys8/y+WGEwmFuLCQp0b6rEEUvK4oLDrSP
         Rf7BTmAo0PpUHFLQDsmvhM0ybmsgDKyVNHrLOOg28zyy6cwdACR+PiZGMx18dGOmsBZx
         0GpfvuBlxJ6dZOGT/U6eIf5QD8rNo9HWz+NqmbEKcLINC54FQrJIoWGnq3OhWVvW3kyg
         WFQUO66ofXEapR7mEAEVYxUI7b+ZupKsrvET1yIDXCpucBhsSRGiBD41mce2wJ7jQdtb
         6V/A5WAcmVlM2IUla0zbhVBQjd0gBrEb4NBmZ5ryqvxcwyflVrm3VTIY0tE/IvZgCQPV
         i+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nETwLTcSQNmZKDmVi3TZpXZbExngQu+m9w5qr6AGgs=;
        b=Ycb1znWqfcTr5ah0axsdMWrXBgB+jwxtO6yoM/5oYNggvR2mBEvBzECs3E2L24PRki
         VlTDkN9MhrAeeY9UhUXXInjmIrx/JG/tHWsjyJr/VcVJAO+agV59+sY3eexQ8eGtI3hS
         z6MT/3JuANVCbjMjdkmWV6Xdp3u/7Pcrex2TIurp8R0zhD9+3l3JRyNdMIGvsE8/aOHX
         1aJsfWnmx4XBcM1+4Az93N4YlfrWzMGsvnzRvM3fh1c0ZS9rVvL5Km946+DkUpXGnfPO
         n4pqeusi9w9u6HDRuvo2WTO/cBn84IOZdxtTOZW0w9Oyfw4dvPtTtkdVY//w9jsFl4Xg
         v0UA==
X-Gm-Message-State: APjAAAU0QVkdDkbdtaWR3CMRJpPSlzQZbBL8jPzNr/qlD/YOHQ49ovqn
        m3sVUrpRxehoZ31PY4BSZIidCLucB5BaF90q980=
X-Google-Smtp-Source: APXvYqzkPsMgK6FybRHJ7x3Iz6w0uc///8DUQ3Vvh8wWfmwZxx/RPFfskdkY4Ly0GSlEFtOJmRtRNOME7RHtvOCscs8=
X-Received: by 2002:a19:6008:: with SMTP id u8mr500304lfb.12.1569261183720;
 Mon, 23 Sep 2019 10:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
 <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
 <CAOMZO5AOVfBpz2Azh65iT_W3CBZUxf9KnqA=kdow7XWd4j--Qg@mail.gmail.com> <45ad0ec1bfd5af4f46efd7d24c627822ac17fdbf.camel@pengutronix.de>
In-Reply-To: <45ad0ec1bfd5af4f46efd7d24c627822ac17fdbf.camel@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Sep 2019 14:53:07 -0300
Message-ID: <CAOMZO5C7d6ovHSyaXNWD4NmTNF-r8jw1tCLxNuh1BmD4JReMjQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
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

On Mon, Sep 23, 2019 at 2:01 PM Lucas Stach <l.stach@pengutronix.de> wrote:

> No, they are not. Those are imx-irqsteer IRQs, this controller has 0
> irq cells, so the description in this patch is correct.

Good point, thanks!
