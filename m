Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6DC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B8220895
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556213154;
	bh=SCIodH7XEn+SVzzhfT4BPlio97K+00AmnvERpi2vNOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lt9/F7t8az3Q4nzMQBxt38tLUrZT7PkSL/gPjtkttFA8jtkF1H1/WzgYrOrzQjOq7
	 Lm0QAZRkgrlHDU1cmDNxmbJLlR2Jjjxk3Nz4B3kwyOemulEYR8Z4vAPup4EC85dsOF
	 KZIdcbgbo17V6X7Ys66sp2z/Ukh6E3wNpq8dT/s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfDYRZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDYRZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:25:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD25206BF;
        Thu, 25 Apr 2019 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556213152;
        bh=SCIodH7XEn+SVzzhfT4BPlio97K+00AmnvERpi2vNOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcBwC2BDVB6jhDs3VSJHrfeRkrrTTMI8CoLBRbHeAAMexaWZFtiDwFa5iLQtdeG72
         3pEO5yOI+LTYoQKSsWdgLeY8gIM35iL6J05riBw7ZEGdEPkXhoKmZFnVZiMmqFWeun
         Za8qoRbv85+PGbMy5WkAAJBZaKoG4h6N70uvx2So=
Date:   Thu, 25 Apr 2019 19:25:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrick Venture <venture@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
Message-ID: <20190425172549.GA12376@kroah.com>
References: <20190423142629.120717-1-venture@google.com>
 <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> >
> > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > >
> > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > currently present into this folder.  These drivers are not generic part
> > > drivers, but rather only apply to the ASPEED SoCs.
> > >
> > > Signed-off-by: Patrick Venture <venture@google.com>
> >
> > Accidentally lost the Acked-by when re-sending this patchset as I
> > didn't see it on v1 before re-sending v2 to the larger audience.
> 
> Since there was a change between v1 and v2, Arnd, I'd appreciate you
> Ack this version of the patchset since it changes when the soc/aspeed
> Makefile is followed.

I have no objection for moving stuff out of drivers/misc/ so the SOC
maintainers are free to take this.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
