Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D44C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AA1222C5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koUS8N61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKKPoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:44:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44290 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfKKPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:44:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id s71so11846653oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiLblMDqbLY1U4Bw7/7i/UGPkUsRgy9FGPSsY6DaoiY=;
        b=koUS8N61d+pMyaRWxBX6khAZh4nn16pc82MIgcsyt8zstMqXfRdgunWrP/pCSdGHo4
         +ZItylzVCbiCTGJ5uBeZQRADK32ndBhqBUso0MnIXQLCsA5nYXr8Brt2JRsR4wUvMCQW
         feXAncwHNrpSmoxrS9dVBV1OeXQOtPKkwfQEab7ppRq3vkBkRfs/C91MEqcPhw6uQas4
         RTjK3LiZQyr0xUQKxH0bmhRnXkAaZTiYZaBoNuSZ44Kb6vGdL/qXyKvWh3DaSFiPs/TK
         Sf41OiJgvZuvLue2rbeyTtPHJUk9uKq/lEjyS0xmPwk9trRkWizQAHOr0QuiuPL0Rsu5
         zbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiLblMDqbLY1U4Bw7/7i/UGPkUsRgy9FGPSsY6DaoiY=;
        b=UK+F7yRQm+Z/n7tYBjKbDGnk1mws5Ni3ivc4sTehjLtoWF3zH1eI81l9QniHmJW88p
         lnd9FzzHTaBM0GBop5pt3wz+1IOhRYHC07h9sJVoYk9z+hvblLQCQP3eBLglC+iGHSuM
         4W1DoWl+0swPUO/Nse2wtLA8kc1vUYJqC0B+MOBTMTAxLnMjfNYEnQ7xTZqH9ldwP8Z9
         wJ9xnxfzcDLehow1KiLniCQ56ol1I+Y3oSBPjboQW2CZM+fCbj9RHiVmS5dpOLIKmPci
         Zl5NUaXPfeN/uDKakr4HeMDp0R/S4Wh5ecmZvZFqqoTvELn6vpH66UjcLXzkhaGJvh/c
         sB6w==
X-Gm-Message-State: APjAAAVm7HiFR1xa+LW6Z+4+79srzvZishl3od5L02Nf6B8fXGmJIbya
        JpsphpIS9Mii/7NrZTGMF2MZ6uwEW9+6Yu5oRlk=
X-Google-Smtp-Source: APXvYqzGpgpXek0/OVESAc/xjACPjWco9/B5v7WHt3WaFIE2i1H6olGrnrme+gjTmXuy8Sp5qQtPqzabXoz7PPaUdRQ=
X-Received: by 2002:aca:2803:: with SMTP id 3mr1129329oix.113.1573487075885;
 Mon, 11 Nov 2019 07:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
 <20191016144540.18810-4-sudipm.mukherjee@gmail.com> <20191017211022.4247d821@gandalf.local.home>
In-Reply-To: <20191017211022.4247d821@gandalf.local.home>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 11 Nov 2019 15:43:59 +0000
Message-ID: <CADVatmMJgb1b5foOZeFres5ubk53H8Amy0_Mggo9obO0CTV0SA@mail.gmail.com>
Subject: Re: [PATCH 4/4] parport: daisy: use new parport device model
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Oct 18, 2019 at 2:10 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 16 Oct 2019 15:45:40 +0100
> Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
>
> > Modify parport daisy driver to use the new parallel port device model.
> >
> > Last attempt was '1aec4211204d ("parport: daisy: use new parport device
> > model")' which failed as daisy was also trying to load the low level
> > driver and that resulted in a deadlock.
> >
> > Cc: Michal Kubecek <mkubecek@suse.cz>
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > ---
> >
> > Steven, Michal,
> > Can you please test this series in your test environment and verify that
> > I am not breaking anything this time.
> >
> >
>
> I checked out 1aec4211204d~1 (just before the broken commit), and
> applied these four patches. It booted with the config that wouldn't
> boot with the broken commit.
>
> Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

A gentle ping on this series.


-- 
Regards
Sudip
