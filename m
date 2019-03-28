Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22541C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A6206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yTKvytau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfC1UJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:09:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45327 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfC1UJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:09:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so24628975qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KM/9zV7nhJZEhAyIMaWFpkTTeCClgzq2ygC/6x7ljpE=;
        b=yTKvytau4zyswCWSQU553tv6x8nxUbcs8dwvf9dRyY7CspwTWvDz9FtXm8l9jV0cXI
         gZ5m47YjN1hyC42Zre/ksmv4kLv/D69sDqnHfALdO+CeVdOQJEZojtPvqQlKYNo+KDah
         x8fEP4GC6b1oJA5BgEYKjsoPsn7aVk2F0XF75q9q/S9shzG6ISsajNOCXtN6K++cFwNT
         1RQt/68m/swdhHMSGmg33zbHA04fZGi8W0W6Dru8QAcZSoomZGAytFnhYm8uGtpiIW9d
         NWdpChwctw1QjINS52NjrjN7RTya46M+Ax2HpCJnxwMZiKhMFckFJ807BXwKyupFWLfu
         YujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KM/9zV7nhJZEhAyIMaWFpkTTeCClgzq2ygC/6x7ljpE=;
        b=IgeaZ53ciuKZu84bQATT+UoQMQN6hbabuJ6KoalzSFzCIMtD8E1g4wr45HLYr1yJ2W
         AG8XuXG1bPS70hay8uWy1kK85QNan7044GaCxWj9qSCIImLy+70AyqnbdYOCBv0KbTh0
         V9nzP3Yfa62ST28A/G1USD3rIJ1pHDxHZSIJM/BFOpqsfSE9+c2wWkv3hdvqVrkN0/PC
         WuAyrXKxlzlxNoblrCyvYn30X6B0BF1Ur99CYSMfhuMA1RhuuLTS+nOdrLZ95uUttsup
         LWmA99RJllZz8ugLY5WG57/RaK9J1Jv9XenSAAMVHUrHWLtdCP4OqGh+BrbtPHOjSNEW
         fS7w==
X-Gm-Message-State: APjAAAVW2KmHLKZ1sVvVB1KxHJvM9DNlfolMPPHSYut6PVZJXwzQvEVb
        iNnYJmzemWSgtGyuKks6TVbjDw==
X-Google-Smtp-Source: APXvYqwFhoFvqklTNFosKHmMhQp6C7fPUkhfZxNVDZ+qeznLZNTWyTRzBtO3A81U9qP+3PdQXd0XkA==
X-Received: by 2002:aed:2267:: with SMTP id o36mr37660116qtc.366.1553803751009;
        Thu, 28 Mar 2019 13:09:11 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n46sm3445937qtn.75.2019.03.28.13.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 13:09:10 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:09:04 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
Message-ID: <20190328130904.48905338@cakuba.netronome.com>
In-Reply-To: <20190328163439.GP14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
        <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
        <20190327201411.GH14297@nanopsycho>
        <20190327222554.GV26076@unicorn.suse.cz>
        <20190328092126.GL14297@nanopsycho>
        <20190328095347.GB26076@unicorn.suse.cz>
        <20190328163439.GP14297@nanopsycho>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 17:34:39 +0100, Jiri Pirko wrote:
> Thu, Mar 28, 2019 at 10:53:47AM CET, mkubecek@suse.cz wrote:
> >On Thu, Mar 28, 2019 at 10:21:26AM +0100, Jiri Pirko wrote:  
> >> Wed, Mar 27, 2019 at 11:25:54PM CET, mkubecek@suse.cz wrote:  
> >> >
> >> >I'm all for implementing new features which are are related to physical
> >> >device (ASIC) rather than network interface only in devlink (at the
> >> >level of kernel-userspace interface). But for features already provided
> >> >by ethtool (userspace utility) I can't help seeing the state of devlink
> >> >support in NIC drivers as a serious blocker.  
> >> 
> >> What I'm thinking about at for some time now would be en explicit
> >> default devlink and devlink_port registration for every netdev for
> >> drivers that does not support devlink themselves. I need to think about
> >> it more, but it seems doable. Then we can hang appropriate things there
> >> and make the ethtoolnl/devlink separation clear. I believe we need to do
> >> it.  
> >
> >That sounds great, such "generic devlink" implementation would be a way
> >around. Kernel could then emulate features which are not implemented by
> >an actual devlink handler (i.e. "generic devlink" is used or particular
> >handler is missing) by falling back to ethtool_ops handler so that
> >userspace could rely on devlink API for things like device information,
> >various dumps, flashing etc. without losing anything.  
> 
> Yep. Plan to do that next week.

The problem with the main part of dev info - fw_version - is that it is
often overloaded in drivers and becomes impossible to parse for users.
I'd rather we didn't dump that nasty chaos in devlink info and let it
die with ethtool IOCTL.

Flashing can also be handled at user space tool level.
