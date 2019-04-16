Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A35BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6395E20684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P3bkwBWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDPDJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:09:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35183 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDPDJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:09:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so1869400lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSjBVyf8Zp+fJz/zVE705Jl6SJOT1Oqdk3OGjACDNKU=;
        b=P3bkwBWdDdNFZfYcOiHGS5iJ38T+iuqU78LPk+8iLuaAFF6YeAo1xXi4hS8E3++dXE
         IlQ7sbhc99dAMINLHW62aknEAKOLhHbxvISdwSX91sevCBIpZwS7UUEH0SlYMtOL03Xa
         L0gZ7dzmMppTisaamHPScVk4yb8xgGNH/P8y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSjBVyf8Zp+fJz/zVE705Jl6SJOT1Oqdk3OGjACDNKU=;
        b=Dd1iiGjkQI4nGBeGwMI85JninNdHhR0pVA4do6NCyobYcUs8VeRqfYyRMrw6kH3mw4
         W/lnTb5pzXcWr4eEeewvSnqvBHSs08xDXs9bZ0g/x5Dou0b1ECLQBa5jnYufOyiEnl5B
         jiTCJMMYmQbJIdlo5WoWC31HRJivcqJY2PAKLvZt+anqE5Meyect/vTmWRUMi8nVe9KQ
         q97Wd1fbWI3csud66YIfj9Ktnu11xHoqEdSBBFGtF1hJsY0y5WPnLrg6Q8r0e95wIv0+
         XpdmfA6SBEhAMQg5Tcs9tIfSqFRgHTJ8WzGAEjzza0t1FnMVZte7yDdGQi7SY8qEalk5
         83lA==
X-Gm-Message-State: APjAAAWvwHj04UgvuAQtxwAvjmeGs5Of6cT29y5gJV//wic6ZHk3nt5f
        gd97IqI/ge+y9ZFjnLtAF+SJ4csAzEI=
X-Google-Smtp-Source: APXvYqzE4YyvuurZAOWwY7BACNu3eHvyhRoPfYTflx0ZQj6B2fJJkA6DgwSebFMbl7gsKb6gDF9fyw==
X-Received: by 2002:a19:cc52:: with SMTP id c79mr15980180lfg.30.1555384169549;
        Mon, 15 Apr 2019 20:09:29 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id c17sm3098927lfm.42.2019.04.15.20.09.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:09:28 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id f23so17684303ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:09:28 -0700 (PDT)
X-Received: by 2002:a2e:8888:: with SMTP id k8mr41921007lji.43.1555384168283;
 Mon, 15 Apr 2019 20:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190409151100.16027-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190409151100.16027-1-andriy.shevchenko@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 16 Apr 2019 11:08:51 +0800
X-Gmail-Original-Message-ID: <CAE=gft7VK=7gV3PV1QdjRPOccEYmL-341fUNX+wXGUfrvzUDfw@mail.gmail.com>
Message-ID: <CAE=gft7VK=7gV3PV1QdjRPOccEYmL-341fUNX+wXGUfrvzUDfw@mail.gmail.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Comet Lake PCI IDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Intel Comet Lake has the same LPSS than Intel Cannon Lake.
> Add the new IDs to the list of supported devices.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index a67f67c90ec4..50a907f93da9 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -129,6 +129,19 @@ static const struct intel_lpss_platform_info cnl_i2c_info = {
>  };
>
>  static const struct pci_device_id intel_lpss_pci_ids[] = {
> +       /* CML */
> +       { PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
> +       { PCI_VDEVICE(INTEL, 0x02a9), (kernel_ulong_t)&spt_uart_info },
> +       { PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&spt_info },
> +       { PCI_VDEVICE(INTEL, 0x02ab), (kernel_ulong_t)&spt_info },
> +       { PCI_VDEVICE(INTEL, 0x02c5), (kernel_ulong_t)&bxt_i2c_info },
> +       { PCI_VDEVICE(INTEL, 0x02c6), (kernel_ulong_t)&bxt_i2c_info },

How come it's not cnl_i2c_info?
