Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5410C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF0720679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bWU6lkvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfG2R4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:56:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41482 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfG2R4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:56:24 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so117858488ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ydp/iSvyO4Dctr758ny32Jpi/Yd+9qWk4e7yWhN/9q4=;
        b=bWU6lkvNBFBsNI/5gDAVH/fT9Dgfh5icONU4+rSt78QK8IHq2doGNzeDH7l6DGm2M0
         JRarFba/eU78OjA+OJJq0ojReTW+IQBSpq2DpxARjd2tx9YqhU6swodtIoBv0S5nbCQw
         4SuPLG5NehAdV0rUxnAa7nE792GpTDko+kT8ycR3+oKVe2FSXB8Gtr0TiPoFcxuL59cY
         bir8FxRb57Jh+WZcSz21x8HF1NvXGrPk6qtlsSXB8ZErbt6ZSrxHIpIXuYqLVDrMbFA/
         WH9FbQkc84Qrxkfm5d5kF4fnsWcjTdkq9HUSIQF2+ufsI8vsMku6U7NNlr4GzQ76vXYm
         kmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ydp/iSvyO4Dctr758ny32Jpi/Yd+9qWk4e7yWhN/9q4=;
        b=ATl+ZB9DlX1vtpkl1aw5NkY79zA6kTaLg76yNo7TfUWkpGE06FGvCA7BVINraw3e22
         G/cLW4V9z4aEgDMfkhqQtIkxcqjXbgt/b//VznDd4wCfTJTipJycQf/oFS4NxoRY2fSo
         gKu71YEZQ3NQEP/Xgo0QJ5HskDAAsFPt2o4RDGyfSNML9J2AFL1PuYbH6rDUWJ/Yf1kg
         se0joGPqau2y2E54Vj2dtf0JSwgHp3g4BKs0i27rrxDIUIlTXSbJeDVWcV2eYQFa5NWO
         h5L/VyD1ezsaaZhyPtHntCZsymta+IYMqx6GUcT2Q/XK+nER6tVwacVAW0ogP3QYSHFa
         Y2sQ==
X-Gm-Message-State: APjAAAWv34E1tFV4J6v439ty7+MMR753wI4GsO2riryIRvF1QoTZevKD
        BsKvuEZVX+D9D0RWZo30UL0=
X-Google-Smtp-Source: APXvYqxvHXwcDJpFBeBzDd72gbHLs+YHAjrbP8UTutLh94ZMUrYvQzW6kIN74l3sUTVxr6YhVLh/lg==
X-Received: by 2002:a05:6602:1d6:: with SMTP id w22mr58630814iot.87.1564422983727;
        Mon, 29 Jul 2019 10:56:23 -0700 (PDT)
Received: from brauner.io ([162.223.5.124])
        by smtp.gmail.com with ESMTPSA id z17sm83874244iol.73.2019.07.29.10.56.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 10:56:22 -0700 (PDT)
Date:   Mon, 29 Jul 2019 19:56:21 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        torvalds@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com
Subject: Re: [PATCH v3 1/2] pidfd: add P_PIDFD to waitid()
Message-ID: <20190729175620.uwszsvidnb2cmul4@brauner.io>
References: <20190727222229.6516-1-christian@brauner.io>
 <20190727222229.6516-2-christian@brauner.io>
 <201907290915.8B421306D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201907290915.8B421306D@keescook>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:24:38AM -0700, Kees Cook wrote:
> On Sun, Jul 28, 2019 at 12:22:29AM +0200, Christian Brauner wrote:
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index a75b6a7f458a..64bb6893a37d 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -1552,6 +1552,23 @@ static long do_wait(struct wait_opts *wo)
> >  	return retval;
> >  }
> >  
> > +static struct pid *pidfd_get_pid(unsigned int fd)
> > +{
> > +	struct fd f;
> > +	struct pid *pid;
> > +
> > +	f = fdget(fd);
> > +	if (!f.file)
> > +		return ERR_PTR(-EBADF);
> > +
> > +	pid = pidfd_pid(f.file);
> > +	if (!IS_ERR(pid))
> > +		get_pid(pid);
> > +
> > +	fdput(f);
> > +	return pid;
> > +}
> > +
> >  static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
> >  			  int options, struct rusage *ru)
> >  {
> > @@ -1574,19 +1591,29 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
> >  		type = PIDTYPE_PID;
> >  		if (upid <= 0)
> >  			return -EINVAL;
> > +
> > +		pid = find_get_pid(upid);
> >  		break;
> >  	case P_PGID:
> >  		type = PIDTYPE_PGID;
> >  		if (upid <= 0)
> >  			return -EINVAL;
> > +
> > +		pid = find_get_pid(upid);
> > +		break;
> > +	case P_PIDFD:
> > +		type = PIDTYPE_PID;
> > +		if (upid < 0)
> > +			return -EINVAL;
> > +
> > +		pid = pidfd_get_pid(upid);
> > +		if (IS_ERR(pid))
> > +			return PTR_ERR(pid);
> 
> I spent some time convincing myself that this early bail out was
> correct. It seems this path is only reachable in the EBADF case, so that
> makes sense. The other failure modes in this switch all give a NULL pid
> so that the final do_wait() returns ECHILD. So, as long as that's
> intentional (which I think it is), this all looks fine. :)

Yep, it is. I didn't want to refactor that out of do_wait(). :)

Thanks!
Christian

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
