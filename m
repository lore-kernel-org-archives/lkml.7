Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1D52184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QTqosVn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfCTJHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:07:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40392 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCTJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:07:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2K971nq014548;
        Wed, 20 Mar 2019 04:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553072821;
        bh=+fgXxalTegibFtlV37QjT9vMEQnxoxfl5WMKBqzKTWw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QTqosVn3O9KvQHbNcMr+qFhe19iqJWkKl946M0iqcOuvisASF4eENaQUoEBTJG+/v
         eG6nyl7ebf1KJJbGes2/ZuHr1KtW2rJ2MXGQOpN5V1XQ2eN4ea8UWAh3LRRHyFMEnQ
         Rh5TsFclE46O7gEVwMLTvurMBwy/O8f0KUaqXd34=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2K971mF064441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 04:07:01 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 04:07:01 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 04:07:01 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2K96l44009292;
        Wed, 20 Mar 2019 04:06:48 -0500
Subject: Re: [PATCH v3 0/8] phy: qcom-ufs: Enable regulators to be off in
 suspend
To:     Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
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
References: <20190205185902.106085-1-evgreen@chromium.org>
 <CAE=gft4YPmqd35ySmZw2UG876Lvt8rcz+nNwELXK98PDvHuVeA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <405b80c6-2624-cc7d-24fa-670b7e8cb3a9@ti.com>
Date:   Wed, 20 Mar 2019 14:36:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft4YPmqd35ySmZw2UG876Lvt8rcz+nNwELXK98PDvHuVeA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 20/03/19 1:34 AM, Evan Green wrote:
> On Tue, Feb 5, 2019 at 10:59 AM Evan Green <evgreen@chromium.org> wrote:
>>
> ...
>> Evan Green (8):
>>   dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
>>   dt-bindings: phy-qcom-qmp: Add UFS PHY reset
>>   dt-bindings: phy: qcom-ufs: Add resets property
>>   arm64: dts: sdm845: Add UFS PHY reset
>>   arm64: dts: msm8996: Add UFS PHY reset controller
>>   scsi: ufs: qcom: Expose the reset controller for PHY
>>   phy: qcom: Utilize UFS reset controller
>>   phy: ufs-qcom: Refactor all init steps into phy_poweron
>>
>>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   6 +-
>>  .../devicetree/bindings/ufs/ufs-qcom.txt      |   5 +-
>>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |   3 +
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |   4 +-
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   3 +
>>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 117 +++++++++---------
>>  drivers/phy/qualcomm/phy-qcom-ufs-i.h         |   5 +-
>>  drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c  |  25 +---
>>  drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c  |  25 +---
>>  drivers/phy/qualcomm/phy-qcom-ufs.c           |  57 +++++++--
>>  drivers/scsi/ufs/Kconfig                      |   1 +
>>  drivers/scsi/ufs/ufs-qcom.c                   | 114 ++++++++++-------
>>  drivers/scsi/ufs/ufs-qcom.h                   |   4 +
>>  13 files changed, 202 insertions(+), 167 deletions(-)
>>
>> --
> 
> Hi Kishon,
> A gentle ping here now that rc1 is out. Are you able to take these? I
> can also repost if needed.

Can you repost with the updated tags please?

Thanks
Kishon
