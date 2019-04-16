Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA780C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5171206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfDPQE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:04:57 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52939 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfDPQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:04:57 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9C2D940004;
        Tue, 16 Apr 2019 16:04:54 +0000 (UTC)
Date:   Tue, 16 Apr 2019 18:04:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: ds1685: use threaded interrupt
Message-ID: <20190416160453.GN3578@piout.net>
References: <20190416093404.6785-1-tbogendoerfer@suse.de>
 <20190416093404.6785-2-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416093404.6785-2-tbogendoerfer@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 11:34:04+0200, Thomas Bogendoerfer wrote:
> Handling of extended interrupts (kickstart, wake-up, ram-clear) was
> moved off to a work queue, but the interrupts aren't acknowledged
> in the interrupt handler. This leads to a deadlock, if driver
> is used with interrupts. To fix this we use a threaded interrupt, get rid
> of the work queue and do locking with just the rtc mutex lock.
> 
> Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time clocks")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/rtc/rtc-ds1685.c   | 220 +++++++++++++++++++++------------------------
>  include/linux/rtc/ds1685.h |   2 -
>  2 files changed, 104 insertions(+), 118 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
