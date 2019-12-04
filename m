Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4606BC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254872081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfLDMF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:05:27 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:47662 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:05:27 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icTPI-000TIg-EC; Wed, 04 Dec 2019 13:05:24 +0100
Message-ID: <58738070c6a7df72451f4384567798887bac4c8a.camel@sipsolutions.net>
Subject: Re: [PATCH 4.19 044/321] mac80211: fix station inactive_time
 shortly after boot
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ahmed Zaki <anzaki@gmail.com>, Sasha Levin <sashal@kernel.org>
Date:   Wed, 04 Dec 2019 13:05:23 +0100
In-Reply-To: <20191204115623.GA25176@duo.ucw.cz>
References: <20191203223427.103571230@linuxfoundation.org>
         <20191203223429.401517191@linuxfoundation.org>
         <20191204115623.GA25176@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-04 at 11:56 +0000, Pavel Machek wrote:
 
> > -	if (time_after(stats->last_rx, sta->status_stats.last_ack))
> > +	if (!sta->status_stats.last_ack ||
> > +	    time_after(stats->last_rx, sta->status_stats.last_ack))
> >  		return stats->last_rx;
> >  	return sta->status_stats.last_ack;
> >  }
> 
> I mean, jiffies do wrapraound periodically, so eventually we'll have
> sta->status_stats.last_ack == 0 even through it is not short after
> boot, no?

Yeah. I contemplated that when I applied the original patch - it's a bit
complicated otherwise, you have to track "is this valid" etc.

Since this is updated on pretty much every frame, it's highly unlikely
you'll go without the value for long, so I figured this was good enough.

johannes

