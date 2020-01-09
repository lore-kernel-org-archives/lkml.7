Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37326C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1422075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcGRRhbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgAIEkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 23:40:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46143 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgAIEky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 23:40:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id n9so2704041pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 20:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TTD2x5dI94tlyfHEVS+KfYZUSun3WSq3+iSXPR+9K3E=;
        b=EcGRRhbfbE2JQ8Efxb2BANb1+NSsd5HC5I3ODMD4HDcIddM/9eT/K3s+T6JjLDtOAf
         teX8g7Exokj6vD0CPHc/mQ+VQw2ITEBotzQ0PYdktEgl6u+Ba1dPztPaEngN6lGC6RwD
         fij68ZT/MPS4qOnxE8vlqabXHHmxDzxSlX8cEpWW00Ibvhsxz854fPXSaeW1eG34RoiZ
         eBsxh9LOqKoi0Wt7FxWx3owFNT8A7iFQGIK03LqBYhIPifGxVoiarmU5JGis1/bmcTLU
         xb1cDo2t/qHKUOG11YSe4PabDIVRm7diGCe+WWwfk3p48XrXxUWAahNPhkIp22iHtZ+D
         9oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TTD2x5dI94tlyfHEVS+KfYZUSun3WSq3+iSXPR+9K3E=;
        b=tJ2EPm9jQgCqoCeA+c1/1XMCC7AzT1H8YYKgOf72XGq+PkNXcBuAHJQspH1TN1A3nv
         pv9npzRXOqAvHRJT4Tz7QgjkHacJ57sDHHnIRjWo7Y5z5XTLpJpb3qoRwP5rV0YF9L5x
         6kGUdTT01SE+D7zXnXBcrBWO5y4NDi7n6h8N9naey03cG9hN8nPwtTsPjs7emH3+l5Zr
         rq8yv7y+77GivbLNfiZLAm1OIdN5ze4ZAtYnjz8NLK2krQeu9q2P2XhOqnoWGykoEhG8
         ECPBe7aGPn3Ci2pIkZuv8crDYMOc4osnE+TCWe9Wnz5hE2jro5H4WcxHmXgwBgxvLGKm
         1B2w==
X-Gm-Message-State: APjAAAVTLyJQzv4MWWQ4U+QANQPd9hU4RARcKjFDe6ovlJbfr9vaGisB
        jrL8MX6Y/E7JjOa4wQFfJ/OL5w==
X-Google-Smtp-Source: APXvYqxchuav0rFtDGS7fXHA6b21hxQl8ETG0FPFpF3G910odNkYOuNybG+b46cGo1evQ5cBeBqPuQ==
X-Received: by 2002:aa7:8e13:: with SMTP id c19mr9209399pfr.227.1578544853917;
        Wed, 08 Jan 2020 20:40:53 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id b20sm5513222pfi.153.2020.01.08.20.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 20:40:52 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:10:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
Message-ID: <20200109044051.62ocfpt44q25q6qi@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-4-saravanak@google.com>
 <20200108111947.q5aafrlz26tnk3nq@vireshk-i7>
 <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-20, 16:58, Saravana Kannan wrote:
> On Wed, Jan 8, 2020 at 3:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >  /**
> > >   * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
> > >   * @opp:     opp for which level value has to be returned for
> > > @@ -299,6 +322,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
> > >
> > > +/**
> > > + * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp in kBps
> >
> > Hmm, I wasn't expecting this. So the interconnects will also have a
> > suspend OPP ?
> 
> Yes, device voting for interconnect paths might want to lower the
> bandwidth to a suspend bandwidth when they suspend.

That's exactly what I was saying, the request for a change during
suspend should come from the device and you can't do it here, i.e.
they should lower their frequency requirement, which should lead to a
low bandwidth automatically.

> > > + * @dev:     device for which we do this operation
> > > + * @avg_bw:  Pointer where the corresponding average bandwidth is stored.
> > > + *           Can be NULL.
> > > + *
> > > + * Return: This function returns the peak bandwidth of the OPP marked as
> > > + * suspend_opp if one is available, else returns 0;
> > > + */
> > > +unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
> > > +                                         unsigned long *avg_bw)
> > > +{
> > > +     struct opp_table *opp_table;
> > > +     unsigned long peak_bw = 0;
> > > +
> > > +     opp_table = _find_opp_table(dev);
> > > +     if (IS_ERR(opp_table))
> > > +             return 0;
> > > +
> > > +     if (opp_table->suspend_opp && opp_table->suspend_opp->available)
> > > +             peak_bw = dev_pm_opp_get_bw(opp_table->suspend_opp, avg_bw);
> > > +
> > > +     dev_pm_opp_put_opp_table(opp_table);
> > > +
> > > +     return peak_bw;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_bw);
> > > +
> > >  int _get_opp_count(struct opp_table *opp_table)
> > >  {
> > >       struct dev_pm_opp *opp;
> > > @@ -343,6 +394,40 @@ int dev_pm_opp_get_opp_count(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
> > >
> >
> > I think we should add function header here instead of the helpers
> > which get exact match for freq, bw or level. And then pass a enum
> > value to it, which tells what we are looking to compare. After that
> > rest of the routines will be just one liners, make them macros in
> > header file itself.
> 
> Not sure I understand what you are saying here.

Okay, lemme try again with proper example.

enum opp_key_type {
        OPP_KEY_FREQ = 0x1,
        OPP_KEY_LEVEL= 0x2,
        OPP_KEY_BW   = 0x4,
        OPP_KEY_ALL  = 0x7,
}

/**
 * Add function header here..
 */
struct dev_pm_opp *dev_pm_opp_find_opp_exact(struct device *dev,
                                             enum opp_key_type key,
                                             unsigned long key_value,
                                             bool available)
{
       struct opp_table *opp_table;
       struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);

       opp_table = _find_opp_table(dev);
       if (IS_ERR(opp_table)) {
               int r = PTR_ERR(opp_table);

               dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
               return ERR_PTR(r);
       }

       mutex_lock(&opp_table->lock);

       list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
               if (temp_opp->available == available &&
                   !opp_compare_key(temp_opp, key, key_value)) {
                       opp = temp_opp;

                       /* Increment the reference count of OPP */
                       dev_pm_opp_get(opp);
                       break;
               }
       }

       mutex_unlock(&opp_table->lock);
       dev_pm_opp_put_opp_table(opp_table);

       return opp;
}

//Now in header file

#define dev_pm_opp_find_freq_exact(dev, freq, available)        dev_pm_opp_find_opp_exact(dev, OPP_KEY_FREQ, freq, available);
#define dev_pm_opp_find_level_exact(dev, level, available)      dev_pm_opp_find_opp_exact(dev, OPP_KEY_LEVEL, level, available);
#define dev_pm_opp_find_bw_exact(dev, bw, available)            dev_pm_opp_find_opp_exact(dev, OPP_KEY_BW, bw, available);

-- 
viresh
