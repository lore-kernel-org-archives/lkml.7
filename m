Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D2AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 22:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BD206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 22:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfHYWNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 18:13:13 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:34111 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728931AbfHYWNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 18:13:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 89B4818224D78;
        Sun, 25 Aug 2019 22:13:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lock65_1bc21af378138
X-Filterd-Recvd-Size: 1900
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Aug 2019 22:13:10 +0000 (UTC)
Message-ID: <98427b15d2a5cc93c72867bb7800df6c38f1f7bf.camel@perches.com>
Subject: Re: [PATCH] cdrom: make debug logging rely on pr_debug and debugfs
 only.
From:   Joe Perches <joe@perches.com>
To:     Diego Elio =?ISO-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 25 Aug 2019 15:13:09 -0700
In-Reply-To: <20190825215833.25817-1-flameeyes@flameeyes.com>
References: <20190825215833.25817-1-flameeyes@flameeyes.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-25 at 22:58 +0100, Diego Elio Pettenò wrote:
> The cdrom driver predates debugfs and most of the modern debugging
> facilities, so instead it has been includings a module parameter and an
> ioctl to enable debug messages.
> 
> In 2019, debugfs and dynamic debug makes most of that redundant, and even
> confusing when trying to trace things in the dept of the driver.
[]
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
[]
> @@ -591,7 +556,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
>  	static char banner_printed;
>  	const struct cdrom_device_ops *cdo = cdi->ops;
>  
> -	cd_dbg(CD_OPEN, "entering register_cdrom\n");
> +	pr_debug("entering register_cdrom\n");

debut output for function tracing can also be removed
and ftrace used instead.

> @@ -643,7 +608,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
>  
>  void unregister_cdrom(struct cdrom_device_info *cdi)
>  {
> -	cd_dbg(CD_OPEN, "entering unregister_cdrom\n");
> +	pr_debug("entering unregister_cdrom\n");

etc...


