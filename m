Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6D720643
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4/xg/3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbfCVLyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:54:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39412 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733161AbfCVLyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so2110165qte.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NA+l8H7/JzX5UkHJY/ZfP3KgdL7pb1ghcMTtXdac7s=;
        b=F4/xg/3Ohxp2rJE95Wf9TWb39GtEhnYItpIHoLIJnpBfXte9bA0UY9wGqVkFYwRZEA
         Yt8Zx9J88t9WFHyAkMKzCTriwwg04UNpaLjole+cvmDO8E6xzJK1XRKI9uImqNAOvod6
         IPlwaRpJTqDLVzPd9fU84sn1WjlaYSNvEp9U01ENAf48YB3weWuBBgiXSvQALYlPyLiQ
         igzMdsRzO6CJhj4lP4LoaVsf5QmH+ql7ljWStvt7gPxjks/8G+8jGJp45ZIJ6W+Ly8FL
         LxffAiMFD8WNwYkR+8WjrZ1p6XAzjC/Jugx57l/JTj/t/QBkKWwaXGUXu5zXX7fp5uln
         WvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NA+l8H7/JzX5UkHJY/ZfP3KgdL7pb1ghcMTtXdac7s=;
        b=JoDDoLhdepmP28Di+I3OnMRJG7sj2sNtreTJxuiSqjE2IrN4AT+awks6I5MEAFTWgh
         L5KZj8EsUDY+sBuTNPiVj9RrbuWbOHWCgbPG2DoateY6l5JccsBxbO8URwVDY7UTJV00
         jpmqN/duIBAxjvqeoxUYo0d1S6hQhLK/KgGlsmQ3SLPJrbmxNIN+k1Et8nV87hMLFcR2
         DeG7J14gUgwryx4Z8JRYAZ08aoJVa/qMEANzGbn6FnkZvQ+sGIoA4KhoB0bFAcwWU8pu
         cef0TlD9FK7tpv1WAEylQwN5hPEn//mTCO/4fo4lnJvWAZ8BQbmrjltXEpAMvHjQ64eF
         BVHA==
X-Gm-Message-State: APjAAAXxRDsLJ2Pipw+jad8s1WvWoDZIqW3qdZQnV2vLHV84Uts5Gcux
        LBnoIRG74SWUNdxL/A2ExOO+8M6WfbzEss31I0jv2w==
X-Google-Smtp-Source: APXvYqwVwlfsFvZxdX5BfBanDSJ+ojm1Y9aUdMs9+GykdIpeqzhIK96QILZsjsRgpMTsZ97i5c4y+mNdZFkL358gaYo=
X-Received: by 2002:a0c:9e2d:: with SMTP id p45mr7588239qve.28.1553255657681;
 Fri, 22 Mar 2019 04:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190319064050.149212-1-kyletso@google.com> <20190319173802.GA31323@roeck-us.net>
 <CAGZ6i=0qeF1YU9N3pnKjejsKY76bY_sfqbwN83LWMRMr82k=nA@mail.gmail.com>
In-Reply-To: <CAGZ6i=0qeF1YU9N3pnKjejsKY76bY_sfqbwN83LWMRMr82k=nA@mail.gmail.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Fri, 22 Mar 2019 19:54:06 +0800
Message-ID: <CAGZ6i=1ZyftH6CcMvpeWz9tLwJxusaOyz5BOaSS3YP2mijSQCw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: collision avoidance
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 12:51 AM Kyle Tso <kyletso@google.com> wrote:
>
> On Wed, Mar 20, 2019 at 1:38 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >

> > >  static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
> > >  {
> > >       if (port->port_type == TYPEC_PORT_DRP) {
> > > @@ -600,6 +664,9 @@ static void tcpm_debugfs_exit(const struct tcpm_port *port) { }
> > >
> > >  #endif
> > >
> > > +static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams,
> > > +                       bool start);
> > > +
> >
> > Does this have to be a forward declaration ?
> >
> tcpm_pd_transmit() calls tcpm_ams_start() and tcpm_ams_start() calls
> tcpm_pd_transmit()
>
Since tcpm_ams_start will be divided into two parts, tcpm_pd_transmit no
longer needs to call tcpm_ams_start.

I will remove the forward declaration in the next version.

thanks,
Kyle
