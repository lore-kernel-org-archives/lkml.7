Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC7C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C02521743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQjxFU27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436577AbfHIPKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:10:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38566 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407113AbfHIPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:10:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so1878608wmm.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1SCXONo5RSxYf+M0mznaIJzWwu01kq1qQRbENDqYVOw=;
        b=eQjxFU27gMI9sxVdj+dQ47Cwte8cJCDhsAadJuMfcQHBGs7NS6FKfJkmWnl+WmVnWX
         KKsJOsNzgs8Gnk8w/W7P3fqj6TN9MOmaXaRuzs88Iwsr8CQKXkvrVdnz2HKG4779GRDE
         YI+sklrXGP768jN64jfOJEhmgmni038fkeC5V69HkuItQTaSKZGvEV8I/FJ5FR6ibsdf
         1mF/JAaHKHRN3+bbVc/wEBhIC3lMGxRVaKoZUEPglhoLJOnKURJldsuNotse36qUSJRy
         IA9qXxoeVaWhM8nls/xv8CPDPAQba3G+X1dmpXzArVW/Gxf3YFRrUt/HvLW0sEnOsdZ0
         I3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1SCXONo5RSxYf+M0mznaIJzWwu01kq1qQRbENDqYVOw=;
        b=ETRWnZtVKk25WlSrsuiM+vdMG9E9mutUmL3RBEMc+1Txj6h00HN12UxV537vdUCSVm
         4+gP2tMkKB3P78R+VRdP61mWShLF42wHHJ82JvRDAF6s+CyflPPkAMvocQCU4Mo94iG1
         sFpHxIfrhLVZMCx8PiK3vuVrgQs7lvhxcBVZZyG8qvVED/L+fxZG1QxUamz2IHBEgsL+
         Z2y0d7GB6EGjranygqG4fw4dvIfmhi/hejV03LEAc1KYCvtFeW2Wu4xsDFY/qnczfZNl
         1fVc8qP/fGZVlNBRAnxFI54PGi/v8xHA4sIBC7liTOFdejc9rlby+NAtm2j1po2X7HQL
         ILZg==
X-Gm-Message-State: APjAAAWdJUn7bi6SwRWnS4LOc/F2KAgtdweB71Dp4Lse63rQfG6/yAJj
        E2vq3Kx970/bInAQbOibFDw=
X-Google-Smtp-Source: APXvYqzaXHMDRWQM2+Hm7PNs/Vp6DGlbGR7KaIvJDloxk2LN/OM0Ln0sa+Umw56blQWyeQHw7V2LeA==
X-Received: by 2002:a7b:cd0c:: with SMTP id f12mr11517438wmj.128.1565363401542;
        Fri, 09 Aug 2019 08:10:01 -0700 (PDT)
Received: from localhost.localdomain ([80.249.82.181])
        by smtp.gmail.com with ESMTPSA id z1sm99119896wrp.51.2019.08.09.08.10.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 08:10:00 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92)
        (envelope-from <jekhor@gmail.com>)
        id 1hw6Y0-0002xT-9c; Fri, 09 Aug 2019 18:11:16 +0300
Date:   Fri, 9 Aug 2019 18:11:16 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] extcon-intel-cht-wc: Don't reset USB data connection at
 probe
Message-ID: <20190809151116.GD30248@jeknote.loshitsa1.net>
References: <20190808220129.2737-1-jekhor@gmail.com>
 <fbe20a5f-0f64-cadf-2c1e-88a468d54a07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe20a5f-0f64-cadf-2c1e-88a468d54a07@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:06:01PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/9/19 12:01 AM, Yauhen Kharuzhy wrote:
> > Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> > PMIC at driver probing for further charger detection. This causes reset of
> > USB data sessions and removing all devices from bus. If system was
> > booted from Live CD or USB dongle, this makes system unusable.
> > 
> > Check if USB ID pin is floating and re-route data lines in this case
> > only, don't touch otherwise.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >   drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> > index 9d32150e68db..3ae573e93e6e 100644
> > --- a/drivers/extcon/extcon-intel-cht-wc.c
> > +++ b/drivers/extcon/extcon-intel-cht-wc.c
> > @@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
> >   	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> >   	struct cht_wc_extcon_data *ext;
> >   	unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
> > +	int pwrsrc_sts, id;
> >   	int irq, ret;
> >   	irq = platform_get_irq(pdev, 0);
> > @@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
> >   		goto disable_sw_control;
> >   	}
> > -	/* Route D+ and D- to PMIC for initial charger detection */
> > -	cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> > +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> > +	if (ret) {
> > +		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> > +		goto disable_sw_control;
> > +	}
> > +
> > +	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
> > +
> > +	/* If no USB host or device connected, route D+ and D- to PMIC for
> > +	 * initial charger detection
> > +	 */
> > +	if (id == INTEL_USB_ID_FLOAT)
> > +		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> 
> The check here should be != INTEL_USB_ID_GND, when we are connected as
> device we are charging from the host we are connected to and the port
> we are connected to may be a CDP (charging downstream port) instead of
> a SDP (standard downstream port) allowing us to charge at 1.5A instead
> of 0.5A, also != INTEL_USB_ID_GND matches the condition used in
> cht_wc_extcon_pwrsrc_event to determine if we should continue with
> charger detection there.

Actually it should be checked as ((id != INTEL_USB_ID_GND) && (id !=
INTEL_USB_RID_A)), to not interrupt connection if ACA used and our host
is OTG A device (for example, if LiveCD boots from USB flash inserted
into an ACA USB hub).

> 
> Like your other patch I will try to give this one a  test-run tomorrow.
> 
> Regards,
> 
> Hans
> 
> 
> >   	/* Get initial state */
> >   	cht_wc_extcon_pwrsrc_event(ext);
> > 

-- 
Yauhen Kharuzhy
