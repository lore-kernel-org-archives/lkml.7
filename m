Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0108DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A82206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oh/esi66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfIQNZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:25:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41227 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfIQNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:25:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so2858598lfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tP2lT2QmrTfyTwJ+WeCbyc84EFThGvD85gc1OLsjwfw=;
        b=oh/esi66/oFsk16IV0kL1n/tjLLu7hdM7amjGH9dakFYbhfyW7fwOCCxDm+JOnUnyC
         vFzqoeCkaPrwncg46vH7RvLRp9tLDg0yHbF5hG+2GrLJ1r4cGQ7ADU9yWPaIIcU4mRvG
         zgZAd70ZtPYsLvuDXy54iEY8x7oXlHwDal50mih5PAji1HbQt0JMgZ9QfbHJOyUB860F
         Z9OBEu/61fr/T4WmY2hyqUCL2z9FjqZxdcLO8ZJ+Z527bcHNJUbRcWrZrHlw3vwZCUCr
         ikIBmWbW/gkOaw5Hb+9W9KffLohUmmdE/Rkm4nWiyn9HRdsm7xgq8L1fU1lMKk/Ona4a
         TrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tP2lT2QmrTfyTwJ+WeCbyc84EFThGvD85gc1OLsjwfw=;
        b=eWr2Tjvu8W1+zE6XRkIk6PIDThtt6VNg2F3kBB7rnGm1ngHgv2MQpDyppzX1ljCe4p
         Ff/HGMc0GoZPHGxbhY93BniNiJXELG1FELiV68tJETpcO+QBoSMCB+I3SpK0ZB3oeqic
         S+/9IqGWSa2XirtExWBFhTceOZfXkmt1Abl3stsTq0xGKsqldQb4h6zU2XIKwIzU4rXm
         Nm2ecXf1FNwEKtJl7BovIha1xEoXf2zCUhMhSHZkUUE4t5Lpl7gr+DtDVL2dlyEj3v79
         A79sEHV7+GHuxHJasf2YTdK1aVLQwGPnRrXRFMjQxuduoQDH3Rlt46qBZ46qgUR5ozgM
         g4rA==
X-Gm-Message-State: APjAAAUjybmvE2LzOZsaH7Mpz4LSTfeXQOAo/r5cxikI07MI9VKXA5gp
        u+U9SfaPS+VZAtHOuS3JpsvW+qI+
X-Google-Smtp-Source: APXvYqxxAQvsRNXHxlULuuanw+TEqWRFA6MKvrdX5lMSXzCd+SynD6WhnD+75cgAbV7j7f2iuL9ufw==
X-Received: by 2002:a19:c80b:: with SMTP id y11mr2240426lff.184.1568726752362;
        Tue, 17 Sep 2019 06:25:52 -0700 (PDT)
Received: from localhost.localdomain (dynamic-vpdn-93-125-15-224.telecom.by. [93.125.15.224])
        by smtp.gmail.com with ESMTPSA id k21sm439617lfm.68.2019.09.17.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 06:25:51 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iADUJ-0001TB-PH; Tue, 17 Sep 2019 16:25:47 +0300
Date:   Tue, 17 Sep 2019 16:25:47 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] extcon-intel-cht-wc: Don't reset USB data connection
 at probe
Message-ID: <20190917132547.GA4226@jeknote.loshitsa1.net>
References: <20190916211536.29646-1-jekhor@gmail.com>
 <20190916211536.29646-2-jekhor@gmail.com>
 <20190917111322.GD2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917111322.GD2680@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:13:22PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 17, 2019 at 12:15:36AM +0300, Yauhen Kharuzhy wrote:
> > Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> > PMIC at driver probing for further charger detection. This causes reset of
> > USB data sessions and removing all devices from bus. If system was
> > booted from Live CD or USB dongle, this makes system unusable.
> > 
> > Check if USB ID pin is floating and re-route data lines in this case
> > only, don't touch otherwise.
> 
> > +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> > +	if (ret) {
> > +		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> > +		goto disable_sw_control;
> > +	}
> > +
> > +	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
> 
> We have second implementation of this. Would it make sense to split to some
> helper?

Do you mean the combination of regmap_read(...CHT_WC_PWRSRC_STS,
&pwrsrc_sts) with cht_wc_extcon_get_id()?

In the cht_wc_extcon_pwrsrc_event() function the pwrsrc_sts is checked
for other bits also, so separation of PWRSRC_STS read and id calculation
to one routine will cause non-clear function calls like as
get_powersrc_and_check_id(..., &powersrc_sts, &id) which is not looks
better than current code duplication. Or we need to spend some time for
refactoring and testing of cht_wc_extcon_pwrsrc_event() code.

> 
> > +	/* If no USB host or device connected, route D+ and D- to PMIC for
> > +	 * initial charger detection
> > +	 */
> 
> I'm not sure it's acceptable style of multi-line comment, but it's up to
> maintainer.
Argh, you are right, I fixed this in local copy but this is not
significant typo.

> 
> > +	if (id != INTEL_USB_ID_GND)
> > +		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> >  
> >  	/* Get initial state */
> >  	cht_wc_extcon_pwrsrc_event(ext);
> > -- 
> > 2.23.0.rc1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Yauhen Kharuzhy
