Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C086C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D32220643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFfk42D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfCLD2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:28:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33100 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCLD2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:28:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id h11so741304pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 20:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bB+RR4ZxVsRgJjMK2ereGu8+gULr4j/CZTYj7819FmE=;
        b=nFfk42D/jk9XM/bUO0tp6ccJ6cXIvrQ3VknHuq0w2pr03lpv5W2Na46+7sg7GX5v2T
         7sJ2TBvAWxOYA6tEEpihoQWPjY+xW1vZEMEWvxDjtH+gDQGqbLTdV+iyb5EM4XLYvLdJ
         Ob4oNcybp0q6QrDu6If9d8/YK3MD6W/QMDrlia1tc4JJyZZhK9dQ2GNFayC9IunFkHyV
         JwmLBhvN8mxuQIIOpdrEC+m+2uxGlZKMiJRIFD2UXlkWIbN3cTionN++81N4LiKKSiC1
         8zFg/pt+0jL+5+5vd5F6H/MIZEJvwO3zG/rR0m/1ZtV7kChkICfxp4/ehHFeVdHq1AHB
         csLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bB+RR4ZxVsRgJjMK2ereGu8+gULr4j/CZTYj7819FmE=;
        b=sh0f9eKVOUv2WiBtyEFMN+VBo0wFrHlAOltxNmsoQvCT9PQgIzrG3duA/w14v8r/h4
         QAB/MKAqf5EObNY9Ql3ULg6ySatiiKmRrD8kYFahYqqiCukWGMML2/1QBDNWapX7l7Qc
         rdTy8bZvKgZRkBTlun3Zg9LhdVCeJkN1nLMI82+6LIlMp/sDjNRXTex4HPVn9p2eJHYr
         zQxG0xn80u8SqZ4YSXSIdfZusZDaaUHG6ibRn1v6HRs2xxo1myM2ZCoHhb9hcq3BfFnt
         ajDAgZRQtwEsRGnE5Ms6PIJ/JUhULeCDugvSt0Ysdiy3QpkM37FKO0S+pp/0FbG6wfAN
         dhfQ==
X-Gm-Message-State: APjAAAWvzyIOC+k0v3M9tO8CF8bstrWO6hG2UK7fxtx59+LNyUgnDLUh
        lhs8eZ6yxXLo5hEycInJm+abTA==
X-Google-Smtp-Source: APXvYqyAcyFJMaWzIXouFitYcDdUX4BKTaMXurBrQA1+ILD+hpVl7LdSI2SiuQaDMh1KlK0USg+bSw==
X-Received: by 2002:a17:902:28a7:: with SMTP id f36mr31797143plb.169.1552361285532;
        Mon, 11 Mar 2019 20:28:05 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id t8sm9290176pgp.5.2019.03.11.20.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 20:28:04 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:58:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        sunzhaosheng@hisilicon.com, jean.xupeng@hisilicon.com,
        yuwei3@hisilicon.com, gengyanping@hisilicon.com,
        peter.panshilin@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PM / wakeup: Remove timer from wakeup_source_remove()
Message-ID: <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
References: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
 <3100371.t8xxUOTPUa@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3100371.t8xxUOTPUa@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-19, 13:05, Rafael J. Wysocki wrote:
> On Friday, March 8, 2019 10:53:11 AM CET Viresh Kumar wrote:
> > wakeup_source_remove() is the counterpart of wakeup_source_add() helper
> > and must undo the initializations done by wakeup_source_add(). Currently
> > the timer is initialized by wakeup_source_add() but removed from
> > wakeup_source_drop(), which doesn't look logically correct. Also it
> > should be okay to call wakeup_source_add() right after calling
> > wakeup_source_remove(), and in that case we may end up calling
> > timer_setup() for a potentially scheduled timer which is surely
> > incorrect.
> > 
> > Move the timer removal part to wakeup_source_remove() instead.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/base/power/wakeup.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index f1fee72ed970..18333962e3da 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -118,7 +118,6 @@ void wakeup_source_drop(struct wakeup_source *ws)
> >  	if (!ws)
> >  		return;
> >  
> > -	del_timer_sync(&ws->timer);
> >  	__pm_relax(ws);
> >  }
> >  EXPORT_SYMBOL_GPL(wakeup_source_drop);
> > @@ -205,6 +204,8 @@ void wakeup_source_remove(struct wakeup_source *ws)
> >  	list_del_rcu(&ws->entry);
> >  	raw_spin_unlock_irqrestore(&events_lock, flags);
> >  	synchronize_srcu(&wakeup_srcu);
> > +
> > +	del_timer_sync(&ws->timer);
> >  }
> >  EXPORT_SYMBOL_GPL(wakeup_source_remove);
> >  
> > 
> 
> I've merged it with the [2/2], rewritten the subject and changelog and
> queued the result as commit d856f39ac1cc ("PM / wakeup: Rework wakeup
> source timer cancellation").

Okay, thanks. We (Android guys) want this to be backported into 4.4+
kernels via the stable tree. Can we mark this for stable in the commit
itself ? Else I would be required to send this separately for all the
kernels. I should have marked it for stable initially though, sorry
about forgetting then.

-- 
viresh
