Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B09DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ED820830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfJCOXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:23:44 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47973 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfJCOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:23:44 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1DB0A240022;
        Thu,  3 Oct 2019 14:23:41 +0000 (UTC)
Date:   Thu, 3 Oct 2019 16:23:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: Add support for century bits to m41t62 (rv4162) RTC
 devices
Message-ID: <20191003142341.GD575@piout.net>
References: <20190911154803.15969-1-lukma@denx.de>
 <20191003114831.GR4106@piout.net>
 <20191003142150.3d73a9d7@jawa>
 <20191003123538.GS4106@piout.net>
 <20191003151434.49762715@jawa>
 <20191003134329.GB575@piout.net>
 <20191003161054.1eeae401@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003161054.1eeae401@jawa>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2019 16:10:53+0200, Lukasz Majewski wrote:
> Sorry, but I do see some inconsistency here.
> 
> The application note [1] says that the correction shall be done in
> application SW.
> 
> The rtc-range.c program [2] sets and reads the time via ioctl (e.g.
> RTC_SET_TIME, RTC_RD_TIME).
> 
> To pass your tests one needs to do the correction in linux kernel
> driver for drivers/rtc/rtc-m41t80.c. 
> 
> Please correct me if I'm wrong, but IMHO it shall be enough to adjust
> 2100, 2200, 2300, years in this driver (the submitted patch shall be
> adjusted to support it - I can prepare proper v2).
> 

There is no way you will be able to know when to adjust the date because
Linux may or may not be running when the boundary is crossed.

The only useful range for an RTC is its fully contiguous range. If it
needs software to run to support an extended range, it can't be used in
the context of Linux.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
