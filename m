Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F265A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LC2w0Rol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCSSie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:38:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46317 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfCSSid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:38:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id s23so14292961pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ydzzh2vp8qLAp+1aPO8su/zx9revbTEm1ZSk87G2Mwo=;
        b=LC2w0RolgAlPG0Cd5in3X5I8KMVBJUM64CF8HbRVayP52YEdO6KTKKwUvhNNnPyqho
         4Dly0PwzBxf78tadJTfLSG7GiyZPJ1SvpnVqIN4YYw/ei4jeGUcngeFxtg/ZwSeVn4JX
         4axNpZ/9NpVGtIsK7svj2SOvuIt1d0ixSJWWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ydzzh2vp8qLAp+1aPO8su/zx9revbTEm1ZSk87G2Mwo=;
        b=tcH43XyBXWOz8Pw2ckp5/92llKW5bUgwrtb8lwhOI1j7GLwl+INBmqVDiMBNO5r8L7
         JtJv/BUJfOf6nvODphuzYhnGQhctTQubr8Ij5i19lTkAye6anAIjpdnSvHeMogy7zpjJ
         kbTVuE9HRjyKABMSV3C9IXBpGBhhTZa3tnHuhDnLS4QB3lUbMjyHOxREcpvMM7OTfcRa
         GSZGAftEM/GyFDp9sHIZYB2NVh4/v2/BbUSCMAeecZfzeVAkFd3XggAbkpg4R3LVA9xn
         X7QLnNZuZUcLLZesFShdZFeU0rYAJvnlxmr+3/yiYWHTJ4NLmpKegNDcFPHO8D6A+Oqd
         ihng==
X-Gm-Message-State: APjAAAVlZVU6VRDKhRR91RyKNnj2sIBAvGo9Fa5cTSbl5yEr2yv3g3/X
        Lr3f9j6gro05/jPwU4g8HvyTWA==
X-Google-Smtp-Source: APXvYqwdX09re8gQr40yKoR/6PxbNTxqPQNJhTH1ST1l/Dw4nbnZCcCSLLZGbKs6QcTv9fNKbpXj+g==
X-Received: by 2002:a63:f146:: with SMTP id o6mr3550312pgk.360.1553020712829;
        Tue, 19 Mar 2019 11:38:32 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t8sm16189435pgp.5.2019.03.19.11.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 11:38:32 -0700 (PDT)
Subject: Re: [PATCH v6 0/3] Stingray USB PHY driver support
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <7490f894-3c0b-c7cd-5ff0-4eea6ea2c199@broadcom.com>
Date:   Tue, 19 Mar 2019 11:38:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Srinath and Rob - patch series looks good now.

patch series,

Acked-by: Scott Branden <scott.branden@broadcom.com>


On 2019-03-19 2:15 a.m., Srinath Mannam wrote:
> These patches add Stingray USB PHY driver and its corresponding
> DT nodes with documentation.
>
> This patch set is based on Linux-5.0-rc2.
>
> Changes from v5:
>    - Removed redundant address and size cells in DT nodes.
>
> Changes from v4:
>    - Addressed Rob Herring review comments
>       - Removed child nodes and added #phy-cells 1
>       - Added xlate function to get phy using phandle argument.
>
> Changes from v3:
>    - Addressed Rob Herring review comments
>       - Changed compatible strings.
>       - updated driver based on new compatible strings.
>
> Changes from v2:
>    - Addressed Kishon review comments
>    - Updated patchset to Linux-5.0-rc2
>
> Changes from v1:
>    - Addressed Kishon review comments
>    - phy init call return value handle
>    
> Srinath Mannam (3):
>    dt-bindings: phy: Add Stingray USB PHY binding document
>    phy: sr-usb: Add Stingray USB PHY driver
>    arm64: dts: Add USB DT nodes for Stingray SoC
>
>   .../bindings/phy/brcm,stingray-usb-phy.txt         |  32 ++
>   .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  72 ++++
>   .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
>   drivers/phy/broadcom/Kconfig                       |  11 +
>   drivers/phy/broadcom/Makefile                      |   1 +
>   drivers/phy/broadcom/phy-bcm-sr-usb.c              | 393 +++++++++++++++++++++
>   6 files changed, 510 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
>   create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
>   create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
>
