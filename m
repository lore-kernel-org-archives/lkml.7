Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F314CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF6420679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0emUZ4DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbfJVRSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:18:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43554 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfJVRSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:18:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so18022809ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=JbSeTyaaDeS0Oac3Dz/SH3vfJqau6TFa9nT5osYxqic=;
        b=0emUZ4DIyrkOQb97o35j44irCAOu5E+woH6fECqyL5uCGqYFsGORlvuLr8FFcJl2Dw
         C6DMgOVSLo2mmE2roDg4aHtF4jWZmbzwZz+AkHrr3+BNHkWwWGAhKfo9vhDAjDDypb3f
         +DCa6+CTdQFMW93ApP+p2eu61uKvUj4QWjA2Sdaq9E961KzBzgsKvbq0z5i2bEPTCipE
         tdzqffi4FWUmGSvvDASGSZxelEVmvFrEU4Q20iW468z/PQIUr2TdQjTTJ1HV2Q47rKtT
         C8CWomXFlYuniNcpugn4jtxubW6hyVXPvFgU+TX8SMMRToZmCvtpZTKOmvwvZO07HLHR
         YgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=JbSeTyaaDeS0Oac3Dz/SH3vfJqau6TFa9nT5osYxqic=;
        b=U4K/tru+J+XmnGBTVQ/Ec3AROfGm3U87wAn4TFv5pCcs5sAkFvivqkro3rjeAx5laC
         DftoWUsvpoB2OmJJEJgscOpYwoiMjfej5ZUCoBGGZEd2OIQ3bwnWxry204LjiyCjRd9v
         wsm9n/b991TElSLWhTaQSOPUm0Ph0BtMzN20i7fNt/x4+TjF0+4uEitdNkK/CLGJRHnx
         0rcTTJDa/ybRVzW3+llQtLrGAbCKt3AZQhX0dd/Cb49wj3J9tELUqRLrivYGeI+oKFAq
         c372+ku0LRvyrJ92eLK+qLe64JqiqFHAuSmKRcMzx5wp21m+4iFlRezPXg6W0xwPgM/s
         B/Lg==
X-Gm-Message-State: APjAAAW96NAiOAIEEmVAxpeuD/5v4Ij3OWjLygSUMnMhlVPRqkQc64tK
        IS9NaajqWl1JKLlo4z+tUuHgZA==
X-Google-Smtp-Source: APXvYqxfS0KYXiZzlr4Zb6U6jiZAmr9m2KY1CTPUKISzb24hQeJNLXEd/Q5Ef4KgY/or62HPngcoiQ==
X-Received: by 2002:a2e:3919:: with SMTP id g25mr19605019lja.242.1571764679410;
        Tue, 22 Oct 2019 10:17:59 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 81sm9324414lje.70.2019.10.22.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:17:58 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:17:47 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Woojung Huh <woojung.huh@microchip.com>,
        Marc Zyngier <maz@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Stefan Wahren <wahrenst@gmx.net>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] net: usb: lan78xx: Use phy_mac_interrupt() for
 interrupt handling
Message-ID: <20191022101747.001b6d06@cakuba.netronome.com>
In-Reply-To: <20191018131532.dsfhyiilsi7cy4cm@linutronix.de>
References: <20191018082817.111480-1-dwagner@suse.de>
        <20191018131532.dsfhyiilsi7cy4cm@linutronix.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 15:15:32 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-10-18 10:28:17 [+0200], Daniel Wagner wrote:
> > handle_simple_irq() expect interrupts to be disabled. The USB
> > framework is using threaded interrupts, which implies that interrupts
> > are re-enabled as soon as it has run.  
> 
> Without threading interrupts, this is invoked in pure softirq context
> since commit ed194d1367698 ("usb: core: remove local_irq_save() around
> ->complete() handler") where the local_irq_disable() has been removed.  
> 
> This is probably not a problem because the lock is never observed with
> in IRQ context.
> 
> Wouldn't handle_nested_irq() work here instead of the simple thingy?

Daniel could you try this suggestion? Would it work?

I'm not sure we are at the stage yet where "doesn't work on -rt" is
sufficient reason to revert a working upstream patch. Please correct 
me if I'm wrong.
