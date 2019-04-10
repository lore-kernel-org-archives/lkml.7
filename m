Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC8AC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9052070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfDJSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:46:32 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:37730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728881AbfDJSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:46:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 95AF6182CF668;
        Wed, 10 Apr 2019 18:46:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: news29_8f85f0d775256
X-Filterd-Recvd-Size: 2047
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Apr 2019 18:46:26 +0000 (UTC)
Message-ID: <e76117d45b1b1caff6bce8d28506e683694d6a79.camel@perches.com>
Subject: Re: [PATCH 18/22] watchdog: mt7621_wdt: Use 'dev' instead of
 dereferencing it repeatedly
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Wed, 10 Apr 2019 11:46:24 -0700
In-Reply-To: <1554913683-25454-19-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
         <1554913683-25454-19-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 09:27 -0700, Guenter Roeck wrote:
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatedly.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches

Interesting collection.  It would be useful to specify which
particular script generated or enabled this patch.

Just scanning briefly, it might have been this one:
https://github.com/groeck/coccinelle-patches/blob/master/common/deref.cocci
But it looks like some manual bit might have been required too.

And trivially:

> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
[]
> @@ -133,18 +133,19 @@ static struct watchdog_device mt7621_wdt_dev = {
[]
>  	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
> -			      &pdev->dev);
> +			      dev);

This could be on one line.


