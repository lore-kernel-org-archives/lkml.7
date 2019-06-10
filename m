Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3CAC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E001206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbfFJTMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:12:48 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:35034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbfFJTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:12:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6460E100E86C2;
        Mon, 10 Jun 2019 19:12:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: noise96_8c799a9dcb15d
X-Filterd-Recvd-Size: 2203
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Jun 2019 19:12:45 +0000 (UTC)
Message-ID: <cd2fe2492251187acf62744a191cf6d76732f9e7.camel@perches.com>
Subject: Re: [PATCH 3/5] random: Add and use pr_fmt()
From:   Joe Perches <joe@perches.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, tytso@mit.edu, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 10 Jun 2019 12:12:44 -0700
In-Reply-To: <20190607182517.28266-3-tiny.windzz@gmail.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
         <20190607182517.28266-3-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-07 at 14:25 -0400, Yangtao Li wrote:
> Prefix all printk/pr_<level> messages with "random: " to make the
> logging a bit more consistent.
> 
> Miscellanea:
> 
> o Convert a printks to pr_notice
> o Whitespace to align to open parentheses
> o Remove embedded "random: " from pr_* as pr_fmt adds it
[]
> diff --git a/drivers/char/random.c b/drivers/char/random.c
[]
> @@ -1031,15 +1033,15 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
>  		crng_init = 2;
>  		process_random_ready_list();
>  		wake_up_interruptible(&crng_init_wait);
> -		pr_notice("random: crng init done\n");
> +		pr_notice("crng init done\n");
>  		if (unseeded_warning.missed) {
> -			pr_notice("random: %d get_random_xx warning(s) missed "
> +			pr_notice("%d get_random_xx warning(s) missed "
>  				  "due to ratelimiting\n",

Trivia:

It'd be nice to coalesce the format string fragments
into a single line at the same time too.

			pr_notice("%d get_random_xx warning(s) missed due to ratelimiting\n",
 				  unseeded_warning.missed);

>  			unseeded_warning.missed = 0;
>  		}
>  		if (urandom_warning.missed) {
> -			pr_notice("random: %d urandom warning(s) missed "
> +			pr_notice("%d urandom warning(s) missed "
>  				  "due to ratelimiting\n",

etc...



