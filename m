Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549FAC432C3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 19:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F61215E5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 19:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="hP1mLjIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLATg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 14:36:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34195 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfLATg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 14:36:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so253312pgf.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 11:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DYmOSMD1BcpuuFPMlel8kjHsCHX2fxH+HvnEIQAuE+A=;
        b=hP1mLjIcOS+hJ4kvQ6XJalDfc+M5rKCS60CDWFbU0nIiInusDOeAV5fLS1Bpe1gyO9
         glE/sYEzK6VYQQKhFiDDXvimInPsX4irDBcKEmP8yzbH4249cpOgLp3Df+9+QhNcrN7v
         rqABDHh8c9HOOs/9ov5xUBH8WqP6hJ2fkLHhlE6+tpOrA9G9q9ZDbT1LAk/hwkzPfumH
         l6sUJ/oKDrJZYBip6ki9IvDqi5zw9A+PWZhsUKHJyDzOYKFFZKgxQPPWM4acAvnlHPvV
         bOVIjahzZwfMdYTHlhUmeRmHQ/+OiMy9tDweBM9SEAe16LPMFU9GissoDvxegpxoiXUA
         Z2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DYmOSMD1BcpuuFPMlel8kjHsCHX2fxH+HvnEIQAuE+A=;
        b=f0DO58bNOhahC0Ogv67InlIHMAYtyOBZzYNbNtgf/cHnjP9n3BZyUvZ64ZIqyjgxOJ
         n3RYzbbJfb2eAzv7QNYflsx+RRMP34SFVO3LvJgUmoorKN1Lsnxg9zVVebcsBWGYquw7
         6vCk04zwBV74QRLDP/KlzDL9n84PYghPND54chHT9RYQcNQTpEcxo4+qY3w921PE0G46
         J6SgXUZ9yLp3mQ9fTNZKXyfQmPQOz/zmBR5YUAoDjdKgSNYDxf/Sz3Hhoad049Lc0uY4
         qc0FkumzvTx7rukEKeBCC9RqmxGktVoSDL4uC7CrV+TEevHRJD2GgqhdGPI4j6TIa5KB
         OO5w==
X-Gm-Message-State: APjAAAW4j7HTu36swZMdk3541IzVHgR6U5rDCDCOQ8DkTFGyjFV54lNG
        Ee8bLbrHDX8MfGgPjwTOGDT3aA==
X-Google-Smtp-Source: APXvYqw/7HI6F49FkvsvGgEqZf7bYFDsdw4FONQdLWlPm5IRyO7lgjqfLDZlH0NRoSILfNxrsg5Miw==
X-Received: by 2002:a65:578e:: with SMTP id b14mr28090389pgr.444.1575229017183;
        Sun, 01 Dec 2019 11:36:57 -0800 (PST)
Received: from debian ([171.49.192.254])
        by smtp.gmail.com with ESMTPSA id i3sm31485662pfd.154.2019.12.01.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 11:36:56 -0800 (PST)
Date:   Mon, 2 Dec 2019 01:06:49 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.4.1
Message-ID: <20191201193649.GA9163@debian>
References: <20191201094246.GA3799322@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201094246.GA3799322@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2019 at 10:42:46AM +0100, Greg KH wrote:
> I'm announcing the release of the 5.4.1 kernel.
> 
> All users of the 5.4 kernel series must upgrade.
> 
> The updated 5.4.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h

hello,

the following readings are from testing performance of 5.4.1 with  5.4.0
the readings are from 5.4.0 to 5.4.1 in 1 is to 1 mapping.
the test results may not be accurate.


5.4 0
-----

real	149m25.803s
user	57m32.082s
sys	5m54.858s

real	141m55.929s
user	52m0.091s
sys	5m15.312s

real	144m18.779s
user	53m1.508s
sys	5m24.352s



5.4.1
-----

real	124m44.923s
user	56m26.547s
sys	5m35.978s

real	104m16.500s
user	51m11.444s
sys	5m1.046s

real	106m1.086s
user	51m45.339s
sys	5m4.815s


--
software engineer
rajagiri school of engineering and technology
