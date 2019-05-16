Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9419EC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640AA2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="U6zq47Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEPO7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:59:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39867 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfEPO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:59:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so5702086edq.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9KSZWGLEZmzzku3a/BIVpEpdyfxDETMafUlcIGbaGkM=;
        b=U6zq47FzoLAi+b5aB6R87xgXMlJSHtX2ZWhNh+CpTsgGf/e0RtGT4/vP/NctcAL2Rp
         sMxaf9Drfma0PxYrMUCpH9dyOBA4phV+kW/nvPoHht3MeN5m85i6PUdM3bY2ap00D+n2
         CJg3t28fjY2M/LJyRa4RH5bbVaYkhAZtbDu4JnGH6BJqvSXQv+lReOnQgkJOGY08+QSy
         17AtTzfu59sJs2sMlTt2MPJnCaq/K2OLVU245mLBQALmSPA541gl0t0emEChlAyaBVTk
         qyKU/l5pCBoWzve7JCQmrzeEBpCbak2GdD2pKyG8bNj0/CnbYmhB85v/LGuGBDl7Dwhj
         p/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KSZWGLEZmzzku3a/BIVpEpdyfxDETMafUlcIGbaGkM=;
        b=mRc+oWeqlIlJZMFWwLJPwPfyM8ympMd76t07KLUb8Gf49MoCMugyjZfSeA1qpjrtRI
         T0c7TDUkWN7eMWedyweWi74Cbyc+WmTr1KuzUObf3FqE41mD+i8TD3ZQ0+o3oxILlShk
         n4j9L2Mhb+hJlPaxmmsYfmdZuiSap2F6yd3MgW1xcCNRmxXLq24FSmf+7Hb6HAf7A3i2
         YBZmNCelMrNeRXzHm9Efaw3eYpnAnyLLAwgkX62mDxREj1VcQNlcSAvo5fF8ykd0ewQw
         ne8DL3/s4m6dFUuElZL/leJRa2xTZzkvw9pQHKks+enXNej1b3NFrsiksizjLkcefzjl
         xGsA==
X-Gm-Message-State: APjAAAVPkJ7Nhj52OX5HQgHQLEJhpsNSveAU9oC+gHVlPZsqCKFiYZ4X
        V/30RPLFKk27dP7OuuYasTFmMQ==
X-Google-Smtp-Source: APXvYqzlsUl3pftfA6oXcxjyn7dDmYqpibTf4H0mIhgsIaTlcrCxLNC0GR5Fgj6uHWo0H3FOAaDMbA==
X-Received: by 2002:a17:906:f84c:: with SMTP id ks12mr28651055ejb.270.1558018783866;
        Thu, 16 May 2019 07:59:43 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id hb11sm1125567ejb.43.2019.05.16.07.59.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 07:59:43 -0700 (PDT)
Date:   Thu, 16 May 2019 16:59:42 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Howells <dhowells@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] uapi: Wire up the mount API syscalls on non-x86
 arches [ver #2]
Message-ID: <20190516145941.dzlf4kxrxoeeoa6t@brauner.io>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <155800755482.4037.14407450837395686732.stgit@warthog.procyon.org.uk>
 <CAMuHMdWsgSWC2AFGf_XBaEc0g=FDkGB1=UH+Ekh9n6k3W4ifWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWsgSWC2AFGf_XBaEc0g=FDkGB1=UH+Ekh9n6k3W4ifWQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 04:56:10PM +0200, Geert Uytterhoeven wrote:
> Hi David, Christian,
> 
> On Thu, May 16, 2019 at 1:54 PM David Howells <dhowells@redhat.com> wrote:
> > Wire up the mount API syscalls on non-x86 arches.
> >
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> > +428    common  open_tree                       sys_open_tree
> > +429    common  move_mount                      sys_move_mount
> > +430    common  fsopen                          sys_fsopen
> > +431    common  fsconfig                        sys_fsconfig
> > +432    common  fsmount                         sys_fsmount
> > +433    common  fspick                          sys_fspick
> 
> The first number conflicts with "[PATCH v1 1/2] pid: add pidfd_open()".
> 
> Note that none of this is part of linux-next.

Yep, already spotted this thanks to Arnd.
David, there's nothing you need to do of course. I'll change the syscall
number for pidfd_open(). Your patchset obviously has priority!

Thanks!
Christian

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
