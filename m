Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CD9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868A1214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="RCduyU6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfEHKUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:20:48 -0400
Received: from onstation.org ([52.200.56.107]:54298 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfEHKUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:20:47 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 610443E941;
        Wed,  8 May 2019 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1557310846;
        bh=GQMfiDCH+yPuPYxmkr3rVNJiGPHx3JJy8lKsx/Svqk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCduyU6kHTTTdGkLVgNg48NGethGwiEZa+Os/9cU/btdu1k09pKeqPLBcFrTFnqZi
         gSQsKHFt7TmyOvd7Ui6zrplzj/60nk8rhrxOgS7Kgu0/2ARXPTQACAcd38izUrgcUV
         xvrOYjFChA4XemKLTx92uZ4Bmw5nQt4HOJkh6bpA=
Date:   Wed, 8 May 2019 06:20:46 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190508102046.GA18635@basecamp>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
 <20190507030241.GC14916@sirena.org.uk>
 <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
 <20190507110345.GF14916@sirena.org.uk>
 <20190507120730.5ylk6v4yvzxuzqld@earth.universe>
 <20190508060936.GH14916@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508060936.GH14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 03:09:36PM +0900, Mark Brown wrote:
> On Tue, May 07, 2019 at 02:07:30PM +0200, Sebastian Reichel wrote:
> 
> > FWIW, I send out kernel.org mails via mail.kernel.org. Konstantin
> > added that service in 2014. You can get a password with
> 
> > ssh git@gitolite.kernel.org getsmtppass
> > 
> > and then use the following settings for (example for git):
> 
> I'd have to send all mail out via kernel.org to do that, or persuade a
> MTA to route mail differently based on contents which seems interesting
> - I inject most of my mail via /usr/sbin/sendmail rather than SMTP
> (including a bunch of scripts).

I use a program called msmtp (https://marlam.de/msmtp/) to route email
to different SMTP servers based on my sender address. Once you have your
accounts configured, replace the call to the sendmail binary in your MUA
with msmtp and it'll route the email differently for you. It's included
in the package repositories for most major Linux distributions. Here's
two resources I found that show how to configure mutt and git send-email
to use msmtp:

https://hostpresto.com/community/tutorials/how-to-send-email-from-the-command-line-with-msmtp-and-mutt/
https://jordonwu.github.io/blog/2015/12/01/git-send-email-and-msmtp-config/

Once you have msmtp setup, send test emails from each of your accounts
to check-auth@verifier.port25.com to have a bot verify that your email
is setup properly (DKIM, SPF, reverse DNS, etc).

Brian
