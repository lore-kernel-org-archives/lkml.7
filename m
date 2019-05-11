Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F0C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B41216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557554866;
	bh=0SGhsFDVAYUAer+zMGd8vxbptVDyA8vsxsDeg+Jr0XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s22XX7Y2Pgrjw283Kv+OODt8/hVFT44oSUwrbx7zrB9Dzfn8vJsO/MaGZME7jGFBR
	 lOoaMg667G4VJtzQ/0kqet41NUyZYq1cwWV6NNdEvwSxZ1IX4xUwk3z4wdqNUwEhqK
	 Q49XP85QvC0BQparPibhXpTeeDRhgLXp8w60HhHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfEKGHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 02:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfEKGHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 02:07:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23745216C4;
        Sat, 11 May 2019 06:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557554863;
        bh=0SGhsFDVAYUAer+zMGd8vxbptVDyA8vsxsDeg+Jr0XM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUoJ/l4qujlTRrdwN9etBE0XaxNNee5dUXMxo/ruVW+WqZaG1TNUhgG9/Ehp6qz9F
         G+znJ/SSFxUnoon7/Y8WNjdOBDs0CBIsJHkMYEwRwXe7JM9v+X+HcBkvRfH34EoUL+
         /HZfqbs5ka5UJ0MSFJHcOSq1lwPAHz30adj+3ak4=
Date:   Sat, 11 May 2019 08:07:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190511060741.GC18755@kroah.com>
References: <CAAie0ar11_mPipN=d=mrgnVdEMO1Np0cCYdqcRfZrij_d-5zaQ@mail.gmail.com>
 <20190510051415.GA6073@kroah.com>
 <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 09:21:39AM +0800, Gen Zhang wrote:
> On Fri, May 10, 2019 at 11:12:50PM +0800, Greg KH <
> gregkh@linuxfoundation.org> wrote:
> >Still impossible to apply :(
> >
> >Also, what about Dave's response to you?  This really can never be hit,
> >like other early-init tty allocations that we do not check because of
> >this issue, correct?
> >
> >thanks,
> >
> >greg k-h
> 1. Cannot imply the patch
> I pulled the latest kernel from github(commit
> 1fb3b526df3bd7647e7854915ae6b22299408baf), and patched with
> **************************************
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> 
> @@ -3322,10 +3322,14 @@ static int __init con_init(void)
> 
>   for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>   vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> + if (!vc_cons[currcons].d || !vc)
> + goto err_vc;
>   INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>   tty_port_init(&vc->port);
>   visual_init(vc, currcons, 1);
>   vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> + if (!vc->vc_screenbuf)
> + goto err_vc_screenbuf;
>   vc_init(vc, vc->vc_rows, vc->vc_cols,
>   currcons || !vc->vc_sw->con_save_screen);
>   }
> @@ -3347,6 +3351,14 @@ static int __init con_init(void)
>   register_console(&vt_console_driver);
>  #endif
>   return 0;
> +err_vc:
> + console_unlock();
> + return -ENOMEM;
> +err_vc_screenbuf:
> + console_unlock();
> + kfree(vc);
> + vc_cons[currcons].d = NULL;
> + return -ENOMEM;
>  }
>  console_initcall(con_init);
> 
> 
> **************************************
> (It is possible that you missed the last line?)

Look at the patch above, all of the whitespace is damaged.  There is no
way you took the raw email and then were able to apply that to the
kernel tree.

You can not cut/paste patches into gmail, please read the kernel
Documentation file all about email clients and how to get them to work
properly to send patches.

> 2. David's response
> In my humble opinion, whatever the cause is, theoratically, there is a
> possibility that memory allocation (e.g. kzalloc()) can be failed.
> I don't think it is related to whether we are in the early-initial stage or
> not.

But it is directly related.

> Once the allocated pointer (e.g. vc) is deferenced, the kernel might go
> wrong.
> And in this case, variable vc_cons[currcons].d, vc and vc->vc_screenbuf is
> deferenced after allocation.
> Thus I think we should add the allocation check to prevent null pointer
> deference.

For most problems, yes, if you can successfully unwind and continue on
with a working system.  Will that happen here?

thanks,

greg k-h
