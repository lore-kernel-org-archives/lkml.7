Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E000EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91472085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLYB71So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfFQNXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:23:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34844 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFQNXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:23:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so9109121wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MCk0UOttsjHTOmjWH/1wGCIVEMWTEE7JSr9eSJt8E6U=;
        b=bLYB71SoakdZWD0bbECjOZJpTdloiPafIY+LfUEJDGwY71oMCbzPqrfRdvuCruNWE2
         Z+qz9f9vsaeBGq/9asrdH8Mbm5YhHQgJTCIuHyw354P4+ZrZ/6dFrkwbFECyXZxQ1Qlz
         gth04rJNMbeXq3hzKkApLHYFKVjT6rW7WUaHWECkpti41bOC/FFL2Ce0zBEd5+qFBQaE
         DkxDjumSNL1g1YJWqj5O+dUQ0d/aheJuKd6dTCgdgqZopQzAKfh+mkYcY9tdItS8wXiA
         +KXAT4cV1mdqlwVJqq0b7RBPDVpQOtorkV1Wq/5Rw++d3HSWAaDPaUlkG8eOHiMz3G7m
         rmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MCk0UOttsjHTOmjWH/1wGCIVEMWTEE7JSr9eSJt8E6U=;
        b=KB9iQH6IVhKlgI0F4qA8kSpKOuU73V04tdzcnG8Akb1hLQtZUHFJ49VwaotqJ/lXl/
         k8kWdv0K87R/Ehl8KT65SWEE7oCUIzG5kSk+/awX1dChrtMHETMTAuCPfrVvkovDNaEX
         v+nUO4JAuRRxHWgbzBqCN7+bAbAIqSBMXktLppAWnNnKSDBWY0lgxvQBR+nG+pDalOrx
         xLAj8GHo1HjxPi+hopqKQ1yIOjmi+CMATlJN/cM2Xyl8lA7++vcdj0I5M51dnaEPdk1L
         GGaHcyLUxML+TEVFuSBcDR9EuZLwHbnvtVkuGTkmLs66QMg444wyF41Gpok3KdUa2Y5+
         GL/A==
X-Gm-Message-State: APjAAAXJd8GVdES4IjLobf7b+mlG8KokXfdGfHr49UDAukmv+2xmFYH3
        Xz1/N0k9GKIpkgogYYedg4sgtQ==
X-Google-Smtp-Source: APXvYqyrzflhrnZXLI/k9VPq8CsskPBB/8KzjstR9LOm9dfd2dHTNp7j6C7TFEfXsWqkUzxuqmhaQA==
X-Received: by 2002:a1c:be12:: with SMTP id o18mr443929wmf.21.1560777831804;
        Mon, 17 Jun 2019 06:23:51 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id u25sm9662835wmc.3.2019.06.17.06.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 06:23:51 -0700 (PDT)
Date:   Mon, 17 Jun 2019 14:23:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v4 0/4] I2C: DWC3 USB: Add support for ACPI based
 AArch64 Laptops
Message-ID: <20190617132349.GI16364@dell>
References: <20190617125105.6186-1-lee.jones@linaro.org>
 <87lfy0gym0.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfy0gym0.fsf@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Felipe Balbi wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > This patch-set ensures the kernel is bootable on the newly released
> > AArch64 based Laptops using ACPI configuration tables.  The Pinctrl
> > changes have been accepted, leaving only I2C (keyboard, touchpad,
> > touchscreen, fingerprint, etc, HID device) and USB (root filesystem,
> > camera, networking, etc) enablement.
> >
> > RESEND: Stripped I2C patches as they have also been merged into
> >         their respective subsystem.
> >
> > v4:
> >  * Collecting Acks
> >  * Adding Andy Gross' new email
> >  * Removing applied Pinctrl patches
> >
> > Lee Jones (4):
> >   soc: qcom: geni: Add support for ACPI
> >   usb: dwc3: qcom: Add support for booting with ACPI
> >   usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
> >   usb: dwc3: qcom: Improve error handling
> 
> pushed to testing/next

Sounds promising, thanks Felipe.

OOI, what is your process?

How does do the patches typically sit in there?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
