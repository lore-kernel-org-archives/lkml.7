Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8050BC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593772080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWDuvQB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfFRIIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:08:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfFRIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:08:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so12862937wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7+XK6aLqdHyJuqOe/EfmAFxcldVywlvsw3biHLfZdLw=;
        b=gWDuvQB1k7LXKzanxGhj67D7H2ev4dYzEfTQ9KTyJRTWMdc5WSxApc3f4CP8NDTKhJ
         B8tWsYPT6QZSzZvMPpOMdrqBMgSe5tgrwPeo9jRnINZ/gE8v9sbghFhTtRBHDbVQwkKs
         XGCjKTg6jhxby7RolexfP1MlSuKwvQa1siLhAU4ruK72qWSaXccSv8Jx6TLYTPKQKSmI
         fyLIZ7BpGyAJyNzkYgsfnbkNw2SnmGMhcHIAzg3YQbDGv+gkFVbJrHSD6FOF3VwOnWkU
         ksZhmV+fozc465sMggqlacQxZ5PxwKbkyv1FicFLoqEr3m1UT3BFVTdfwHcBZDS4fx9Z
         djmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7+XK6aLqdHyJuqOe/EfmAFxcldVywlvsw3biHLfZdLw=;
        b=mIxi+P0qmkTGpMiP3IKGPGfnKkuaA6b+HTZCFEz6bzDH14eM9s8NvvVmILNK8lZhMw
         ZgXLkGdEXxFyN1F7IBePM4z4oMvkNma/9EW0Tm+adpFH7HWaMKhD2x+9iTbzEkOJIMJ8
         7/a8scuyhb7a93f+qPiSTwSZh7KH1P9vNajPenN7mPDEO2Wa7aVSmfMZlXiyZG+0Bg7a
         zCaiiZFNo3OoH/+o6fp2Ite/eh7hvT9AMvnaGYywdEKSCDya4aRWMmZpItfkfzVhAJGB
         G8To+5E4iwxS3zLMElLTWbH2ibyEhQj87cgY/T7+EuLjY/+ez6XKSRF4aYVZNj+nuJky
         J+mQ==
X-Gm-Message-State: APjAAAVrrlrhRS1ZETehaAWEjWzvuEe6VkKR0cKlGyiSbjQxGYgJ0thg
        VgEnXnGctOuH8UNWvbtkhl1KOw==
X-Google-Smtp-Source: APXvYqwd2z7gnkyuKgUH4Vl+EJ9hNK/zuX63Cwe+vVbNOvf+uFKnW+PiW9RWY9rA+O5VoFiGEdAh0g==
X-Received: by 2002:adf:dc45:: with SMTP id m5mr12897113wrj.148.1560845311283;
        Tue, 18 Jun 2019 01:08:31 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id u13sm9755253wrq.62.2019.06.18.01.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 01:08:30 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:08:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v4 0/4] I2C: DWC3 USB: Add support for ACPI based
 AArch64 Laptops
Message-ID: <20190618080828.GJ16364@dell>
References: <20190617125105.6186-1-lee.jones@linaro.org>
 <87lfy0gym0.fsf@linux.intel.com>
 <20190617132349.GI16364@dell>
 <87a7efgxw7.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7efgxw7.fsf@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019, Felipe Balbi wrote:
> Lee Jones <lee.jones@linaro.org> writes:
> > On Mon, 17 Jun 2019, Felipe Balbi wrote:
> >
> >> Lee Jones <lee.jones@linaro.org> writes:
> >> 
> >> > This patch-set ensures the kernel is bootable on the newly released
> >> > AArch64 based Laptops using ACPI configuration tables.  The Pinctrl
> >> > changes have been accepted, leaving only I2C (keyboard, touchpad,
> >> > touchscreen, fingerprint, etc, HID device) and USB (root filesystem,
> >> > camera, networking, etc) enablement.
> >> >
> >> > RESEND: Stripped I2C patches as they have also been merged into
> >> >         their respective subsystem.
> >> >
> >> > v4:
> >> >  * Collecting Acks
> >> >  * Adding Andy Gross' new email
> >> >  * Removing applied Pinctrl patches
> >> >
> >> > Lee Jones (4):
> >> >   soc: qcom: geni: Add support for ACPI
> >> >   usb: dwc3: qcom: Add support for booting with ACPI
> >> >   usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
> >> >   usb: dwc3: qcom: Improve error handling
> >> 
> >> pushed to testing/next
> >
> > Sounds promising, thanks Felipe.
> >
> > OOI, what is your process?
> >
> > How does do the patches typically sit in there?
> 
> I'll probably merge to my 'next' branch today. I leave them in
> testing/next for a couple days, usually, so 0-day can run its thing and
> I get a chance of at least boot testing on our machines in the lab here.
> 
> Since this doesn't touch anything "generic", I don't _have_ to boot
> test, so I'll probably merge to 'next' today.

You're a star.  Thanks Felipe.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
