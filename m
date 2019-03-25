Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B881F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfCYOyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:54:49 -0400
Received: from muru.com ([72.249.23.125]:42406 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCYOys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:54:48 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6076B80CC;
        Mon, 25 Mar 2019 14:55:01 +0000 (UTC)
Date:   Mon, 25 Mar 2019 07:54:44 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
Message-ID: <20190325145444.GK19425@atomide.com>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-4-dmurphy@ti.com>
 <20190322221654.GG19425@atomide.com>
 <dc24b66c-658e-41aa-c869-42c4a7e812a8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc24b66c-658e-41aa-c869-42c4a7e812a8@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dan Murphy <dmurphy@ti.com> [190325 12:36]:
> On 3/22/19 5:16 PM, Tony Lindgren wrote:
> > I can control the backlight brightness just fine via /sys, and
> > backlight shows up as the trigger in /sys/class/leds/lm3532:backlight,
> > but /sys/class/backlight is empty and looks like drm can't find it.
> > 
> > Do I need to enable some additional driver(s) to get this to work
> > with the drm driver?
> > 
> 
> Can you dump or point to the defconfig?

This is just with the omap2plus_defconfig as in the droid4-pending-v5.0
test branch below [0]. That branch has Sebastian's drm patches. The
branch also has the older ti-lmu patches that I reverted for testing
before applying your new series and enabling it in .config.

The drm driver (drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c) just
does:

backlight = of_parse_phandle(node, "backlight", 0);
...

That should still work the same, right?

Regards,

Tony


[0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v5.0
