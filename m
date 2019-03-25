Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FFDC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0BF20828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACTk/Put"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfCYQaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:30:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41352 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:30:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so2705595pgs.8;
        Mon, 25 Mar 2019 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vr3ET9nY9p17j3lCEGp73mt2+yU+B9gbDkoTgQB1PvY=;
        b=ACTk/PutGYEA3PG3MZe93XLme3XTXcV9Tg+qXHAuPed3r/mF7IW6Gg9BnnI12mhQ/o
         aN7aHhL8w9y02lax21/M2lex+5xBxCemJlWW8COK+QgdHetf4VXUONk1O0pgHRV+5Cvv
         7pKc1ihJlbI2cSuGUY1H9C+g7CBW6jsAzZysUo3Hv7h/4CbzKJ5FGmf3WhZ/eg8x6Lj5
         awdj5a+d1sBb5eoU/d4rP8EKADApMZf3TY49tfkOZf2c3CMfQgKimu0kVJfjz2Uv5vDH
         aUuoRpLvd2yMWOPjSW4aZl+W2+ioihJQ2J02p3gz06huKD/mefkE1ODh8hWxp+FJwV2u
         yJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vr3ET9nY9p17j3lCEGp73mt2+yU+B9gbDkoTgQB1PvY=;
        b=dz9dEum2hBr8Pi885NRTX0oa5C7yVvj3kspQ7/eVMLCcD4AUdJHHFdUcm12zpcriLv
         gOQm57F37CMIV9MlCaoGjXwh2kx9o2rVB+ChMAMcl7BhBYPS0dJyLHbcv+ulb3IEohSD
         xQPl8ZzJAoOi4HWOTvwwXsBgxlMZPdzMR5BUSAGvygS4Jy/aU2JvSxg7udwUek8CE1MN
         v03dE0ZBYbf14kcAvbm2kObPh3JuLcqgWAkuh9I+zNTxs2ci76FTnGIgIshUV8SEPYV1
         Z5AWWFMjqkPaH6IS6etDujqZVNnm99fADXnKzzMrvoMhLLH86tkoY5k9thWTZvNFRbyV
         EKdw==
X-Gm-Message-State: APjAAAW1B7MJ63cKXeRtn0xIoeVu021XrOsZe3zlOgPJWTn9+ILka0kR
        jVuXQhWBJ6Cf5OdEDY1g7JQ=
X-Google-Smtp-Source: APXvYqwzE3tuM/SF2d1XgMM5dfqGW9Vo0Ga/5BKvSyomG2Dkp2z8SoJ09XhK4ZlGYUXgOd6kNAT01g==
X-Received: by 2002:a63:618d:: with SMTP id v135mr24196053pgb.2.1553531402717;
        Mon, 25 Mar 2019 09:30:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c134sm22943378pfc.87.2019.03.25.09.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:30:00 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:29:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Message-ID: <20190325162959.GA28275@roeck-us.net>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
 <50fafc60-0ee4-ab33-8d24-dfc149215bee@roeck-us.net>
 <20190325150533.GI7284@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325150533.GI7284@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:05:33PM +0000, Mark Brown wrote:
> On Mon, Mar 25, 2019 at 07:21:00AM -0700, Guenter Roeck wrote:
> 
> > It is actually a bit more complicated than that. The stored pointer (drv->soc_card)
> > isn't released. The problem is that dev_get_drvdata(drv->soc_card->dev) is NULL,
> > which causes the crash. I don't think there is a UAF involved - I built the
> > test image with KASAN enabled and it did not barf at me.
> 
> What is a "UAF"?
> 

use-after-free. Sorry, I saw that term used so often recently that I somehow
thought it was common and started using it myself.

Guenter

> > Overall the implementation does seem a bit suspicious to me. I don't really
> > understand why the platform driver handles suspend/resume for the cards.
> > But that may just be my lack of understanding. However, either case, I think the
> > Haswell driver (sst-haswell-pcm.c) has a similar problem. I am also not sure if
> 
> It's certainly a bit unusual, usually the platform driver would just
> deal with suspending itself and the card driver would handle overall
> card suspension together with the core.


