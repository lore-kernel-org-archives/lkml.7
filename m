Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89954C742C2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F81F2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="boVWWIm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfGLNyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:54:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34926 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfGLNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:54:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so4359682pfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbtfTW9V02xddXFM/PSRd/S88/GmzvyypYUwoJ77Sxo=;
        b=boVWWIm7A/RhKwsj75Ii2wvu0YBSEoqiS9KDPCNwMsk9rf+IXvIKWzw+NGwJcs7cpn
         f4I7H+ccUuEJ/SB44AkJE3DrEnH3QSFt+Wa/cfxR6dQZIYRNRKUtsqARjM9IdTm6GI7j
         fHLp2t0ldNetPUr2is+PMrg2d8xHEw0rnNtck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbtfTW9V02xddXFM/PSRd/S88/GmzvyypYUwoJ77Sxo=;
        b=XzGnE+8nniM2rYdqh3+EoGpDbdJQDdGcuKUW9FxOiXPBSnPFoPRsa4N2CuPeGZRwq3
         koxSxRgo/pYHy4LGvXu2vw3LIG00gxxlvEuPBjeNkjDTadDA7k3KEMIbs0MaG7CF8nyB
         29F78s47VallaEBqdbvhUD+K19bwNlVQ3o6NJDqheZ8bHVo7/Rd6jYwAMUWmo1eQtc5n
         /vcQPQo5WP9ic4PYX0oaXjRf+IPKZ878xUFHjQCH5E4jr9oOqjGEJp0mnJvok0HncuyP
         eE/2FRddwsIuFmCq0IDV+y5ndInmWiD6N8e4MvqI8i9O3CczUUIeGQixAsPuwvc99KfW
         n8eA==
X-Gm-Message-State: APjAAAW2kLczeINzxNwHz+6cEwwpAjzG1lbcZk4aRC8Cb3ozfoME5gQX
        yFLHPsW0qFLvHO8UbASjI5k=
X-Google-Smtp-Source: APXvYqz4/5kba+Dz57lJEmLjqFIivdNE3VPux/9/ZgXz8YegcDuFs/puQy0bx/s8Z1GFqF1Citc4KA==
X-Received: by 2002:a65:5188:: with SMTP id h8mr10984028pgq.294.1562939663707;
        Fri, 12 Jul 2019 06:54:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a6sm7733188pjs.31.2019.07.12.06.54.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 06:54:22 -0700 (PDT)
Date:   Fri, 12 Jul 2019 09:54:21 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the pidfd
 tree
Message-ID: <20190712135421.GG92297@google.com>
References: <20190515131629.405837b0@canb.auug.org.au>
 <20190708120114.5ca1613d@canb.auug.org.au>
 <20190712125304.GC92297@google.com>
 <20190712130235.2r4jlwpfffijz4hj@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712130235.2r4jlwpfffijz4hj@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 03:02:36PM +0200, Christian Brauner wrote:
> On Fri, Jul 12, 2019 at 08:53:04AM -0400, Joel Fernandes wrote:
> > On Mon, Jul 08, 2019 at 12:01:14PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > On Wed, 15 May 2019 13:16:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Today's linux-next merge of the akpm-current tree got a conflict in:
> > > > 
> > > >   include/linux/pid.h
> > > > 
> > > > between commit:
> > > > 
> > > >   51f1b521a515 ("pidfd: add polling support")
> > > > 
> > > > from the pidfd tree and commit:
> > > > 
> > > >   c02e28a1bb18 ("kernel/pid.c: convert struct pid:count to refcount_t")
> > > > 
> > > > from the akpm-current tree.
> > > > 
> > > > I fixed it up (see below) and can carry the fix as necessary. This
> > > > is now fixed as far as linux-next is concerned, but any non trivial
> > > > conflicts should be mentioned to your upstream maintainer when your tree
> > > > is submitted for merging.  You may also want to consider cooperating
> > > > with the maintainer of the conflicting tree to minimise any particularly
> > > > complex conflicts.
> > > > 
> > > > -- 
> > > > Cheers,
> > > > Stephen Rothwell
> > > > 
> > > > diff --cc include/linux/pid.h
> > > > index 1484db6ca8d1,0be5829ddd80..000000000000
> > > > --- a/include/linux/pid.h
> > > > +++ b/include/linux/pid.h
> > > > @@@ -3,7 -3,7 +3,8 @@@
> > > >   #define _LINUX_PID_H
> > > >   
> > > >   #include <linux/rculist.h>
> > > >  +#include <linux/wait.h>
> > > > + #include <linux/refcount.h>
> > > >   
> > > >   enum pid_type
> > > >   {
> > > 
> > > I am still getting this conflict (the commits have changed).  Just a
> > > reminder in case you think Linus may need to know.
> > 
> > Could you let me know if this trivial header inclusion conflict has been
> > resolved now? Let me know what else I can do to help.
> 
> I've informed Linus about this conflict when I sent the PR and he has
> pulled the tag which includes your polling changes. So it shouldn't
> require you to do anything since the conflict is pretty trivial. :)

Thank you Christian!

- Joel

