Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38581C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059722064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564761119;
	bh=mwcuuYwzyABqEFYdLEq2l7jte5DqBDhigU0GWSIC4dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f8H8Is/sWXRszyji+w3CaNbkn7WHibSfIg1QZ6GzkU2lH5dWMTiW13xL6xuAn9MqH
	 bzCh++E1E2UYaQojddzL/Mx3TX/AKPj/s32U0y34ccBXOf6+0X/LsFyh//jiac/Vef
	 Zrvwx3EqzS5JchZQGp81woM5nfdgk4s+I2Bwtjws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfHBPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfHBPv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:51:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BBA02064A;
        Fri,  2 Aug 2019 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761116;
        bh=mwcuuYwzyABqEFYdLEq2l7jte5DqBDhigU0GWSIC4dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyYtnx6iFOwd/HIqK211HYpkmqwB5afPCmD2rn3O+lpPf8oweGahH0nBm/ASj76qx
         jbmFlvo9D1sBczpjC9LZpLawUSyqz+7EFuMLDDelmbFnx3HLNlVmDoha6UhrLbJ6WW
         BdDIPElw0rc6kaXwwOHj6zUrgnTcHDAi3be1wJ6k=
Date:   Fri, 2 Aug 2019 17:51:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.2 03/20] ALSA: usb-audio: Sanity checks for each pipe
 and EP types
Message-ID: <20190802155154.GA28398@kroah.com>
References: <20190802092055.131876977@linuxfoundation.org>
 <20190802092058.248343532@linuxfoundation.org>
 <20190802134828.GA797@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802134828.GA797@sasha-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:48:28AM -0400, Sasha Levin wrote:
> On Fri, Aug 02, 2019 at 11:39:57AM +0200, Greg Kroah-Hartman wrote:
> > From: Takashi Iwai <tiwai@suse.de>
> > 
> > commit 801ebf1043ae7b182588554cc9b9ad3c14bc2ab5 upstream.
> > 
> > The recent USB core code performs sanity checks for the given pipe and
> > EP types, and it can be hit by manipulated USB descriptors by syzbot.
> > For making syzbot happier, this patch introduces a local helper for a
> > sanity check in the driver side and calls it at each place before the
> > message handling, so that we can avoid the WARNING splats.
> > 
> > Reported-by: syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This commit has a fix: 5d78e1c2b7f4b ("ALSA: usb-audio: Fix gpf in
> snd_usb_pipe_sanity_check") which was not pulled by Linus yet.
> 
> I'm going to drop this commit and re-queue it together with it's fix
> once it makes it upstream.

Ah, thanks for doing that.

greg k-h
