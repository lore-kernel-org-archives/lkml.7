Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B35C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B9C229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wn50C/Q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbfGYDBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:01:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42624 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389229AbfGYDBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:01:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so21922339pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jqf8vsSQMR94XfPuzjd466qFEcaiXpTcAQ55AzJc7DU=;
        b=wn50C/Q84xBwjLKKhX7OkkbWtf+dnGxzOKobzhNmx0UeEP8PAmThBR92dQMa1IyUIb
         XUkuQxe35kpZS357GCgy1y4VcJ43hVV37YzTNEHmLLWqiSXlqtFoZSbGcukA4/nNY4ub
         ZO5D2VV9yh29Yw3Iumsw1Q20b76lKOWgG7XxgdgI7WLXeDVMN0VzbNqCypJfwWWoA/PJ
         AYGdncDNfONlMkaRK7M8FQrgxVLAhKY7aslJa0hwfzArkVbBd9z2PRwMTbfVd00rpIrL
         /bTF2fdAyIUg2eYB3nDx9fplBJGpwu3t7od4Ws123jeIsa3ECOD2ILLZYXNCwQJCQ0mO
         TF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqf8vsSQMR94XfPuzjd466qFEcaiXpTcAQ55AzJc7DU=;
        b=jw1v3kuaUZsJJI5v9FW17izm1xqbnYRb+oy3y1VkRaNd3ROnFq5MvU77rCJ5C+vS49
         wVNoKh9x4tKhH9N2ntRzM1ZzlLSKaR+wVMNkyR/7mxlBLhskB81C957p0Wz+rpPgVEBm
         ZtsDOfG/5SuYO2H5HFW28k45hqCJfaxmYt7tHVNdik72MB4J6Z2Kt6sWmrYvCCQ7B8ZD
         R9Cr+SpV/w+8eM9beVbFjqGL9iIHbpvuzAM8ffSMTmimcKfHNoqPHKuiZgc37w/DIt1f
         Pf3P1AMUVJ4qB1hrNQMbyc8c+wYdtsltFoe4rXeUJU9bQNIYWqVDtQ526/7+/kYIgj+1
         46Ag==
X-Gm-Message-State: APjAAAXrbZqQzq/aYmmUliFBUv7m0WfEKVocnWCow/MySK7x1TkpwHgg
        iQ9SiphCyttGC8qsEA3Yqgr+Ig==
X-Google-Smtp-Source: APXvYqw71EQNZoF1EeaQQUf7DPyno7aB8xgu0IkSJ2vtzF50+7ew4BZC2tgrZsLg3aSp2DcnXv0obQ==
X-Received: by 2002:a63:1046:: with SMTP id 6mr86480080pgq.111.1564023700028;
        Wed, 24 Jul 2019 20:01:40 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id g2sm62095703pfb.95.2019.07.24.20.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 20:01:39 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:31:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] PM / devfreq: Add required OPPs support to
 passive governor
Message-ID: <20190725030137.uz22iwvdv37fsw56@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-6-saravanak@google.com>
 <20190723100406.7zchvflrmoaipxek@vireshk-i7>
 <CAGETcx89X0Xra+3HK+jbuCHXMgRL7QCwSShyMy7DY2Bg1eVjDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx89X0Xra+3HK+jbuCHXMgRL7QCwSShyMy7DY2Bg1eVjDQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-19, 17:26, Saravana Kannan wrote:
> On Tue, Jul 23, 2019 at 3:04 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 17-07-19, 15:23, Saravana Kannan wrote:
> > >       /*
> > > @@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> > >        * list of parent device. Because in this case, *freq is temporary
> > >        * value which is decided by ondemand governor.
> > >        */
> > > -     opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> > > -     if (IS_ERR(opp)) {
> > > -             ret = PTR_ERR(opp);
> > > +     p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> > > +     if (IS_ERR(p_opp)) {
> > > +             ret = PTR_ERR(p_opp);
> > >               goto out;
> > >       }
> > >
> > > -     dev_pm_opp_put(opp);
> > > +     if (devfreq->opp_table && parent_devfreq->opp_table)
> > > +             opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
> > > +                                        devfreq->opp_table, p_opp);
> >
> > you put p_opp right here.

What about this comment ?

> >
> > Also shouldn't you try to get p_opp under the above if block only? As
> > that is the only user of it ?
> 
> No, p_opp (used to be called opp) was used even before my changes. If
> there's no required-opps mapping this falls back to assuming the slave
> device OPP to pick should be the same index as the master device's
> opp.
> 
> So I believe this patch is correct as-is.

Right.

-- 
viresh
