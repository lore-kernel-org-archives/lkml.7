Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849D0C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5103120675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBSlYA70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfEVIHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:07:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40308 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfEVIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:07:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so915122pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R9LcwzmisTS7r+q4SwIHnWG/B1+FQ56zuQk1IuY/Co0=;
        b=mBSlYA7037o5LdH8eMdLpiuP/Z0aDaIBdqWhlZ1Aw1ZT8Q0ilpxCXWDmHOA94KAy4j
         FOHOJChPrPKrQDhRVVxSvqgb5u2TH3sYCMxc9vIKl+/LVWRXQkSKIepTRb2fNuUhNwok
         5GJaBXVx6qxIkP+yAmN81F5CjXh2AY/HjHNrMcCMuT5rBktHcEu3F0KIBuMrPLqBN4mz
         6Im0gi+ueBW0CjxkTIDxaXEneaNuaUJ6T7knsVvc38tOcLSTPNG5Oyrur3gAggIT/UFE
         ZdKU/mMrGxhRyeeOEUbp7nDUgWL9TTqt2YN1CsX+RcC3u90GjlqqeGMcJ+Zpw2DKQeHy
         UegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R9LcwzmisTS7r+q4SwIHnWG/B1+FQ56zuQk1IuY/Co0=;
        b=h1ZlNYwknak6QMqOGD9yZHM11+lZNvGG1fY4x33Md67pBWOlHdxSrB5oJqXmo3o+te
         mbT4qe/ZmnWpDmQqJN8z6sD6eo3xXQY9dZMYP4y6nZ171Vd8CbgzTmZRE0no/iyUtDPT
         wWf3lba3VO/z/NZymVoOBGRVyg0644vJDgqOKFbHuTFlZCl/BsHWhEZzzLI4rJlZDQIH
         FMHNYXfz1NgQnJjzBpFtI3wlWx37wCJ8aAyN6jYGylCvj8tBWf10oYtMugHtKPKJ6vSu
         sS0cru8YsKCTey+ptgJSQczs4OierAU9qC45h7K+QhA7gAFu9QsvnS60E9ThGPgDz0s8
         lxjA==
X-Gm-Message-State: APjAAAVwvcV+WquNhI55b3kSQw65RaSL8+FOjhpNAi2eaO3ggSFEUAGN
        YIYyHKWNQ3csDVLmX5PN9Sed6PyOqHQ=
X-Google-Smtp-Source: APXvYqzQNy8lcXx0lrcIRiJQ6ZfSoau8hQXBKZ8CDx9/qXMrvEXwAOkhvqcFadJHGimhxun18HFPMA==
X-Received: by 2002:aa7:930e:: with SMTP id 14mr36801323pfj.262.1558512427215;
        Wed, 22 May 2019 01:07:07 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e12sm43143956pfl.122.2019.05.22.01.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 01:07:06 -0700 (PDT)
Date:   Wed, 22 May 2019 16:06:56 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_io: Fix a missing-check bug in drivers/tty/tty_io.c
Message-ID: <20190522080656.GA5109@zhanggen-UX430UQ>
References: <20190522014006.GB4093@zhanggen-UX430UQ>
 <abc68141-df99-1ae1-ea51-c83bd4480d92@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc68141-df99-1ae1-ea51-c83bd4480d92@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 06:25:36AM +0200, Jiri Slaby wrote:
> On 22. 05. 19, 3:40, Gen Zhang wrote:
> > In alloc_tty_struct(), tty->dev is assigned by tty_get_device(). And it
> > calls class_find_device(). And class_find_device() may return NULL.
> > And tty->dev is dereferenced in the following codes. When 
> > tty_get_device() returns NULL, dereferencing this tty->dev null pointer
> > may cause the kernel go wrong. Thus we should check tty->dev.
> > Further, if tty_get_device() returns NULL, we should free tty and 
> > return NULL.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > 
> > ---
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 033ac7e..1444b59 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -3008,6 +3008,10 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
> >  	tty->index = idx;
> >  	tty_line_name(driver, idx, tty->name);
> >  	tty->dev = tty_get_device(tty);
> > +	if (!tty->dev) {
> > +		kfree(tty);
> > +		return NULL;
> > +	}
> 
> This is incorrect, you introduced an ldisc reference leak.
Thanks for your reply, Jiri!
And what do you mean by an ldisc reference leak? I did't get the reason
of introducing it.
> 
> And can this happen at all?
I think tty_get_device() may happen to return NULL. Because it calls 
class_find_device() and there's a chance class_find_device() returns
NULL.
Thanks
Gen
> 
> thanks,
> -- 
> js
> suse labs
