Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC818C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FB4208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0YgCWmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfFYWdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:33:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32800 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfFYWdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:33:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so171540pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JT1Dg+Da84rmyT0HimXlivWp8rkXdkjd2YjQgSg5q78=;
        b=g0YgCWmWyWoOk8i0P51O+hzfezQLPWB35vHuYvI92qYbh/90WoDAhhrmkhKiKU7HnL
         u67taUAMYO/RuifJsYFWe87jOy6YD4Kg78lUjB9KOPOh18LgI6x3hyfkJLXuyGg5gKLw
         BS8wVHY3pMPdA24g4TL+k1Xx7Gi9DriOMFX1btp6Di7Ltrc8xT/aw2c4ZiM15gx6NlAO
         seDd1BYMelbsEw+WoH4yNpNXTfE7MlrXO7BuKB2QG5Lsh5tBybIA70LrQU79Nmu74W8Q
         zlSTHA3/yBtQv7jRnkmy6Oio2hdBzm/JWrRtXbiTuJ5lBvNvyqvRgY/gKiAXGtcj0Lew
         GY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JT1Dg+Da84rmyT0HimXlivWp8rkXdkjd2YjQgSg5q78=;
        b=F1vMsiitaX1zASUxtow9aSMVpXlE3hs6iWznGJl9jPjG+xZLicx568dkoCb4dIaHWr
         tdYnI0Kd+oRdPesJSt9CGU5XBzHeCISsqo+ej5tIQF1jGYPJl1WqyH9VqQ6mAC6IE7Jc
         wK4JoOQr+rkKrYmPUw7TdTH3amZSlqkq/qtKJYVfzX+Sj6K++JREmJhh75h2o/TOIeRQ
         vMmdvdQR/CT+h3nq8Qks4Hnn7oArL/8hio4d2mEyHpOlg8+ldKg9quzlZi9QxXilElYC
         qO5QK6o+6a26AmbHSpVz75RK85MDmaQuINE47FQ2tO6uHwKJG6Onk7whovFRAZh8j0pd
         t40w==
X-Gm-Message-State: APjAAAXK7ljRWN2wWSiWmiEYcgUHzSttWhjdebRXD5OjsbXWUDNECsyQ
        9E5e2dAyN41R3cgOomSwn6vMHw==
X-Google-Smtp-Source: APXvYqyKtzqaJPagQIzaNMbJft8gYiPTJ/62A6mnD2mpmhx2FUd/IX5Bn3rvFBc7HFZmTo52Uib8rw==
X-Received: by 2002:a17:90a:db08:: with SMTP id g8mr251900pjv.39.1561502020992;
        Tue, 25 Jun 2019 15:33:40 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:765b:31cb:30c4:166])
        by smtp.gmail.com with ESMTPSA id v138sm17334627pfc.15.2019.06.25.15.33.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 15:33:40 -0700 (PDT)
Date:   Tue, 25 Jun 2019 15:33:35 -0700
From:   Eric Biggers <ebiggers@google.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 4.19 84/90] cfg80211: fix memory leak of wiphy device name
Message-ID: <20190625223335.GB218319@google.com>
References: <20190624092313.788773607@linuxfoundation.org>
 <20190624092319.410368076@linuxfoundation.org>
 <20190625215135.GA32248@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625215135.GA32248@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:51:36PM +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > commit 4f488fbca2a86cc7714a128952eead92cac279ab upstream.
> > 
> > In wiphy_new_nm(), if an error occurs after dev_set_name() and
> > device_initialize() have already been called, it's necessary to call
> > put_device() (via wiphy_free()) to avoid a memory leak.
> ....
> > --- a/net/wireless/core.c
> > +++ b/net/wireless/core.c
> > @@ -498,7 +498,7 @@ use_default_name:
> >  				   &rdev->rfkill_ops, rdev);
> >  
> >  	if (!rdev->rfkill) {
> > -		kfree(rdev);
> > +		wiphy_free(&rdev->wiphy);
> >  		return NULL;
> >  	}
> 
> Is kfree(rdev) still neccessary?
> drivers/net/wireless/marvell/libertas/cfg.c seems to suggest so.
> 

No, because it's freed by:

    wiphy_free()
        => put_device()
            => wiphy_dev_release()
                => cfg80211_dev_free()
		    => kfree(rdev)

drivers/net/wireless/marvell/libertas/cfg.c is different because there the
struct wiphy is separately allocated from the struct wireless_dev that's being
freed afterwards.

- Eric
