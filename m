Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429C0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ACE21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576659974;
	bh=0BUHQxelaIbpcyTbJXAUhvHYdT3wPBLKD9ngCccacow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pbWKxYPkyy0vjQJW8PW/GwinfYgUohr9YiwZvX3F4SOjnOnS1TG/Slw3ShR5vp71k
	 RsiIHLCQE+z8UK3bgUvzGX7xsuVsenUdLB9Smv0GPIg9DVV+q31+uAwuUrsNqhnqiJ
	 9WnmYSjvtZnOibfowq0ORad7EkWMJOm1y//W7QeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLRJGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:06:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42909 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:06:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so1110193lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 01:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LoWGVsAFVqdPCZk3645h8RlXm3r92XUsX5DvRrh+veI=;
        b=oKKkUU1kfNVi27g8ZV8R4z+v65yepuSYMhY8XUjlqX3aKZP0/JQvcC8uUEpHHoDPuD
         0CklNS0IJIhTfRCwCnhWdt6cy8kEWcMS19ri71hBCA3W6ErduYVnFFRToY4pnnbnkeDM
         pqgrST5x1p6p/zI/Tg/BtoR8Gr3SFGxTb5eT7aRR6zoqHbCoYcVrs/8izmY2Qk4KRHqy
         fwkwUQJ1CaIe8dAL0COeLR38ePu2SIREL6QdDvDHn09KijHPgz3Z9VNOHVHaJ6b4R1Ed
         h9jMT80FIY1Y+YKAkJfSDRV9CKE8+z7FDN37VZFJX1sJ0MpBLblG4VNGZRH8MkoLKhpQ
         l2/g==
X-Gm-Message-State: APjAAAV8QrIKNYfq8RU8JOwMZxiOjBUZXegsHVcGMBop6g10uIeiJtvA
        Ztq4Tn/HRUF0P0AqVKXaieQ=
X-Google-Smtp-Source: APXvYqxrwoJMzM6SBVb05umAFTDMomAqvjatJWBl0k523u/asOxclce1j6Gz8TUpGt/VsBkZVleRfA==
X-Received: by 2002:ac2:5975:: with SMTP id h21mr1008826lfp.165.1576659970887;
        Wed, 18 Dec 2019 01:06:10 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id c20sm727300ljj.55.2019.12.18.01.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 01:06:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ihVHS-0002uT-7d; Wed, 18 Dec 2019 10:06:06 +0100
Date:   Wed, 18 Dec 2019 10:06:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] serdev: fix builds with CONFIG_SERIAL_DEV_BUS=m
Message-ID: <20191218090606.GJ22665@localhost>
References: <201912181000.82Z7czbN%lkp@intel.com>
 <20191218083842.14882-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218083842.14882-1-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 09:38:42AM +0100, Uwe Kleine-König wrote:
> Commit 54edb425346a ("serdev: simplify Makefile") broke builds with
> serdev configured as module. I don't understand it completely yet, but
> it seems that
> 
> 	obj-$(CONFIG_SERIAL_DEV_BUS) += serdev/
> 
> in drivers/tty/Makefile with CONFIG_SERIAL_DEV_BUS=m doesn't result in
> code that is added using obj-y in drivers/tty/serdev/Makefile being
> compiled. So instead of dropping $(CONFIG_SERIAL_DEV_BUS) in serdev's
> Makefile, drop it in drivers/tty/Makefile.

Why not simply revert the offending patch? There are some dependencies
here related to how the tty layer is built. If you're still not certain
on why things broke, I suggest just reverting for now.

You can send a follow-up clean up if you think that's warranted instead.

> Fixes: 54edb425346a ("serdev: simplify Makefile")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> as Greg already added the offending patch to tty-next I assume it is
> frozen and cannot be dropped any more, so here is an incremental fix.

Johan
