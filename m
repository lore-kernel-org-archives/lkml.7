Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A61C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF11522DD6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566352614;
	bh=235ljVuAxbtaMfi35kt+Xj4TBKzZOdHa3kddyh9DjNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lSOz5JYCr3OPqWwZpS6MWYolc9SfQI0IetW+IL9b5W0Ce0CD8fET9mimDtUIGnzpg
	 6LBBO3wzdtnAzBNGQ/Xjw9aIXtQJB9AIAtL9Z+8cSujcWvT4htCedG3dzD5ynTxId9
	 htFqvfB/KwDJegHy4E09zA7nunkloE3sSYbHa5LY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHUB4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfHUB4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:56:52 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD84822DD3;
        Wed, 21 Aug 2019 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566352611;
        bh=235ljVuAxbtaMfi35kt+Xj4TBKzZOdHa3kddyh9DjNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0oCVGOskkJxcRNPBT3Z3lACezqO411r1BH03NRcAH5tlJAcxI90wQRJs0qrSz9GBO
         L7TQi83QYY8aIZabdTJk1L1GUuegMPU1uVNLubXXGYvQ0aCVwBgQorXkqG3+JTX/Fd
         9+taTVWpDAhIcoqELEkf49ISnWZ7UDyyEtg34y6w=
Date:   Tue, 20 Aug 2019 18:56:47 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v7 1/7] driver core: Add support for linking devices
 during device addition
Message-ID: <20190821015647.GA12237@kroah.com>
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-2-saravanak@google.com>
 <32a8abd2-b6a4-67df-eee9-0f006310e81e@gmail.com>
 <CAGETcx8Q27+Jnz+rHtt33muMV6U+S3cmKh02Ok_Ds_ZzfBqhrg@mail.gmail.com>
 <522e8375-5070-f579-6509-3e44fe66768e@gmail.com>
 <CAGETcx-9Bera+nU-3=ZNpHqdqKxO0TmNuVUsCMQ-yDm1VXn5zA@mail.gmail.com>
 <a4c139c1-c9d1-3e5a-f47f-cd790b42da1f@gmail.com>
 <CAGETcx-J7+d3pcArMZvO5zQbUhAhRW+1=FUf7C1fV9-QhkckBw@mail.gmail.com>
 <6028b35b-a4ca-18de-84c6-4a22dbd987c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6028b35b-a4ca-18de-84c6-4a22dbd987c9@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 06:06:55PM -0700, Frank Rowand wrote:
> On 8/20/19 3:10 PM, Saravana Kannan wrote:
> > On Mon, Aug 19, 2019 at 9:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 8/19/19 5:00 PM, Saravana Kannan wrote:
> >>> On Sun, Aug 18, 2019 at 8:38 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> On 8/15/19 6:50 PM, Saravana Kannan wrote:
> >>>>> On Wed, Aug 7, 2019 at 7:04 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>>>
> >>>>>>> Date: Tue, 23 Jul 2019 17:10:54 -0700
> >>>>>>> Subject: [PATCH v7 1/7] driver core: Add support for linking devices during
> >>>>>>>  device addition
> >>>>>>> From: Saravana Kannan <saravanak@google.com>

This is a "fun" thread :(

You two should get together in person this week and talk.  I think you
both will be at ELC, can we do this tomorrow or Thursday so we can hash
it out in a way that doesn't end up talking past each other, like I feel
is happening here right now?

thanks,

greg k-h
