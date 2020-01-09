Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB15C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208E2206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="G3hIUulK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbgAINvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:51:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37942 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbgAINvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:51:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so7498255wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XDCI6TLpdeIYPij5yOHYCifq+NjQyJfwW4dyJEujviU=;
        b=G3hIUulK4TgEq82wz5GNtf5wS7Mq2sgiYrOa/+OvqMHJJNB+YkDsyumIDlcCCGezFj
         HhXGOIkHJkDvYMuJCmaFP8yZYz5J0m9VCj1xx+9Me5O68XQr8zMuMvFsy7n1V5NfOBAg
         yKDeiHq/64ozhgaPBvsuPgK3un1Cz9HQs2Tl1dcS7eCeC2XIdGcwXpWz+1yAvfQw09vX
         vtKx6J1uFA2d5uG0T9Wr3TFZoFQAPMlNG5WDxJ9tQBnJu1G+Ghd/unu/ESnKGg1BcK2P
         mnhyOGn3lLylsBqzjiUj360YW3DdgotpRceA50aZfwY32TVnatQod9+G/+iR0BX4Vs6u
         tyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XDCI6TLpdeIYPij5yOHYCifq+NjQyJfwW4dyJEujviU=;
        b=NtAkXjxSxUVZ/ontNVSe5c0ZU/3H7buJmNaw0K2lyXvdzB4paM3/fveSe43zGXDgxb
         90+CJsDbNmLXahXdmNMUbcVUkN2nF4YHpi/byIA18izgr9GT7fI6/OAZ1nYmyvMNEueJ
         kiBZOM1yuRiJHiy0VC+JK9CNwSCy93so7EEegQpLoHxJmWLlYtYfWTmO19vIuuGPLrxf
         F5fwrsA6pVknPI6IpeoyrB6cdbzbqJSlcK+R+G2eTVfYsL5vtPLFwPlBmgLQ8GIdSMzG
         WruSpo/pQinJ1uUm4Z8jTIO1YenmJjCN26oIojYvcDVQ5CJkhcDRJ2vI9fzpBIM6HGY1
         10dQ==
X-Gm-Message-State: APjAAAXXAd0C45Zy/wYMxKa9kyDeBs2IRSOKmlc3SqIas9sBllYDblEB
        CoPlAD9YscJFBl7dBcnLQw1Rhb1Op2VWDR79xOm1Ow==
X-Google-Smtp-Source: APXvYqz8e1hxJpaPqVsNsHKM5ImeIdIGCduTba279//zephv/DVYc8tIyk0DE067Xb7xRCg7Bq0x3Ng81eVOKS4awRo=
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr11245464wrr.104.1578577889103;
 Thu, 09 Jan 2020 05:51:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578577147.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1578577147.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Thu, 9 Jan 2020 14:51:18 +0100
Message-ID: <CAHTX3dJDuoXjX4CJJ88Vf_uUWSi7GDMGM5vYmxwNFB+9Sqw7cg@mail.gmail.com>
Subject: Re: [PATCH 0/6] arm64: zynqmp: Various DT fixes
To:     linux-arm <linux-arm-kernel@lists.infradead.org>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 9. 1. 2020 v 14:39 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> Hi,
>
> I am sending various DT fixes which have been found over the xilinx
> release.
> 1-2 patches are fixing reported description issues
> 3-6 patches are actual fixes.
>
> Thanks,
> Michal
>
>
> Michal Simek (5):
>   arm64: zynqmp: Fix address for tca6416_u97 chip on zcu104
>   arm64: zynqmp: Turn comment to gpio-line-names
>   arm64: zynqmp: Setup clock-output-names for si570 chips
>   arm64: zynqmp: Remove broken-cd from zcu100-revC
>   arm64: zynqmp: Setup default number of chipselects for zcu100
>
> Venkatesh Yadav Abbarapu (1):
>   arm64: zynqmp: Fix the si570 clock frequency on zcu111
>
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  3 +-
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 45 +++++--------------
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  4 +-
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  2 +
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  4 +-
>  5 files changed, 20 insertions(+), 38 deletions(-)
>
> --
> 2.24.0
>

Please ignore this patchset. I sent just 6 patches instead of 8 that's
why description here is not correct.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
