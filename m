Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800A1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB2D20684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ii2d/Flb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbfJYRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:35:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39430 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731004AbfJYRfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:35:51 -0400
Received: by mail-io1-f65.google.com with SMTP id y12so3333676ioa.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gEWKmO1JLEWI240XsOEzrNFqCV7DX0CDuyfcFqb1UPs=;
        b=ii2d/FlbFFfLw1J7Trx8IiCnxyGVg18kfouTBl9bWVRvK1R65YbslejRhtY7kwlQ2y
         TG46bymn/CWK/sc3k5H2s43P2dlhWiDP/39z7hPvv2NN4lbLdJkLjzRAIgqZ/aj4dME/
         zyTTaeaN9zmllRPI+8JoD7PTBG09QYGtu67iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gEWKmO1JLEWI240XsOEzrNFqCV7DX0CDuyfcFqb1UPs=;
        b=aNDFqWmpy8O7Ww1yxzA6CuYj4lCal3GiKjEvsevnW6kzqjoyshb44QmJ7QN7PaNrKG
         aPqWhcWctBWlwaUbWi+X7RqiQkYj5TufrEDiGqNutxWjaMiONRxH2oENymRxhV74WbW3
         gxJ+bDUwX73xTKIaqunDoPgUgqGKabI2ACGDWU9TDvSTTW97EaYqlBtemSS2dwf4L3mQ
         d/3WUG0inG0831K35Vp16uJikslWya9ezQbpzg75ywWrxiYKU9eMUrNP9LfsZY4t2CtN
         ob9RH7REhsAeyRSwW9S2EgrWWiF9k3jaX7ZQHgPMIT0VX5lvmw4Rt5p6k2pb0RX6c1FA
         x+Uw==
X-Gm-Message-State: APjAAAXCLmO+20RDwfhvVEgBjmKLYSiakMw+qYj4F5A5TKCLt7D5nlDu
        YfrvO30TXbVu+JSTPrkSMLJ6TA==
X-Google-Smtp-Source: APXvYqyzpGIXq/nDIK0TS8mA7DXhAVWzAqiLOUDj9h836hFhnC/oUb34Fd7KxD4LvXwb6cob9b4eDQ==
X-Received: by 2002:a6b:9245:: with SMTP id u66mr4873228iod.98.1572024949830;
        Fri, 25 Oct 2019 10:35:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id f1sm391794ile.77.2019.10.25.10.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:35:49 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:35:47 -0600
From:   Daniel Campello <campello@chromium.org>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH v6] platform/chrome: wilco_ec: Add Wilco EC keyboard
 backlight LEDs support
Message-ID: <20191025173547.GB1768@chromium.org>
References: <20191018120830.1.Id856c69b1fda0a9b2248218ea0cfb6919aa1cb0d@changeid>
 <3c8c22a0-db91-354f-d9b9-ef0d9b80641f@collabora.com>
 <CAHX4x86+1dNkGHUDvYcC_OhSyTPRcg8UJLAZKCdjmnwVWDOC+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHX4x86+1dNkGHUDvYcC_OhSyTPRcg8UJLAZKCdjmnwVWDOC+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nick for taking care of this. I just reviewed your patch
in the other thread. Also, thanks Enric for your comments.

Thanks again.
Daniel

On Thu, Oct 24, 2019 at 04:18:07PM -0600, Nick Crews wrote:
> Thanks for getting this going again Daniel. This version of
> the patch is fairly old, and after so long I've found some
> things about it that I don't like, even though I wrote it
> originally :). One of the main things was how complicated it
> was, and how there was duplicated code in core.c and the
> kbd_backlight_leds.c.
>
> Therefore, I just sent a newer version of this that simplifies
> things greatly, and addresses the feedback that Enric just gave.
> Check for that patch (it's paired with another unrelated one)
> and see what you think.
>
> Cheers,
> Nick
>
> On Thu, Oct 24, 2019 at 3:54 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Daniel,
> >
> > Some few comments, mostly nits. In general I'm fine with it.
> >
> > Thanks,
> >  Enric
