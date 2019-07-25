Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B4C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14E022C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nj+0T5bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfGYMGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:06:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42115 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfGYMGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:06:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so584855wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QrZnAj55GJc2DX6oG5oAtaMU4bSEqiLtxAoqbHsBW6U=;
        b=Nj+0T5bs0d2ufZh1I08Rd4bGQokn2WEvSLQX+2AJ7s+UB3f9RiKMpd8q7mXlGJ5Avl
         vFcQwnzFB2vmGE+nstAcIOEevpTqhsk9Ijq0QTEaGjX4iznBhWaW5Vn88nfnaGvrG3cc
         vqvD+TpluBbMnlSomn821rTVwAzQMFwZYdL/wpEjFAtNp0SL4oTPmA9d3tLvEEVPitS+
         Szrr8RjNC78tK/OYj+aYnFmYbADlXqJXX5KXgHIxCa4zEzywuQHW3XBPtXmUwYQ4s7dU
         eIlGXALAJh8y9W2giQe6DTlNpw0TsBnCM4O2ia2fXmuL29Ywnl4zDFzAEbxMuJ1O9gbb
         MCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QrZnAj55GJc2DX6oG5oAtaMU4bSEqiLtxAoqbHsBW6U=;
        b=H9xMlazOboUjR1u06TzYoXRR/7frqNuRQUbQdOep0YFN/r35AUr3Hoj3yvPTVhJ2yT
         IAUYNWmkH6q3Iz9rtXyC01xs+e2NaG6vpH+KblsY1Rw7lV0YOTA+YuotBZ7r3vlWC0YV
         H+HaRT9AMSI849/9k/uHkrLR5JSyh2s6+4iVjrz1nlOAmnMZZbA5waQ6t5f1ZQj/8YPN
         JApnTlujc4GnAlb3BvrSdjT5/kInA3yA92Cz/A/xEenkCgaEmGQQOk2TiLghVU3TmO8N
         1aIftl59wBwM/74LEyoblVSoHUmnLgwct9pVFRl/W+EzHoVxtVZ8p1x1wfAgn7/JRrNq
         xQxg==
X-Gm-Message-State: APjAAAVNPzU59nMrYq+cuLRIm863Zcn/OiU0K1ggZ9mYqt+viQ50MDUQ
        2uy+9nqkF21sBVurY6DPlo7euw==
X-Google-Smtp-Source: APXvYqz5cejIS4t0SsogpN4XZMgzduvjw6mlihzrhym3PGwkVtCxXJ0tVe2LrtC3tMsHhpgVO8oZDw==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr92906851wrs.44.1564056365397;
        Thu, 25 Jul 2019 05:06:05 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id r11sm62286536wre.14.2019.07.25.05.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 05:06:04 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:05:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Remove D3cold delay
Message-ID: <20190725120554.GE23883@dell>
References: <20190705045503.13379-1-kai.heng.feng@canonical.com>
 <20190709114647.GX9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709114647.GX9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jul 2019, Andy Shevchenko wrote:

> On Fri, Jul 05, 2019 at 12:55:03PM +0800, Kai-Heng Feng wrote:
> > Goodix touchpad may drop its first couple input events when
> > i2c-designware-platdrv and intel-lpss it connects to took too long to
> > runtime resume from runtime suspended state.
> > 
> > This issue happens becuase the touchpad has a rather small buffer to
> > store up to 13 input events, so if the host doesn't read those events in
> > time (i.e. runtime resume takes too long), events are dropped from the
> > touchpad's buffer.
> > 
> > The bottleneck is D3cold delay it waits when transitioning from D3cold
> > to D0, hence remove the delay to make the resume faster. I've tested
> > some systems with intel-lpss and haven't seen any regression.
> 
> Thank you for the patch. I took it to our internal testing and will tell
> the result within couple of weeks.

Any news?

> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202683
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/mfd/intel-lpss-pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> > index aed2c0447966..3c271b14e7c6 100644
> > --- a/drivers/mfd/intel-lpss-pci.c
> > +++ b/drivers/mfd/intel-lpss-pci.c
> > @@ -35,6 +35,8 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
> >  	info->mem = &pdev->resource[0];
> >  	info->irq = pdev->irq;
> >  
> > +	pdev->d3cold_delay = 0;
> > +
> >  	/* Probably it is enough to set this for iDMA capable devices only */
> >  	pci_set_master(pdev);
> >  	pci_try_set_mwi(pdev);
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
