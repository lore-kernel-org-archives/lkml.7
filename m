Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E050C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E7D20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak9p/uPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442717AbfIYIVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:21:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53461 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405820AbfIYIVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:21:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so3985470wmd.3;
        Wed, 25 Sep 2019 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=07HHxynuwRX2AxzUmWOs5TTpHN0wbdYgczfuCjqhEZU=;
        b=Ak9p/uPdzo8AlUpi4OGQdDIrmxSxm62rMBBWaO/s7BUHwNjtkWnd5KXLjlshIU977b
         6kPFYUOLqqX4PxCwkShjXzPA/xNBr7niko/DpV2taGZ88o6XNaSwedn9icLXa2q1s+S8
         2OgPmjWhJjbu9bQ2h/zhbCMU/maQYodYHCCzteFRKTuIqhmuJN+9r0XgWqbBxko4GEs5
         fEOju1qOVh3WOwYSM912MivsN5fpIPHO0usWKYQxV6XpnpIDQQtY5W+GximZSjy7KuzG
         OgyXV/HGvAMYEQG6ZA/DTG8xHVlkIBETsEzXFKHFeAblTjm/ShALTbSpEt4sPjuxgCgy
         buig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=07HHxynuwRX2AxzUmWOs5TTpHN0wbdYgczfuCjqhEZU=;
        b=DRyne32u3rIxRJN2XvWrq8KzjO6+42NgnhUJRnJqeHiWxr1TyRa+nMzj99iLt7YPUk
         cyX6WjXc4+NmHMwI941xBaXesrf6SB4C3YNg1HgYZaP64GLMQ3PQM1bPMpSFTlTIpLqA
         p+17vV1Dyh7cCVzNlPtmd3laTqFVNYVe/HD6SFZzjQ3ZIegOVWO6RXqmfohMQpvCSOvf
         82i8J0QZKJjn+k9Tw4mIMW5ih+D8TmZy/zgLQiIBea7smFVvPJKzxYUX36DF3kH0PPQw
         UsbA0b4ivPBh7E4dumxPjI29sRPFt83FOSEACpjmVAcwN9BqbabnEMMivFphAy3ybNje
         YsaQ==
X-Gm-Message-State: APjAAAVToA8XfEvAL8VXeGzhye5kApNvdeaGxLznaoPkKl9b9I8zkz+m
        TQzobv65SfHbqKqHwnk32lk=
X-Google-Smtp-Source: APXvYqzeqND3xSEL3Da/l7gOEPtiJolvl2AIQAGTg92Aa1V9ScGXZTZ+ghAc45AHbJu35hyNRLlQBw==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr6066933wmj.12.1569399711322;
        Wed, 25 Sep 2019 01:21:51 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b62sm2753407wmc.13.2019.09.25.01.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 01:21:50 -0700 (PDT)
Date:   Wed, 25 Sep 2019 10:21:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlight on
 Inspiron 10xx
Message-ID: <20190925082149.yjhmmb64i4h6sddi@pali>
References: <156824368856.28378.14511879419677114177@WARFSTATION>
 <20190912073358.n5bxqosowhky5uhb@pali>
 <156882055514.9370.16951540573597044820@WARFSTATION>
 <20190922134323.mowwoyeuqoalpwsg@pali>
 <baba1f72c68f4699955d2b7a52df65e1@AUSX13MPC105.AMER.DELL.COM>
 <CAHp75VfjhuFzTRg7X_ici6ACj54sQKH0mR8x9M-XAYk5cbTQ7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfjhuFzTRg7X_ici6ACj54sQKH0mR8x9M-XAYk5cbTQ7g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 September 2019 11:07:35 Andy Shevchenko wrote:
> On Mon, Sep 23, 2019 at 4:24 PM <Mario.Limonciello@dell.com> wrote:
> > > From: Pali Rohár <pali.rohar@gmail.com>
> > > Sent: Sunday, September 22, 2019 8:43 AM
> > > To: Pacien TRAN-GIRARD
> > > Cc: Matthew Garrett; Darren Hart; Andy Shevchenko; platform-driver-
> > > x86@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello, Mario
> > > Subject: Re: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlight on
> > > Inspiron 10xx
> 
> > > We need to wait what Mario wrote about this particular problem.
> > >
> >
> > I agree an Inspiron is unlikely to be updated 9 years later.  I think the right thing
> > to do in this instance is to blacklist this particular platform in kernel driver.
> 
> Does it mean you are okay with the proposed patch? Can you give your tag then?

I would rather use different name as kbd_phantom_backlight. E.g.
lbd_broken_backlight or something which indicates non-working / disabled
support.

Also in commit message is written that problem is with KBD_LED_OFF_TOKEN
and KBD_LED_ON_TOKEN tokens, but proposed patch does not blacklist these
tokens, but rather turn off whole kbd functionality. So proposed patch
does not patch commit message, nor explain it.

-- 
Pali Rohár
pali.rohar@gmail.com
