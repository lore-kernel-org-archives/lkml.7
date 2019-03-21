Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD9121874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vh4dsJfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfCUR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:28:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40795 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfCUR2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:28:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id u68so5179140lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6jKrAO0FUaoRnQDNx1D2qJD6Jq9gsPKBoBHuvAd8k0=;
        b=Vh4dsJfJcmq+Er4FM4x603yB0T1lFU9OAOcdxZSWRbc4Oris2Mbtx8++CSJ4Y2oKth
         pI9c7jNF9uAOW4zhvTsVjsB8egbs15wj35VBdrv/rmRolOwbFVNWRi0JCpjfPwalkMyu
         UdQhRxtR9LJo4Fvfk8Wioy2RTbEqnDL69TX8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6jKrAO0FUaoRnQDNx1D2qJD6Jq9gsPKBoBHuvAd8k0=;
        b=N0zO3FGlLSceMVX/0hqs6CQofWF7GLSjO07mhaD5Hq3gAv/6jrUsywGWZrMvvaIxyw
         r3VsuOCE3i4dESeLc0x398pXwsJdvFkNzJ+r6Z4z7xeuw0IpTf6IAbzgXz8BLq7nPMQL
         E65MNxywyApBPhTTNYOLLO7+BumSTfW1Xmjm669rLMuQIovUFjB14HoHSoO1474EHESn
         2s7gl/4IE7LJOGouNxrTklgyPY8w7j+5IwzrbO3Z1LTo4w4rpLiccRNQPscEaT0xzGkH
         t3woQZIYY/crGILnBoQDseIVAak60YzF7ItO3/Lo0b5/sITNBe7TLFXKuf8efGwbSk1F
         o+ww==
X-Gm-Message-State: APjAAAUuPI5H5G/FTJvG07uFaZIxWeJqtT5mQQd9Dhq4v9MFdLWFtGEF
        1o7Bt4xaf95pudhxI8CgC9rTeuAJu9M=
X-Google-Smtp-Source: APXvYqwx33U4qfLyqG6Jq0nC1dKmV5hYl/WjY3kiwUIsK5AwtrGjgQaoZXj5IZJxQBRN3Ow2VNu6Jw==
X-Received: by 2002:ac2:5086:: with SMTP id f6mr2747357lfm.43.1553189295968;
        Thu, 21 Mar 2019 10:28:15 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id l14sm953936ljh.62.2019.03.21.10.28.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 10:28:15 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id j89so6031506ljb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:28:15 -0700 (PDT)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr2859999ljg.64.1553188825271;
 Thu, 21 Mar 2019 10:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190205185902.106085-1-evgreen@chromium.org> <CAE=gft4YPmqd35ySmZw2UG876Lvt8rcz+nNwELXK98PDvHuVeA@mail.gmail.com>
 <405b80c6-2624-cc7d-24fa-670b7e8cb3a9@ti.com>
In-Reply-To: <405b80c6-2624-cc7d-24fa-670b7e8cb3a9@ti.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 21 Mar 2019 10:19:48 -0700
X-Gmail-Original-Message-ID: <CAE=gft63ejm3hEt783FXA+jkG3BSaX2s8CL8+KjFTVLVUwTprg@mail.gmail.com>
Message-ID: <CAE=gft63ejm3hEt783FXA+jkG3BSaX2s8CL8+KjFTVLVUwTprg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] phy: qcom-ufs: Enable regulators to be off in suspend
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Wed, Mar 20, 2019 at 2:07 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Evan,
>
> On 20/03/19 1:34 AM, Evan Green wrote:
> > On Tue, Feb 5, 2019 at 10:59 AM Evan Green <evgreen@chromium.org> wrote:
> >>
> > ...
> >> Evan Green (8):
> >>   dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
> >>   dt-bindings: phy-qcom-qmp: Add UFS PHY reset
> >>   dt-bindings: phy: qcom-ufs: Add resets property
> >>   arm64: dts: sdm845: Add UFS PHY reset
> >>   arm64: dts: msm8996: Add UFS PHY reset controller
> >>   scsi: ufs: qcom: Expose the reset controller for PHY
> >>   phy: qcom: Utilize UFS reset controller
> >>   phy: ufs-qcom: Refactor all init steps into phy_poweron
> >>
> >>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   6 +-
> >>  .../devicetree/bindings/ufs/ufs-qcom.txt      |   5 +-
> >>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |   3 +
> >>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |   4 +-
> >>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   3 +
> >>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 117 +++++++++---------
> >>  drivers/phy/qualcomm/phy-qcom-ufs-i.h         |   5 +-
> >>  drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c  |  25 +---
> >>  drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c  |  25 +---
> >>  drivers/phy/qualcomm/phy-qcom-ufs.c           |  57 +++++++--
> >>  drivers/scsi/ufs/Kconfig                      |   1 +
> >>  drivers/scsi/ufs/ufs-qcom.c                   | 114 ++++++++++-------
> >>  drivers/scsi/ufs/ufs-qcom.h                   |   4 +
> >>  13 files changed, 202 insertions(+), 167 deletions(-)
> >>
> >> --
> >
> > Hi Kishon,
> > A gentle ping here now that rc1 is out. Are you able to take these? I
> > can also repost if needed.
>
> Can you repost with the updated tags please?
>

Sure, done!
https://lore.kernel.org/lkml/20190321171800.104681-1-evgreen@chromium.org/T/#t
