Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AB4C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5390217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAZZ9QTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfDQWAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:00:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38401 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQWAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:00:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so132990plb.5;
        Wed, 17 Apr 2019 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgblIlf5Qc1gp2OuyuklS+7DJRECeay9iFnK4IwZ3uc=;
        b=EAZZ9QTmA5ORmtlwhogxoIeJ41WC1QHyCjqP+1mrt+bLvVkBrT4G6L7N7pY6onFY9s
         UJDSNcyNZhc8dExVrTPPmXl3UclaVgL2qoqEfWkAu/B1ophkyjO7CumIpZap9HDrEVBp
         yoNTW9IK4gnk1wqCF+xGxg92JSJXSTxviJXfAjz/UXZQ8DCQfmmt1yGTAPgo5a4JnyXz
         KjPyvC/FHrmujxSaMPPC3HyOYBwj1Oz4j5Kz/IA2df+H2Zi4Ni/BSKhExG4we1OJNNz/
         gP8kfKb5x1eLV9l/gobfuaeuoKPQcRo5X57Q40458KImUwDiPc5W5vZGdCK0KXU6mzAa
         Ghzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgblIlf5Qc1gp2OuyuklS+7DJRECeay9iFnK4IwZ3uc=;
        b=UYqGRzfZ+flnQroebonpKY1J7lrvitiptHHngMoDxkqzgXlNO1TbVVtjrpDskcBuIs
         T2ZE0rFytMvUswqX0OKIBUzUW+Fr4voByM6OmkPbNRdhq2FT/ndbjVcUjeYg4N6+ffCY
         Qqqbx38c+hqiOiZ3Plu6Oga5SpkwkIVllBHPoyHZ3+ca5NT2PSM9rUQDPnkH7kAakpGy
         tb9iydtDDLc7U/aNipvUV3QnMbpcAbixafCe7K//vQXgaw56Gu+Fm3TJIg15reqWLON0
         mNRqSX6SHCChy/cdsO1Jq3ZErEmbl7PVNKshYCNRWvqc4a8upzjyVBB1cApykjX2OA8+
         8vUg==
X-Gm-Message-State: APjAAAV62q6NUYazdSo4QAWpTD37bg1ORyLm6s0N8vdaZdAE13RXmZbU
        BgI79NjMbinTcJPu0/Y1q3Y=
X-Google-Smtp-Source: APXvYqzphHBcgzRBl0i+Zx8MywYWmHG6H0FZG+U2dLnkdBMXk1drnKeIQcIGm3WZjx6iDEEBooJaKw==
X-Received: by 2002:a17:902:b489:: with SMTP id y9mr83281107plr.17.1555538443444;
        Wed, 17 Apr 2019 15:00:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h127sm10791pgc.31.2019.04.17.15.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:00:42 -0700 (PDT)
Date:   Wed, 17 Apr 2019 15:00:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190417220041.GB23015@roeck-us.net>
References: <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net>
 <20190416205533.GB8268@kunai>
 <20190416212046.GC26442@roeck-us.net>
 <20190416221702.GC8268@kunai>
 <20190416223813.GA744@roeck-us.net>
 <20190417194528.xwivkyubhxyfrx4m@ninjato>
 <20190417201758.GB6223@roeck-us.net>
 <20190417211831.GA16788@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417211831.GA16788@kunai>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:18:32PM +0200, Wolfram Sang wrote:
> 
> > > I have the following diff applied on top of patch 2. Works with and
> > > without a parent device. I am not super happy casting 'identity' but
> > > since its u8-type is exported to userspace, I think we can't avoid it.
> > > Guenter, is this cast safe? Here is the diff:
> > > 
> > I would think it is safe, but question is if it is it needed - ie do you see
> > a warning if it isn't there ? Presumably yes; if so, let's just do it.
> 
> Yes, the compiler rightfully complains otherwise.
> 
> Do you prefer resending only patch 2 or the whole series?
> 
Please resend the whole series; that simplifies tracking.

Thanks,
Guenter
