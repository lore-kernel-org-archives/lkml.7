Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80330C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5272D20665
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391166AbfISPQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:16:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388706AbfISPQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9811780F6D;
        Thu, 19 Sep 2019 15:16:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF4625C226;
        Thu, 19 Sep 2019 15:16:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x8JFGJuJ015086;
        Thu, 19 Sep 2019 11:16:19 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x8JFGHsn015068;
        Thu, 19 Sep 2019 11:16:17 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 19 Sep 2019 11:16:17 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Xiaoming Ni <nixiaoming@huawei.com>, penberg@cs.helsinki.fi,
        jslaby@suse.com, nico@fluxnic.net, textshell@uchuujin.de,
        sam@ravnborg.org, daniel.vetter@ffwll.ch, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        yuehaibing@huawei.com, zengweilin@huawei.com
Subject: Re: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
In-Reply-To: <20190919092933.GA2684163@kroah.com>
Message-ID: <alpine.LRH.2.02.1909191114340.14850@file01.intranet.prod.int.rdu2.redhat.com>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com> <20190919092933.GA2684163@kroah.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 19 Sep 2019 15:16:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Sep 2019, Greg KH wrote:

> On Thu, Sep 19, 2019 at 05:18:15PM +0800, Xiaoming Ni wrote:
> > Using kzalloc() to allocate memory in function con_init(), but not
> > checking the return value, there is a risk of null pointer references
> > oops.
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> 
> We keep having this be "reported" :(
> 
> > ---
> >  drivers/tty/vt/vt.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 34aa39d..db83e52 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -3357,15 +3357,33 @@ static int __init con_init(void)
> >  
> >  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > +		if (unlikely(!vc)) {
> > +			pr_warn("%s:failed to allocate memory for the %u vc\n",
> > +					__func__, currcons);
> > +			break;
> > +		}
> 
> At init, this really can not happen.  Have you see it ever happen?
> 
> >  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> >  		tty_port_init(&vc->port);
> >  		visual_init(vc, currcons, 1);
> >  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> > +		if (unlikely(!vc->vc_screenbuf)) {
> 
> Never use likely/unlikely unless you can actually measure the speed
> difference.  For something like this, the compiler will always get it
> right without you having to do anything.
> 
> And again, how can this fail?  Have you seen it fail?
> 
> > +			pr_warn("%s:failed to allocate memory for the %u vc_screenbuf\n",
> > +					__func__, currcons);
> > +			visual_deinit(vc);
> > +			tty_port_destroy(&vc->port);
> > +			kfree(vc);
> > +			vc_cons[currcons].d = NULL;
> > +			break;
> > +		}
> >  		vc_init(vc, vc->vc_rows, vc->vc_cols,
> >  			currcons || !vc->vc_sw->con_save_screen);
> >  	}
> >  	currcons = fg_console = 0;
> >  	master_display_fg = vc = vc_cons[currcons].d;
> > +	if (unlikely(!vc)) {
> 
> Again, never use likely/unlikely unless you can measure it.
> 
> thanks,
> 
> greg k-h

Why does it use GFP_NOWAIT and not GFP_KERNEL? Is there some problem with 
GFP_KERNEL during initialization?

Mikulas
