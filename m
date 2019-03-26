Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2490F20830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ekF6isRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfCZIRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:17:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38405 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZIRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:17:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so11768883wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8IuhVUU8VN24Bm91m+5yilgjhsBocRkmJfD9yYD4pM=;
        b=ekF6isRR193dz/KHcYnB99op8hgVbP6bhQlZq/jslyKU1FEq8pVpKX4UVtz5tekjKk
         P+JXCVdkB4jOgF1TaSsqfvCOKV4+CNOCiHk1pe7LvT2XZ6VzANqJzQPO7IDyQzYWfocO
         2Ny3mhPNOBJkVcGnWoJVckuYxbU/HhCC/er6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8IuhVUU8VN24Bm91m+5yilgjhsBocRkmJfD9yYD4pM=;
        b=BpU0fVAN9xfug2hiYFVn26ulaj5xpgqbEI+A/eF+fVljPLMOI6thkgHzNOFUBRgS6C
         TgxBpOd7z7M2BvHi0dTXMQsTmsAw/qI9ggk7u7uDbBdoQPqoCiM5mWptiEK9CKSgMnLA
         kNc34HuDIAE8w/LEr8P14iQpT9QFyCcu6wcUFzDlh1vwJmDMNSBlcUbfLXH+ZWaHR3nY
         7dc4XE8dwafqi+b7w2yjZ47XLbgLflwpmBzYFfiUcP5URPGyxpkWks5zqs5FUZjOtp+H
         w1UShlq1c9hgSfmXzCf+uuj5VD3+jEywKGgPCuAoXQKyOD3ul6ev2mOOfJ0BBloD1i6O
         3bGg==
X-Gm-Message-State: APjAAAXewHUuLvh43Ib7ajtcnGZdA7H5zFWG+/NRcj0RHoZsot1aPOxe
        uPQDmhESDkjjIoEad8nDTs8Z4oaKmS0dWbd+glOTlQ==
X-Google-Smtp-Source: APXvYqyQ0wdI5LwX20R1gbruwmMxL2Aylb706Cgc7QpjkI4YFbKf+AQsYi7R9T2BG76Jl1YWZ1bB9ljaaE8nX+b8+CA=
X-Received: by 2002:a1c:c504:: with SMTP id v4mr8518074wmf.45.1553588272721;
 Tue, 26 Mar 2019 01:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
 <7490f894-3c0b-c7cd-5ff0-4eea6ea2c199@broadcom.com> <1f910861-7d3b-63ad-da79-9515eae2b230@gmail.com>
 <90db2ec9-c960-8cf5-c5d3-1e8e85d6ad60@ti.com>
In-Reply-To: <90db2ec9-c960-8cf5-c5d3-1e8e85d6ad60@ti.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 26 Mar 2019 13:47:41 +0530
Message-ID: <CABe79T4zZWA8f3QZzc3xYGQkae-CvXBbMHMN5_b5nDYh86vX3g@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Stingray USB PHY driver support
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 1:00 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
>
> On 22/03/19 10:12 PM, Florian Fainelli wrote:
> > On 3/19/19 11:38 AM, Scott Branden wrote:
> >> Thanks Srinath and Rob - patch series looks good now.
> >>
> >> patch series,
> >>
> >> Acked-by: Scott Branden <scott.branden@broadcom.com>
> >>
> >
> > Kishon, can you let me know when you apply patches 1 and 2 so I can
> > queue up patch 3 for inclusion the 5.2 ARM SoC pull request? Thanks!
>
> merged the dt-binding and sr-usb driver, thanks.

Thanks a lot Kishon.

Regards,
Srinath.
>
> -Kishon
> >
> >>
> >> On 2019-03-19 2:15 a.m., Srinath Mannam wrote:
> >>> These patches add Stingray USB PHY driver and its corresponding
> >>> DT nodes with documentation.
> >>>
> >>> This patch set is based on Linux-5.0-rc2.
> >>>
> >>> Changes from v5:
> >>>    - Removed redundant address and size cells in DT nodes.
> >>>
> >>> Changes from v4:
> >>>    - Addressed Rob Herring review comments
> >>>       - Removed child nodes and added #phy-cells 1
> >>>       - Added xlate function to get phy using phandle argument.
> >>>
> >>> Changes from v3:
> >>>    - Addressed Rob Herring review comments
> >>>       - Changed compatible strings.
> >>>       - updated driver based on new compatible strings.
> >>>
> >>> Changes from v2:
> >>>    - Addressed Kishon review comments
> >>>    - Updated patchset to Linux-5.0-rc2
> >>>
> >>> Changes from v1:
> >>>    - Addressed Kishon review comments
> >>>    - phy init call return value handle
> >>>    Srinath Mannam (3):
> >>>    dt-bindings: phy: Add Stingray USB PHY binding document
> >>>    phy: sr-usb: Add Stingray USB PHY driver
> >>>    arm64: dts: Add USB DT nodes for Stingray SoC
> >>>
> >>>   .../bindings/phy/brcm,stingray-usb-phy.txt         |  32 ++
> >>>   .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  72 ++++
> >>>   .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
> >>>   drivers/phy/broadcom/Kconfig                       |  11 +
> >>>   drivers/phy/broadcom/Makefile                      |   1 +
> >>>   drivers/phy/broadcom/phy-bcm-sr-usb.c              | 393
> >>> +++++++++++++++++++++
> >>>   6 files changed, 510 insertions(+)
> >>>   create mode 100644
> >>> Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> >>>   create mode 100644
> >>> arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
> >>>   create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
> >>>
> >
> >
