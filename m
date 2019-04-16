Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E1C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E294B2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3KajffQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfDPVOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:14:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33727 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:14:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so10951208pgh.0;
        Tue, 16 Apr 2019 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OU2nSMmt5htbg6+q1msxmMt8aeMJWwleorLRoerjeR4=;
        b=b3KajffQ9aP+3ncagGjPE22931SX/MgceA+6oJec+mTIF0ISBnJV2s7XoJLRrss81q
         cclSmEgeaMR2wcrXJ2iNWrALryx8xf2jXe+dnBBXkhSRoVoV+0HyjpBSTBtak/5jmE4i
         vz8JllSwgkifnPsJ1latKIeNY0VpgYHNxKsu+qVdlPK/KSzmKFlDwKd/VmWXI9aHfJru
         4OktXKqBB9MIEM3I11DeYrSlSR5E2tSoxLDuw/dIpMbKSySpU9C+EVkpFtckFXEbnKMh
         5mrHRa/tDRRtFjKEG1jrrVdQd4Uwo0EfvvSEN/TiyCyNXw/Sbx7PNPhckwLRzL6iiksw
         RXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OU2nSMmt5htbg6+q1msxmMt8aeMJWwleorLRoerjeR4=;
        b=tZGb1Kdxs+ckXYEKB29CMbBcw2bgD6lHSxwNbu3Svxo7ybwEsixTS+JmKQSguMFn3r
         G4JSGrlMJfdIe3pdRz9EZuhomV2+IJgl17e4grmq5peww02lrv0IgWlrlOvrqwUezTfW
         x14EQBTjp+ola9zQTuMxBJ1aZkvUHP7vwFIZkRdaQMRqyIeXFZdLkupX158opl+zsjQU
         PhymsZgTdH26cv5z8VGefv4yx3jhg/+wAscZWXGm4sJQihRtrkz/mcZHv2R2tduXxAng
         avCHB4kDr1YgWe+qVIFwyhawIs4y8q6I2X7RrwfYxntF3wJRtxLWNXK6mquROgPU+kh7
         UxRA==
X-Gm-Message-State: APjAAAVBKoYgmKJYOck+cRzqiKao0TwGnSgnkNfAzintYAMAVF1JtkKZ
        YJSRoCSZLvSmhox51Ei1f08=
X-Google-Smtp-Source: APXvYqzcE1dCn3q7phznH1vyMXkl7qSNRon1S425yX+yB3XidPafUbKkJXgJLBKXzp71+pN5DgHlRw==
X-Received: by 2002:aa7:9a89:: with SMTP id w9mr77416934pfi.213.1555449255384;
        Tue, 16 Apr 2019 14:14:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m7sm70388306pgg.62.2019.04.16.14.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:14:14 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:14:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190416211413.GB26442@roeck-us.net>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416205003.GA8268@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416205003.GA8268@kunai>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:50:03PM +0200, Wolfram Sang wrote:
> Hi Jerry,
> 
> > I applied patches 1,2 & 6 in testing.
> > 
> > Note, that hpwdt is passing NULL as the third parameter to watchdog_init_timeout().
> > 
> > The second patch in this series is using "dev" as input to dev_err and dev_warn.
> > 
> > This results in the following in dmesg when trying to load hpwdt w/ an invalid soft_margin:
> > 
> > 
> > [   80.848160] (NULL device *): driver supplied timeout (4294967295) out of range
> > [   80.855429] (NULL device *): falling back to default timeout (30)
> 
> Thank you for this report. Yes, using 'dev' blindly is a bug.
> 
> > if the call in hpwdt driver is changed to:
> > 
> > 	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, &dev->dev))
> > 
> > 
> > We see the message like we'd desire:
> > 
> > [ 2061.167100] hpwdt 0000:01:00.0: driver supplied timeout (4294967295) out of range
> > [ 2061.174633] hpwdt 0000:01:00.0: falling back to default timeout (30)
> 
> The above observation makes sense, but I think we should fix the core
> code and not the hpwdt driver. My suggestion would be to add something
> like this to watchdog_init_timeout():
> 
> 	struct device *err_dev = dev ?: wdd->parent;
> 
> And then use err_dev for all the printing. Guenter?
> 

That is a good idea, and we should do that. Unfortunately, wdd->parent can also
be NULL, either because there is no parent device (e.g. softdog.c), or because
the driver author forgot to set ->parent. So we still need a fallback.
Does it make sense to print watchdog_info->identity if both dev and wdd->parent
are NULL ?

Guenter
