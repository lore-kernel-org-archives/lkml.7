Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E1C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987642184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPmOucFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCNNof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:44:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39371 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCNNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:44:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so2758280wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nAygQuAN2Ep1RjNQH8Rkl+EGXN+NRu9th/af/xku6Hw=;
        b=wPmOucFGhini30TBE5fO8WK3lmlOXRHHp0QmRy7hOh7jvdj/9z5/CGRrwX3QKb1v7g
         u8M1JKIDECHzWNmMu5h43r9onVsmOM7+7b7cLC9Ce1PfS/pbqe7VCXlVuo5a57el9HJF
         SkvXr6aEtSGzPk6kb01bPFhZz0Z/g6pYu1wmYpUI4L0Ri7ydvkDui4KMrhSz+M3vVCMe
         2LAtYNt9Ez5mJa0jW2XJV+usGoiOebW8fyuHPe7VL4GzyggPNhtAdlAuEikCAmlfKQR2
         r/H+hjOBAXAixgkcIrEggVUY7TeEEqophqWE8otxmluxM/dZlqP7a5fQQHuexvVGet1A
         KjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nAygQuAN2Ep1RjNQH8Rkl+EGXN+NRu9th/af/xku6Hw=;
        b=gqUKGM8Du/z6omNHBJw3n9bnQvAsXcKiDpoJjXhZd0b+kBoaTNdvvqEnYWqrWrhuZV
         lENKyR2eN0vi7Bs+/BIo9Y6WXw7+jk8sTb8tbggSTuEmFVktRBi1mlYceYbQ1Cb96GG9
         eJdmXTYEGLrAZuWf+lE3+mQTf3TRvyzyPk4q9YalwZU03zZWLdcFU01CfX1YMR7pybu7
         m5BzVUYuh7tN6auiJJgt2jZDcv74IxUDFhWT1C3rpIE4ywOCz8nyhDg1CA0pzI1eS6Vj
         5nf3Qyskp5rviJSRsxoiRBAgZC6MVWdGs0JC0dz3gpDi6WLoVpyXKUZDkiGlhpPBnePv
         +mVA==
X-Gm-Message-State: APjAAAU0v39+MomP+VtfHC8J4Aed6PYNtjVfjYUbRNpvDhnZE/6p/+rI
        DawuDIM7usHZtl0t+bRjrd71EA==
X-Google-Smtp-Source: APXvYqzTyFinBnIUlxzhh36lZ4klfslF6Yc0OOGn0mwwwCmk43k3j278ceSgykV+h9S1kEgPikMzPw==
X-Received: by 2002:a1c:7ec2:: with SMTP id z185mr2815639wmc.69.1552571072332;
        Thu, 14 Mar 2019 06:44:32 -0700 (PDT)
Received: from apalos (ppp-94-64-206-130.home.otenet.gr. [94.64.206.130])
        by smtp.gmail.com with ESMTPSA id a82sm2427548wmf.11.2019.03.14.06.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 06:44:31 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:44:28 +0200
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
Message-ID: <20190314134428.GA24768@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian,
> Hi,
> 
> I assume you use the 1000 MHz firmware. This does also not work on my Rev 7
> board. But I'm pretty sure this is not a problem of the patches, because if
> I take a newer kernel (4.19.20/27) without the patches it also does not
> work. A kernel 4.19.17 does work for me. My opinion on that is that this is
> another problem which does just occure now because now the cpu frequency
> scaling is working with the right frequencies.
I am not sure which firmware i am running, i did all my tests on 5.0.0 and
changing between governors worked fine without the patches

Regards
/Ilias
> 
> Ilias Apalodimas <ilias.apalodimas@linaro.org> schrieb am Do., 14. März
> 2019, 13:15:
> 
> > Hi Gregory,
> > > The clock parenting was not setup properly when DVFS was enabled. It was
> > > expected that the same clock source was used with and without DVFS which
> > > was not the case.
> > >
> > > This patch fixes this issue, allowing to make the cpufreq support work
> > > when the CPU clocks source are not the default ones.
> > >
> > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: Christian Neubert <christian.neubert.86@gmail.com>
> > > Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > > ---
> > >  drivers/clk/mvebu/armada-37xx-periph.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/clk/mvebu/armada-37xx-periph.c
> > b/drivers/clk/mvebu/armada-37xx-periph.c
> > > index 1f1cff428d78..26ed3c18a239 100644
> > > --- a/drivers/clk/mvebu/armada-37xx-periph.c
> > > +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> > > @@ -671,6 +671,17 @@ static int armada_3700_add_composite_clk(const
> > struct clk_periph_data *data,
> > >               map = syscon_regmap_lookup_by_compatible(
> > >                               "marvell,armada-3700-nb-pm");
> > >               pmcpu_clk->nb_pm_base = map;
> > > +
> > > +             /*
> > > +              * Use the same parent when DVFS is enabled that the
> > > +              * default parent received at boot time. When this
> > > +              * function is called, DVFS is not enabled yet, so we
> > > +              * get the default parent and we can set the parent
> > > +              * for DVFS.
> > > +              */
> > > +             if (clk_pm_cpu_set_parent(muxrate_hw,
> > > +
> >  clk_pm_cpu_get_parent(muxrate_hw)))
> > > +                     dev_warn(dev, "Failed to setup default parent
> > clock for DVFS\n");
> > >       }
> > >
> > >       *hw = clk_hw_register_composite(dev, data->name,
> > data->parent_names,
> > > --
> > > 2.20.1
> > >
> > Applied this and selected only
> >
> > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> >
> > After changing the governor from 'powersave' to 'performance' the board
> > completely froze (i even lost access to the serial port)
> >
> > Cheers
> > /Ilias
> >
