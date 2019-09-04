Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B59C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC97E20820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a8j7VVK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfIDXXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:23:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfIDXXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:23:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so290295pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=lphsBie2JSPrEUQ5VneXuMojjEkJzSMY/OrsBG/BydQ=;
        b=a8j7VVK8er6IJw91u+NvdDPk2ijqJGtLrIv1MkWa0sCQf5kqLdJYUZ/SWNW12ydLao
         zCvU8l9hw5aKSe1mvG/BPwT1yuVIEVuPnun0X7NC9b5mWL5//gVpFBPtlVOmytZo91px
         ETFMKqh9wU1Ttq/T1Yx+3KL8kytlWVgUJQbfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=lphsBie2JSPrEUQ5VneXuMojjEkJzSMY/OrsBG/BydQ=;
        b=hEzuXtO6YSPFbcem1fGqmc2l8beHyWa5Ext2t277YU9YUlCFwtyS07hSdqNCjbmHps
         UAJmE+Zaa3+2vjODt0o2CvbeYOiJLln3hvOICwJrmI0jbnVaHR5hqUQLL9SeGfp8zEgL
         tp612jvbV2Y8laIk2iGqUakgCuDGhGkcv92RSV8sK6KuZlhMHEx/Dgu5gKpA/vH/H3Ds
         42whXgaKlLkK5NsrR5N1rk8m+ZI3IQwlNJ6Fln5U2KnlzEKNKFMVqZFuyyOEunO/WHzH
         90GltT6ReYB0i/hejmOPytYfQ3TUxgtOkxBM54iNTjk4yQfiF7F22EfAEAHbsl3IS0L1
         oIfA==
X-Gm-Message-State: APjAAAUObj76sIBgAgtX+E8dhtOSUpbbeuSOkDkCE3kSMEhiKi6jUlNv
        8jLwuRLY1svKCSXOCRIO+Qq5wQ==
X-Google-Smtp-Source: APXvYqxu+d8OGsxHVrHtrfwnaDEw2e+JR8t1WqEtXjbxB5d/zhpcvmj7dPTA26D0ItyguUMbrdtT2Q==
X-Received: by 2002:a62:168e:: with SMTP id 136mr255170pfw.144.1567639386396;
        Wed, 04 Sep 2019 16:23:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y13sm144265pfm.164.2019.09.04.16.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 16:23:06 -0700 (PDT)
Message-ID: <5d70475a.1c69fb81.650ed.0ad0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190904100835.6099-4-vkoul@kernel.org>
References: <20190904100835.6099-1-vkoul@kernel.org> <20190904100835.6099-4-vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] phy: qcom-qmp: Add SM8150 QMP UFS PHY support
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 04 Sep 2019 16:23:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-09-04 03:08:35)
> @@ -878,6 +883,93 @@ static const struct qmp_phy_init_tbl msm8998_usb3_pc=
s_tbl[] =3D {
>         QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
>  };
> =20
> +static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] =3D {
> +       QMP_PHY_INIT_CFG(QPHY_POWER_DOWN_CONTROL, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_SYSCLK_EN_SEL, 0xD9),

Can you use lowercase hex?

> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_HSCLK_SEL, 0x11),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_HSCLK_HS_SWITCH_SEL, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_LOCK_CMP_EN, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_VCO_TUNE_MAP, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_PLL_IVCO, 0x0F),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_VCO_TUNE_INITVAL2, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_BIN_VCOCAL_HSCLK_SEL, 0x11),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_DEC_START_MODE0, 0x82),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_V4_CP_CTRL_MODE0, 0x06),

Gotta love the pile of numbers and register writes...

