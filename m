Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF9BC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE5D2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AkAgROt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392111AbfFKWaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:30:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35816 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392091AbfFKWaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:30:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so7751281pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nJbbRKlTPYM1woarvu6grRc9TzO5KmCP13nZ/PCJ6c=;
        b=AkAgROt9atHwV3xoI9VjaZrzZaaO5howAWh2priY04W1eiUwPse4i9GNmq6QF62bfM
         MjEIEYGjhwP96quM3HMtr3Th7Fkvo1GgNOmUIQgHXmbm147RCQC4UZxj1RlLETex3AUi
         Ks7ioq3D9bjZkjE4COgReB+rkRk03RcrgiW1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nJbbRKlTPYM1woarvu6grRc9TzO5KmCP13nZ/PCJ6c=;
        b=mIJY7zXEyv0ZIkDXXqr6N3PtaQ4M8N5e9B79EIWHOyco127h2nLq+cKqwIHG0m+0qc
         HYomm2aY28/Qi7mHXX9EFEXkpRJ8k6bkx/ELzrd0CeC1NlUxO5xGpbSt2EGjSy/fhKOT
         OboentJ41pSZ9cPRQVlx6uvf0fZqgYstPjBfklqiupI1qQS+Z4POWlv1Cy6828QfwPgE
         Drj4ulYXIKdszVcTCV9gLY8DSSVS1T0QeOjkzqOIqQPcbDTVC8v1Xcm7as10mBBJKnWA
         cqE4SmMNzgnsTjz4Jr0xzM3Jkjd8mXWUuHQ5HHqbp5EjKAyxxmmiJSVcYMhbLLFEATXS
         rZ7w==
X-Gm-Message-State: APjAAAW4tza4na3OBgu+PuISZuJ9qoqr90huJ83XRr5oEgg8soIw85ty
        0gHIbGzc5DceQ17CjaS6HUd30A==
X-Google-Smtp-Source: APXvYqzPGqvHJEEW8KGadINzmMV1t9wKDJZxZqs3Q4ilQ1+NwSxiG1GZwT6wk/dEzb5udw5jUepoxQ==
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr28582703pje.123.1560292222289;
        Tue, 11 Jun 2019 15:30:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a13sm8937301pgh.6.2019.06.11.15.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 15:30:20 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:30:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@google.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Guenter Roeck <groeck@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: compute brightness of LED
 linearly to human eye.
Message-ID: <20190611223019.GH137143@google.com>
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <20180208113032.27810-4-enric.balletbo@collabora.com>
 <20190607220947.GR40515@google.com>
 <20190608210226.GB2359@xo-6d-61-c0.localdomain>
 <20190610205233.GB137143@google.com>
 <20190611104913.egsbwcedshjdy3m5@holly.lan>
 <CA+ASDXOq7KQ+f4KMh0gaC9hvXaxBDdsbiJxiTbeOJ9ZVaeNJag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+ASDXOq7KQ+f4KMh0gaC9hvXaxBDdsbiJxiTbeOJ9ZVaeNJag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:55:30AM -0700, Brian Norris wrote:
> On Tue, Jun 11, 2019 at 3:49 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > This is a long standing flaw in the backlight interfaces. AFAIK generic
> > userspaces end up with a (flawed) heuristic.
> 
> Bingo! Would be nice if we could start to fix this long-standing flaw.

Agreed!

How could a fix look like, a sysfs attribute? Would a boolean value
like 'logarithmic_scale' or 'linear_scale' be enough or could more
granularity be needed?

The new attribute could be optional (it only exists if explicitly
specified by the driver) or be set to a default based on a heuristic
if not specified and be 'fixed' on a case by case basis. The latter
might violate "don't break userspace" though, so I'm not sure it's a
good idea.
