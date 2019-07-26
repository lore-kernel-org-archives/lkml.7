Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5ACC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD65218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfGZR3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:29:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41744 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfGZR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:29:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id v22so39602897qkj.8;
        Fri, 26 Jul 2019 10:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrswEMq49v0E6o4rCshYouYaas2WPZBTPTlCzSQC26c=;
        b=BsAs8CEVE29gEs+jDGIH87bg5feWerYpY/8VF8FGCIxBgBNhIYi9OraX5TcO6BZY2h
         iHr4Jk7CHnTuImVgL0ZHbYSQKO6gMmqls4GFn23DX56+phLs5tzeRRyE2BkvpLvJV6BW
         8L6P3lTvtPJSneWU8V46hsXrfmjQqUXNcUjVss+m/AYN6sIEgiPAFpA910eZCgLxdMxL
         /zTnWoahpInZ+il+U4gA89ztwWBImvulYv+9RPtBVhutQKQHiX+IHOGbwiIMuwE4nYia
         1/hKepg9i10tTjULkPRMTeOkIF05eHTlVdsJ+cXtV19L3KweCvOE4Jd8USLjihYeYbPr
         vhCg==
X-Gm-Message-State: APjAAAWKfTA92harVsT/7lsAOXzj9EzCPopNJIDrLLD6KeMIfqeqA+ae
        U4yf/ksLHlNpXCjpLVBBBkhDyZLSrHI9912jshI=
X-Google-Smtp-Source: APXvYqyeBztnXSiBRW7+PbidYoc+fBMsn3sfImtAWkG860mdcYkPRzviwCac/eeCIlsHK4v5dz+V77TwlT5nEb1WPzo=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr61461306qka.138.1564162145449;
 Fri, 26 Jul 2019 10:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190726135814.48760-1-yuehaibing@huawei.com>
In-Reply-To: <20190726135814.48760-1-yuehaibing@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jul 2019 19:28:49 +0200
Message-ID: <CAK8P3a0q4BVxjEHOAmO2hQGKBWObYitC=ix-Jy8fPuxPxbk0ag@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: initio: Make some functions static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 3:59 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/scsi/initio.c:881:22: warning: symbol 'initio_find_busy_scb' was not declared. Should it be static?
> drivers/scsi/initio.c:919:22: warning: symbol 'initio_find_done_scb' was not declared. Should it be static?
> drivers/scsi/initio.c:1657:5: warning: symbol 'initio_state_7' was not declared. Should it be static?
> drivers/scsi/initio.c:1743:5: warning: symbol 'initio_xpad_in' was not declared. Should it be static?
> drivers/scsi/initio.c:1767:5: warning: symbol 'initio_xpad_out' was not declared. Should it be static?
> drivers/scsi/initio.c:1792:5: warning: symbol 'initio_status_msg' was not declared. Should it be static?
> drivers/scsi/initio.c:1842:5: warning: symbol 'int_initio_busfree' was not declared. Should it be static?
> drivers/scsi/initio.c:1912:5: warning: symbol 'int_initio_resel' was not declared. Should it be static?
> drivers/scsi/initio.c:2368:5: warning: symbol 'initio_bus_device_reset' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

The patch looks fine, but I wonder if sparse should print a different
warning message
here. Note that those functions are in fact static, they just have a
'static' forward
declaration followed by a definition without the 'static' keyword.

The change does improve readability of course, so maybe it's not worth changing
sparse.

      Arnd
