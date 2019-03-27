Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A8B2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711326;
	bh=sYYHvKeWC88YLOkAVkldwoRznvvxDdT5buVntOmPy9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zNF2yJkD9dbfGX18yEcYnO7XLrlJctxTiR5viE7qyjRyA9WVYqxzTdjmtwW7jJOUh
	 IBrqLtBxV3U9XhdyMBZ6dtWzBcMqaUqUpo5NYqCbx85Slwz+MQJYSYX+c7k2UFTqeJ
	 pGfgqpZtmw0jijOQQHx7P5grHmqhefGtRkipOobU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391930AbfC0S2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391917AbfC0S2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:28:42 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D7D2082F;
        Wed, 27 Mar 2019 18:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711321;
        bh=sYYHvKeWC88YLOkAVkldwoRznvvxDdT5buVntOmPy9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kubmpPdUaNWLF3NbONxOVi9dU1k6E/aOgsnLX8SkZI8VQddTCuvHgKuO3LYZNgVs1
         rLG54uuOy5kCYfnZsUsuU6NyFRUJi7578ukbGGQuHjNTwQpMtbIwphOFBY389/5Dmp
         vthPSjyQYvQkQmMbbqqSkmhKXnG4yalRbJ7VQRNI=
Date:   Thu, 28 Mar 2019 01:51:02 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        linux-netdev@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Add Fieldbus subsystem + support HMS Profinet card
Message-ID: <20190327165102.GA26051@kroah.com>
References: <20190318180338.23964-1-TheSven73@gmail.com>
 <20190327164922.GA12063@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327164922.GA12063@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:49:22AM +0900, Greg KH wrote:
> On Mon, Mar 18, 2019 at 02:03:32PM -0400, Sven Van Asbroeck wrote:
> > This patch:
> >   1. adds a Fieldbus subsystem
> >   2. adds support for the HMS Industrial Networks AB Profinet card.
> > 
> 
> <snip>
> 
> Can I get a follow-on patch to add a TODO file to this directory in
> staging saying what needs to be done to the code to get it out of
> staging?

Actually, just add it to the resend when you fix up the following build
errors that I get when I applied this series and built it:

ERROR: "devm_regulator_register" [drivers/staging/fieldbus/anybuss/arcx-anybus.ko] undefined!
ERROR: "rdev_get_drvdata" [drivers/staging/fieldbus/anybuss/arcx-anybus.ko] undefined!

thanks,

greg k-h
