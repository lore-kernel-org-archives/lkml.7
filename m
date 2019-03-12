Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E641F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2qk5VCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfCLUFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:05:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34477 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfCLUFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:05:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id f14so4131185wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uuhgoHlXM7d277qxk4+ydCLrpaKbcarfCOJFjJOe6Xg=;
        b=n2qk5VCOlJ2njiSSM4nglT9pIq93gEGRF8knDlEor0mt4qud0J7AZyk2yB0UiCZxW4
         TXe+1vE63BC44zfPSubV4jaKPymWm2f/c1uJHKFev6rTly7f0dbgVf231kQxvgKCFpql
         BYn1F9mn5plx5wmTFUCmNqaJwjRJLX3EnleCv/S6EGK8jfyFhnFZEcZQ9CF8GhNFeSMW
         OaLNUzgWjKZjyYPWTyxGZ5JH4qkHgsXZzsXDOz1g1FD42XLtu0eHoi7TOqoayThWcQka
         6dBTi+/ON82Bk+Jp1HvfqaL0N6KdDf9HKwx3OiZLVCZDFwZXcZR3zhws316aFzHfnb86
         ebcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uuhgoHlXM7d277qxk4+ydCLrpaKbcarfCOJFjJOe6Xg=;
        b=YwW5ek73vjs4iqoG5Y1oO4Gbx1bpibDP4HctXj4p182Lr8m3zRB5xnt55qfdKFk03M
         k5XglHBtQtjaOZ7F1PZvHkXQH4rrkBZcHyvyvNGgjNgI5hpcmSNDJa+IwOKrhGiQIg7i
         HXaKkpKOOQtQEN4nbht+X1uhXRTni6Ycl+NiXdeCyoUCfZRErHV+WgFyYcsRkuh8DYSI
         wkTHxO/trQol3I6hsUS2GXJ3SFGP6XcyG+V8YG87QcbVpcdmWnQsOiNjG0d3pSt3tPUN
         iwxQWBt9B4+63MuISQicwStlNVMsyEYXOGwnDuiOBcxRGRcQkvHR127Hd6B+55kFoiSo
         EFFw==
X-Gm-Message-State: APjAAAWNvz65JlZcue6AXIbp2lyDgpWqn0MNF33qP/IPUR3t2JgJEFsg
        5xfhQIFd/SlXU3dqA8G8jG4=
X-Google-Smtp-Source: APXvYqyLn9o988fdJ4aWaA2sK/lk3bMurIriZgcrc7IW7egEpyXZfvAPtikMZUHOJ2lCWiPj0xt5Vw==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr24102170wrt.7.1552421145152;
        Tue, 12 Mar 2019 13:05:45 -0700 (PDT)
Received: from darwi-home-pc (ip-109-42-1-8.web.vodafone.de. [109.42.1.8])
        by smtp.gmail.com with ESMTPSA id q5sm13264756wrn.43.2019.03.12.13.05.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 12 Mar 2019 13:05:44 -0700 (PDT)
Date:   Tue, 12 Mar 2019 21:05:33 +0100
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: kmsg_dump: Mark registered flag as private
Message-ID: <20190312200533.GA5777@darwi-home-pc>
References: <20190310200302.GA11096@darwi-home-pc>
 <20190311124905.GA416@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311124905.GA416@tigerII.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 11, 2019 at 09:49:05PM +0900, Sergey Senozhatsky wrote:
> On (03/10/19 21:03), Ahmed S. Darwish wrote:
> > The 'registered' flag is internally used by kmsg_dump_register()
> > and kmsg_dump_unregister() to track multiple registrations of the
> > same dumper.
> >
> > It's protected by printk's internal dump_list_lock, and must thus
> > be accessed only from there. Mark it as private.
> >
> > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> > ---
> >  include/linux/kmsg_dump.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> > index 2e7a1e032c71..7c08cb58259a 100644
> > --- a/include/linux/kmsg_dump.h
> > +++ b/include/linux/kmsg_dump.h
> > @@ -36,7 +36,7 @@ enum kmsg_dump_reason {
> >   * @dump:	Call into dumping code which will retrieve the data with
> >   * 		through the record iterator
> >   * @max_reason:	filter for highest reason number that should be dumped
> > - * @registered:	Flag that specifies if this is already registered
> > + * @registered:	Flag that specifies if this is already registered (private)
> >   */
> >  struct kmsg_dumper {
> >  	struct list_head list;
>
>
> Do we really do this thing?
>
>
> $ git grep "(private)" include/linux/
> include/linux/kmsg_dump.h: * @list:     Entry in the dumper list (private)
> include/linux/uwb.h: * specific (private) DevAddr (UWB_RSV_TARGET_DEVADDR).
>

Hmmm, while writing a kmsg_dumper for [1], I noticed that struct
kmsg_dumper is:

    /**
     * struct kmsg_dumper - kernel crash message dumper structure
     * @list:        Entry in the dumper list (private)  <== *
     * ...
     * @registered:  Flag that specifies if this is already registered
     */
    struct kmsg_dumper {
    	struct list_head list;
    	...
    	bool registered;
    	/* private state of the kmsg iterator */         <== *
    	...
    };

_All_ private members are annotated (<== *), so this gave the
impression that 'bool registered' was public..

Then I discovered from printk.c code that it's actually private,
and protected by the printk's internal dump_list_lock...

So this trivial patch was submitted for consistency.

thanks,

[1] https://lore.kernel.org/lkml/20190310013142.GA3376@darwi-home-pc

--
darwi
http://darwish.chasingpointers.com
