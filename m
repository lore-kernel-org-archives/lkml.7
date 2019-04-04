Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332E8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005E32075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nptu9/ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfDDING (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:13:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36512 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:13:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so971857pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4cCuwfvSobbo8jFihzQgZV5fXOqx94RX1+2ZmLbzWrw=;
        b=Nptu9/ednT89PkC9YhnmCNC5792Vol86cEOGR5CEovzFr8mYEhG1p2FBOR/mrVvx1p
         M3r5U4xnYAca6jMbKoZgsniZBKREScviNREm/NXYMTrT/XuFdqFbtGRY8YWA1Mq3SZNo
         im6yc7K8YsSgfW9r+d5nsIBG4+yxyW4VvdwvecfFav527UfPMS5I95iemRKXyD977MUC
         MiP5ulTve0Dw1MLkz3ShmOuC+ygUfW3fEHPAUhcc0EvPSEnreFDdnVx/MMFT2UgUhXAT
         fu7vZ73XVfxDifMlsJCm5k1/ZaymsKy5Gc/SoGV+yab5ubBBVN3+QCqTe9wAUdHXG5Mt
         HsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4cCuwfvSobbo8jFihzQgZV5fXOqx94RX1+2ZmLbzWrw=;
        b=sLsdP19HqVqWvoGUH7ADKSpwGGJXuBs9aN4F95VNtAxAnczAma51mZtvkE+kDQf1RZ
         q5DyHNR5+HHffBIQATBrC0hXkoNhNUYllavAGQCWogZVaxnFHVxcOtbHZrk2tZnNVMZH
         ypBgg8ZFqu+d1TDN3NHA5+rx5MQncFbgW+GDwuTn03V8/7Vj7GPPypFq4nXcTTQIe+v4
         FRrNVzVSoHJCMZG3nLOqTJ+TrEFMJ454RIkEy2IadiFejaDBQWo1E2wHhKtqe+ibb0uk
         hKR276cLytWm7bdPjAPTcQ5dbGiOiFu439aO14VtsJjEfc/As5dZEVf2TLgHLF0AHKkB
         ZcsA==
X-Gm-Message-State: APjAAAV8cOX1m0nhYmdZw3sPIXk5uv/sK4H+Hg1KAntFuxlJlMnpde7E
        cgQnnI/eA4oWaeQuKUVXjjEwWA==
X-Google-Smtp-Source: APXvYqxtL54GCuAVO2e7XnkjzpBMSD4vP/0Lo2F2zlVe0dzWSJ2a+0kDIW6qFROs8dj1lEtAyAKhTg==
X-Received: by 2002:a63:6786:: with SMTP id b128mr4520619pgc.318.1554365584860;
        Thu, 04 Apr 2019 01:13:04 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id x16sm31829291pge.27.2019.04.04.01.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:13:03 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:12:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        jflat@chromium.org, kernel@collabora.com, bleung@chromium.org,
        groeck@chromium.org, rajatja@google.com, dtor@chromium.org
Subject: Re: [PATCH v2 2/2] mfd: cros_ec: Instantiate the CrOS USB PD logger
 driver
Message-ID: <20190404081258.GL6830@dell>
References: <20190403140529.23103-1-enric.balletbo@collabora.com>
 <20190403140529.23103-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403140529.23103-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Enric Balletbo i Serra wrote:

> Add the cros-usbpd-logger driver for logging event data for the USB PD
> charger available in the Embedded Controller on ChromeOS systems. The
> logging feature is logically separate functionality from charge manager,
> hence is instantiated as a different driver.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Lee, this is send as separate patch because touches the MFD subsystem,
> apart from that the driver won't be instantiated if [1/2] is not
> merged, which I think is not a problem, it is safe for both go through
> their subsystem separately.
> 
> Thanks,
>  Enric
> 
> Changes in v2: None
> 
>  drivers/mfd/cros_ec_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
