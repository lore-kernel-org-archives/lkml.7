Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BFFC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ABC206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq2RBP4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbfIPTMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:12:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45201 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfIPTMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:12:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so805786lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZDcXHRTBF3B1tu0KIfFb9BX/IeADYbXe8JqiLYtLTY=;
        b=Zq2RBP4guwXTDsPSCgjkxGMPZwzEbeM315wcks370+oWG0TGoSdstFNQqCBtqHHG+m
         QXjM0+IYQ2FYIPECEuKtHpvPxxk4n2/bDdmuKVRhAnZHQYTrGzsFQv668YkjpZ4qO23Z
         VGZXOA6oO6B07kq6d1Lj/i3K/sdrKMg5kNSpGcQtUvoB+cuOvgLi5sKB2Pa8gxAlzmSu
         dXiHWheM/M8r7pV9z2XrJ8f3125oPObwCjlpGtDSR2FPe7GLkElLRuzPUtC+M+zZ8W+Y
         /enHK5sJnDVtURjhNZ+6mW53cx61tWtBaIrhrIz62FU8CVTxyOBNbPQ1RdDwJQw2UXj+
         G2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZDcXHRTBF3B1tu0KIfFb9BX/IeADYbXe8JqiLYtLTY=;
        b=f3XfZMkcKHu+4eu/KM6Tn+6vBnlgSLwsi41nYqko0yvW18FFjcSmAsdESFVilyVl1A
         y2ArusTNvl4N/VzKKfSOpayMjzVWI22vmf63r9Yd8kHjNanYlFZPZ0cA84zyopjmVBzI
         jPaUPJcj3RK5F5aEx2uefvuCI/NSuAKm5uEitHQXbHU1t/ize4KtGFNfkKw8AVfzOiFA
         /2vHK1p9L/41ldTmXFAAgynqZYqGWLo5XvHPzF6HJRUdmI9AZYdc8h2NXtaCirYyD5qs
         P9Jmdu/sWphDCg2Ns2mh51Jd/UPo/FNy4+IpANqkyHWNSUaZ4VeB0XD2uUeRxND76lQO
         n+TA==
X-Gm-Message-State: APjAAAVqUXN47yabVRbqThgdxq1aTB10KMIAsu3rTtTzSVZfkPBq/4v1
        F/jxMgWl0wsIeeUUITulGDY=
X-Google-Smtp-Source: APXvYqzPs3LikHvR6KJNgOvNCIK1XPbE9fQZy/HmzWPNiDYadnkJBrlk67/AUrQt00DFAnYq/Ndoyw==
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr518488lfn.52.1568661135046;
        Mon, 16 Sep 2019 12:12:15 -0700 (PDT)
Received: from localhost.localdomain ([46.216.138.44])
        by smtp.gmail.com with ESMTPSA id z26sm1988306ljz.62.2019.09.16.12.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:12:14 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1i9wQ2-0006dn-9C; Mon, 16 Sep 2019 22:12:14 +0300
Date:   Mon, 16 Sep 2019 22:12:14 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] extcon-intel-cht-wc: Don't reset USB data connection at
 probe
Message-ID: <20190916191214.GA17481@jeknote.loshitsa1.net>
References: <20190808220129.2737-1-jekhor@gmail.com>
 <fbe20a5f-0f64-cadf-2c1e-88a468d54a07@redhat.com>
 <20190809151116.GD30248@jeknote.loshitsa1.net>
 <492098ce-ec4c-a860-4625-27c410d7deb3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492098ce-ec4c-a860-4625-27c410d7deb3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 07:18:45PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09-08-19 17:11, Yauhen Kharuzhy wrote:
> > On Fri, Aug 09, 2019 at 01:06:01PM +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 8/9/19 12:01 AM, Yauhen Kharuzhy wrote:
> > > > Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> > > > PMIC at driver probing for further charger detection. This causes reset of
> > > > USB data sessions and removing all devices from bus. If system was
> > > > booted from Live CD or USB dongle, this makes system unusable.
> > > > 
> > > > Check if USB ID pin is floating and re-route data lines in this case
> > > > only, don't touch otherwise.
> > > > 
> > > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > > > ---
> > > >    drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
> > > >    1 file changed, 14 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> > > > index 9d32150e68db..3ae573e93e6e 100644
> > > > --- a/drivers/extcon/extcon-intel-cht-wc.c
> > > > +++ b/drivers/extcon/extcon-intel-cht-wc.c
> > > > @@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
> > > >    	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> > > >    	struct cht_wc_extcon_data *ext;
> > > >    	unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
> > > > +	int pwrsrc_sts, id;
> > > >    	int irq, ret;
> > > >    	irq = platform_get_irq(pdev, 0);
> > > > @@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
> > > >    		goto disable_sw_control;
> > > >    	}
> > > > -	/* Route D+ and D- to PMIC for initial charger detection */
> > > > -	cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> > > > +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> > > > +	if (ret) {
> > > > +		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> > > > +		goto disable_sw_control;
> > > > +	}
> > > > +
> > > > +	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
> > > > +
> > > > +	/* If no USB host or device connected, route D+ and D- to PMIC for
> > > > +	 * initial charger detection
> > > > +	 */
> > > > +	if (id == INTEL_USB_ID_FLOAT)
> > > > +		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> > > 
> > > The check here should be != INTEL_USB_ID_GND, when we are connected as
> > > device we are charging from the host we are connected to and the port
> > > we are connected to may be a CDP (charging downstream port) instead of
> > > a SDP (standard downstream port) allowing us to charge at 1.5A instead
> > > of 0.5A, also != INTEL_USB_ID_GND matches the condition used in
> > > cht_wc_extcon_pwrsrc_event to determine if we should continue with
> > > charger detection there.
> > 
> > Actually it should be checked as ((id != INTEL_USB_ID_GND) && (id !=
> > INTEL_USB_RID_A)), to not interrupt connection if ACA used and our host
> > is OTG A device (for example, if LiveCD boots from USB flash inserted
> > into an ACA USB hub).
> 
> Right, except that cht_wc_extcon_get_id never returns INTEL_USB_RID_A,
> so checking for that would be superfluous and also would be inconsistent
> with what cht_wc_extcon_pwrsrc_event is doing, so for now please just test
> for != INTEL_USB_ID_GND, if cht_wc_extcon_get_id ever starts supporting
> RID_A then we should fix both cht_wc_extcon_pwrsrc_event and you new check
> at that time.
> 
> Hmm, I now see that cht_wc_extcon_get_id currently only reports one of:
> INTEL_USB_ID_GND or INTEL_USB_ID_FLOAT so == INTEL_USB_ID_FLOAT is
> equivalent to != INTEL_USB_ID_GND still please check for 1= INTEL_USB_ID_GND
> as that is what cht_wc_extcon_pwrsrc_event is doing.
> 
> > > Like your other patch I will try to give this one a  test-run tomorrow.
> 
> I've given this patch a test-run today and I can confirm that BC1.2 charger
> detection still works fine on my device using this driver.

OK.


-- 
Yauhen Kharuzhy
