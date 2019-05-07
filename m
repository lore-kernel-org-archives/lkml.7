Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B984C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E5F20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557234382;
	bh=XfQZU2DpqqrNaC5uwBRr2mXrJytyFoUzUl7vvTJlB8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OtDw86pM2NWDoDt+kmNTpoZ8n5n7D3Cl3U2ENZ3oJ0MJp07ounjbTILtGEIcyvpG9
	 UCxANoUOf3hCvMFOP1wPyy7ziP7qsouCoUKQJu+IOaeTtqGw7si/Ypqh12H0qgegEi
	 6r/bogku63DTC2IBiKThoJkTgM30xBcws1K259Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEGNGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfEGNGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:06:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D928720578;
        Tue,  7 May 2019 13:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557234379;
        bh=XfQZU2DpqqrNaC5uwBRr2mXrJytyFoUzUl7vvTJlB8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqpLWNvcQYpwOH0Ds3NTlc9nCXnv0qgpF0DE5BgxFOBWxB5O9IwDE++/eiiqgLqC7
         zgwwtIGe/kQfEykEnjo7lXnoozEu4ckYLeqRhgjX7ZegjRKcU+zNgx9oPo8lBwiFhN
         yh/3iZ0MkOUnVjxqkPVCPrwuPah2PEPxomZ5pWDY=
Date:   Tue, 7 May 2019 15:06:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Tobin C . Harding" <tobin@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Remove custom kobject state handling
Message-ID: <20190507130616.GA17386@kroah.com>
References: <20190503132625.23442-1-pmladek@suse.com>
 <20190503132625.23442-2-pmladek@suse.com>
 <alpine.LSU.2.21.1905071355430.7486@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1905071355430.7486@pobox.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 02:32:57PM +0200, Miroslav Benes wrote:
> On Fri, 3 May 2019, Petr Mladek wrote:
> 
> > kobject_init() always succeeds and sets the reference count to 1.
> > It allows to always free the structures via kobject_put() and
> > the related release callback.
> > 
> > Note that the custom kobject state handling was used only
> > because we did not know that kobject_put() can and actually
> > should get called even when kobject_init_and_add() fails.
> > 
> > The patch should not change the existing behavior.
> 
> Pity that the changelog does not describe the change from 
> kobject_init_and_add() to two-stage kobject init (separate kobject_init() 
> and kobject_add()).
> 
> Petr changed it, because now each member of new dynamic lists (created in 
> klp_init_patch_early()) is initialized with kobject_init(), so we do not 
> have to worry about calling kobject_put() (this is slightly different from 
> kobj_added).
> 
> It would also be possible to retain kobject_init_and_add() and move it to 
> klp_init_patch_early(), but it would be uglier in my opinion.

kobject_init_and_add() is only there for the "simple" use cases.
There's no problem with doing the two-stage process on your own like
this, that's exactly what it is there for :)

thanks,

greg k-h
