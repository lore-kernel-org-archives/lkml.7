Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1A9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CA921928
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8i7fCXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJUCZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:25:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUCZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:25:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so6794449pgi.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 19:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VzWdCtzmSYF/0RAS8/Kzf4oQ1nX/6cypQt9wzSvyGBo=;
        b=l8i7fCXcwlYpE+x6LM93AukPZTXrH3qEevxZGcqgVty19q3wDNePK6MLPRqb4Zkl+v
         9iTf0UjyN9f+EjvvymcW8sxb1fUOueiLxgASSLmbBlm+yg+2sUaYYYHCLZRVeaKeu1I4
         hwnUcC281iJloUkbZr0sPcNjtfoK2PYoMx1B0tpcwOtVXQW34pcb4MEOZncUbH3ucq7b
         WB3KTPU0Q1VHndOpVs7OU7E0Ehb9ieYw7VP6///xaAxgJ2JWMUEEyfBU4zXvgEVGCTOM
         Fdj/9OsQTfUjNFjR0wjqFaItPGJLFqH3D3OR1wnl0H36HJUyzg361PWiBK4aNEV9PF5Y
         RPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VzWdCtzmSYF/0RAS8/Kzf4oQ1nX/6cypQt9wzSvyGBo=;
        b=i5Ti8JDxgjQ5rPFCNTyPv3X3r+hMUTkcZGMDTjtrQLsCDT+ZBHwR/4p0zTEjQRvk4q
         J1GkHCVLyP+oJOCHl8sc7OycbuNn97DviH7wpoHPV36ixlzpZam5am1EoR/CVzTQr3ZO
         J9jZQMzMsZQwIaTtrT0C/prPaomwnKg3OW12/FXRZkSstgsWZ5SZ/okhhEjdkBlaKZ+0
         pBZoUs5SUVQB23ZydSn4HnoxyFddpK+1qljSoB6Z9eWvBMagru2jR9V4w2BZOeFbHJ8u
         wsTH68eUSJO329eAo1Rm6cJ3owjhUZ8Vx9tuU8bbRn2BeF2LGEpi8Mjs8xTKTtuZ/gWC
         DL1w==
X-Gm-Message-State: APjAAAXuC0q4ov/zMYG3nDFxalG5xpm/MKPxXKU5Fhf30U7YmWBTd3LF
        bcJoGwNEAS2cxBxm6zbHX/DB9w==
X-Google-Smtp-Source: APXvYqxhfKqto7mTnoOArVy2mBC9Vr1S8AjFgffMAGgboDuM0dTTF+ed+TZaUWw/8IZ9/9zKA4BFPA==
X-Received: by 2002:a63:e145:: with SMTP id h5mr23188556pgk.447.1571624719092;
        Sun, 20 Oct 2019 19:25:19 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 64sm13903581pfx.31.2019.10.20.19.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:25:18 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:55:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static
 OPPs again
Message-ID: <20191021022516.gecunkpahu7okvm5@vireshk-i7>
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
 <20191018211214.444D32089C@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018211214.444D32089C@mail.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 14:12, Stephen Boyd wrote:
> Quoting Viresh Kumar (2019-10-18 02:28:41)
> > The list_kref reaches a count of 0 when all the static OPPs are removed,
> > for example when dev_pm_opp_of_cpumask_remove_table() is called, though
> > the actual OPP table may not get freed as it may still be referenced by
> > other parts of the kernel, like from a call to
> > dev_pm_opp_set_supported_hw(). And if we call
> > dev_pm_opp_of_cpumask_add_table() again at this point, we must
> > reinitialize the list_kref otherwise the kernel will hit a WARN() in
> > kref infrastructure for incrementing a kref with value 0.
> > 
> > Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/opp/of.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 6dc41faf74b5..1cbb58240b80 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -663,6 +663,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
> >                 return 0;
> >         }
> >  
> > +       /*
> > +        * Re-initialize list_kref every time we add static OPPs to the OPP
> > +        * table as the reference count may be 0 after the last tie static OPPs
> 
> s/tie/time/
> 
> > +        * were removed.
> > +        */
> > +       kref_init(&opp_table->list_kref);
> 
> It seems racy.

I am not sure if I see a race here, but maybe I am missing something.
Care to explain ?

> Why are we doing this vs. making an entirely new and
> different OPP structure? Or why is the count reaching 0 when something
> is obviously still referencing it?

The kref for the opp table is opp_table->kref and the one here is
different. This is list_kref which is used for freeing OPPs added
statically from the DT. The static OPPs get added to the OPP table
when one calls dev_pm_opp_of_cpumask_add_table() and must be removed
on a call to dev_pm_opp_of_cpumask_remove_table(). The opp table
structure may not get freed at this moment though as it is still
referenced by the caller of dev_pm_opp_set_supported_hw().

And now when we try to add the static OPPs again (re-insertion of
cpufreq module), we need to reinitialize the list_kref again as its
count reached 0 earlier and the resources (static OPPs) were freed.

-- 
viresh
