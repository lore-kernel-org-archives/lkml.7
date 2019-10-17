Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BB0FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E7121A49
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571280648;
	bh=sTZxZi+EvaRc2jbPlVYU7AjokigXvgJH+X0xEfGPUv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WG7GOPNj908RsjbKRI68B9jrvhrYcXR1WtkmzEGrqljYEOguxQiX3oUrf90A61ER+
	 HNN4jMeX1E2QOgdqNq/fZEJhwoYwSBwnT/lJYnkcfZ4m2gfsPiTCxk7lgPql45RCIM
	 v3OD9DbS899uuhCDrQjAJLng4X6iiMfiCBr2VtEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390441AbfJQCup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbfJQCuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:50:44 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513B02082C;
        Thu, 17 Oct 2019 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571280643;
        bh=sTZxZi+EvaRc2jbPlVYU7AjokigXvgJH+X0xEfGPUv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afxeJDH/81paRLGTdPmdSynz/VZVcaJhJ/ksjLu+kHtd/GhLRX/5QARl8xJDAeG5W
         gnAgfBrO9zfE3Hg46Y1q0QiHAmh9UMxcK6t3WmXIMPSy6BvPE0tcfgoXbDIWRcfgul
         6G6Cam211FrrxDBwBgTHAI96UkwO1XeF19sZFd4I=
Date:   Wed, 16 Oct 2019 19:50:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com>,
        akpm@osdl.org, deepa.kernel@gmail.com, hch@infradead.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        syzkaller-bugs@googlegroups.com, tklauser@nuerscht.ch,
        trond.myklebust@fys.uio.no
Subject: Re: KASAN: use-after-free Read in mnt_warn_timestamp_expiry
Message-ID: <20191017025041.GC1552@sol.localdomain>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com>,
        akpm@osdl.org, deepa.kernel@gmail.com, hch@infradead.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        syzkaller-bugs@googlegroups.com, tklauser@nuerscht.ch,
        trond.myklebust@fys.uio.no
References: <0000000000007f489b0595115374@google.com>
 <20191017014755.GA1552@sol.localdomain>
 <20191017015853.GR26530@ZenIV.linux.org.uk>
 <20191017022705.GB1552@sol.localdomain>
 <20191017023735.GS26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017023735.GS26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 03:37:35AM +0100, Al Viro wrote:
> On Wed, Oct 16, 2019 at 07:27:05PM -0700, Eric Biggers wrote:
> 
> > How about the following?
> > 
> > 	pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
> > 		sb->s_type->name,
> > 		is_mounted(mnt) ? "remounted" : "mounted",
> > 		mntpath,
> > 		tm.tm_year+1900, (unsigned long long)sb->s_time_max);
> > 
> > I think more people would understand "remounted" than "reconfigured".  Also,
> > is_mounted(mnt) seems like a better choice than mnt_has_parent(real_mount(mnt)).
> 
> Works for me(tm).  Care to fold that into your patch and resend?
> 

Sent: https://lkml.kernel.org/linux-fsdevel/20191017024814.61980-1-ebiggers@kernel.org/T/#u
