Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2630CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 04:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A1A2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 04:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lxe3V4zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfJUEff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 00:35:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39920 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfJUEfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 00:35:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so11727237ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 21:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQNBrejSIfQot1yvJ+CXYvqpFeva493kmEcK/FmvoDg=;
        b=Lxe3V4zwPgql6DdVfOuGdemoN+iTyWUFJnNUZSjTdmoNQjUtvBndjhx5Rdj4/DP/Dn
         4z1dCVwOAa6V8CYqKP/3oWo7ve+o5f+Qtc1jdxgfpXkIeuRIPOFHPql1RbabNN2N0bOA
         KrA9Gd8YoyxUxwQ4bbDHN4daiPvi8CYU5SYtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQNBrejSIfQot1yvJ+CXYvqpFeva493kmEcK/FmvoDg=;
        b=s/tY5WzmQzcneTjZA45k8NBp7VcxMd1K3WHAB8QkKS4OMGzMZMfIn1uhMWvM85cSLO
         IXZBlJ8giajzDE1dm1dLC+jqdiE6zLp1IQn3HPbWciAOyBmg/2rVtr82OZLquFT2Ciys
         Ay+onHDaCnrulhV8Av2nfgjykDmRe22RQYKwodhS04/N6iN4EgHwScfcd9FAO9tWJt+Z
         AaRFm+Kmpv7yzSqXezrQ0Kjx+6NVjaf6RW6jKVk9F8MCouTQslD2gG1xMqWQjJ4RLrWL
         SA+pbWFe14rqKrrY85BEAZ8x/gr2QTDVFsqtIidG0D/D0L1oygOcoKe8ZgteXUBqyRGz
         CFXA==
X-Gm-Message-State: APjAAAXETcdCHS+Gollw5QDq6x9u8XwpEJHkjXjyD3pNi2UKJ9gdsFFZ
        PuNe8RZmO8CMVr8N86lV0FZ2rFtDh9X/Di+HzicDxw==
X-Google-Smtp-Source: APXvYqyPwzrXyWagP0WdecOXwfobY6lx3tOdIlc+iCpmqPIfDijQd2X10s5moFVm+KFeq7Sc0yztxE8DVsyHeSnsbyY=
X-Received: by 2002:a2e:990c:: with SMTP id v12mr11977368lji.58.1571632530840;
 Sun, 20 Oct 2019 21:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <1571313682-28900-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1571313682-28900-4-git-send-email-sheetal.tigadoli@broadcom.com>
 <20191017122156.4d5262ac@cakuba.netronome.com> <CAACQVJrO_PN8LBY0ovwkdxGsyvW_gGN7C3MxnuW+jjdS_75Hhw@mail.gmail.com>
 <20191018100122.4cf12967@cakuba.netronome.com>
In-Reply-To: <20191018100122.4cf12967@cakuba.netronome.com>
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Date:   Mon, 21 Oct 2019 10:05:18 +0530
Message-ID: <CAACQVJp1R-9frrgjn6=5s_f3AGBq-fyy5CsYdAio1e=c9iLB9g@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] bnxt_en: Add support to collect crash dump via ethtool
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:31 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Fri, 18 Oct 2019 12:04:35 +0530, Vasundhara Volam wrote:
> > On Fri, Oct 18, 2019 at 12:52 AM Jakub Kicinski wrote:
> > > On Thu, 17 Oct 2019 17:31:22 +0530, Sheetal Tigadoli wrote:
> > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > > index 51c1404..1596221 100644
> > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > > @@ -3311,6 +3311,23 @@ static int bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
> > > >       return rc;
> > > >  }
> > > >
> > > > +static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
> > > > +{
> > > > +     struct bnxt *bp = netdev_priv(dev);
> > > > +
> > > > +#ifndef CONFIG_TEE_BNXT_FW
> > > > +     return -EOPNOTSUPP;
> > > > +#endif
> > >
> > >         if (!IS_ENABLED(...))
> > >                 return x;
> > >
> > > reads better IMHO
> > Okay.
> >
> > >
> > > But also you seem to be breaking live dump for systems with
> > > CONFIG_TEE_BNXT_FW=n
> > Yes, we are supporting set_dump only if crash dump is supported.
>
> It's wrong.
Sorry not very clear. You are saying that support set_dump all the
time and return
error, if the config option is not enabled? If yes, I will modify the
same way as it
makes sense.

>
> > > > +     if (dump->flag > BNXT_DUMP_CRASH) {
> > > > +             netdev_err(dev, "Supports only Live(0) and Crash(1) dumps.\n");
> > >
> > > more of an _info than _err, if at all
> > I made this err, as we are returning error on invalid flag value. I
> > can modify the log to
> > something like "Invalid dump flag. Supports only Live(0) and Crash(1)
> > dumps.\n" to make
> > it more like error log.
>
> Not an error.
Okay.
