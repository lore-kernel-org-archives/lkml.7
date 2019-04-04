Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699C9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35ABD20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAT/eN5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfDDIGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:06:39 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53372 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDIGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:06:38 -0400
Received: by mail-it1-f196.google.com with SMTP id y204so2347642itf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=shJdvdGb88860d31wYHMujcMhegndt2m1bOdjIXO+xc=;
        b=CAT/eN5GQvaUHT/B2oGu2uy902nw2xGiQS04eueuNNfsLLiZ2sZrq1djYQUxHf2ud/
         n4+1n183QmzwuTPCPClOc+3NaDZIGu3NXptqhAeWzIfBCO4KxPmkBN7QdpGxr02T7WrS
         5q5MxVvuAl8Hm1ON1Npt1S9VcGhvzKXMtlWpIe24EHTKYIYYcuGISN43xxMMhRiM9tmk
         TIk2vubJ5B2kxfOOK+yASqUse32MZmoGeqyeS25U8XCv1D+SQIZI85Q6aWOrDxm0MjB4
         xDf4yd/TjtKrulVw5KQ9WvR7RsC3GO5GQH/tEXLTJb3SlTvGxCp9FKYPkw6wHaP1wIcj
         DsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=shJdvdGb88860d31wYHMujcMhegndt2m1bOdjIXO+xc=;
        b=jUSpx6MpY4YKBrNds4UiJVbeM9WtROnVyF6Iw4KapXUR2AM+vKQc2n6EWKVxCtL4ML
         7K89xF3BgF1iRZt7RyFL/vJGuXsWK7vGS6LIf4gMTI1cKgOvdQ2FvmvWLxIn8odlDdMD
         oNx537ulDFSa3Kfg9lMMxnhi/IeVgrE3Fi5ejBWx4YxiYs98dEBLdhHo3ITlS9/Djod6
         2KTg7glgPmITWmaxB6oK5YQSJKOrw4mIxtKKqozLKX+qgL37cOFjqRgAajqsbGf0i3TK
         PdvLq6YhfrtNg+NCzvag8Q/DZ5sJvzwksBZiJX+jtZnrPohG7AIuOqX2hU9lC0QB0VFt
         iEyw==
X-Gm-Message-State: APjAAAW/+kBe6r0aG7ieNswEQH4I5ZraI7OuJNP115Vx9piMTaxEipR3
        ltEqekSNK1qeW9Bg1cjmLiy2hw==
X-Google-Smtp-Source: APXvYqxnNjN8K03nxu262Y9rYxDVOZyo44d73RJ8HFDjE227lUwvptExYSziV+j6FXd2h9oXxm68Mw==
X-Received: by 2002:a02:1cc1:: with SMTP id c184mr3629232jac.97.1554365197844;
        Thu, 04 Apr 2019 01:06:37 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u19sm8172086iol.16.2019.04.04.01.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:06:36 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:06:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190404080623.GJ6830@dell>
References: <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
 <20190403112559.GP11301@dell>
 <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
 <20190404025234.GB6830@dell>
 <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
 <20190404065452.GD6830@dell>
 <20190404072449.GE3493@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404072449.GE3493@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > ROHM. Also, I am not terribly excited about the option of changing this
> > > back to function-pointer as I already removed the pointer from parent
> > > data and this changed parent data is already adapted to all sub drivers
> > > - so this is all just babbling. Maybe it is just my huge ego shouting
> > > there - 'I was right, I must have the final say'.
> > 
> > No, a call-back function would be a back-step.
> 
> You are probably right.
> 
> > Ego or no ego, you're wrong. =:-D
> 
> I'd rephrase that as "It's not that I am wrong, but you are right." =)

Works for me.

> > > As a side note, I already did submit v12 with other styling fixes but
> > > which left the WDT function in MFD. If you still see the WDT functions
> > > should be exported from WDT - then please ignore the v12. I'll do v13
> > > at the afternoon (my time, which is only a bit after noon your time I
> > > guess) which will export these functions from WDT. (Well, I had to try
> > > once more :D)
> > 
> > Please keep the WDT code in the WDT driver.  Create a little stub for
> > the cases where the WDT driver is not enabled - job done.
> 
> Yes Sir.

=;-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
