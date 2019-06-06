Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB5DC28EB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DF820693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqIZgrne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfFFQz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:55:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40092 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:55:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so1159280pla.7;
        Thu, 06 Jun 2019 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u6Y+cqrYVOxVvx9PJQvJzOmV48wnJDsYZSMNZJzXapE=;
        b=KqIZgrneAkfId4BXzJlJ/Ba8ZWCyfARfJKryBHIwJpFOUWjvAFIhrMepKB/WdmaJCW
         +Q80K/fqEwYpYM9kk/LC4dVD2ffjBQhjIlpa6xmKPFYunh8O9gYd56CtjXDBwr5UhYX6
         uhvj7YSiUsR2Txa/kz6rPS4nTfow4cH/wA73R6mnZxQtz1ELmkKUURkHP1Ho0flF+Tgx
         QVzbpjAAcaVuL5DWYrX+exTgeFmY61JZuMYPfF/xqAMkOIj4SPQ+T787MdhgLcFBWZc/
         FMivxtwW7WooFzXWErEAvPQ9y+MNrWGFbjU4zl3Fd15Qs3FJT1CjMA5HYrl6nwB7sSNP
         v/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u6Y+cqrYVOxVvx9PJQvJzOmV48wnJDsYZSMNZJzXapE=;
        b=Jg5jDJvQ9DpP4pKDENeRFgUIhWnWjmOGjXkND78TZcD34GXDHX/5kGsPXhBZMsiQm8
         Ynvo5Sh7YupUEEJ1knIYFJGZg/wROKJWjT0LfXOXRp2xCliDGzvEk/8x/99DWhtiGdtQ
         S8Au84JgebV0Z2+VZ5Wu47ihLs84Q6Bn5A56PoZM1LQQqXdPlkMQktKw+m7MwjNCVsK9
         WoySHS2KjCRTwt3BlvOgB54oLu+cjK1d3YHTRBdTnZt3/rDhFSg3MU7MUu5wEXC15V6i
         HmTAF/tKtM9mAQLPvDEYDJcUR9mejaLdRiVNfpnnk8LK8Mdi3apNHFX9BBLw+lDPT4iN
         5r+w==
X-Gm-Message-State: APjAAAX1a7aTtmwCpbA8ZL//U58IXgVUPvqhQnRNkebuhcbKkCeg+3db
        P0aXAQUXjO4svopeRQllzNxOHm82
X-Google-Smtp-Source: APXvYqwHF6yRaqzqDbC6gurFQGmA6lvnuMqzvtLNElTfoD8vZ9MYpXIJJZthS6U1heSqJXe4EB/EMA==
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr50809503plb.193.1559840157877;
        Thu, 06 Jun 2019 09:55:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l21sm2257286pff.40.2019.06.06.09.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 09:55:57 -0700 (PDT)
Date:   Thu, 6 Jun 2019 09:55:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] hwmon: core: fix potential memory leak in
 *hwmon_device_register*
Message-ID: <20190606165555.GA32130@roeck-us.net>
References: <20190530025605.3698-1-eduval@amazon.com>
 <20190530025605.3698-3-eduval@amazon.com>
 <20190605203837.GA30238@roeck-us.net>
 <20190606143509.GF1534@u40b0340c692b58f6553c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606143509.GF1534@u40b0340c692b58f6553c.ant.amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 07:35:44AM -0700, Eduardo Valentin wrote:
> On Wed, Jun 05, 2019 at 01:38:38PM -0700, Guenter Roeck wrote:
> > On Wed, May 29, 2019 at 07:56:05PM -0700, Eduardo Valentin wrote:
> > > When registering a hwmon device with HWMON_C_REGISTER_TZ flag
> > > in place, the hwmon subsystem will attempt to register the device
> > > also with the thermal subsystem. When the of-thermal registration
> > > fails, __hwmon_device_register jumps to ida_remove, leaving
> > > the locally allocated hwdev pointer.
> > > 
> > > This patch fixes the leak by jumping to a new label that
> > > will first unregister hdev and then fall into the kfree of hwdev
> > > to finally remove the idas and propagate the error code.
> > > 
> > 
> > Hah, actually this is wrong. hwdev is freed indirectly with the
> > device_unregister() call. See commit 74e3512731bd ("hwmon: (core)
> > Fix double-free in __hwmon_device_register()").
> 
> heh.. I see it now. Well, it is not a straight catch though. 
> 
> > 
> > It may make sense to add a respective comment to the code, though.
> > 
> 
> I agree. Or a simple comment saying "dont worry about freeing hwdev
> because hwmon_dev_release() takes care of it".
> 
> Are you patching it ?
> 

Will do. I'll send a patch in a minute.

Thanks,
Guenter
