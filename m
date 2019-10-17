Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B12FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D1E2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeC7H7ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436640AbfJQNj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:39:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40165 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436619AbfJQNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:39:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so2403657wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGdIYkBoWouhui5JZwa5SxA1USJYrGRfLAGOfC1qQUE=;
        b=EeC7H7ue3oN1wyNo5+y+h/f3QtZwbPbLcR8bvVPiUDCnvQ1Wzzk22Y9y+SWAeu3llf
         RurKgJ3iIuYu/Et+Jldq3rRCJK+O1oCBGPuIoQNEb/bzD4U2PZFn/hwgLd+zF9vXA3Ij
         NYkpxgZCWqu4QiJ5veb+lqQbk0AsCybJARVL08fZusOFmSiHSGhiOnk4yOHRhqDmY3tn
         ZZyKt5J3y+I2fnGBXO+Yca1TaceT4qVU+oy+/27lbS4BQs/tZs2GQzAxgD7jodqHN953
         qu1oLELMNkcdB2ndjb9exvZknfturibZR8zRbaNgoN/iNeuKYk5KavYeyrGElH8K4Ux9
         9B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGdIYkBoWouhui5JZwa5SxA1USJYrGRfLAGOfC1qQUE=;
        b=TJfZZhF5GUHIyUGdTZ5OKVPV+QypwH2bvQu+1rr3Dc4Ll7Zl0JyZdio6fAhPzyem6k
         wja/keeNjv+wAp/aZB7tCzLrFf3vkvDUSSDMLbDhk8Z5ZBGbFfo7b5HSeKuTVwwe+MP8
         uAn5adL4ewIaPctR469/O9B56kly7l0lUaWuiWhVfuJ6epuYbgXghKbsAHdiVMT9VpC1
         K1sSwMFSLK36sY9LnOdWMAHNybyH+6c9SXVh5YhNVoILJVqn9/Of/nrtDIJ1AcQaIf9f
         NELXnLKOto3mNFHJS23OMWmMVAJ40DgnwtbaxBUcSAChNs1U8QW59CwQBOtmWyf9msGY
         XXNA==
X-Gm-Message-State: APjAAAWmn7d2J6zY0zIgm/GwG/aCogrfAxnFex7xGfvAQaVaXsL92lM2
        aS3dUExRDwsdRrzHYGWZD8bUsw==
X-Google-Smtp-Source: APXvYqy4Lrrg4pMfTd+atu6SWJQ7WAc2FDA1OuzXE16c+jlAXvx7iaUxxV+K+zpm0rWL0ddLU3HqQg==
X-Received: by 2002:a5d:4644:: with SMTP id j4mr2365010wrs.355.1571319597038;
        Thu, 17 Oct 2019 06:39:57 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id k8sm777915wrg.15.2019.10.17.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 06:39:55 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:39:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     kgunda@codeaurora.org
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH V7 6/6] backlight: qcom-wled: Add auto string detection
 logic
Message-ID: <20191017133954.7vgqjgwxojmjw446@holly.lan>
References: <1571220826-7740-1-git-send-email-kgunda@codeaurora.org>
 <1571220826-7740-7-git-send-email-kgunda@codeaurora.org>
 <20191017112941.qqvgboyambzw63i3@holly.lan>
 <fa32f7ec727cb2626ad877a6cef32a1b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa32f7ec727cb2626ad877a6cef32a1b@codeaurora.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:47:47PM +0530, kgunda@codeaurora.org wrote:
> On 2019-10-17 16:59, Daniel Thompson wrote:
> > On Wed, Oct 16, 2019 at 03:43:46PM +0530, Kiran Gunda wrote:
> > > The auto string detection algorithm checks if the current WLED
> > > sink configuration is valid. It tries enabling every sink and
> > > checks if the OVP fault is observed. Based on this information
> > > it detects and enables the valid sink configuration.
> > > Auto calibration will be triggered when the OVP fault interrupts
> > > are seen frequently thereby it tries to fix the sink configuration.
> > > 
> > > The auto-detection also kicks in when the connected LED string
> > > of the display-backlight malfunctions (because of damage) and
> > > requires the damaged string to be turned off to prevent the
> > > complete panel and/or board from being damaged.
> > > 
> > > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> > 
> > It's a complex bit of code but I'm OK with it in principle. Everything
> > below is about small details and/or nitpicking.
> > 
> > 
> > > +static void wled_ovp_work(struct work_struct *work)
> > > +{
> > > +	struct wled *wled = container_of(work,
> > > +					 struct wled, ovp_work.work);
> > > +	enable_irq(wled->ovp_irq);
> > > +}
> > > +
> > 
> > A bit of commenting about why we have to wait 10ms before enabling the
> > OVP interrupt would be appreciated.
> > 
> > 
> Sure. Will add the comment in the next series.
> > > +static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
> > > +{
> > > +	struct wled *wled = _wled;
> > > +	int rc;
> > > +	u32 int_sts, fault_sts;
> > > +
> > > +	rc = regmap_read(wled->regmap,
> > > +			 wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS, &int_sts);
> > > +	if (rc < 0) {
> > > +		dev_err(wled->dev, "Error in reading WLED3_INT_RT_STS rc=%d\n",
> > > +			rc);
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> > > +	rc = regmap_read(wled->regmap, wled->ctrl_addr +
> > > +			 WLED3_CTRL_REG_FAULT_STATUS, &fault_sts);
> > > +	if (rc < 0) {
> > > +		dev_err(wled->dev, "Error in reading WLED_FAULT_STATUS rc=%d\n",
> > > +			rc);
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> > > +	if (fault_sts &
> > > +		(WLED3_CTRL_REG_OVP_FAULT_BIT | WLED3_CTRL_REG_ILIM_FAULT_BIT))
> > > +		dev_dbg(wled->dev, "WLED OVP fault detected, int_sts=%x
> > > fault_sts= %x\n",
> > > +			int_sts, fault_sts);
> > > +
> > > +	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
> > > +		mutex_lock(&wled->lock);
> > > +		disable_irq_nosync(wled->ovp_irq);
> > 
> > We're currently running the threaded ISR for this irq. Do we really need
> > to disable it?
> > 
> We need to disable this IRQ, during the auto string detection logic. Because
> in the auto string detection we configure the current sinks one by one and
> check the
> status register for the OVPs and set the right string configuration. We
> enable it later after
> the auto string detection is completed.

This is a threaded oneshot interrupt handler. Why isn't the framework
masking sufficient for you here?


Daniel.
