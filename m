Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C5AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AE6213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hznpp6Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCSULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:11:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37810 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCSULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:11:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so236315ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhKLPSxsBURs/3A6c4Kl4otn0vCdIHOP0Pi8YTDtQ3o=;
        b=Hznpp6Gk7dOpM3seQIt855WgtWDN9V2LlRXI1NreE00k0/04QqFLIWhLjHTy3aKQvR
         OofhnjHyw3Pj9STlaQ60/zF1Wj062aY5fBrdjOx8b/pWqujk0HR3CDQOCYXOwFcpA3BW
         TIQmoJRhj2nDaY5uDgf59uvV7et+tFiVkFxPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhKLPSxsBURs/3A6c4Kl4otn0vCdIHOP0Pi8YTDtQ3o=;
        b=lAu05w4YPFa9FIjfxjpgVP/iTYmMdovhsPUxmDkiKCPSLH4uk6/lIMGV6z/MQAScCZ
         U8l+mHxfWLBzOdAjuQbN3hRGvFzXiDrBSfTX3y8vhjPbFhD5BRcI2/96RpTmPagllk36
         9wLZgb7LBJ3DsFWfNA/1k2Ox35GL+OBzh7ImC5ERF97xW0xDFdMvEebqThk0GFHdcNHw
         WqUPGGALzSFyVIs2LMIcYuddqKjaMzMxKVBn1Y0Nj75cia3bcxVUwSFo//r1syMeyofz
         nbr3vx0ggM1ey9oNJ0qUP5T2I0CafEroexkIIv9k1WM5XRn6nZdL1BPqwmZ0kIyTh1cm
         rqng==
X-Gm-Message-State: APjAAAVplyE1UmJCuCGNB/9kItOMrvtnvmhJ02sj2hAC/OSYgbiNUpTl
        jJ3hAtDL4xeCLpRYe8KtbgmFDaAG1es=
X-Google-Smtp-Source: APXvYqwbASMygQErfaobuAmmE7D+s1EPewaKp+39g7EZRrsNwSgnIO5426oza3w7zV2XQZUFTXVNlQ==
X-Received: by 2002:a2e:85cf:: with SMTP id h15mr15233294ljj.73.1553026305567;
        Tue, 19 Mar 2019 13:11:45 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y16sm2164ljd.63.2019.03.19.13.11.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 13:11:45 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id f18so84302lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:11:45 -0700 (PDT)
X-Received: by 2002:a2e:9655:: with SMTP id z21mr12960544ljh.60.1553025898818;
 Tue, 19 Mar 2019 13:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190205185902.106085-1-evgreen@chromium.org>
In-Reply-To: <20190205185902.106085-1-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Mar 2019 13:04:22 -0700
X-Gmail-Original-Message-ID: <CAE=gft4YPmqd35ySmZw2UG876Lvt8rcz+nNwELXK98PDvHuVeA@mail.gmail.com>
Message-ID: <CAE=gft4YPmqd35ySmZw2UG876Lvt8rcz+nNwELXK98PDvHuVeA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] phy: qcom-ufs: Enable regulators to be off in suspend
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, liwei <liwei213@huawei.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Subhash Jadavani <subhashj@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 10:59 AM Evan Green <evgreen@chromium.org> wrote:
>
...
> Evan Green (8):
>   dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
>   dt-bindings: phy-qcom-qmp: Add UFS PHY reset
>   dt-bindings: phy: qcom-ufs: Add resets property
>   arm64: dts: sdm845: Add UFS PHY reset
>   arm64: dts: msm8996: Add UFS PHY reset controller
>   scsi: ufs: qcom: Expose the reset controller for PHY
>   phy: qcom: Utilize UFS reset controller
>   phy: ufs-qcom: Refactor all init steps into phy_poweron
>
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   6 +-
>  .../devicetree/bindings/ufs/ufs-qcom.txt      |   5 +-
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |   3 +
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |   4 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   3 +
>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 117 +++++++++---------
>  drivers/phy/qualcomm/phy-qcom-ufs-i.h         |   5 +-
>  drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c  |  25 +---
>  drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c  |  25 +---
>  drivers/phy/qualcomm/phy-qcom-ufs.c           |  57 +++++++--
>  drivers/scsi/ufs/Kconfig                      |   1 +
>  drivers/scsi/ufs/ufs-qcom.c                   | 114 ++++++++++-------
>  drivers/scsi/ufs/ufs-qcom.h                   |   4 +
>  13 files changed, 202 insertions(+), 167 deletions(-)
>
> --

Hi Kishon,
A gentle ping here now that rc1 is out. Are you able to take these? I
can also repost if needed.
-Evan
