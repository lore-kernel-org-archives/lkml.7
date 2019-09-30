Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CD5C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E29216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569852536;
	bh=dVI226ZRY3L1K2ohBFSeVn5/mzy6YdAm3hYyooR7kmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iMSncuFZg+1FLdDPFRHcheCMx58DAcAlxpREJnc5VZMxHqDGd4XN7SR/DX8sqdIbt
	 skvJeJVX38pPodlUSZ5g5BQ3kGM7BLLiiUCVWyUXeHPLzm6/EBSn4SON8ImOxe3xwB
	 0oFZplhrn3qx9o1P+u5shHSttkjkiq1Wl4Yi2GTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfI3OIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbfI3OIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:08:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81BA215EA;
        Mon, 30 Sep 2019 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852534;
        bh=dVI226ZRY3L1K2ohBFSeVn5/mzy6YdAm3hYyooR7kmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMF/2ntZtPbp2MktRbMnbVUbRNUdg6WwbyRG8O5CVsyuxzMdh8SGb4Z0LJf2lNO18
         BRlXnndwtHe2ZXQh1t8KBZDAuzzId2Vubfa2JkQ4awgASsXS0GsRZM6s6/JGg3iVs0
         8kLLDXtWjVNCFBOUmk0p0sn4Tn2GraOIb6SaUY5w=
Date:   Mon, 30 Sep 2019 15:39:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH 1/2] leds: Add flag to keep trigger always
Message-ID: <20190930133902.GA2249614@kroah.com>
References: <1565398367-11811-1-git-send-email-gurus@codeaurora.org>
 <20190810071322.GA13760@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810071322.GA13760@amd>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 09:13:22AM +0200, Pavel Machek wrote:
> On Fri 2019-08-09 17:52:46, Guru Das Srinagesh wrote:
> > From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> > 
> > Commit 0013b23d66a2768f5babbb0ea9f03ab067a990d8 ("leds: disable triggers
> > on brightness set") removes the trigger on an LED class device when
> > brightness is set to 0. However, there are some LED class devices which
> > need the trigger not to be removed. In a use case like camera flash,
> > camera flash driver passes in a trigger device to LED class driver. If
> > the trigger is removed when the brightness is set to 0, this will affect
> > the clients using those triggers. Hence add a flag to always keep the
> > trigger even when brightness is set to 0.
> 
> No.
> 
> Yes, it would affect those clients. Don't do it, then. It is
> root-only operation.

I don't understand.  The original commit broke userspace operations.
Shouldn't it be reverted, or fixed this way in order to have userspace
work properly again?

thanks,

greg k-h
