Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E9C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE37E206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgAGSaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:30:21 -0500
Received: from foss.arm.com ([217.140.110.172]:32924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgAGSaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:30:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E226631B;
        Tue,  7 Jan 2020 10:30:19 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EC223F534;
        Tue,  7 Jan 2020 10:30:19 -0800 (PST)
Subject: Re: rk3399 rockchip pcie power domain is saying unsupported
To:     Anand Moon <linux.amoon@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <CANAwSgRXd=w87CKO4WQz7ZRAk+un7ctTPCi5XSa7GfNDhjy0YQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b476f25-e3b9-2aaf-c46f-c28118924120@arm.com>
Date:   Tue, 7 Jan 2020 18:30:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CANAwSgRXd=w87CKO4WQz7ZRAk+un7ctTPCi5XSa7GfNDhjy0YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 6:00 pm, Anand Moon wrote:
> Hi All,
> 
> On my rock960 I want to add power domain feature for pcie node using
> following patch. [0] https://patchwork.kernel.org/patch/9322549/
> I also tried to add some more cru to see below
> but the power domain summary shows unsupported

Doesn't that just mean that the EHCI and PCIe drivers haven't enabled 
RPM (or have explicitly disabled it)?

Robin.

> # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> ...
> pd_sdioaudio                    off-0
>      /devices/platform/fe310000.dwmmc                    suspended
>      /devices/platform/ff8a0000.i2s                      suspended
> pd_perihp                       on
>      /devices/platform/fe380000.usb                      unsupported
>      /devices/platform/fe3c0000.usb                      unsupported
>      /devices/platform/fe3a0000.usb                      suspended
>      /devices/platform/fe3e0000.usb                      suspended
>      /devices/platform/f8000000.pcie                     unsupported
> pd_sd                           on
>      /devices/platform/fe320000.dwmmc                    active
> pd_gmac                         off-0
> ...
> can any one share more inputs.
> ----
> @@ -1049,6 +1056,19 @@
>                                           <&cru SCLK_SDMMC>;
>                                  pm_qos = <&qos_sd>;
>                          };
> +                       pd_perihp@RK3399_PD_PERIHP {
> +                               reg = <RK3399_PD_PERIHP>;
> +                               clocks = <&cru ACLK_PERIHP>,
> +                                        <&cru SCLK_PCIEPHY_REF>,
> +                                        <&cru ACLK_PERF_PCIE>,
> +                                        <&cru ACLK_PCIE>,
> +                                        <&cru PCLK_PCIE>,
> +                                        <&cru SCLK_PCIE_PM>;
> +                               pm_qos = <&qos_perihp>,
> +                                        <&qos_pcie>,
> +                                        <&qos_usb_host0>,
> +                                        <&qos_usb_host1>;
> +                       };
> 
> -Anand
> 
