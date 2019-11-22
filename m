Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31832C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BDF2071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574435971;
	bh=n4AJKJGVZy+SCQms3UvzF7qaH7ySK/kr/MGC6JHE41g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cxofBSk7935IxSKaDIcCMdace4F5qF7te+m5SD+0gouK825DapA/86B2iadb6YXto
	 cv8Y3Sgz/Bkk9AeETa/742y+A86GnSsnWGdf7XodfEVT1P69ciOZQluv9ufdZ2NQaN
	 zD8eIRTcPibIxC3vaSnR9KsmmAJA9e6l1QL/aInw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKVPTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfKVPT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:19:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9665C2071C;
        Fri, 22 Nov 2019 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574435969;
        bh=n4AJKJGVZy+SCQms3UvzF7qaH7ySK/kr/MGC6JHE41g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaLJKmzNlKaCc4l5J4pJaGyM2DFKHCq9Gk2EQV/QKv1DBDLq6sqhxMCaCQSmdHO+j
         DyRSeSO7clEOczGUvhKUKlBseLKbt3rWLRGHHiXC3yc/JkUocUGi23XHz8ZFqwrBSV
         Bl/KUKuufuZpHw0hAC0WEs6UnMrRVbO6zOLXLsMU=
Date:   Fri, 22 Nov 2019 16:19:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kusanagi Kouichi <slash@ac.auone-net.jp>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
Message-ID: <20191122151926.GA2083897@kroah.com>
References: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
 <20191121115232.GC427938@kroah.com>
 <20191121124413687.NRXY.44544.ppp.dion.ne.jp@dmta0002.auone-net.jp>
 <20191121132644.GA475684@kroah.com>
 <20191121185540.1465a308@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121185540.1465a308@oasis.local.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 06:55:40PM -0500, Steven Rostedt wrote:
> On Thu, 21 Nov 2019 14:26:44 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Nov 21, 2019 at 09:44:13PM +0900, Kusanagi Kouichi wrote:
> > > On 2019-11-21 12:52:32 +0100, Greg Kroah-Hartman wrote:  
> > > > 
> > > > Has this always been a problem, or did it just show up due to some other
> > > > kernel change?
> > > >   
> > > 
> > > The latter. Please see https://lkml.org/lkml/2019/11/21/11  
> > 
> > So it is fine for this to go into 5.5-rc1 then, right?  I'll queue it up
> > that way.
> 
> As the following patch also relies on this fix, can you add this too:
> 
>  https://lore.kernel.org/lkml/20191120104350753.EWCT.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp/
> 
> And add my Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Now queued up, thanks!

greg k-h
