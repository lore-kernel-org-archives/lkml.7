Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E2FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D7820645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOtaltYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEBMVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:21:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35909 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:21:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so1727399lfi.3;
        Thu, 02 May 2019 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YoRzopPLw6P5ilGOLkCCwo6ncg+nRGCaqA3qJdWLPkk=;
        b=pOtaltYCjij+nwgRjIdtwgj9znTc9Rk3LcgVKAbP4FdMpQNoR+PQmyu3tG86uIJDJd
         /XSjQ1WAq1cPH/U3LeAPAPTg+5lei9AopWETGpHqzFzDjn56gB9IkqBrR6sL0pHTTxxM
         2h3GwE5cRxD82OJAtLDkyFxGjM8YGwwSdIv9UVdC0nvxzinS6Vv2gKseB53tf1rQL3Dl
         pin8IOhpRJ93QII/OEtxdqjh0TKcKv153cc1xQhuaKFfLvnG9z9fQOXozQUdAG5bLmvA
         lX4bY/InhTH5oo+J31LjWsmXqcVRb8oQeD12FlDI0uGst880z1QS0Noeu7iRjOrNKQEM
         2eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YoRzopPLw6P5ilGOLkCCwo6ncg+nRGCaqA3qJdWLPkk=;
        b=HuB/w0O2KyENHRceoX8q60wWO4a/gGYebnXYEim6c+W0ktWHyWpp6YZmz6rdY89j1p
         kQM0/VzTECvdkUmaMStQSAkNOnW9bd2qvxRTyXhqvWl2pv4ym5b1zL1kTWKX6EnASpyQ
         PgXOOGo5el2/nLr8NfgNEnUOcQpGH+ROPGLmgBYxUEiRrTUoekHQy/dm1qddUrMuZjlm
         BkmLk+GVgAYRTilF8WdC7ijocnf2V3AS0UbmaQ55/YrihlUFGU/06HIJe9Up9K8vEqiW
         SImtf//UkBdfz0UqemstuFyFVi+Za5J9lQObkPjQNrX95Hppc3t4CosnnHSGKgSWzU4R
         0WcQ==
X-Gm-Message-State: APjAAAXwxzfmWSk2LcKBm8PslDO0zhHYUkOjex6tvfub60nmi6ft6aOc
        OUckfZgJ8ywnaPjr+t9LONEl0Ih1fovd8A9HYI4=
X-Google-Smtp-Source: APXvYqyqBIGxYazeIZ6OVG3oD6l17c7c09dmf9ZVSVOxS3YSB4C1RHmrYVvtN7ivy/b4hZFSt817dsEZ1InDgfl70fc=
X-Received: by 2002:a19:f001:: with SMTP id p1mr1972072lfc.27.1556799673301;
 Thu, 02 May 2019 05:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190430074730.8236-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20190430074730.8236-1-sebastien.szymanski@armadeus.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 2 May 2019 09:21:08 -0300
Message-ID: <CAOMZO5DTAvdxbb8UQufDTNWgkCj55OzXn=SZFXRocUOnkMY55Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: Add csi node
To:     =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi S=C3=A9bastien,

On Tue, Apr 30, 2019 at 4:47 AM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:

> +                       csi: csi@21c4000 {
> +                               compatible =3D "fsl,imx6ul-csi", "fsl,imx=
7-csi";

After adding "fsl,imx6ul-csi" to
Documentation/devicetree/bindings/media/imx7-csi.txt:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
