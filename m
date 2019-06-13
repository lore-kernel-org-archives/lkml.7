Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BCEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83A520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441107;
	bh=x6g8SpdX2s4hgnOzlEqiNhMKdDtcVuerNEHpNk2rrmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nApVm9l08402tQKTbBkisaztOuFU4sMMa2+c97LGliVAy/OXv8zQ8qfj90upWiBnZ
	 CaAURbXmxsh8UsS4UZjUJcCILQpYYXUuKSHYCTUM6dR9t6+ke50eQ8JpXYMwY5FU6r
	 Hp0TzuCxz9Ytj2ZBojTUD6YtfJ2JJTK3xb3yPczI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfFMPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731659AbfFMJL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:11:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199922133D;
        Thu, 13 Jun 2019 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560417085;
        bh=x6g8SpdX2s4hgnOzlEqiNhMKdDtcVuerNEHpNk2rrmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTZL4pHjJOw7s/bprqy0krU4/Onto+EUdmkGYsEHNey88pVk2tB0UidD45l7fPpTp
         LEuaNYkdd3tG9SHhffzcXQ/0B2ERGtQTvo2bWIMeqM9EbfqjP9e07ltsVpzrFcDYAx
         7illd/oKz/AQSJo3ByZi7LPB8aBsqCF4lNhXqzkg=
Date:   Thu, 13 Jun 2019 11:11:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 61/81] ALSA: seq: Protect in-kernel ioctl calls with
 mutex
Message-ID: <20190613091122.GA31122@kroah.com>
References: <20190613075649.074682929@linuxfoundation.org>
 <20190613075653.581995283@linuxfoundation.org>
 <s5hzhmlluwx.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzhmlluwx.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:02:54AM +0200, Takashi Iwai wrote:
> On Thu, 13 Jun 2019 10:33:44 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > [ Upstream commit feb689025fbb6f0aa6297d3ddf97de945ea4ad32 ]
> > 
> > ALSA OSS sequencer calls the ioctl function indirectly via
> > snd_seq_kernel_client_ctl().  While we already applied the protection
> > against races between the normal ioctls and writes via the client's
> > ioctl_mutex, this code path was left untouched.  And this seems to be
> > the cause of still remaining some rare UAF as spontaneously triggered
> > by syzkaller.
> > 
> > For the sake of robustness, wrap the ioctl_mutex also for the call via
> > snd_seq_kernel_client_ctl(), too.
> > 
> > Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> This commit is reverted later by commit f0654ba94e33.
> So please drop this.  The proper fix is done later by commit
> 7c32ae35fbf9 ("ALSA: seq: Cover unsubscribe_port() in list_mutex")
> 
> Ditto for 4.19.y and 5.1.y.

Now dropped everywhere, and I added 7c32ae35fbf9 ("ALSA: seq: Cover
unsubscribe_port() in list_mutex") everywhere instead.

thanks,

greg k-h
