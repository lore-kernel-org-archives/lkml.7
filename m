Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA401C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A861208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560492564;
	bh=MCq50Ao69iZZCdhmd9FQAh4J7GheaJEiNvU0CEIW6mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NNuHhbOx00pn9HW1DEaipTbQAckVzummjjdZV135a3fET2tmzwls9BOJgkZFy7V8G
	 XP9VL/oE5+ApOJ68GrGChIijLsxR9D1LvEX8lKH79aRAyWIY9t8ISRzqzIIhBql26W
	 Pz3Ldjtu6KPt/1Ey10fTsPjLJUca7HfujneU+8OM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfFNGJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNGJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:09:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE0EE20851;
        Fri, 14 Jun 2019 06:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560492562;
        bh=MCq50Ao69iZZCdhmd9FQAh4J7GheaJEiNvU0CEIW6mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hm1dCsjsHea4fg7qzxjZ6g0blwGo+xVDbRbqB9NosDIfEu/PIUCSTzrrwRqT3nOu8
         7QDbzySTfK1tDfOXdKZMYcD49RNnF/dXsqftus1pyaHBNxEm3hliVqT5LRRHRJB8fu
         ltziWtYwHPwzfCyBCug8PL8A8OtM/Lmb7Jr736Nw=
Date:   Fri, 14 Jun 2019 08:09:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     groeck@google.com, linux-kernel@vger.kernel.org,
        groeck@chromium.org, adurbin@chromium.org, dlaurie@chromium.org
Subject: Re: [PATCH] gsmi: replace printk with relevant dev_<level>
Message-ID: <20190614060919.GA7271@kroah.com>
References: <20190613185705.GA16951@ahmlpt0706>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613185705.GA16951@ahmlpt0706>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:27:05AM +0530, Saiyam Doshi wrote:
> Replace printk() with dev_* macros for logging consistency.
> In process of replacing printk with dev_err, dev_info etc.,
> removed unnecessary "out of memory" debug message.

That is multiple things done in the same patch, please break this up
into a patch series, only doing one "logical" thing per patch.

Note, generic cleanup patches like this are tough to get done in the
"real" part of the kernel, I strongly recommend you start out in
drivers/staging/ where these types of changes are welcomed.  Get
experience there and then move out into other areas of the kernel if you
want to, that way you don't annoy developers/maintainers with basic
errors like this.

good luck!

greg k-h
