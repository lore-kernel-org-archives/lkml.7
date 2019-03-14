Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8338020854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfCNKET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:04:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52051 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCNKET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:04:19 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4NDl-0006id-IW; Thu, 14 Mar 2019 11:04:17 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4NDk-0002hp-8t; Thu, 14 Mar 2019 11:04:16 +0100
Date:   Thu, 14 Mar 2019 11:04:16 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/4] leds: netdev trigger: use memcpy in device_name_store
Message-ID: <20190314100416.5ywtxhsbhqz6rvdq@pengutronix.de>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-2-linux@rasmusvillemoes.dk>
 <20190314092929.65amwzsaswcvsexl@pengutronix.de>
 <8b2903c9-e56b-ea22-41b2-d6f96bec1d96@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b2903c9-e56b-ea22-41b2-d6f96bec1d96@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 10:57:14AM +0100, Rasmus Villemoes wrote:
> On 14/03/2019 10.29, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Wed, Mar 13, 2019 at 09:26:12PM +0100, Rasmus Villemoes wrote:
> >> --- a/drivers/leds/trigger/ledtrig-netdev.c
> >> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> >> @@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
> >>  		trigger_data->net_dev = NULL;
> >>  	}
> >>  
> >> -	strncpy(trigger_data->device_name, buf, size);
> >> +	memcpy(trigger_data->device_name, buf, size);
> >> +	trigger_data->device_name[size] = '\0';
> > 
> > This is open-coding
> > 
> > 	strlcpy(trigger_data->device_name, buf, size);
> 
> No. size here is the number of bytes userspace wrote, which never (well,
> almost never, they could do something odd) contain a nul byte. Passing
> that as size to strlcpy would guarantee that we chopped off the last
> character from the user input.

You're right here, strlcpy isn't a replacement here. I withdraw my
suggestion.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
