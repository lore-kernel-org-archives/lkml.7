Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F219C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4222082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="lZxNyi6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfC2Iid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:38:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52822 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfC2Iid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:38:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so1585137wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgNeplyT3OFWb28Y+gJ/FuUgcoPKTLA2kpGRRsSxzCI=;
        b=lZxNyi6INfRPrrEbA3BeOvZnCHpAl8BIODECHC/MZ9c3xZOl5kRJkl7udWwKuG6Y07
         /0ckQ43oviNNSiGXzPMXlZffil9LxAWt5MlXXS824ds5AmLtQvMMaczF7yuLw6SRTBGP
         pEK5OHQwUOHY9Xpl9UMZfj6R1v6k1HS9SH+2VYUx4bYmIpTIM47W6ASIgCa0eUvNuG9U
         7bQp7UUqfRMjKDkv/x/tmlZu7QPVoUd6w6RV0sDsTxG7YTbDRhifurBgaj3xcgciYn1x
         VwjB8XdM7Ul2ejKmwMUEgz4FEG0HM6THAKDYC16dw1omABVxBGR6lDQ9KBJfNzKFzET1
         tH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgNeplyT3OFWb28Y+gJ/FuUgcoPKTLA2kpGRRsSxzCI=;
        b=q+nUrKhMK0sUr1xXULTlwU0bZcD5KIklUCXUQ8QpZ8c78Q1rF5lc57sQqn04Xk4QR6
         kuzMjNOokJRQdlH6Zc32F5E3rPOr/tH3ajgumwHtlFT3XDJtUqr7Ql8kfF5BQfWLtDni
         M9EOfdT0x+BYJAVnRpnHTQVhFcJb0a6cBGNiFsLv+tiY+awebxOAtS6uV8uQ9lPTl/sg
         WkgF2VRaF+cNhnYse4YkA60JCoFVLEMh7NfxsW529alPsXlugYOgfKjTpz/+/aYkehX1
         zyGoZr9dwL3tUA8Uh7DNJxxIVQ4W1VqWoJ14sM3d/HTbKkEAFHA0LYsEpioZivbpV4ju
         LHjw==
X-Gm-Message-State: APjAAAWc1n2AUPK6mINkvuSJqMW636sTx6OktlMECT6dONbOAHCYlMCO
        Kostujz5z6LMdy9cpva151gig+G44UiW397lFZAvwg==
X-Google-Smtp-Source: APXvYqxYvWrsUeGT15Wvy5OeRAwgZjMg4vNYVlJN6S20n8QbYinagydHtnG4gLbrAmqoLtqftx5/KsqYZnjyPbt/98k=
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr2737105wmd.109.1553848711373;
 Fri, 29 Mar 2019 01:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20171117064904.GZ17200@lahna.fi.intel.com> <CAB4CAwdGQjXc6gsswyCgLTfFRN9CgcC=OJ6pz4rX-HCn8AT-TQ@mail.gmail.com>
 <20171121105205.GP22431@lahna.fi.intel.com> <CAB4CAwcjXi=YX+0PEC6wBdfAZ=am+BceB4HCFzTXzdts_FE2vQ@mail.gmail.com>
 <20171121120422.GR22431@lahna.fi.intel.com> <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
 <20190327172940.GR3622@lahna.fi.intel.com> <20190328091729.GV9224@smile.fi.intel.com>
 <CAD8Lp44xuzHj4uu3a-Y9wscSyEmuG6=nbww6T9-9FaYZT_qYsw@mail.gmail.com>
 <CAB4CAwfH237-EUgfyR8-KWKo0HJOf=QkxiNjkBRg+gBpbKiM7g@mail.gmail.com> <20190328123444.GX3622@lahna.fi.intel.com>
In-Reply-To: <20190328123444.GX3622@lahna.fi.intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 29 Mar 2019 16:38:20 +0800
Message-ID: <CAB4CAwcQTH5BiDDbzfFXTDDuYQ_fuDd_1tKkecf6vwygGQmn5w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over suspend/resume
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 8:34 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Mar 28, 2019 at 08:19:59PM +0800, Chris Chiu wrote:
> > On Thu, Mar 28, 2019 at 5:38 PM Daniel Drake <drake@endlessm.com> wrote:
> > >
> > > On Thu, Mar 28, 2019 at 5:17 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > Hmm... Can you confirm that laptop you declared as a fixed case and the
> > > > mentioned here is the same one?
> > >
> > > They are definitely not the same exact unit - originally we had a
> > > pre-production sample, and now we briefly diagnosed a real production
> > > unit that was sold to a customer. There could be subtle motherboard
> > > variations as you mention.
> > >
> > > > If it's the case, I recommend to ping Asus again and make them check and fix.
> > >
> > > We'll keep an eye open for any opportunities to go deeper here.
> > > However further investigation on both our side and theirs is blocked
> > > by not having any of the affected hardware (since the models are now
> > > so old), so I'm not very optimistic that we'll be able to make
> > > progress there.
> > >
> > > > Meanwhile, Mika's proposal sounds feasible and not so intrusive. We may
> > > > implement this later on.
> > >
> > > Chris will work on implementing this for your consideration.
> > >
> > > Thanks for the quick feedback!
> > > Daniel
> >
> > What if I modify the patch as follows? It doesn't save HOSTSW_OWN register.
> > It just toggles the bit specifically for the IRQ GPIO pin after resume when DMI
> > matches.
>
> I don't really like having quirks like this if we can avoid it and in
> this case I think we can. Just always save HOSTSW_OWN and then restore
> it if there is a GPIO requested and the value differs (and log a warning
> or something like that).

You mean save the content of hostsw_own register on padgroup based ex.
    communities[i].hostown[gpp] = readl(base + gpp * 4);

And then check the hostown bit for the GPIO requested pin in
intel_pinctrl_resume(),
differs the hostsw_own bit on pin base (like padcfg), then restore the
hostsw_own
value of the padgroug which the GPIO pin is belonging to?

I think what you mean should be a much more straightforward solution
for this. Could
you implement this in your way and we can try to help verification. Thanks.


Chris
