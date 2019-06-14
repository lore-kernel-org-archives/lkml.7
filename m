Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7703C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947F22177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560526350;
	bh=PJ6s6+mmJeZDNa175UFy5kch2QVF530bftti5lPPeJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bQ/lZcVlQj6lWrJsGV1sK5xqhQ+i6UfBxrlDZBRyoMzGU8cw2Hw2W+Ff0FlP4sqzl
	 HmWJ9BBBC3PpHXX1pComQ0NYgbnZ6tNi5qw1dVIuAgMz/VbyaEbtdnH7jTCMN3NHQc
	 xNP3aK7vGcuPMJuOYs2z75Kda4pgQVDOGKVl3UJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFNPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:32:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B5A2175B;
        Fri, 14 Jun 2019 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560526348;
        bh=PJ6s6+mmJeZDNa175UFy5kch2QVF530bftti5lPPeJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbv6v96aJHaQI82B1bM2l/P5uwdjb9rBNbcYo4w0uUZFLkccGWIXvBGpki/PZ8C4S
         FHJUzHYRR6zQKiu0bo6GftzC0byFL18pRtsSAjF6zgyC9sbUuhR1qDtjKrBMVMaNzH
         PouLYg27ntO8rTWKzCnoK0IzuyU6hxLIhqPJWCEU=
Date:   Fri, 14 Jun 2019 17:32:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Jack Ping CHNG <jack.ping.chng@linux.intel.com>,
        kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drivers: Provide devm_platform_ioremap_resource_byname()
Message-ID: <20190614153225.GE18049@kroah.com>
References: <39e46643-d799-94b7-4aa5-d6d99d738f99@web.de>
 <20190614133840.GN9224@smile.fi.intel.com>
 <20190614141004.GC7234@kroah.com>
 <20190614144706.GO9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614144706.GO9224@smile.fi.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 05:47:06PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 14, 2019 at 04:10:04PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 14, 2019 at 04:38:40PM +0300, Andy Shevchenko wrote:
> > > +Cc: Jack Ping, who did internally the same
> > > 
> > > On Fri, Jun 14, 2019 at 03:26:25PM +0200, Markus Elfring wrote:
> > > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > > Date: Fri, 14 Jun 2019 15:15:14 +0200
> > > > 
> > > > The functions “platform_get_resource_byname” and “devm_ioremap_resource”
> > > > are called together in 181 source files.
> > > > This implementation detail can be determined also with the help
> > > > of the semantic patch language (Coccinelle software).
> > > > 
> > > > Wrap these two calls into another helper function.
> > > > Thus a local variable does not need to be declared for a resource
> > > > structure pointer before and a redundant argument can be omitted
> > > > for the resource type.
> > > 
> > > This one makes sense.
> > > Though I'm not sure Greg will see your message.
> > 
> > Nope, didn't see it, don't want to see it, it will only cause more work
> > in the longrun...
> > 
> > > Rafael, maybe you can apply this one?
> > 
> > Um, don't go around maintainers please, that's rude.  
> 
> I won't do it, how should we proceed if de facto this functionality is good to
> have besides the fact of coming new user in the future?
> 
> > There is a reason
> > this specific developer is in my blacklist, and perhaps they should be
> > in yours as well :)
> 
> Perhaps.
> 
> > I don't like adding new apis with no user.
> 
> Perhaps Jack Ping will send it as a first patch of his series where he utilizes
> this functionality. Would it be acceptable?

Yes, that would be ok.

thanks,

greg k-h
