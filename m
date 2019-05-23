Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9793CC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4182175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558590782;
	bh=tax24nmBc628VmVjaF783AtVlysAZD6fCJGwTezeGjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EQN/0J0jYNGA8bYTsn+cxfxoXZb4TrJjfGSMRHlxwU8h7uFDQ7hsfWjLS9M1vbwFz
	 SEvkikSR5Q45ejlDdRUOBt8B+/8zHvQSIh4n0rJZnbeI8oQZEWMBM0g3jlECeyyXOY
	 LkHCmUnDx3qAiY7IDT1XuUx5139pOxExO3uv+nhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfEWFxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfEWFxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:53:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A63C2075E;
        Thu, 23 May 2019 05:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558590781;
        bh=tax24nmBc628VmVjaF783AtVlysAZD6fCJGwTezeGjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmiFpU/tt/UQvKhkn2236vqNC/YozN9lFSm4XiW03lKqrccWSyLvTdLlr03/2UA3M
         ryAHMnWBeh8CwIYNHMYhcynpGmw6h/iG3xxauTq+qFbPFtZr0P5gjIqPInQcDY7SuF
         uraQf5X7iaoEd5DZmzYTG42sbkRLn2pmdhW1I/3M=
Date:   Thu, 23 May 2019 07:52:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: -Wuninitialized warning in drivers/misc/sgi-xp/xpc_partition.c
Message-ID: <20190523055258.GC22946@kroah.com>
References: <20190503033340.GA7980@archlinux-i9>
 <20190523015639.GB17819@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523015639.GB17819@archlinux-epyc>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 06:56:39PM -0700, Nathan Chancellor wrote:
> On Thu, May 02, 2019 at 08:33:40PM -0700, Nathan Chancellor wrote:
> > Hi all,
> > 
> > When building with -Wuninitialized, Clang warns:
> > 
> > drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is uninitialized when used within its own initialization [-Wuninitialized]
> >         void *buf = buf;
> >               ~~~   ^~~
> > 1 warning generated.
> > 
> > I am not really sure how to properly initialize buf in this instance.
> > I would assume it would involve xpc_kmalloc_cacheline_aligned like
> > further down in the function but maybe not, this function isn't entirely
> > clear. Could we get your input, this is one of the last warnings I see
> > in a few allyesconfig builds.
> > 
> > Thanks,
> > Nathan
> 
> Hi all,
> 
> Friendly ping for comments/input. This is one of a few remaining
> warnings I see, it'd be nice to get it fixed up so we can turn it on for
> the whole kernel.

Patches are gladly welcome :)

thanks,

greg k-h
