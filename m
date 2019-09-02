Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696AAC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381F821744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Tbc3Mj5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yvEAQHsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfIBQr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:47:28 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40117 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfIBQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:47:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6D69B5A5;
        Mon,  2 Sep 2019 12:47:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Sep 2019 12:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=X4LCCxeuQKKBpdGg9K31qhm4hIZ
        cpVvtnQtc9U0Ccy0=; b=Tbc3Mj5CAQtxKSYc87aqaJHqwUU7vtREDCr5pCD0RCM
        2RDUv5zFY0I09pRJWET565WJnVMVU5PUfqZfeIrnu7BouP/5Wc9mbN6BL6HnBJhA
        rv8whm+YKyrGfimK6LR5tG6eu3v7uvWjqamfcEG2bSu22yrDCTBu2LJ+UJp/MsZr
        NvAwj3lvU2Yl4f4jGO0fL/RJrMrhJz7zvNxrBpkViQofeRrE6p6pfWyHrdwL83YJ
        62MWhgSl2J90zgzDUPzX/FqHWUPzBqKg/vbyWrlKFwFyeQd+aJNotSbW6kQ9xfh2
        u5kphtaBoa/PRhNTfh5bGK8/moZ++1Q7kvwAWq4mtpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=X4LCCx
        euQKKBpdGg9K31qhm4hIZcpVvtnQtc9U0Ccy0=; b=yvEAQHsg41RyWHWY+Nult+
        lYkP/S+SNZn0RwG9riT2fIuKgYFepQo4kLQ09WHIn4opVfELepUPrNjGon4hm4ZE
        WBM2NPgw9/G7qJCF58UXOI7EXKxLY2TX0XEUn/V+Se/hxEMnXW88Y0vrkcn5LZYA
        yKIxQAPpC4rFauAfNO3FHLyWpmYX1I+c3jKs+Yszp9JBxnQW7Pp5AgcZ2HwC3LIM
        a1gci7xQIdhZt5MqLOaC76hVrBQa3nOyZBcml4zBL6w15PP0QvkRtV4agw+rvBC4
        G/LkUb6gB2YSDeNfcCeHSuwR1ivE9KaRWkc0icrMf7lu3S/QmyqPiE/8ul3oqZYA
        ==
X-ME-Sender: <xms:nUdtXQeVNSFsLK57rw0DDtlPc4Gew2HfW_sPrNPZmW-LmflqeRACmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejtddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:nUdtXWezTV2Z-J53rDm_B27lt8QTpxTudVW-qZA3h5dUDU-h_T7o1w>
    <xmx:nUdtXcjZ4v8gf2DXBVcUO13q0PA0ph8gCg0-aMNQr9gzR3zkh0__xw>
    <xmx:nUdtXaRznwZfylVI749YbT13_vwoROezbPrPebmbf4KhE883uoWDBw>
    <xmx:nkdtXYvq75Bi0D4ONwTDaUsTeatonNxosb6w0S5iQeQMqBZNJis4Pg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8B2F3D6005F;
        Mon,  2 Sep 2019 12:47:25 -0400 (EDT)
Date:   Mon, 2 Sep 2019 18:47:24 +0200
From:   Greg KH <greg@kroah.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Julius Werner <jwerner@chromium.org>,
        Dan Williams <dcbw@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
Message-ID: <20190902164724.GA22619@kroah.com>
References: <CAODwPW8gTZ_2WEc9n=WJ2PEmQk2anTQYfwQ-898+kOq6wsjnZw@mail.gmail.com>
 <Pine.LNX.4.44L0.1908301337150.1459-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1908301337150.1459-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 01:43:36PM -0400, Alan Stern wrote:
> > I could instead add a new sysfs node 'force_bind' to the driver core,
> > that would work like 'bind' except for skipping the
> > driver_match_device() call entirely and forcing a probe(). Do you
> > think that would be acceptable? Or is that too big of a hammer to make
> > available for all drivers in Linux? Maybe if I do the same thing but
> > only for usb drivers, or even only for the usb-storage driver
> > specifically, would that be acceptable?
> 
> This is a question for Greg.  The problem is that there may be drivers
> which can't handle being probed for devices they don't match.
> 
> Still, we ought to have a mechanism for doing manual but not automatic 
> matches.
> 
> Greg, any thoughts?

This should work just fine today.  Add a new device id to the "new_id"
file and then tell the driver to bind.  That's pretty much the same as a
"force_bind", right?

thanks,

greg k-h
