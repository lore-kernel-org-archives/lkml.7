Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E96C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EF8206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JSDMM+L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCSOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:14:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41288 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDCSOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:14:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so8546294pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PAutgMNY5er0NjNwfdvREwtsEWrLCksC1HkO704l74E=;
        b=JSDMM+L12QordLyZwzJjJ7OXgp4sR3IVP53jsM2Tekny4ThNX2/ieonw9hBJ1p7egH
         gTwBbM1WDV9ADrNQdkpR5Rz1uMM6VfGh+AkS/jtfhBDj4DNDqzGxkmumOTEGWFOHUNwo
         ZdsMCgNTY7e5UDYWvSuTaHZqBHAvLGGt8xOEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PAutgMNY5er0NjNwfdvREwtsEWrLCksC1HkO704l74E=;
        b=OuySbXUS6EdDHAnOaDG+DIG0S55cuddV9f8J7fRx/mvGbVyD0BRPgK/Zwv1C6TbWfC
         rlAjgGByPh00eS2Uz2q6icN4IcwGKMGSFv7l0VeE6Z0EW4lX7OTS6CpRD12LE1FYK14y
         pWMuu+2P4Tb+rb5qEQvjCLo/ZWDEwuPLbOyI8UOJa8fOSIouwWdoA8QiC8TssQ7FFKc3
         0zCDQWBRHBWFPZOifYvQw64hUe6skQYE6MZnucDpUuAkj0AQXDLDVWztYaq5DeATwxt+
         /LeyqduZJ3lBfaFtftH42v7Kvocy4nHZpwKj8eRkJ8MbnpnhY7F4Y4VMU15KZlLjjsTB
         5NGQ==
X-Gm-Message-State: APjAAAXve1V465aLksbzTZEoR0KzeqrXHkvt7KX8ANsW9bspw03WFqCo
        313sDsc84GlODoEQaCRlI+2LIQ==
X-Google-Smtp-Source: APXvYqx4MaocD+oyu7OLC5ZeLGWu/SEkn5GGk0LAGklMJgsgxCMwVnrh0RSPJMyWCvXvCrxr+Y2+lQ==
X-Received: by 2002:a63:4b14:: with SMTP id y20mr1062222pga.306.1554315256754;
        Wed, 03 Apr 2019 11:14:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i24sm22681681pfo.85.2019.04.03.11.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 11:14:16 -0700 (PDT)
Date:   Wed, 3 Apr 2019 11:14:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, ryandcase@chromium.org,
        rspangler@chromium.org, Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
Message-ID: <20190403181415.GQ112750@google.com>
References: <20190403160526.257088-1-dianders@chromium.org>
 <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:04:16AM -0700, Brian Norris wrote:
> I know some of this was hashed out last night, but I wasn't reading my
> email then to interject ;)
> 
> On Wed, Apr 3, 2019 at 9:05 AM Douglas Anderson <dianders@chromium.org> wrote:
> > +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
> > +                                struct cros_ec_command *ec_msg,
> > +                                cros_ec_xfer_fn_t fn)
> > +{
> > +       struct cros_ec_xfer_work_params params;
> > +
> > +       INIT_WORK(&params.work, cros_ec_xfer_high_pri_work);
> > +       params.ec_dev = ec_dev;
> > +       params.ec_msg = ec_msg;
> > +       params.fn = fn;
> > +       init_completion(&params.completion);
> > +
> > +       /*
> > +        * This looks a bit ridiculous.  Why do the work on a
> > +        * different thread if we're just going to block waiting for
> > +        * the thread to finish?  The key here is that the thread is
> > +        * running at high priority but the calling context might not
> > +        * be.  We need to be at high priority to avoid getting
> > +        * context switched out for too long and the EC giving up on
> > +        * the transfer.
> > +        */
> > +       queue_work(system_highpri_wq, &params.work);
> 
> Does anybody know what the definition of "too long" is for the phrase
> "Don't queue works which can run for too long" in the documentation?
> 
> > +       wait_for_completion(&params.completion);
> 
> I think flush_workqueue() was discussed and rejected, but what about
> flush_work()? Then you don't have to worry about the rest of the
> contents of the workqueue -- just your own work--and I think you could
> avoid the 'completion'.

Indeed, flush_work() seems the right thing to do.

I thought to remember that there is a function to wait for a work to
complete and scanned through workqueue.h for it, but somehow missed it.

> You might also have a tiny race in the current implementation, since
> (a) you can't queue the same work item twice and
> (b) technically, the complete() call is still while the work item is
> running -- you don't really guarantee the work item has finished
> before you continue.
> So the combination of (a) and (b) means that moving from one xfer to
> the next, you might not successfully queue your work at all. You could
> probably test this by checking the return value of queue_work() under
> a heavy EC workload. Avoiding the completion would also avoid this
> race.

Each transfer has it's own work struct (allocated on the stack), hence
a) does not occur. b) is still true, but shouldn't be a problem on
its own.

Anyway, using flush_work() as you suggested is the better solution :)
