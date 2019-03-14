Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7302CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB3D2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2H61cWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfCNOPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:15:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55781 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfCNOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:15:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so3146968wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h3eflKZ/U+x1paFTsOvszBUjr9EhFpJqq4bYYQGoa+s=;
        b=S2H61cWmmfRm4ITfBMNSrHCrGf/GTJgaOwZ4g/FegA2gYJCkz4zn7pytQvsbNB0IOa
         bLnr7CrxTbu8WqswdvALQ4B7AfEpI2Lz9bqiHTR+6rFxbcplUCZ2VxJHSE9tl1GqxXRn
         aWzVrwpHSuXC+HzCyGglLNGrVCis3g3oxzPQXi1xlrIKIGpt2ml7CTNWdgJS2V2c7BYi
         nTpYDa0ns4NVkhDB9XMU45GH0Zl96MM9ONub0LEDEtadWtd5XFFql1+ylJ3V/xUH9GJe
         0ZYSoLVnfYr5NP1ANn+SNqjhcBxCpW4uGwxsXW2RvFQp02HCNlgXEQ2ufyJ9Riulb3K7
         3dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h3eflKZ/U+x1paFTsOvszBUjr9EhFpJqq4bYYQGoa+s=;
        b=nm0ijkzIlgdLjU4C84ZSAs7E/X1VezEHEJ+TFwB4rybCHg086D5uVG7v/7Q1sUepJP
         3zjCRYnqyZu5PZFy7uso6Dob/xlp+r+3XtiSErNcBIAFOAmVapYtAWucaTv+tGmw8CBF
         +XHLd4rEcoQHeL8ZCMLJcCGnCNESMSTMNz72wSifeauY5CDJNgocnoFPpoYr8cJlQ1Hs
         TESBfqG1Bl4UUezWATP7VXy54PZ5+UstvvKsH4f8RQnXeVdZkX/NQDwGHgIEjVFd5Aj8
         krtf8eyXvllatVfZOJdggxFxIoDTFDyuUoHPJKS+j39BleQdRPDhvNfC9yQasMODPrkX
         H1lA==
X-Gm-Message-State: APjAAAUwFkQHxsQzS8r3YjocJVacdI7ltK07r5CtbnpL7oOoGxWt5lUJ
        VlRq2DSvXk/BAodssIirvhCARQ==
X-Google-Smtp-Source: APXvYqyK0Q6clg15VvUmDjviOAXe+jXX97QGLM+FHc8soM2FhJI3TH7F+eHhxxDxOx0AQSXvjOOMqA==
X-Received: by 2002:a1c:64c1:: with SMTP id y184mr2752559wmb.0.1552572933333;
        Thu, 14 Mar 2019 07:15:33 -0700 (PDT)
Received: from apalos (ppp-94-64-206-130.home.otenet.gr. [94.64.206.130])
        by smtp.gmail.com with ESMTPSA id e12sm17266135wrs.91.2019.03.14.07.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:15:32 -0700 (PDT)
Date:   Thu, 14 Mar 2019 16:15:29 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Christian Neubert <christian.neubert.86@gmail.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Message-ID: <20190314141529.GA5576@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <CAC5LXJf=f2bZLroSXFkGiF2W=1XzAgb_wwtpvZY7O9xv28wbVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5LXJf=f2bZLroSXFkGiF2W=1XzAgb_wwtpvZY7O9xv28wbVA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> Hi,
> 
> the cpu frequency scaling never worked right (only on the 4.4 kernel from
> marvell). If you use the 1000 MHz firmware you are running with just 800
> MHz (this is the case on my board with a current firmware).
>
> Just have a look what the kernel thinks it is running at (frequency).
Ok, probably my bad here. By 'worked fine' i mean that this didn't lead to any 
freezes or panics. I know the actual frequency wasn't set properly

Regards
/Ilias
> 
> Regards,
> Christian
> 
> Ilias Apalodimas <ilias.apalodimas@linaro.org> schrieb am Do., 14. März
> 2019, 14:44:
> 
> > Hello Christian,
> > > Hi,
> > >
> > > I assume you use the 1000 MHz firmware. This does also not work on my
> > Rev 7
> > > board. But I'm pretty sure this is not a problem of the patches, because
> > if
> > > I take a newer kernel (4.19.20/27) without the patches it also does not
> > > work. A kernel 4.19.17 does work for me. My opinion on that is that this
> > is
> > > another problem which does just occure now because now the cpu frequency
> > > scaling is working with the right frequencies.
> > I am not sure which firmware i am running, i did all my tests on 5.0.0 and
> > changing between governors worked fine without the patches
> >
> > Regards
> > /Ilias
> > >
> > > Ilias Apalodimas <ilias.apalodimas@linaro.org> schrieb am Do., 14. März
> > > 2019, 13:15:
> > >
> > > > Hi Gregory,
> > > > > The clock parenting was not setup properly when DVFS was enabled. It
> > was
> > > > > expected that the same clock source was used with and without DVFS
> > which
> > > > > was not the case.
> > > > >
> > > > > This patch fixes this issue, allowing to make the cpufreq support
> > work
> > > > > when the CPU clocks source are not the default ones.
> > > > >
> > > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Reported-by: Christian Neubert <christian.neubert.86@gmail.com>
> > > > > Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > > > > ---
> > > > >  drivers/clk/mvebu/armada-37xx-periph.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/drivers/clk/mvebu/armada-37xx-periph.c
> > > > b/drivers/clk/mvebu/armada-37xx-periph.c
> > > > > index 1f1cff428d78..26ed3c18a239 100644
> > > > > --- a/drivers/clk/mvebu/armada-37xx-periph.c
> > > > > +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> > > > > @@ -671,6 +671,17 @@ static int armada_3700_add_composite_clk(const
> > > > struct clk_periph_data *data,
> > > > >               map = syscon_regmap_lookup_by_compatible(
> > > > >                               "marvell,armada-3700-nb-pm");
> > > > >               pmcpu_clk->nb_pm_base = map;
> > > > > +
> > > > > +             /*
> > > > > +              * Use the same parent when DVFS is enabled that the
> > > > > +              * default parent received at boot time. When this
> > > > > +              * function is called, DVFS is not enabled yet, so we
> > > > > +              * get the default parent and we can set the parent
> > > > > +              * for DVFS.
> > > > > +              */
> > > > > +             if (clk_pm_cpu_set_parent(muxrate_hw,
> > > > > +
> > > >  clk_pm_cpu_get_parent(muxrate_hw)))
> > > > > +                     dev_warn(dev, "Failed to setup default parent
> > > > clock for DVFS\n");
> > > > >       }
> > > > >
> > > > >       *hw = clk_hw_register_composite(dev, data->name,
> > > > data->parent_names,
> > > > > --
> > > > > 2.20.1
> > > > >
> > > > Applied this and selected only
> > > >
> > > > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> > > > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > > > CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> > > >
> > > > After changing the governor from 'powersave' to 'performance' the board
> > > > completely froze (i even lost access to the serial port)
> > > >
> > > > Cheers
> > > > /Ilias
> > > >
> >
